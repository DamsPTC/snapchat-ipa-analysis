"""Verify full injection removal and native metadata restoration offline."""
import hashlib
import json
from pathlib import Path
import plistlib
import struct
import sys
import tempfile
import unittest
from unittest.mock import patch
import zipfile

from test_ipa_cleanup import load_command
from test_spoof_consistency import ROOT

sys.path.insert(0, str(ROOT / 'tools'))
from clean_ipa import (build, commands, dylib_name, main_header_without_addons,
                       restore_bundle_id)

SCRT = '@executable_path/Frameworks/SCRT.framework/SCRT'
SKENGINE = '@executable_path/SKEngine.dylib'
MAIN = 'Payload/Snapchat.app/Snapchat'
PLIST = 'Payload/Snapchat.app/Info.plist'
SCRT_FILE = 'Payload/Snapchat.app/Frameworks/SCRT.framework/SCRT'
SKENGINE_FILE = 'Payload/Snapchat.app/SKEngine.dylib'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def fixture(import_ordinal=1):
    stream = bytes([0x10 | import_ordinal, 0])
    loads = [load_command('/usr/lib/libobjc.A.dylib', 0xc),
             load_command(SCRT), load_command(SKENGINE),
             struct.pack('<12I', 0x80000022, 48, 0, 0, 0x300, len(stream), 0, 0, 0, 0, 0, 0)]
    body = b''.join(loads)
    data = bytearray(bytes(range(256)) * 16)
    data[:32] = struct.pack('<8I', 0xfeedfacf, 0x100000c, 0, 2, len(loads), len(body), 0, 0)
    data[32:32 + len(body)] = body
    data[0x300:0x300 + len(stream)] = stream
    return bytes(data)


def plist_fixture(fmt=plistlib.FMT_BINARY):
    value = {'CFBundleIdentifier': 'app.neriostore.snapchatunbanss06',
             'MinimumOSVersion': '10.0', 'CFBundleVersion': '12.81.0.47',
             'ApplicationIdentifier': '3MY7A92V5W.com.toyopagroup.picaboo',
             'NestedUntouched': {'values': [True, 4, 'preserve']}}
    data = plistlib.dumps(value, fmt=fmt, sort_keys=False)
    restored = dict(value, CFBundleIdentifier='com.toyopagroup.picaboo', MinimumOSVersion='12.4')
    result = plistlib.dumps(restored, fmt=fmt, sort_keys=False)
    spec = {'path': PLIST, 'bytes': len(data), 'before_sha256': sha(data),
            'after_bytes': len(result), 'after_sha256': sha(result),
            'before_bundle_id': value['CFBundleIdentifier'], 'after_bundle_id': restored['CFBundleIdentifier'],
            'restore_minimum_os': {'before': '10.0', 'after': '12.4'}}
    return data, result, spec


class NativeBaselineTests(unittest.TestCase):
    def test_remove_both_injections_preserves_every_other_command_and_file_offset(self):
        data = fixture()
        prefix = main_header_without_addons(data, [SCRT, SKENGINE])
        result = prefix + data[len(prefix):]
        after = commands(result)
        self.assertEqual(len(after), len(commands(data)) - 2)
        self.assertEqual(result[len(prefix):], data[len(prefix):])
        loads = [dylib_name(c) for kind, _, c in after if kind in (0xc, 0x80000018)]
        self.assertEqual(loads, ['/usr/lib/libobjc.A.dylib'])
        self.assertNotIn(b'SCRT.framework', result)
        self.assertNotIn(b'SKEngine.dylib', result)
        retained = [bytes(c) for kind, _, c in commands(data) if kind != 0x80000018]
        self.assertEqual([bytes(c) for _, _, c in after], retained)

    def test_removal_refuses_imports_from_either_injection(self):
        for ordinal in (2, 3):
            with self.assertRaisesRegex(ValueError, 'imports'):
                main_header_without_addons(fixture(ordinal), [SCRT, SKENGINE])

    def test_only_the_audited_plist_values_change_in_both_formats(self):
        for fmt in (plistlib.FMT_BINARY, plistlib.FMT_XML):
            before, expected, spec = plist_fixture(fmt)
            actual = restore_bundle_id(before, spec)
            self.assertEqual(actual, expected)
            left, right = plistlib.loads(before), plistlib.loads(actual)
            changed = {key for key in left if left[key] != right[key]}
            self.assertEqual(changed, {'CFBundleIdentifier', 'MinimumOSVersion'})
            self.assertEqual(set(left), set(right))

    def test_plist_restoration_refuses_wrong_preimages(self):
        data, _, spec = plist_fixture()
        for changes in ({'before_bundle_id': 'wrong'},
                        {'restore_minimum_os': {'before': '11.0', 'after': '12.4'}},
                        {'after_sha256': '0' * 64}):
            with self.assertRaises(ValueError):
                restore_bundle_id(data, dict(spec, **changes))

    def test_native_build_never_applies_a_spoof_patch_and_verifies_the_complete_zip(self):
        main = fixture()
        prefix = main_header_without_addons(main, [SCRT, SKENGINE])
        plist, restored_plist, plist_spec = plist_fixture()
        inputs = {MAIN: main, PLIST: plist, SCRT_FILE: b'remove-whole-framework',
                  SKENGINE_FILE: b'remove-extra-library', 'Payload/Snapchat.app/native-resource': b'keep-exactly'}
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source, output = root / 'source.ipa', root / 'native.ipa'
            with zipfile.ZipFile(source, 'w') as archive:
                for name, content in inputs.items():
                    archive.writestr(name, content)
            recipe = {'id': 'test-native', 'mode': 'native-baseline',
                      'source': {'sha256': sha(source.read_bytes()), 'bytes': source.stat().st_size,
                                 'files': len(inputs)},
                      'main': {'path': MAIN, 'bytes': len(main), 'before_sha256': sha(main),
                               'after_sha256': sha(prefix + main[len(prefix):]), 'remove_loads': [SCRT, SKENGINE]},
                      'remove_files': [{'path': name, 'bytes': len(inputs[name]), 'sha256': sha(inputs[name])}
                                       for name in (SCRT_FILE, SKENGINE_FILE)],
                      'restore_plists': [plist_spec], 'limitations': ['synthetic offline fixture']}
            with patch('clean_ipa.prepare_binary', side_effect=AssertionError('Spoof patch must not run')):
                result = build(source, output, recipe, root / 'result.json')
            self.assertFalse(result['spoof_patch_applied'])
            self.assertFalse(result['official_original_equivalence_verified'])
            self.assertTrue(result['zip_crc_and_all_hashes_verified'])
            self.assertEqual((result['output_files'], result['unchanged_files']), (3, 1))
            self.assertEqual(sha(output.read_bytes()), result['output_sha256'])
            with zipfile.ZipFile(output) as archive:
                self.assertEqual(set(archive.namelist()), {MAIN, PLIST, 'Payload/Snapchat.app/native-resource'})
                self.assertEqual(archive.read(PLIST), restored_plist)
                self.assertEqual(archive.read('Payload/Snapchat.app/native-resource'), b'keep-exactly')
                self.assertEqual(archive.read(MAIN), prefix + main[len(prefix):])
            # A second invocation must not overwrite the verified file.
            with self.assertRaisesRegex(ValueError, 'never overwritten'):
                build(source, output, recipe)
            self.assertEqual(sha(output.read_bytes()), result['output_sha256'])

    def test_production_recipe_removes_the_entire_framework_and_preserves_native_binaries(self):
        recipe = json.loads((ROOT / 'tools/native_baseline/recipe.json').read_text())
        source = json.loads((ROOT / 'analysis/manifest.json').read_text())
        removed = {entry['path'] for entry in recipe['remove_files']}
        scrt = {entry['path'] for entry in source['files'] if '/SCRT.framework/' in entry['path']}
        self.assertTrue(scrt and scrt <= removed)
        self.assertEqual(len(removed), 45)
        self.assertFalse(set(recipe['retained_macho_paths']) & removed)
        self.assertEqual(recipe['main']['remove_loads'], [SCRT, SKENGINE])
        self.assertNotIn('base_patch_manifest', recipe)
        self.assertEqual(len(recipe['restore_plists']), 7)


if __name__ == '__main__':
    unittest.main()
