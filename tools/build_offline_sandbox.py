"""Build a new, standalone offline UIKit laboratory; never read or patch an IPA."""
import argparse
import hashlib
import json
import os
import platform
import plistlib
from pathlib import Path
import struct
import subprocess
import zipfile


IDENTIFIER = 'com.damsptc.snaplab.offline'
APP_NAME = 'SnapLab'
SOURCE = Path(__file__).resolve().parent / 'offline_sandbox'


def run(*args):
    return subprocess.check_output(args, text=True).strip()


def inspect_device_binary(data):
    if struct.unpack_from('<II', data) != (0xfeedfacf, 0x100000c):
        raise ValueError('Expected thin ARM64 Mach-O')
    count, total = struct.unpack_from('<II', data, 16)
    if total > len(data) - 32 or count > 512:
        raise ValueError('Invalid Mach-O commands')
    position, imports, build_platform = 32, [], None
    allowed = {
        '/System/Library/Frameworks/UIKit.framework/UIKit',
        '/System/Library/Frameworks/Foundation.framework/Foundation',
        '/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation',
        '/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics',
        '/usr/lib/libobjc.A.dylib', '/usr/lib/libSystem.B.dylib',
    }
    for _ in range(count):
        kind, length = struct.unpack_from('<II', data, position)
        if length < 8 or position + length > 32 + total:
            raise ValueError('Invalid load command')
        if kind == 0x1d:
            raise ValueError('Device binary must be unsigned')
        if kind in (0xc, 0x80000018, 0x8000001f, 0x80000023):
            name_offset = struct.unpack_from('<I', data, position + 8)[0]
            end = data.index(b'\0', position + name_offset, position + length)
            name = data[position + name_offset:end].decode()
            if name not in allowed:
                raise ValueError('Unexpected dependency: ' + name)
            imports.append(name)
        if kind == 0x32:
            build_platform = struct.unpack_from('<I', data, position + 8)[0]
        position += length
    if position != 32 + total or build_platform != 2:
        raise ValueError('Expected iPhoneOS platform')
    return imports


def build(output, simulator):
    output.mkdir(parents=True, exist_ok=True)
    app = output / 'Payload' / f'{APP_NAME}.app'
    app.mkdir(parents=True, exist_ok=False)
    source_names = ['LabModel.h', 'LabModel.m', 'LabApp.m']
    sources = {name: (SOURCE / name).read_bytes() for name in source_names}
    # This target has no network transport, identity hooks, runtime rebinding or real DeviceCheck adapter.
    forbidden = [b'NSURLSession', b'NSURLConnection', b'CFNetwork', b'http://', b'https://',
                 b'identifierForVendor', b'MGCopyAnswer', b'method_setImplementation',
                 b'method_exchangeImplementations', b'dlopen(', b'dlsym(']
    if any(marker in text for text in sources.values() for marker in forbidden):
        raise ValueError('Unexpected transport or interception code in offline target')
    sdk = 'iphonesimulator' if simulator else 'iphoneos'
    arch = platform.machine() if simulator else 'arm64'
    target = f'{arch}-apple-ios15.0' + ('-simulator' if simulator else '')
    sdk_path = run('xcrun', '--sdk', sdk, '--show-sdk-path')
    command = ['xcrun', '--sdk', sdk, 'clang', '-target', target, '-isysroot', sdk_path,
               '-fobjc-arc', '-fblocks', '-std=gnu11', '-O1', '-Wall', '-Wextra', '-Werror',
               '-framework', 'Foundation', '-framework', 'UIKit', '-framework', 'CoreGraphics',
               f'-DLAB_ENABLE_SELF_TEST={int(simulator)}',
               str(SOURCE / 'LabModel.m'), str(SOURCE / 'LabApp.m'), '-o', str(app / APP_NAME)]
    if not simulator:
        command += ['-Wl,-no_adhoc_codesign']
    subprocess.run(command, check=True)
    info = {
        'CFBundleExecutable': APP_NAME, 'CFBundleIdentifier': IDENTIFIER,
        'CFBundleDisplayName': 'SnapLab local', 'CFBundleName': APP_NAME,
        'CFBundlePackageType': 'APPL', 'CFBundleVersion': '1',
        'CFBundleShortVersionString': '0.1.0', 'MinimumOSVersion': '15.0',
        'LSRequiresIPhoneOS': True, 'UIDeviceFamily': [1, 2],
        'CFBundleSupportedPlatforms': ['iPhoneSimulator' if simulator else 'iPhoneOS'],
        'UILaunchScreen': {}, 'UISupportedInterfaceOrientations': ['UIInterfaceOrientationPortrait'],
        'UIApplicationSceneManifest': {
            'UIApplicationSupportsMultipleScenes': False,
            'UISceneConfigurations': {'UIWindowSceneSessionRoleApplication': [{
                'UISceneConfigurationName': 'Default', 'UISceneDelegateClassName': 'LabSceneDelegate',
            }]},
        },
    }
    (app / 'Info.plist').write_bytes(plistlib.dumps(info))
    if simulator:
        subprocess.run(['codesign', '--force', '--sign', '-', '--timestamp=none', str(app)], check=True)
        print(app)
        return
    binary = (app / APP_NAME).read_bytes()
    imports = inspect_device_binary(binary)
    for forbidden_binary in [b'snapchat.janus.api', b'SCRT.framework', b'LAB_SELF_TEST',
                             b'lab-ui-test-result.json', b'runSelfTest']:
        if forbidden_binary in binary:
            raise ValueError('Unexpected legacy/client or simulator-only code')
    destination = output / 'SnapLab_Offline_unsigned.ipa'
    original = {}
    with zipfile.ZipFile(destination, 'x', zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for file in sorted(app.iterdir()):
            name = file.relative_to(output).as_posix()
            data = file.read_bytes()
            original[name] = data
            entry = zipfile.ZipInfo(name, (2026, 9, 27, 0, 0, 0))
            entry.create_system = 3
            entry.external_attr = (0o100755 if file.name == APP_NAME else 0o100644) << 16
            archive.writestr(entry, data, compress_type=zipfile.ZIP_DEFLATED, compresslevel=9)
    with zipfile.ZipFile(destination) as archive:
        if set(archive.namelist()) != set(original) or archive.testzip() is not None:
            raise ValueError('Archive inventory/CRC mismatch')
        for name, data in original.items():
            if archive.read(name) != data:
                raise ValueError('Archive contents changed')
    digest = hashlib.sha256(destination.read_bytes()).hexdigest()
    report = {
        'format': 1, 'target': 'standalone_offline_sandbox', 'commit': os.getenv('GITHUB_SHA'),
        'bundle_identifier': IDENTIFIER, 'ipa_sha256': digest, 'ipa_size': destination.stat().st_size,
        'source_sha256': {name: hashlib.sha256(data).hexdigest() for name, data in sources.items()},
        'device_binary_sha256': hashlib.sha256(binary).hexdigest(), 'imports': imports,
        'sdk_version': run('xcrun', '--sdk', 'iphoneos', '--show-sdk-version'),
        'profile': {'model': 'iPhone 12 mini', 'product_type': 'iPhone13,1', 'serial': 'SIM12MINI002'},
        'devicecheck': 'local_simulation_only', 'real_authentication_transport': False,
        'original_ipa_modified': False, 'original_login_fixed': False, 'original_autofill_fixed': False,
        'simulator_self_test_code_in_device_binary': False,
    }
    (output / 'offline-sandbox-build.json').write_text(json.dumps(report, indent=2) + '\n')
    (output / 'SHA256SUMS.txt').write_text(f'{digest}  {destination.name}\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output', type=Path)
    parser.add_argument('--simulator', action='store_true')
    args = parser.parse_args()
    build(args.output, args.simulator)
