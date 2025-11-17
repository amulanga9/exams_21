#!/bin/bash

# Test for paramsum
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for paramsum
SOURCE="./answers/paramsum.c"
BINARY="./build/paramsum"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "a" "b" "c")
expected="3"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "hello" "world" "test" "123")
expected="4"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: No arguments
output=$("$BINARY")
expected="0"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 4: Single argument
output=$("$BINARY" "test")
expected="1"
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All paramsum tests passed!"
exit 0
