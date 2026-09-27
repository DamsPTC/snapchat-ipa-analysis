"""Run real SCRT ARM64 instructions with mocked Foundation/runtime calls.

These tests never load the IPA, contact a service, delete a file or use a keychain.
They verify control flow and data flow, not iOS integration or ARC implementation.
"""
import hashlib
import json
from pathlib import Path
import struct
import unittest
import uuid

from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import *

ROOT = Path(__file__).resolve().parents[1]
SPEC = json.loads((ROOT / 'tools/spoof_fix/patches.json').read_text())


def images():
    data = (ROOT / SPEC['path']).read_bytes()
    digest = hashlib.sha256(data).hexdigest()
    assert digest in (SPEC['before_sha256'], SPEC['after_sha256'])
    original, patched = bytearray(data), bytearray(data)
    for patch in SPEC['patches']:
        offset = patch['offset']
        before, after = bytes.fromhex(patch['before']), bytes.fromhex(patch['after'])
        assert len(before) == len(after)
        original[offset:offset + len(before)] = before
        patched[offset:offset + len(after)] = after
    assert hashlib.sha256(original).hexdigest() == SPEC['before_sha256']
    assert hashlib.sha256(patched).hexdigest() == SPEC['after_sha256']
    return bytes(original), bytes(patched)


REGS = [UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X2, UC_ARM64_REG_X3,
        UC_ARM64_REG_X4, UC_ARM64_REG_X5, UC_ARM64_REG_X6, UC_ARM64_REG_X7,
        UC_ARM64_REG_X8, UC_ARM64_REG_X9, UC_ARM64_REG_X10, UC_ARM64_REG_X11,
        UC_ARM64_REG_X12, UC_ARM64_REG_X13, UC_ARM64_REG_X14, UC_ARM64_REG_X15,
        UC_ARM64_REG_X16, UC_ARM64_REG_X17, UC_ARM64_REG_X18]


class Runtime:
    BUNDLE = 'app.neriostore.snapchatunbanss06'
    KEY = 'SHIELD_ID_' + BUNDLE
    NEW_UUID = '6B23EB84-AC47-4128-A72E-ECD449F0CB23'
    STOP = 0x500000
    ORIGINAL_LOGIN = 0x500100
    ORIGINAL_HEADER = 0x500200

    def __init__(self, data, saved=None, verification=True):
        self.uc = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
        self.uc.mem_map(0, 0x200000)
        self.uc.mem_write(0, data)
        self.uc.mem_map(0x400000, 0x10000)
        self.uc.mem_map(0x500000, 0x1000)
        self.objects = {}
        self.next_object = 0x300000
        self.defaults = {'unrelated-setting': 'keep'}
        if saved is not None:
            self.defaults[self.KEY] = saved
        self.events = []
        self.generated = 0
        self.persisted = 0
        self.verification = verification
        self.login_args = None
        self.headers = {}
        self.token = 'original-devicecheck-token'
        self.constants = {}
        # Decode the existing CFString literals used by the tested functions.
        for offset in range(0xb65d0, 0xbe670, 32):
            pointer = struct.unpack_from('<Q', data, offset + 16)[0] & 0xffffffff
            length = struct.unpack_from('<Q', data, offset + 24)[0] & 0xffffffff
            if pointer + length < len(data):
                self.constants[offset] = data[pointer:pointer + length].decode('utf8', 'replace')
        for address, cls in [(0xcbb18, 'NSUserDefaults'), (0xcbb10, 'NSBundle'),
                             (0xcb9f8, 'NSString'), (0xcbae8, 'NSUUID')]:
            self.write_pointer(address, self.obj(('class', cls)))
        self.write_pointer(0xcd7f0, 0)
        self.write_pointer(0xcdcd0, self.ORIGINAL_LOGIN)
        self.write_pointer(0xcdcf0, self.ORIGINAL_HEADER)
        self.uc.hook_add(UC_HOOK_CODE, self.instruction)

    def obj(self, value):
        if value is None:
            return 0
        pointer = self.next_object
        self.next_object += 16
        self.objects[pointer] = value
        return pointer

    def value(self, pointer):
        if not pointer:
            return None
        if pointer in self.constants:
            return self.constants[pointer]
        if pointer not in self.objects:
            raise AssertionError(f'Unknown object pointer {pointer:#x}')
        return self.objects[pointer]

    def pointer(self, address):
        return struct.unpack('<Q', self.uc.mem_read(address, 8))[0]

    def write_pointer(self, address, value):
        self.uc.mem_write(address, struct.pack('<Q', value))

    def cstring(self, address):
        raw = bytes(self.uc.mem_read(address, 200))
        return raw.split(b'\0', 1)[0].decode()

    def instruction(self, uc, address, size, _):
        intercept = (0x75c28 <= address < 0x7df00 or address in
                     (0x24ec0, 0x25674, 0x4241c, 0x4e960, self.ORIGINAL_LOGIN, self.ORIGINAL_HEADER))
        if not intercept:
            return
        args = [uc.reg_read(reg) for reg in REGS[:5]]
        result = self.call(address, args)
        # Actual calls may clobber caller-saved registers. Expose accidental reliance.
        for index, reg in enumerate(REGS[1:], 1):
            uc.reg_write(reg, 0xdead0000 + index)
        uc.reg_write(UC_ARM64_REG_X0, result or 0)
        uc.reg_write(UC_ARM64_REG_PC, uc.reg_read(UC_ARM64_REG_LR))

    def call(self, address, a):
        x0, x1, x2, x3, x4 = a
        if address in (0x76444, 0x76468, 0x7636c):  # retain / retain-autoreleased / autorelease-return
            return x0
        if address == 0x76438:  # release
            return 0
        if address == 0x764a4:  # storeStrong
            self.write_pointer(x0, x1)
            return 0
        if address == 0x7cd60:
            return self.obj(('defaults',))
        if address == 0x79660:
            return self.obj(('main-bundle',))
        if address == 0x774e0:
            return self.obj(self.BUNDLE)
        if address == 0x7d080:  # Darwin variadic NSString formatting
            argument = self.value(self.pointer(self.uc.reg_read(UC_ARM64_REG_SP)))
            return self.obj(self.value(x2).replace('%@', str(argument)))
        if address == 0x7d000:
            value = self.defaults.get(self.value(x2))
            return self.obj(value if isinstance(value, str) else None)
        if address == 0x76330:
            return self.obj(('allocated-uuid',))
        if address == 0x79040:  # NSUUID parser returns nil for an invalid UUID string
            value = self.value(x2)
            try:
                parsed = uuid.UUID(value) if isinstance(value, str) else None
            except (ValueError, AttributeError):
                parsed = None
            return self.obj(('uuid', str(parsed).upper())) if parsed else 0
        if address == 0x76800:
            self.generated += 1
            return self.obj(('uuid', self.NEW_UUID))
        if address == 0x76820:
            return self.obj(self.value(x0)[1])
        if address == 0x7bae0:
            self.defaults[self.value(x3)] = self.value(x2)
            self.persisted += 1
            return 0
        if address == 0x7d500:
            return 1
        if address == 0x4e960:
            return 0
        if address == 0x4241c:
            self.events.append('verify')
            return int(self.verification)
        if address in (0x24ec0, 0x25674):
            self.events.append('wipe-keychain' if address == 0x24ec0 else 'wipe-files')
            return 0
        if address == 0x764f8:
            return self.obj(self.cstring(x0))
        if address == 0x763f0:
            selector = self.value(x1)
            if selector == 'loginHeader':
                return self.obj(('login-header',))
            if selector == 'setIosDeviceCheckToken:':
                self.events.append('set-token')
                self.token = self.value(x2)
                return 0
            raise AssertionError(selector)
        if address == self.ORIGINAL_LOGIN:
            self.events.append('original-login')
            self.login_args = a[:]
            return 0
        if address == 0x77aa0:
            return int(self.value(x0) is not None and self.value(x2) in self.value(x0))
        if address == 0x79220:
            return int(self.value(x0) is not None and self.value(x0) == self.value(x2))
        if address == self.ORIGINAL_HEADER:
            self.headers[self.value(x3)] = self.value(x2)
            return 0
        raise AssertionError(f'Unmodelled call: {address:#x}')

    def run(self, address, args=()):
        self.uc.reg_write(UC_ARM64_REG_SP, 0x40f000)
        self.uc.reg_write(UC_ARM64_REG_LR, self.STOP)
        for index, value in enumerate(args):
            self.uc.reg_write(REGS[index], value)
        self.uc.emu_start(address, self.STOP, count=20000)
        if self.uc.reg_read(UC_ARM64_REG_PC) != self.STOP:
            raise AssertionError('Function did not return within the instruction budget')
        if self.uc.reg_read(UC_ARM64_REG_SP) != 0x40f000:
            raise AssertionError('Stack pointer was not restored')
        return self.uc.reg_read(UC_ARM64_REG_X0)


class SpoofConsistencyTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.original, cls.patched = images()

    def test_valid_identity_is_preserved_without_rewrite(self):
        saved = '7EC38941-9F0E-41B6-A54A-B0A310332F9A'
        runtime = Runtime(self.patched, saved)
        runtime.run(0x22220)
        self.assertEqual(runtime.value(runtime.pointer(0xcd7f0)), saved)
        self.assertEqual((runtime.generated, runtime.persisted), (0, 0))

    def test_missing_invalid_and_wrong_type_identities_are_repaired_once(self):
        for saved in (None, '', 'not-a-uuid', 'Z' * 36, 1234):
            with self.subTest(saved=saved):
                runtime = Runtime(self.patched, saved)
                runtime.run(0x22220)
                runtime.run(0x22220)
                self.assertEqual(runtime.value(runtime.pointer(0xcd7f0)), runtime.NEW_UUID)
                self.assertEqual(runtime.defaults[runtime.KEY], runtime.NEW_UUID)
                self.assertEqual(runtime.defaults['unrelated-setting'], 'keep')
                self.assertEqual((runtime.generated, runtime.persisted), (1, 1))

    def test_repaired_identity_survives_a_new_process(self):
        first = Runtime(self.patched, 'invalid')
        first.run(0x22220)
        second = Runtime(self.patched, first.defaults[first.KEY])
        second.run(0x22220)
        self.assertEqual(second.value(second.pointer(0xcd7f0)), first.NEW_UUID)
        self.assertEqual(second.generated, 0)

    def test_both_existing_identity_getters_return_the_repaired_profile(self):
        runtime = Runtime(self.patched, 'invalid')
        runtime.run(0x22220)
        for getter in (0x210e8, 0x211e4):
            for _ in range(2):
                result = runtime.run(getter, (runtime.obj(('device',)), runtime.obj(('selector',))))
                self.assertEqual(runtime.value(result), ('uuid', runtime.NEW_UUID))
        self.assertEqual(runtime.generated, 1)

    def test_original_archive_reproduces_invalid_identity_bug(self):
        runtime = Runtime(self.original, 'invalid')
        runtime.run(0x22220)
        self.assertEqual(runtime.value(runtime.pointer(0xcd7f0)), 'invalid')
        result = runtime.run(0x210e8, (runtime.obj(('device',)), runtime.obj(('selector',))))
        self.assertEqual(result, 0)

    def test_failed_component_verification_no_longer_wipes_local_state(self):
        for data, expected in ((self.original, ['wipe-keychain', 'wipe-files', 'verify']),
                               (self.patched, ['verify'])):
            runtime = Runtime(data, verification=False)
            args = [runtime.obj(('argument', n)) for n in range(5)]
            runtime.run(0x41bdc, args)
            self.assertEqual(runtime.events, expected)
            self.assertIsNone(runtime.login_args)
            self.assertEqual(runtime.token, 'original-devicecheck-token')

    def test_successful_verification_preserves_spoof_actions_and_login_arguments(self):
        runtime = Runtime(self.patched, verification=True)
        args = [runtime.obj(('argument', n)) for n in range(5)]
        runtime.run(0x41bdc, args)
        self.assertEqual(runtime.events, ['verify', 'wipe-keychain', 'wipe-files', 'set-token', 'original-login'])
        self.assertEqual(runtime.login_args, args)
        self.assertEqual(runtime.token, 'DEVICE_CHECK_TOKEN_NOT_AVAILABLE_GTE_IOS11')

    def test_single_user_agent_matches_the_existing_batch_device_profile(self):
        for marker in ('iPhone', 'Anti-Snap/1.0'):
            runtime = Runtime(self.patched)
            runtime.run(0x43c1c, [runtime.obj(('request',)), runtime.obj(('selector',)),
                                  runtime.obj(marker), runtime.obj('User-Agent')])
            expected = runtime.value(0xbaf70).replace('%@', runtime.value(0xbae70))
            self.assertEqual(runtime.headers['User-Agent'], expected)
            self.assertIn('iPhone10,3; iOS 16.7.12', expected)

    def test_original_user_agent_reproduces_device_mismatch(self):
        runtime = Runtime(self.original)
        runtime.run(0x43c1c, [runtime.obj(('request',)), runtime.obj(('selector',)),
                              runtime.obj('iPhone'), runtime.obj('User-Agent')])
        self.assertIn('iPhone6,1; iOS 12.5.7', runtime.headers['User-Agent'])

    def test_other_header_values_are_unchanged_by_device_fix(self):
        runtime = Runtime(self.patched)
        for field, value in [('User-Agent', 'ordinary-client'), ('X-Custom', 'iPhone'), ('User-Agent', None)]:
            runtime.run(0x43c1c, [runtime.obj(('request',)), runtime.obj(('selector',)),
                                  runtime.obj(value), runtime.obj(field)])
            self.assertEqual(runtime.headers[field], value)

    def test_only_declared_regions_changed_and_disabled_modules_stay_disabled(self):
        allowed = set()
        for patch in SPEC['patches']:
            allowed.update(range(patch['offset'], patch['offset'] + len(bytes.fromhex(patch['after']))))
        changes = {index for index, pair in enumerate(zip(self.original, self.patched)) if pair[0] != pair[1]}
        self.assertTrue(changes)
        self.assertFalse(changes - allowed)
        self.assertEqual(len(self.original), len(self.patched))
        for guard in SPEC['activation_guards']:
            expected = bytes.fromhex(guard['bytes'])
            self.assertEqual(self.patched[guard['offset']:guard['offset'] + len(expected)], expected)

    def test_identity_assembly_reproduces_the_checked_patch(self):
        from keystone import Ks, KS_ARCH_ARM64, KS_MODE_LITTLE_ENDIAN
        source = (ROOT / 'tools/spoof_fix/initialize_identity.s').read_text()
        source = '\n'.join(line.split('//')[0].strip() for line in source.splitlines())
        patch = SPEC['patches'][0]
        code = bytes(Ks(KS_ARCH_ARM64, KS_MODE_LITTLE_ENDIAN).asm(source, addr=patch['offset'], as_bytes=True)[0])
        expected = bytes.fromhex(patch['after'])
        self.assertEqual(code + bytes.fromhex('1f2003d5') * ((len(expected) - len(code)) // 4), expected)


if __name__ == '__main__':
    unittest.main()
