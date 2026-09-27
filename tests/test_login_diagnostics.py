import struct
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'tools'))
from build_login_diagnostics import add_dependency, DEPENDENCY
from clean_ipa import commands, dylib_name


def executable(first_section=0x300):
    segment = struct.pack('<II16sQQQQiiII', 0x19, 152, b'__TEXT', 0x100000000,
                          0x1000, 0, 0x1000, 5, 5, 1, 0)
    section = struct.pack('<16s16sQQIIIIIIII', b'__text', b'__TEXT',
                          0x100000000 + first_section, 16, first_section, 2, 0, 0, 0, 0, 0, 0)
    header = struct.pack('<8I', 0xfeedfacf, 0x100000c, 0, 2, 1, 152, 0, 0)
    result = bytearray(header + segment + section)
    result += bytes(first_section + 16 - len(result))
    result[first_section:] = bytes(range(16))
    return bytes(result)


class DiagnosticPackagingTests(unittest.TestCase):
    def test_only_zero_header_padding_is_used(self):
        original = executable()
        changed, first = add_dependency(original)
        self.assertEqual(len(original), len(changed))
        self.assertEqual(changed[first:], original[first:])
        self.assertEqual(changed[32:184], original[32:184])
        self.assertEqual(dylib_name(commands(changed)[-1][2]), DEPENDENCY)

    def test_nonzero_padding_is_not_overwritten(self):
        original = bytearray(executable())
        original[184] = 1
        with self.assertRaisesRegex(ValueError, 'zero padding'):
            add_dependency(original)

    def test_insufficient_space_is_rejected(self):
        with self.assertRaisesRegex(ValueError, 'zero padding'):
            add_dependency(executable(200))

    def test_duplicate_load_is_rejected(self):
        changed, _ = add_dependency(executable())
        with self.assertRaisesRegex(ValueError, 'already loaded'):
            add_dependency(changed)


if __name__ == '__main__':
    unittest.main()
