#!/bin/bash

# Example script showing how to use prebuilt Breakpad binaries
# This script demonstrates basic usage of the key Breakpad tools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Breakpad Prebuilt Binaries Usage Example${NC}"
echo "================================================"

# Check if tools exist
TOOLS_DIR="$(dirname "$0")"
DUMP_SYMS="$TOOLS_DIR/dump_syms"
MINIDUMP_STACKWALK="$TOOLS_DIR/minidump_stackwalk"
MINIDUMP_DUMP="$TOOLS_DIR/minidump_dump"

# Make tools executable (in case they aren't)
chmod +x "$DUMP_SYMS" "$MINIDUMP_STACKWALK" "$MINIDUMP_DUMP" 2>/dev/null || true

echo "1. Extracting symbols from a binary:"
echo -e "${YELLOW}Usage: ./dump_syms <binary> > symbols.sym${NC}"
echo "Example: ./dump_syms /bin/ls > ls.sym"
echo

echo "2. Processing a minidump file:"
echo -e "${YELLOW}Usage: ./minidump_stackwalk <minidump> [symbol_paths...]${NC}"
echo "Example: ./minidump_stackwalk crash.dmp ./symbols/"
echo

echo "3. Dumping minidump contents:"
echo -e "${YELLOW}Usage: ./minidump_dump <minidump>${NC}"
echo "Example: ./minidump_dump crash.dmp"
echo

echo "4. Complete workflow example:"
echo "# Extract symbols from your application"
echo "./dump_syms /path/to/your/app > app.sym"
echo
echo "# Create symbols directory structure"
echo "mkdir -p symbols/your_app/VERSION/your_app.sym"
echo "mv app.sym symbols/your_app/VERSION/"
echo
echo "# Process crash dump with symbols"
echo "./minidump_stackwalk crash.dmp symbols/"
echo

echo -e "${GREEN}For detailed documentation, visit:${NC}"
echo "https://chromium.googlesource.com/breakpad/breakpad/+/master/docs/"

# Check if any tools are missing
missing_tools=()
[ ! -f "$DUMP_SYMS" ] && missing_tools+=("dump_syms")
[ ! -f "$MINIDUMP_STACKWALK" ] && missing_tools+=("minidump_stackwalk") 
[ ! -f "$MINIDUMP_DUMP" ] && missing_tools+=("minidump_dump")

if [ ${#missing_tools[@]} -gt 0 ]; then
    echo
    echo -e "${RED}Warning: The following tools are missing:${NC}"
    printf '%s\n' "${missing_tools[@]}"
    echo "Please ensure you have downloaded the complete prebuilt package."
fi
