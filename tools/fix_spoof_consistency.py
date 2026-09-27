#!/usr/bin/env python3
"""Apply an audited, hash-pinned patch; never execute any application binary."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import tempfile


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def atomic_write(path, data):
    mode = path.stat().st_mode & 0o777 if path.exists() else 0o644
    with tempfile.NamedTemporaryFile(dir=path.parent, prefix='.spoof-fix-', delete=False) as handle:
        temporary = Path(handle.name)
        handle.write(data)
    try:
        os.chmod(temporary, mode)
        os.replace(temporary, path)
    finally:
        temporary.unlink(missing_ok=True)


def prepare_binary(original, spec):
    """Validate and patch bytes without filesystem writes or application execution."""
    digest = sha256(original)
    applied = {
        spec['before_sha256']: set(),
        spec['after_sha256']: {patch['id'] for patch in spec['patches']},
    }
    for revision in spec.get('intermediate_revisions', []):
        applied[revision['sha256']] = set(revision['patch_ids'])
    if digest not in applied or len(original) != spec['bytes']:
        raise ValueError('Unknown SCRT binary: refusing offsets from another build')
    modified = bytearray(original)
    seen = set()
    for patch in spec['patches']:
        before, after = bytes.fromhex(patch['before']), bytes.fromhex(patch['after'])
        offset = patch['offset']
        region = set(range(offset, offset + len(before)))
        if not before or len(before) != len(after) or offset < 0 or offset + len(before) > len(original) or region & seen:
            raise ValueError('Invalid or overlapping patch region')
        seen.update(region)
        expected = after if patch['id'] in applied[digest] else before
        if original[offset:offset + len(before)] != expected:
            raise ValueError(f'Preimage mismatch for {patch["id"]}')
        modified[offset:offset + len(after)] = after
    if sha256(modified) != spec['after_sha256']:
        raise ValueError('Patched checksum does not match the audited result')
    for guard in spec['activation_guards']:
        offset, expected = guard['offset'], bytes.fromhex(guard['bytes'])
        if modified[offset:offset + len(expected)] != expected:
            raise ValueError(f'Activation guard changed: {guard["name"]}')
    return bytes(modified), applied


def prepare(root, spec):
    binary = root / spec['path']
    modified, applied = prepare_binary(binary.read_bytes(), spec)

    manifest_path = root / 'analysis/manifest.json'
    manifest = json.loads(manifest_path.read_text())
    entries = [entry for entry in manifest['files'] if entry['path'] == spec['path']]
    if len(entries) != 1 or entries[0]['sha256'] not in applied:
        raise ValueError('Unexpected manifest entry for SCRT')
    if entries[0]['bytes'] != spec['bytes']:
        raise ValueError('Manifest byte count changed')
    entries[0]['sha256'] = spec['after_sha256']
    manifest['extraction_preserves_file_bytes'] = False
    manifest['runtime_tested'] = False
    manifest['derived_revision'] = {
        'patch_set': spec['id'],
        'upstream_commit': spec['upstream_commit'],
        'patch_manifest': 'tools/spoof_fix/patches.json',
        'device_profile': spec.get('device_profile'),
        'modified_files': [spec['path']],
        'iphone_tested': False,
        'note': 'source_* fields identify the unmodified upstream IPA, not a rebuilt IPA',
    }

    sums_path = root / 'FILES.sha256'
    lines = sums_path.read_text().splitlines(keepends=True)
    matching = [index for index, line in enumerate(lines) if line.rstrip('\n').endswith('  ' + spec['path'])]
    if len(matching) != 1 or lines[matching[0]][:64] not in applied:
        raise ValueError('Unexpected FILES.sha256 entry for SCRT')
    lines[matching[0]] = spec['after_sha256'] + '  ' + spec['path'] + '\n'

    readme_path = root / 'README.md'
    readme = readme_path.read_text()
    readme = readme.replace('Archive privée du contenu exact de', 'Archive privée dérivée du contenu de')
    readme = readme.replace(
        'ajouts ont été désactivés. Aucun autre changement de l’application n’est effectué\nlors de cet import.',
        'ajouts ont été désactivés. Les correctifs de cohérence documentés ci-dessous\nsont ensuite appliqués de façon reproductible après l’extraction.')
    readme = readme.replace('Empreinte SHA-256 de l’IPA exacte :', 'Empreinte SHA-256 de l’IPA source, avant ces correctifs :')
    marker = '\n<!-- spoof-consistency-v1 -->\n'
    readme = readme.split(marker, 1)[0].rstrip() + marker
    readme += (root / 'tools/spoof_fix/README.fragment.md').read_text()
    return {
        binary: bytes(modified),
        manifest_path: (json.dumps(manifest, indent=2, ensure_ascii=False) + '\n').encode(),
        sums_path: ''.join(lines).encode(),
        readme_path: readme.encode(),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--check', action='store_true', help='Require already patched binary and consistent inventories')
    args = parser.parse_args()
    root = args.root.resolve()
    spec = json.loads((root / 'tools/spoof_fix/patches.json').read_text())
    try:
        writes = prepare(root, spec)  # Validate every precondition before the first write.
        changed = [str(path.relative_to(root)) for path, data in writes.items() if path.read_bytes() != data]
        if args.check and changed:
            raise ValueError('Patch or metadata needs applying: ' + ', '.join(changed))
        if not args.check:
            for path, data in writes.items():
                if path.read_bytes() != data:
                    atomic_write(path, data)
    except (ValueError, KeyError, OSError) as error:
        parser.exit(1, str(error) + '\n')
    print(json.dumps({'patch_set': spec['id'], 'sha256': spec['after_sha256'], 'changed_files': changed, 'iphone_tested': False}))


if __name__ == '__main__':
    main()
