#!/usr/bin/env python3
"""Rebuild the pinned IPA with audited add-on removals; never run its code."""
import argparse
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import stat
import struct
import tempfile
import zipfile

from fix_spoof_consistency import prepare_binary, sha256

ROOT = Path(__file__).resolve().parents[1]
RECIPE_PATH = ROOT / 'tools/cleanup/recipe.json'
DYLIB_LOADS = {0xc, 0x80000018, 0x8000001f, 0x80000023}
RET = bytes.fromhex('c0035fd6')
CHUNK = 1024 * 1024


def commands(data):
    if len(data) < 32 or struct.unpack_from('<II', data) != (0xfeedfacf, 0x100000c):
        raise ValueError('Expected a thin ARM64 Mach-O')
    count, size = struct.unpack_from('<II', data, 16)
    end, offset = 32 + size, 32
    if end > len(data):
        raise ValueError('Truncated load commands')
    result = []
    for _ in range(count):
        if offset + 8 > end:
            raise ValueError('Truncated load command')
        command, length = struct.unpack_from('<II', data, offset)
        if length < 8 or length % 8 or offset + length > end:
            raise ValueError('Invalid load command size')
        result.append((command, offset, memoryview(data)[offset:offset + length]))
        offset += length
    if offset != end:
        raise ValueError('Load command count/size mismatch')
    return result


def dylib_name(command):
    if len(command) < 24:
        raise ValueError('Truncated dylib command')
    start = struct.unpack_from('<I', command, 8)[0]
    if not 24 <= start < len(command):
        raise ValueError('Invalid dylib name offset')
    raw = bytes(command[start:])
    if b'\0' not in raw:
        raise ValueError('Unterminated dylib name')
    return raw.split(b'\0', 1)[0].decode('utf8')


def bind_ordinals(data):
    """Read the classic dyld bind opcodes used by this pinned build."""
    cursor, ordinals = 0, set()

    def leb():
        nonlocal cursor
        result, shift = 0, 0
        while cursor < len(data) and shift < 70:
            value = data[cursor]
            cursor += 1
            result |= (value & 0x7f) << shift
            if not value & 0x80:
                return result
            shift += 7
        raise ValueError('Truncated or oversized LEB128')

    while cursor < len(data):
        value = data[cursor]
        cursor += 1
        opcode, immediate = value & 0xf0, value & 0xf
        if opcode == 0x10:
            ordinals.add(immediate)
        elif opcode == 0x20:
            ordinals.add(leb())
        elif opcode == 0x40:
            while cursor < len(data) and data[cursor]:
                cursor += 1
            if cursor == len(data):
                raise ValueError('Unterminated bind symbol')
            cursor += 1
        elif opcode in (0x60, 0x70, 0x80, 0xa0):
            leb()
        elif opcode == 0xc0:
            leb()
            leb()
        elif opcode not in (0, 0x30, 0x50, 0x90, 0xb0):
            raise ValueError(f'Unsupported bind opcode {opcode:#x}')
    return ordinals


def main_header_without_addon(data, target):
    """Remove only an unreferenced LAST dylib load; keep file offsets unchanged."""
    parsed = commands(data)
    loads = [(offset, command) for kind, offset, command in parsed if kind in DYLIB_LOADS]
    matches = [(i, offset, command) for i, (offset, command) in enumerate(loads, 1)
               if dylib_name(command) == target]
    if len(matches) != 1:
        raise ValueError('Expected exactly one add-on load command')
    ordinal, offset, removed = matches[0]
    if ordinal != len(loads) or struct.unpack_from('<I', removed)[0] != 0x80000018:
        raise ValueError('Refusing to renumber dependencies or remove a strong load')
    for kind, _, command in parsed:
        if kind == 0x80000034:
            raise ValueError('Chained imports are outside this pinned recipe')
        if kind in (0x22, 0x80000022):
            for field in (16, 24, 32):  # bind, weak-bind, lazy-bind
                start, size = struct.unpack_from('<II', command, field)
                if start + size > len(data):
                    raise ValueError('Bind stream outside file')
                if ordinal in bind_ordinals(memoryview(data)[start:start + size]):
                    raise ValueError('A bind stream imports from the removed dylib')
        if kind == 2:
            start, count = struct.unpack_from('<II', command, 8)
            if start + count * 16 > len(data):
                raise ValueError('Symbol table outside file')
            for index in range(count):
                _, symbol_type, _, description, _ = struct.unpack_from('<IBBHQ', data, start + index * 16)
                if not symbol_type & 0xe0 and symbol_type & 0xe == 0 and description >> 8 == ordinal:
                    raise ValueError('An undefined symbol imports from the removed dylib')
    old_end = 32 + struct.unpack_from('<I', data, 20)[0]
    length = len(removed)
    header = bytearray(data[:old_end])
    header[offset:old_end - length] = data[offset + length:old_end]
    header[old_end - length:old_end] = bytes(length)
    struct.pack_into('<II', header, 16, len(parsed) - 1, old_end - 32 - length)
    commands(header)  # Structural validation of the replacement header.
    return bytes(header)


def clean_scrt(data, recipe):
    spec = recipe['scrt']
    if len(data) != spec['bytes'] or sha256(data) != spec['before_sha256']:
        raise ValueError('Cleanup requires the exact v3 SCRT revision')
    result = bytearray(data)
    changed = set()
    for patch in spec['patches']:
        offset = patch['offset']
        before = bytes.fromhex(patch['before'])
        if before == RET or len(before) != 4 or data[offset:offset + 4] != before:
            raise ValueError('Unexpected add-on entry preimage')
        if offset in changed:
            raise ValueError('Duplicate add-on entry')
        changed.add(offset)
        result[offset:offset + 4] = RET
    if sha256(result) != spec['after_sha256']:
        raise ValueError('Unexpected cleaned SCRT hash')
    table = spec['initializer_table']
    entries = list(struct.unpack_from('<' + 'I' * table['count'], result, table['offset']))
    if entries != [entry['offset'] for entry in spec['initializers']]:
        raise ValueError('Initializer table changed')
    for entry in spec['initializers'] + spec['objc_loads']:
        offset = entry['offset']
        if entry['retained']:
            if result[offset:offset + 4] != data[offset:offset + 4] or data[offset:offset + 4] == RET:
                raise ValueError('Core initializer changed')
        elif result[offset:offset + 4] != RET:
            raise ValueError('An add-on activation entry remains active')
    return bytes(result)


def checked_members(archive, expected_count):
    entries = archive.infolist()
    if len({entry.filename for entry in entries}) != len(entries):
        raise ValueError('Duplicate archive entries')
    for entry in entries:
        path = PurePosixPath(entry.filename)
        if path.is_absolute() or '..' in path.parts or not path.parts or path.parts[0] != 'Payload':
            raise ValueError('Unsafe archive path')
        if stat.S_ISLNK(entry.external_attr >> 16) or entry.flag_bits & 1:
            raise ValueError('Links and encrypted entries are unsupported')
    files = [entry for entry in entries if not entry.is_dir()]
    if len(files) != expected_count:
        raise ValueError('Unexpected archive file count')
    return sorted(files, key=lambda entry: entry.filename)


def chunks(handle):
    while data := handle.read(CHUNK):
        yield data


def checked_bytes(data, spec, field='before_sha256'):
    if len(data) != spec['bytes'] or sha256(data) != spec[field]:
        raise ValueError(f'Unexpected input/output bytes for {spec["path"]}')


def build(source, output, recipe, report_path=None):
    source, output = source.resolve(), output.resolve()
    if output == source or output.exists():
        raise ValueError('Use a new output path; existing files are never overwritten')
    if report_path and (report_path.resolve() in (source, output) or report_path.exists()):
        raise ValueError('Use a separate new report path')
    with source.open('rb') as handle:
        digest = hashlib.file_digest(handle, 'sha256').hexdigest()
    if digest != recipe['source']['sha256'] or source.stat().st_size != recipe['source']['bytes']:
        raise ValueError('Unknown source IPA; refusing offsets from another build')
    base_spec = json.loads((ROOT / recipe['base_patch_manifest']).read_text())
    if base_spec['id'] != recipe['base_patch_id'] or base_spec['after_sha256'] != recipe['scrt']['before_sha256']:
        raise ValueError('Base patch revision changed')
    removals = {entry['path']: entry for entry in recipe['remove_files']}
    inventory, modified = [], []
    output.parent.mkdir(parents=True, exist_ok=True)
    fd, name = tempfile.mkstemp(prefix='.clean-ipa-', suffix='.ipa', dir=output.parent)
    os.close(fd)
    temporary = Path(name)
    try:
        with zipfile.ZipFile(source) as original, zipfile.ZipFile(temporary, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=6) as rebuilt:
            files = checked_members(original, recipe['source']['files'])
            names = {entry.filename for entry in files}
            if not set(removals).issubset(names) or not {recipe['main']['path'], recipe['scrt']['path']}.issubset(names):
                raise ValueError('Missing audited file')
            for entry in files:
                path = entry.filename
                if path in removals:
                    checked_bytes(original.read(entry), removals[path], 'sha256')
                    continue
                info = zipfile.ZipInfo(path, date_time=(1980, 1, 1, 0, 0, 0))
                info.create_system = entry.create_system
                info.external_attr = entry.external_attr
                info.compress_type = zipfile.ZIP_DEFLATED
                info.file_size = entry.file_size
                digest = hashlib.sha256()
                with rebuilt.open(info, 'w') as destination:
                    if path == recipe['main']['path']:
                        data = original.read(entry)
                        checked_bytes(data, recipe['main'])
                        prefix = main_header_without_addon(data, recipe['main']['remove_load'])
                        destination.write(prefix)
                        digest.update(prefix)
                        remainder = memoryview(data)[len(prefix):]
                        for start in range(0, len(remainder), CHUNK):
                            part = remainder[start:start + CHUNK]
                            destination.write(part)
                            digest.update(part)
                        del remainder, part, data
                        if digest.hexdigest() != recipe['main']['after_sha256']:
                            raise ValueError('Unexpected cleaned main binary hash')
                    elif path == recipe['scrt']['path']:
                        data, _ = prepare_binary(original.read(entry), base_spec)
                        data = clean_scrt(data, recipe)
                        destination.write(data)
                        digest.update(data)
                    else:
                        with original.open(entry) as handle:
                            for part in chunks(handle):
                                destination.write(part)
                                digest.update(part)
                record = {'path': path, 'sha256': digest.hexdigest(), 'bytes': entry.file_size}
                inventory.append(record)
                if path in (recipe['main']['path'], recipe['scrt']['path']):
                    modified.append(record)
        # Read every output byte back: CRC, inventory, hash and size verification.
        with zipfile.ZipFile(temporary) as archive:
            checked_members(archive, len(inventory))
            if set(archive.namelist()) != {entry['path'] for entry in inventory}:
                raise ValueError('Rebuilt archive inventory mismatch')
            for entry in inventory:
                with archive.open(entry['path']) as handle:
                    actual = hashlib.file_digest(handle, 'sha256').hexdigest()
                if actual != entry['sha256'] or archive.getinfo(entry['path']).file_size != entry['bytes']:
                    raise ValueError('Rebuilt file verification failed')
        with temporary.open('rb') as handle:
            archive_hash = hashlib.file_digest(handle, 'sha256').hexdigest()
        manifest_text = ''.join(f'{entry["sha256"]}  {entry["path"]}\n' for entry in inventory)
        result = {'recipe': recipe['id'], 'source_sha256': recipe['source']['sha256'],
                  'output_filename': output.name, 'output_sha256': archive_hash,
                  'output_bytes': temporary.stat().st_size, 'output_files': len(inventory),
                  'output_uncompressed_bytes': sum(entry['bytes'] for entry in inventory),
                  'inventory_sha256': sha256(manifest_text.encode()), 'signature': 'unsigned',
                  'iphone_tested': False, 'server_behavior_tested': False,
                  'removed_files': recipe['remove_files'], 'modified_files': modified,
                  'unchanged_files': len(inventory) - len(modified), 'zip_crc_and_all_hashes_verified': True}
        # Exclusive publication also prevents overwriting a file created while building.
        os.link(temporary, output)
        if report_path:
            with report_path.open('x', encoding='utf8') as handle:
                json.dump(result, handle, indent=2, ensure_ascii=False)
                handle.write('\n')
        return result
    finally:
        temporary.unlink(missing_ok=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--report', type=Path)
    args = parser.parse_args()
    try:
        result = build(args.source, args.output, json.loads(RECIPE_PATH.read_text()), args.report)
    except (OSError, ValueError, KeyError, zipfile.BadZipFile) as error:
        parser.exit(1, str(error) + '\n')
    print(json.dumps({key: value for key, value in result.items() if key not in ('removed_files', 'modified_files')}))


if __name__ == '__main__':
    main()
