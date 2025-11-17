#!/bin/bash

# Test for rostring
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for rostring
SOURCE="./answers/rostring.c"
BINARY="./build/rostring"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "abc   " "de     fg")
expected="bc abc de fg"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "Que la      lumiere soit et la lumiere fut")
expected="la lumiere soit et la lumiere fut Que"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

# Test 3: Single word
output=$("$BINARY" "test")
expected="test"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All rostring tests passed!"
exit 0
