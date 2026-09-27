"""Execute the audited boundaries without an iPhone, a keychain or networking.

Foundation, Security and MobileGestalt are explicit test doubles. These tests
verify SCRT's argument/data flow, not Apple's UUID generator or server behavior.
"""
from copy import deepcopy
import hashlib
import struct
import unittest

from test_spoof_consistency import Runtime, SPEC, images


class KeychainRuntime(Runtime):
    ORIGINAL_ADD = 0x500400
    ORIGINAL_COPY = 0x500500
    ORIGINAL_UPDATE = 0x500600

    def __init__(self, data, status=0):
        super().__init__(data)
        self.uc.mem_map(0x600000, 0x10000)
        self.calls = []
        self.status = status
        self.result = self.obj(b'security-result')
        self.extra_intercepts.update((self.ORIGINAL_ADD, self.ORIGINAL_COPY, self.ORIGINAL_UPDATE))
        self.write_pointer(0xb0440, 0x600010)  # stack canary import
        self.write_pointer(0x600010, 0x12345678)
        self.write_pointer(0x600020, 0)  # fast-enumeration mutation counter
        self.write_pointer(0xccdc0, 0xb8350)  # original fixed service CFString
        for index, (slot, key) in enumerate(((0xb0670, 'kSecAttrAccessGroup'),
                                             (0xb06a8, 'kSecAttrService'),
                                             (0xb06b0, 'kSecAttrSynchronizable'))):
            cell = 0x600100 + 8 * index
            self.write_pointer(slot, cell)
            self.write_pointer(cell, self.obj(key))
        for slot, target in ((0xcd7f8, self.ORIGINAL_ADD), (0xcd800, self.ORIGINAL_COPY),
                              (0xcd808, self.ORIGINAL_UPDATE)):
            self.write_pointer(slot, target)
        # Decode the three actual exception lists rather than assuming their contents.
        for address in (0xbf780, 0xbf798, 0xbf7b0):
            count, items = struct.unpack_from('<QQ', data, address + 8)
            items &= 0xffffffff
            self.objects[address] = [self.value(struct.unpack_from('<Q', data, items + 8 * i)[0] & 0xffffffff)
                                     for i in range(count)]

    def call(self, address, a):
        x0, x1, x2, x3, x4 = a
        if address == 0x798a0:  # mutableCopy
            return self.obj(deepcopy(self.value(x0)))
        if address == 0x79aa0:  # objectForKey:
            return self.obj(self.value(x0).get(self.value(x2)))
        if address == 0x7bae0:  # setObject:forKey:
            self.value(x0)[self.value(x3)] = self.value(x2)
            return 0
        if address == 0x7a560:  # removeObjectForKey:
            self.value(x0).pop(self.value(x2), None)
            return 0
        if address == 0x762f4:  # memset
            self.uc.mem_write(x0, bytes([x1 & 0xff]) * x2)
            return x0
        if address == 0x77c60:  # countByEnumeratingWithState:objects:count:
            if self.pointer(x2):
                return 0
            values = self.value(x0)
            assert len(values) <= x4
            self.write_pointer(x2, 1)
            self.write_pointer(x2 + 8, x3)
            self.write_pointer(x2 + 16, 0x600020)
            for index, value in enumerate(values):
                self.write_pointer(x3 + 8 * index, self.obj(value))
            return len(values)
        if address in (self.ORIGINAL_ADD, self.ORIGINAL_COPY, self.ORIGINAL_UPDATE):
            query = deepcopy(self.value(x0))
            attributes = deepcopy(self.value(x1)) if address == self.ORIGINAL_UPDATE else None
            self.calls.append({'target': address, 'query': query, 'attributes': attributes,
                               'pointers': (x0, x1)})
            if address != self.ORIGINAL_UPDATE and x1 and self.status == 0:
                self.write_pointer(x1, self.result)
            return self.status & 0xffffffff
        return super().call(address, a)


class GestaltRuntime(Runtime):
    MG_COPY_ANSWER = 0x500300

    def __init__(self, data, result):
        super().__init__(data)
        self.answer = self.obj(result)
        self.keys = []
        self.extra_intercepts.add(self.MG_COPY_ANSWER)
        for function_slot, once_slot in ((0xcd7b0, 0xcd7b8), (0xcddd8, 0xcdde0)):
            self.write_pointer(function_slot, self.MG_COPY_ANSWER)
            self.write_pointer(once_slot, 0xffffffffffffffff)

    def call(self, address, a):
        if address == self.MG_COPY_ANSWER:
            self.keys.append(self.value(a[0]))
            return self.answer
        return super().call(address, a)


class IdentityBoundaryTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.original, cls.patched = images()

    @staticmethod
    def query(service):
        return {'kSecClass': 'generic-password', 'kSecAttrService': service,
                'kSecAttrAccount': 'same-account', 'kSecAttrAccessGroup': 'test.access.group',
                'kSecAttrSynchronizable': True, 'kSecValueData': b'test-only'}

    def test_original_keychain_hooks_collapse_distinct_services(self):
        for entry in (0x208c0, 0x20b74, 0x20e28):
            with self.subTest(entry=hex(entry)):
                runtime = KeychainRuntime(self.original)
                for service in ('test.service.alpha', 'test.service.beta'):
                    second = runtime.obj({'kSecAttrAccessGroup': 'test.access.group'}) if entry == 0x20e28 else 0
                    runtime.run(entry, (runtime.obj(self.query(service)), second))
                services = [call['query']['kSecAttrService'] for call in runtime.calls]
                self.assertEqual(services, ['com.apple.shield.identity.v3'] * 2)

    def test_keychain_calls_preserve_service_security_attributes_and_results(self):
        for entry, target in ((0x208c0, KeychainRuntime.ORIGINAL_ADD),
                              (0x20b74, KeychainRuntime.ORIGINAL_COPY),
                              (0x20e28, KeychainRuntime.ORIGINAL_UPDATE)):
            for status in (0, -50, -25300):
                for service in ('test.service.alpha', 'test.service.beta'):
                    with self.subTest(entry=hex(entry), status=status, service=service):
                        runtime = KeychainRuntime(self.patched, status)
                        query = self.query(service)
                        query_ptr = runtime.obj(deepcopy(query))
                        attributes = {'kSecAttrAccessGroup': 'test.access.group',
                                      'kSecAttrSynchronizable': False, 'kSecValueData': b'new-test-value'}
                        second = runtime.obj(deepcopy(attributes)) if entry == 0x20e28 else 0x600200
                        actual_status = runtime.run(entry, (query_ptr, second))
                        self.assertEqual(actual_status, status & 0xffffffff)
                        self.assertEqual(runtime.calls, [{'target': target, 'query': query,
                                         'attributes': attributes if entry == 0x20e28 else None,
                                         'pointers': (query_ptr, second)}])
                        self.assertEqual(runtime.value(query_ptr), query)
                        if entry != 0x20e28:
                            self.assertEqual(runtime.pointer(second), runtime.result if status == 0 else 0)

    def test_gestalt_readers_return_the_system_answer_without_the_test_profile(self):
        for data in (self.original, self.patched):
            for entry in (0x1f418, 0x5dfe4):
                for key, result in (('ProductType', 'test-system-model'),
                                    ('SerialNumber', 'test-system-serial'),
                                    ('UniqueDeviceID', 'test-system-id'), ('BuildVersion', None)):
                    with self.subTest(entry=hex(entry), key=key):
                        runtime = GestaltRuntime(data, result)
                        returned = runtime.run(entry, (runtime.obj(key),))
                        self.assertEqual(returned, runtime.answer)
                        self.assertEqual(runtime.keys, [key])

    def test_fresh_installations_preserve_distinct_uuid_generator_outputs(self):
        values = ('F03FDF3D-7734-4DD2-8A56-3E70A756083B', 'AE762E97-71E0-45AC-92BB-A548C5231A56')
        for data in (self.original, self.patched):
            observed = []
            for value in values:
                runtime = Runtime(data, generated_uuid=value)
                runtime.run(0x22220)
                saved = runtime.defaults[runtime.KEY]
                observed.append(saved)
                self.assertEqual(runtime.value(runtime.pointer(0xcd7f0)), value)
                restarted = Runtime(data, saved, generated_uuid='126055B2-3800-48E7-879C-C87ABC642B99')
                restarted.run(0x22220)
                self.assertEqual(restarted.value(restarted.pointer(0xcd7f0)), value)
                self.assertEqual(restarted.generated, 0)
            self.assertEqual(tuple(observed), values)

    def test_previous_revision_wiped_on_success_but_current_login_does_not(self):
        revision = SPEC['intermediate_revisions'][-1]
        previous = bytearray(self.original)
        for patch in SPEC['patches']:
            if patch['id'] in revision['patch_ids']:
                code = bytes.fromhex(patch['after'])
                previous[patch['offset']:patch['offset'] + len(code)] = code
        self.assertEqual(hashlib.sha256(previous).hexdigest(), revision['sha256'])
        for data, expected in ((bytes(previous), ['verify', 'wipe-keychain', 'wipe-files', 'set-token', 'original-login']),
                               (self.patched, ['verify', 'set-token', 'original-login'])):
            runtime = Runtime(data, verification=True)
            args = [runtime.obj(('test-argument', index)) for index in range(5)]
            runtime.run(0x41bdc, args)
            self.assertEqual(runtime.events, expected)
            self.assertEqual(runtime.login_args, args)

    def test_residual_log_entries_return_without_collecting_or_sending(self):
        class NoCalls(Runtime):
            def instruction(self, uc, address, size, context):
                if address == 0x4e960:  # execute the actual RET instead of the generic logger double
                    return
                return super().instruction(uc, address, size, context)

            def call(self, address, args):
                raise AssertionError(f'Unexpected external call: {address:#x}')

        for entry in (0x4e3d8, 0x4e960, 0x4ecc4, 0x4ed34, 0x4fa6c):
            runtime = NoCalls(self.patched)
            # Pre-populated telemetry/queue globals must not cause any collection or upload.
            for address in (0xcdd08, 0xcdd10, 0xcdd20, 0xcdd28):
                runtime.write_pointer(address, runtime.obj(('test-log-data', address)))
            before = bytes(runtime.uc.mem_read(0xcdd08, 0x40))
            result = runtime.run(entry, (runtime.obj('test-log'), runtime.obj({'test': True}), 1))
            if entry == 0x4fa6c:
                self.assertEqual(result, 0)  # report no successful upload
            self.assertEqual(bytes(runtime.uc.mem_read(0xcdd08, 0x40)), before)

    def test_boundary_patch_assembly_matches_manifest(self):
        from keystone import Ks, KS_ARCH_ARM64, KS_MODE_LITTLE_ENDIAN
        assembler = Ks(KS_ARCH_ARM64, KS_MODE_LITTLE_ENDIAN)
        for patch in SPEC['patches']:
            if 'assembly' in patch:
                code = bytes(assembler.asm(patch['assembly'], addr=patch['offset'], as_bytes=True)[0])
                self.assertEqual(code, bytes.fromhex(patch['after']))


if __name__ == '__main__':
    unittest.main()
