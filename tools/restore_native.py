#!/usr/bin/env python3
"""Remove the known injections and restore bundle IDs; not an App Store original."""
import argparse
import json
from pathlib import Path
import zipfile

from clean_ipa import ROOT, build


def load_recipe(preserve_source_metadata=False):
    recipe = json.loads((ROOT / 'tools/native_baseline/recipe.json').read_text())
    if preserve_source_metadata:
        recipe['id'] = 'native-baseline-metadata-control-v1'
        recipe['restore_plists'] = []
        recipe['limitations'] = [
            'Diagnostic control, not a confirmed login or AutoFill fix',
            'All input metadata is retained byte for byte, including bundle IDs and MinimumOSVersion',
            'All identified injected libraries remain removed; no spoof or DeviceCheck replacement is restored',
            'The input was already modified; official App Store equivalence is not verified',
            'Six native extension binaries retain cryptid=1; signing and extension functionality remain unverified',
            'No on-device or server validation of this control; existing on-device data is not erased',
        ]
    return recipe


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--report', type=Path)
    parser.add_argument('--preserve-source-metadata', action='store_true',
                        help='Diagnostic control: retain every input plist byte for byte')
    args = parser.parse_args()
    recipe = load_recipe(args.preserve_source_metadata)
    try:
        result = build(args.source, args.output, recipe, args.report)
    except (OSError, ValueError, KeyError, zipfile.BadZipFile) as error:
        parser.exit(1, str(error) + '\n')
    print(json.dumps({key: value for key, value in result.items()
                      if key not in ('removed_files', 'modified_files', 'source_limitations')}))


if __name__ == '__main__':
    main()
