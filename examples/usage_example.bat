@echo off
REM Example script showing how to use prebuilt Breakpad binaries on Windows
REM This script demonstrates basic usage of the key Breakpad tools

echo Breakpad Prebuilt Binaries Usage Example (Windows)
echo ===================================================
echo.

set TOOLS_DIR=%~dp0
set DUMP_SYMS=%TOOLS_DIR%dump_syms.exe
set MINIDUMP_STACKWALK=%TOOLS_DIR%minidump_stackwalk.exe
set MINIDUMP_DUMP=%TOOLS_DIR%minidump_dump.exe

echo 1. Extracting symbols from a binary:
echo Usage: dump_syms.exe ^<binary^> ^> symbols.sym
echo Example: dump_syms.exe myapp.exe ^> myapp.sym
echo.

echo 2. Processing a minidump file:
echo Usage: minidump_stackwalk.exe ^<minidump^> [symbol_paths...]
echo Example: minidump_stackwalk.exe crash.dmp .\symbols\
echo.

echo 3. Dumping minidump contents:
echo Usage: minidump_dump.exe ^<minidump^>
echo Example: minidump_dump.exe crash.dmp
echo.

echo 4. Complete workflow example:
echo # Extract symbols from your application
echo dump_syms.exe C:\path\to\your\app.exe ^> app.sym
echo.
echo # Create symbols directory structure
echo mkdir symbols\your_app\VERSION\
echo move app.sym symbols\your_app\VERSION\
echo.
echo # Process crash dump with symbols
echo minidump_stackwalk.exe crash.dmp symbols\
echo.

echo For detailed documentation, visit:
echo https://chromium.googlesource.com/breakpad/breakpad/+/master/docs/
echo.

REM Check if any tools are missing
set missing_tools=
if not exist "%DUMP_SYMS%" set missing_tools=%missing_tools% dump_syms.exe
if not exist "%MINIDUMP_STACKWALK%" set missing_tools=%missing_tools% minidump_stackwalk.exe
if not exist "%MINIDUMP_DUMP%" set missing_tools=%missing_tools% minidump_dump.exe

if not "%missing_tools%"=="" (
    echo Warning: The following tools are missing:
    echo %missing_tools%
    echo Please ensure you have downloaded the complete prebuilt package.
)

pause
