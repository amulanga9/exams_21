#!/bin/bash

# Test for ulstr
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ulstr
SOURCE="./answers/ulstr.c"
BINARY="./build/ulstr"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Mixed case
output=$("$BINARY" "L'eSPrit nE peUt plUs pRogResSer s'Il staGne et sI peRsIsTent VAnIte et auto-justification.")
expected="l'EspRIT Ne PEuT PLuS PrOGrESsER S'iL STAgNE ET Si PErSiStENT vaNiTE ET AUTO-JUSTIFICATION."
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed"
    echo "Expected: $expected"
    echo "Got: $output"
    exit 1
fi

# Test 2: All lowercase
output=$("$BINARY" "abcdefghijklmnopqrstuvwxyz")
expected="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: All uppercase
output=$("$BINARY" "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
expected="abcdefghijklmnopqrstuvwxyz"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 4: No arguments
output=$("$BINARY")
expected=""
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected empty line"
    exit 1
fi

echo "All ulstr tests passed!"
exit 0
