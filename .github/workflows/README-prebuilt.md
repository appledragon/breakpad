# Breakpad Prebuilt Binaries Workflow

This GitHub Actions workflow is used to automatically build cross-platform prebuilt binary files for Breakpad.

## Features

This workflow supports building prebuilt versions for the following platforms:

### Linux
- **x86_64** (64-bit)
- **i386** (32-bit)

Included tools:
- `minidump_stackwalk` - Process minidump files to produce stack traces
- `minidump_dump` - Dump the contents of a minidump file
- `dump_syms` - Extract debugging symbols from binary files
- `minidump-2-core` - Convert minidump to core dump
- `pid2md` - Generate minidump from running process
- `core2md` - Convert core dump to minidump
- `libbreakpad_client.a` - Crash reporting client library
- `libbreakpad.a` - Minidump processor library

### macOS
- **x86_64** (Intel 64-bit)
- **arm64** (Apple Silicon)

Included tools:
- `minidump_stackwalk` - Process minidump files to produce stack traces
- `minidump_dump` - Dump the contents of a minidump file
- `dump_syms` - Extract debugging symbols from Mach-O binary files
- `libbreakpad.a` - Crash reporting client library
- `libbreakpad_processor.a` - Minidump processor library

### Windows
- **x86** (32-bit)
- **x64** (64-bit)

Included tools:
- `dump_syms.exe` - Extract debugging symbols from PE binary files
- `symupload.exe` - Upload symbol files to crash reporting server
- `minidump_stackwalk.exe` - Process minidump files to produce stack traces
- Client libraries and header files for integration

## Trigger Methods

This workflow can be triggered in the following ways:

1. **Version tag push**: When pushing tags starting with `v` (e.g., `v1.0.0`)
2. **Manual trigger**: Manually run through the GitHub Actions interface

## Usage

### 1. Create a Release Version

Push a version tag:
```bash
git tag v1.0.0
git push origin v1.0.0
```

### 2. Manual Trigger Build

1. Visit the GitHub repository's Actions page
2. Select the "Build Prebuilt Binaries" workflow
3. Click "Run workflow"
4. Optionally specify a release tag name (defaults to "nightly")

### 3. Download Prebuilt Files

After the build completes, a GitHub Release will be automatically created containing prebuilt binary files for all platforms:

- `breakpad-linux-x86_64.tar.gz` - Linux 64-bit binary files
- `breakpad-linux-i386.tar.gz` - Linux 32-bit binary files
- `breakpad-macos-x86_64.tar.gz` - macOS Intel 64-bit binary files
- `breakpad-macos-arm64.tar.gz` - macOS Apple Silicon binary files
- `breakpad-windows-x64.zip` - Windows 64-bit binary files
- `breakpad-windows-x86.zip` - Windows 32-bit binary files

## Build Environment

- **Linux**: Ubuntu Latest, using autotools build system
- **macOS**: macOS Latest, supporting Intel and Apple Silicon architectures
- **Windows**: Windows 2019, using Visual Studio 2019

## Dependencies

This workflow automatically handles the following dependencies:
- Google's depot_tools
- Build toolchains for each platform
- Necessary compilers and libraries

## Troubleshooting

If the Windows build fails, the workflow will try multiple build methods:
1. Use existing solution files
2. Manually compile individual tools
3. Include header files and libraries for development use

Each release package includes a README.txt file explaining the included tools and usage instructions.

## Custom Configuration

You can customize the build configuration by modifying the `.github/workflows/build-prebuilt.yml` file:

- Modify target architectures
- Add or remove build tools
- Adjust build parameters
- Change release format

## Related Documentation

- [Breakpad Official Documentation](https://chromium.googlesource.com/breakpad/breakpad/+/master/docs/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Depot Tools Documentation](https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html)
