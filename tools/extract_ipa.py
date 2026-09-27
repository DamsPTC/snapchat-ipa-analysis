#!/usr/bin/env python3
"""Extract and document the exact archived IPA without running its binaries."""
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import plistlib
import stat
import sys
import zipfile

EXPECTED_SHA256 = '416aa57047ef1aaa77d03d1ca4c69759412b11d8141da877306be94d2bf633e9'
EXPECTED_FILE_COUNT = 8112


def main():
    source = Path(sys.argv[1]).resolve()
    root = Path(sys.argv[2]).resolve() if len(sys.argv) > 2 else Path.cwd()
    root.mkdir(parents=True, exist_ok=True)
    actual = hashlib.file_digest(source.open('rb'), 'sha256').hexdigest()
    if actual != EXPECTED_SHA256:
        raise SystemExit(f'Unexpected IPA SHA-256: {actual}')
    manifest = []
    versions = []
    plist_copies = []
    with zipfile.ZipFile(source) as archive:
        files = [info for info in archive.infolist() if not info.is_dir()]
        if len(files) != EXPECTED_FILE_COUNT:
            raise SystemExit('Unexpected file count')
        if len({info.filename for info in files}) != len(files):
            raise SystemExit('Duplicate archive entries')
        for info in archive.infolist():
            path = PurePosixPath(info.filename)
            if path.is_absolute() or '..' in path.parts or not path.parts or path.parts[0] != 'Payload':
                raise SystemExit(f'Unexpected archive path: {path}')
            mode = info.external_attr >> 16
            if stat.S_ISLNK(mode):
                raise SystemExit(f'Unexpected symbolic link: {path}')
            target = root.joinpath(*path.parts)
            if info.is_dir():
                target.mkdir(parents=True, exist_ok=True)
                continue
            data = archive.read(info)  # ZIP CRC is verified by zipfile.
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)
            os.chmod(target, 0o755 if mode & 0o111 else 0o644)
            digest = hashlib.sha256(data).hexdigest()
            manifest.append((info.filename, digest, len(data)))
            if info.filename.endswith('/Info.plist'):
                try:
                    contents = plistlib.loads(data)
                except Exception:
                    continue
                if 'CFBundleIdentifier' in contents:
                    versions.append({
                        'path': info.filename,
                        'bundle_id': contents.get('CFBundleIdentifier'),
                        'version': contents.get('CFBundleShortVersionString'),
                        'build': contents.get('CFBundleVersion'),
                    })
                    plist_copies.append((path, contents))
    app = next(v for v in versions if v['path'] == 'Payload/Snapchat.app/Info.plist')
    assert app['version'] == '12.81.0' and app['build'] == '12.81.0.47'
    for name, expected, _ in manifest:
        with root.joinpath(*PurePosixPath(name).parts).open('rb') as handle:
            assert hashlib.file_digest(handle, 'sha256').hexdigest() == expected, name
    analysis = root / 'analysis'
    analysis.mkdir(exist_ok=True)
    for path, contents in plist_copies:
        exported = analysis / 'plists' / str(path)
        exported = exported.with_suffix('.xml')
        exported.parent.mkdir(parents=True, exist_ok=True)
        exported.write_bytes(plistlib.dumps(contents, fmt=plistlib.FMT_XML, sort_keys=False))
    (analysis / 'versions.json').write_text(json.dumps(versions, indent=2, ensure_ascii=False) + '\n')
    inventory = {
        'source_filename': source.name,
        'source_sha256': actual,
        'source_bytes': source.stat().st_size,
        'extracted_files': len(manifest),
        'extracted_bytes': sum(size for _, _, size in manifest),
        'version': app['version'],
        'build': app['build'],
        'signature': 'unsigned',
        'extraction_preserves_file_bytes': True,
        'runtime_tested': False,
        'files': [{'path': name, 'sha256': digest, 'bytes': size} for name, digest, size in manifest],
    }
    (analysis / 'manifest.json').write_text(json.dumps(inventory, indent=2, ensure_ascii=False) + '\n')
    (root / 'FILES.sha256').write_text(''.join(f'{digest}  {name}\n' for name, digest, _ in manifest))
    (root / 'README.md').write_text('''# Snapchat — IPA extraite pour analyse

Archive privée du contenu exact de `Snapchat_DeviceCheck_etude_unsigned.ipa`,
version **12.81.0**, build **12.81.0.47**.

Cette révision est celle dont la version déclarée a été corrigée et dont certains
ajouts ont été désactivés. Aucun autre changement de l’application n’est effectué
lors de cet import.

## Contenu

- `Payload/Snapchat.app/` : fichiers extraits, binaires et ressources.
- `analysis/plists/` : copies XML lisibles des métadonnées ; les fichiers originaux
  restent inchangés dans `Payload/`.
- `analysis/versions.json` : versions et identifiants déclarés par les composants.
- `analysis/manifest.json` et `FILES.sha256` : inventaire et empreintes SHA-256.
- `tools/extract_ipa.py` : extraction contrôlée de cette archive précise.
- L’IPA complète, non signée, est jointe à la release `v12.81.0-version-fix`.

L’extraction donne les fichiers compilés distribués dans l’application.
Il ne s’agit pas du code source Swift/Objective-C ni d’un projet Xcode.

## Modifications déjà présentes dans cette révision

- `CFBundleShortVersionString` rétabli à `12.81.0`, build `12.81.0.47` conservé.
- Initialisateur de réécriture des versions/en-têtes en `13.67.1` désactivé.
- `Assets.der`, `I.plist`, `snappy.framework` et sa dépendance de chargement retirés.
- Plusieurs points d’activation des ajouts Snap++ désactivés.
- Initialisation du logger et fonction `_fwlog` neutralisées.
- Anciennes signatures et anciens profils de distribution retirés.

Du code dormant reste dans SCRT. Le hook de connexion, les interceptions du
runtime et SKEngine restent présents. Ce n’est pas une purge complète des ajouts,
ni une application officielle, ni une garantie de sécurité ou de connexion.
Le fonctionnement sur iPhone de cette révision n’a pas été validé.

## Récupération complète

Le binaire principal de 204 641 792 octets est stocké avec **Git LFS**.
Après un clonage authentifié du dépôt :

```sh
git lfs install
git lfs pull
sha256sum -c FILES.sha256
```

Un simple téléchargement ZIP du dépôt peut ne contenir que le pointeur LFS
du binaire principal. L’IPA jointe à la release contient toujours tous les fichiers.

Empreinte SHA-256 de l’IPA exacte :

```text
416aa57047ef1aaa77d03d1ca4c69759412b11d8141da877306be94d2bf633e9
```
''', encoding='utf-8')
    print(json.dumps({k: v for k, v in inventory.items() if k != 'files'}, ensure_ascii=False))


if __name__ == '__main__':
    main()
