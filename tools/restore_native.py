#!/usr/bin/env python3
"""Remove the known injections and restore bundle IDs; not an App Store original."""
import argparse
import json
from pathlib import Path
import zipfile

from clean_ipa import ROOT, build


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--report', type=Path)
    args = parser.parse_args()
    recipe = json.loads((ROOT / 'tools/native_baseline/recipe.json').read_text())
    try:
        result = build(args.source, args.output, recipe, args.report)
    except (OSError, ValueError, KeyError, zipfile.BadZipFile) as error:
        parser.exit(1, str(error) + '\n')
    print(json.dumps({key: value for key, value in result.items()
                      if key not in ('removed_files', 'modified_files', 'source_limitations')}))


if __name__ == '__main__':
    main()
