#!/bin/bash

# Test for repeat_alpha
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for repeat_alpha
SOURCE="./answers/repeat_alpha.c"
BINARY="./build/repeat_alpha"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Basic test
output=$("$BINARY" "abc")
expected="abbccc"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Mixed case
output=$("$BINARY" "Abc")
expected="Abbccc"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: With numbers and special chars
output=$("$BINARY" "21 !")
expected="21 !"
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

echo "All repeat_alpha tests passed!"
exit 0
