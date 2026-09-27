#!/usr/bin/env python3
"""Add the small local observer to the exact, unsigned native baseline."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import plistlib
import struct
import tempfile
import zipfile

from clean_ipa import commands, dylib_name, checked_members, DYLIB_LOADS

BASE_SHA256 = 'dd49ab63e079abac15391bfb7861d69fa876ec1b7d2a2a54b1ac801441e77c92'
MAIN = 'Payload/Snapchat.app/Snapchat'
FRAMEWORK = 'NativeLoginDiagnostics.framework'
EXECUTABLE = 'NativeLoginDiagnostics'
DEPENDENCY = f'@executable_path/Frameworks/{FRAMEWORK}/{EXECUTABLE}'
ALLOWED_IMPORTS = {
    '/System/Library/Frameworks/Foundation.framework/Foundation',
    '/System/Library/Frameworks/UIKit.framework/UIKit',
    '/usr/lib/libobjc.A.dylib', '/usr/lib/libSystem.B.dylib',
}


def digest(data):
    return hashlib.sha256(data).hexdigest()


def file_digest(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def add_dependency(data):
    parsed = commands(data)
    if any(kind == 0x1d for kind, _, _ in parsed):
        raise ValueError('Refusing to modify a signed input executable')
    if any(dylib_name(cmd) == DEPENDENCY for kind, _, cmd in parsed if kind in DYLIB_LOADS):
        raise ValueError('Diagnostic observer is already loaded')
    section_offsets = []
    for kind, _, cmd in parsed:
        if kind != 0x19:
            continue
        count = struct.unpack_from('<I', cmd, 64)[0]
        if 72 + count * 80 > len(cmd):
            raise ValueError('Invalid segment sections')
        for i in range(count):
            start = 72 + 80 * i
            size, offset = struct.unpack_from('<QI', cmd, start + 40)
            if size and offset:
                section_offsets.append(offset)
    if not section_offsets:
        raise ValueError('No file-backed section')
    first_section = min(section_offsets)
    old_end = 32 + struct.unpack_from('<I', data, 20)[0]
    name = DEPENDENCY.encode() + b'\0'
    length = (24 + len(name) + 7) & ~7
    new_end = old_end + length
    if new_end > first_section or any(data[old_end:new_end]):
        raise ValueError('Insufficient verified zero padding for the dependency')
    extra = struct.pack('<6I', 0xc, length, 24, 0, 0x10000, 0x10000) + name
    extra += bytes(length - len(extra))
    result = bytearray(data)
    result[old_end:new_end] = extra
    struct.pack_into('<II', result, 16, len(parsed) + 1, new_end - 32)
    after = commands(result)
    if [bytes(c) for _, _, c in after[:-1]] != [bytes(c) for _, _, c in parsed]:
        raise ValueError('An existing load command changed')
    if result[first_section:] != data[first_section:]:
        raise ValueError('Executable body changed')
    return bytes(result), first_section


def validate_observer(data):
    if struct.unpack_from('<I', data, 12)[0] != 6:
        raise ValueError('Expected an MH_DYLIB observer')
    parsed = commands(data)
    imports = [dylib_name(cmd) for kind, _, cmd in parsed if kind in DYLIB_LOADS]
    if not imports or set(imports) - ALLOWED_IMPORTS:
        raise ValueError(f'Unexpected observer dependencies: {imports}')
    ids = [dylib_name(cmd) for kind, _, cmd in parsed if kind == 0xd]
    if ids != [f'@rpath/{FRAMEWORK}/{EXECUTABLE}']:
        raise ValueError('Unexpected observer install name')
    platforms = []
    for kind, _, cmd in parsed:
        if kind == 0x32:
            platform, minimum = struct.unpack_from('<II', cmd, 8)
            platforms.append((platform, minimum))
        elif kind == 0x25:
            platforms.append((2, struct.unpack_from('<I', cmd, 8)[0]))
        elif kind == 0x1d:
            raise ValueError('Observer must be delivered unsigned')
    if platforms != [(2, 0x0c0400)]:
        raise ValueError(f'Expected iPhoneOS, minimum iOS 12.4: {platforms}')
    return {'imports': imports, 'platform': 'iPhoneOS', 'minimum_os': '12.4', 'sha256': digest(data)}


def build(source, framework, output, report):
    if output.exists() or report.exists() or source.resolve() == output.resolve():
        raise ValueError('Output/report must be new files')
    if file_digest(source) != BASE_SHA256:
        raise ValueError('The exact unsigned native baseline is required')
    observer = (framework / EXECUTABLE).read_bytes()
    observer_report = validate_observer(observer)
    info = (framework / 'Info.plist').read_bytes()
    metadata = plistlib.loads(info)
    if metadata.get('CFBundleExecutable') != EXECUTABLE or metadata.get('CFBundlePackageType') != 'FMWK':
        raise ValueError('Invalid observer framework metadata')
    additions = {
        f'Payload/Snapchat.app/Frameworks/{FRAMEWORK}/{EXECUTABLE}': observer,
        f'Payload/Snapchat.app/Frameworks/{FRAMEWORK}/Info.plist': info,
    }
    output.parent.mkdir(parents=True, exist_ok=True)
    report.parent.mkdir(parents=True, exist_ok=True)
    fd, temporary = tempfile.mkstemp(prefix='.login-diagnostic-', suffix='.ipa', dir=output.parent)
    os.close(fd)
    try:
        expected = {}
        with zipfile.ZipFile(source) as original, zipfile.ZipFile(temporary, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=6) as target:
            members = checked_members(original, 8067)
            names = {entry.filename for entry in members}
            if names & additions.keys():
                raise ValueError('Framework already present')
            if any('SCRT.framework/' in name or name.endswith(('SKEngine.dylib', 'CydiaSubstrate')) for name in names):
                raise ValueError('Unexpected historical injection in the baseline')
            for entry in members:
                data = original.read(entry)
                if entry.filename == MAIN:
                    before = data
                    data, first_section = add_dependency(data)
                    main_report = {'before_sha256': digest(before), 'after_sha256': digest(data),
                        'first_file_backed_section': first_section,
                        'body_after_first_section_sha256': digest(data[first_section:]),
                        'body_unchanged': data[first_section:] == before[first_section:]}
                item = zipfile.ZipInfo(entry.filename, (1980, 1, 1, 0, 0, 0))
                item.compress_type = zipfile.ZIP_DEFLATED
                item.external_attr = entry.external_attr
                target.writestr(item, data, compresslevel=6)
                expected[entry.filename] = (len(data), digest(data))
            for name, data in additions.items():
                item = zipfile.ZipInfo(name, (1980, 1, 1, 0, 0, 0))
                item.compress_type = zipfile.ZIP_DEFLATED
                item.external_attr = (0o100755 if name.endswith('/' + EXECUTABLE) else 0o100644) << 16
                target.writestr(item, data, compresslevel=6)
                expected[name] = (len(data), digest(data))
        with zipfile.ZipFile(temporary) as result:
            members = checked_members(result, 8069)
            if {entry.filename for entry in members} != set(expected):
                raise ValueError('Output inventory mismatch')
            for entry in members:
                data = result.read(entry)
                if (len(data), digest(data)) != expected[entry.filename]:
                    raise ValueError('Output content mismatch: ' + entry.filename)
        result = {'mode': 'local_runtime_diagnostics_v1', 'source_sha256': BASE_SHA256,
            'ipa_sha256': file_digest(Path(temporary)), 'ipa_bytes': Path(temporary).stat().st_size,
            'unchanged_files': 8066, 'modified_files': [MAIN], 'added_files': sorted(additions),
            'main': main_report, 'observer': observer_report,
            'login_fix_confirmed': False, 'autofill_fix_confirmed': False,
            'on_iphone_tested': False, 'credentials_or_tokens_logged': False}
        os.link(temporary, output)  # Atomic, exclusive publication; no overwrite.
        with report.open('x') as stream:
            json.dump(result, stream, indent=2)
            stream.write('\n')
        return result
    finally:
        Path(temporary).unlink(missing_ok=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('framework', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--report', type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(build(args.source, args.framework, args.output, args.report), indent=2))


if __name__ == '__main__':
    main()
