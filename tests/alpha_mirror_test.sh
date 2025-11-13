#!/bin/bash

# Test for alpha_mirror
SOURCE="./answers/alpha_mirror.c"
BINARY="./build/alpha_mirror"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Basic test
output=$("$BINARY" "abc")
expected="zyx"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Mixed case
output=$("$BINARY" "My horse is Amazing.")
expected="Nb slihv rh Znzarmt."
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Numbers and special chars
output=$("$BINARY" "abc123")
expected="zyx123"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All alpha_mirror tests passed!"
exit 0
