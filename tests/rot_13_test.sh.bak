#!/bin/bash

# Test for rot_13
SOURCE="./answers/rot_13.c"
BINARY="./build/rot_13"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Basic test
output=$("$BINARY" "abc")
expected="nop"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Full alphabet
output=$("$BINARY" "abcdefghijklmnopqrstuvwxyz")
expected="nopqrstuvwxyzabcdefghijklm"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Mixed case
output=$("$BINARY" "My horse is Amazing.")
expected="Zl ubefr vf Nznmvat."
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

echo "All rot_13 tests passed!"
exit 0
