"""Check binary preservation, automatic activation and Mach-O dependency hazards."""
import hashlib
import io
import json
from pathlib import Path
import struct
import sys
import unittest
import zipfile

from test_spoof_consistency import ROOT, Runtime, images

sys.path.insert(0, str(ROOT / 'tools'))
from clean_ipa import (RET, bind_ordinals, checked_members, clean_scrt,
                       commands, dylib_name, main_header_without_addon)

RECIPE = json.loads((ROOT / 'tools/cleanup/recipe.json').read_text())
TARGET = '@executable_path/SKEngine.dylib'


def load_command(name, kind=0x80000018):
    value = name.encode() + b'\0'
    size = (24 + len(value) + 7) & ~7
    return struct.pack('<6I', kind, size, 24, 0, 0, 0) + value + bytes(size - 24 - len(value))


def macho_fixture(bind=b'\x11\x00', extra_load=False, symbol_ordinal=0):
    """Small independent linker fixture with real dyld command/opcode formats."""
    loads = [load_command('/usr/lib/libobjc.A.dylib', 0xc), load_command(TARGET)]
    if extra_load:
        loads.append(load_command('/usr/lib/libSystem.B.dylib', 0xc))
    loads.append(struct.pack('<12I', 0x80000022, 48, 0, 0, 0x300, len(bind), 0, 0, 0, 0, 0, 0))
    if symbol_ordinal:
        loads.append(struct.pack('<6I', 2, 24, 0x350, 1, 0x380, 1))
    body = b''.join(loads)
    data = bytearray(bytes(range(256)) * 16)
    data[:32] = struct.pack('<8I', 0xfeedfacf, 0x100000c, 0, 2, len(loads), len(body), 0, 0)
    data[32:32 + len(body)] = body
    data[0x300:0x300 + len(bind)] = bind
    if symbol_ordinal:
        struct.pack_into('<IBBHQ', data, 0x350, 0, 1, 0, symbol_ordinal << 8, 0)
    return bytes(data)


class IPACleanupTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.original, cls.v3 = images()
        cls.cleaned = clean_scrt(cls.v3, RECIPE)

    def test_scrt_changes_only_four_noncore_entries(self):
        allowed = {offset for patch in RECIPE['scrt']['patches']
                   for offset in range(patch['offset'], patch['offset'] + 4)}
        changed = {i for i, (before, after) in enumerate(zip(self.v3, self.cleaned)) if before != after}
        self.assertEqual(changed, allowed)
        self.assertEqual(len(changed), 16)
        self.assertEqual(len(self.v3), len(self.cleaned))
        self.assertEqual(hashlib.sha256(self.cleaned).hexdigest(), RECIPE['scrt']['after_sha256'])

    def test_only_three_audited_initializers_remain_active_and_loads_do_nothing(self):
        class NoCalls(Runtime):
            def call(self, address, args):
                raise AssertionError(f'Unexpected call from removed initializer: {address:#x}')

        active = []
        for entry in RECIPE['scrt']['initializers'] + RECIPE['scrt']['objc_loads']:
            if self.cleaned[entry['offset']:entry['offset'] + 4] == RET:
                NoCalls(self.cleaned).run(entry['offset'])
            else:
                self.assertTrue(entry['retained'])
                active.append(entry['offset'])
        self.assertEqual(active, [0x21698, 0x44440, 0x56be0])

    def test_cleaned_core_identity_and_actual_login_still_follow_v3_flow(self):
        for data in (self.v3, self.cleaned):
            runtime = Runtime(data, saved='invalid')
            runtime.run(0x22220)
            self.assertEqual(runtime.defaults[runtime.KEY], runtime.NEW_UUID)
            for getter in (0x210e8, 0x211e4):
                result = runtime.run(getter, (runtime.obj('device'), runtime.obj('selector')))
                self.assertEqual(runtime.value(result), ('uuid', runtime.NEW_UUID))
            runtime.events.clear()
            args = [runtime.obj(('argument', i)) for i in range(5)]
            runtime.run(0x41bdc, args)
            self.assertEqual(runtime.events, ['set-token', 'original-login'])
            self.assertEqual(runtime.login_args, args)

    def test_existing_dormant_stubs_are_not_new_bypasses(self):
        for entry in RECIPE['scrt']['unchanged_source_stubs']:
            expected = bytes.fromhex(entry['bytes'])
            for data in (self.original, self.v3, self.cleaned):
                self.assertEqual(data[entry['offset']:entry['offset'] + len(expected)], expected)

    def test_unknown_scrt_fails_closed(self):
        changed = bytearray(self.v3)
        changed[-1] ^= 1
        with self.assertRaisesRegex(ValueError, 'exact v3'):
            clean_scrt(changed, RECIPE)

    def test_remove_last_weak_load_preserves_data_offsets_and_other_commands(self):
        data = macho_fixture()
        prefix = main_header_without_addon(data, TARGET)
        result = prefix + data[len(prefix):]
        before = commands(data)
        after = commands(result)
        kept = [bytes(command) for kind, _, command in before
                if not (kind == 0x80000018 and dylib_name(command) == TARGET)]
        self.assertEqual([bytes(command) for _, _, command in after], kept)
        self.assertEqual(result[len(prefix):], data[len(prefix):])
        self.assertEqual(len(result), len(data))
        end = 32 + struct.unpack_from('<I', result, 20)[0]
        self.assertEqual(result[end:len(prefix)], bytes(len(prefix) - end))

    def test_dependency_removal_refuses_ordinal_renumbering(self):
        with self.assertRaisesRegex(ValueError, 'renumber'):
            main_header_without_addon(macho_fixture(extra_load=True), TARGET)

    def test_dependency_removal_refuses_bind_and_symbol_imports(self):
        for data in (macho_fixture(bind=b'\x12\x00'), macho_fixture(bind=b'\x20\x02\x00'),
                     macho_fixture(symbol_ordinal=2)):
            with self.assertRaisesRegex(ValueError, 'imports'):
                main_header_without_addon(data, TARGET)

    def test_unknown_or_truncated_bind_encoding_is_rejected(self):
        for stream in (b'\xd0', b'\x20\x80', b'\x40unterminated'):
            with self.assertRaises(ValueError):
                bind_ordinals(stream)

    def test_archive_validation_rejects_paths_outside_payload(self):
        for name in ('../escape', 'Payload/../escape', '/Payload/file', 'Other/file'):
            buffer = io.BytesIO()
            with zipfile.ZipFile(buffer, 'w') as archive:
                archive.writestr(name, b'test')
            with zipfile.ZipFile(buffer) as archive:
                with self.assertRaisesRegex(ValueError, 'path'):
                    checked_members(archive, 1)


if __name__ == '__main__':
    unittest.main()
