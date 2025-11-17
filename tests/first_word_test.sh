#!/bin/bash

# Test for first_word
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true

# Use dynamic source file if provided, otherwise use default
SOURCE="${CURRENT_SOURCE_FILE:-./answers/first_word.c}"
BINARY="./build/first_word"

# Compile with Verter standard compiler (CLANG)
$CC $CFLAGS "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed:"
    $CC $CFLAGS "$SOURCE" -o "$BINARY" 2>&1
    exit 1
fi

# Test 1: Normal case
output=$("$BINARY" "hello world")
expected="hello"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Multiple words
output=$("$BINARY" "  FOR PONY")
expected="FOR"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: No arguments
output=$("$BINARY")
expected=""
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected empty line, got '$output'"
    exit 1
fi

# Test 4: Only spaces
output=$("$BINARY" "   ")
expected=""
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected empty line, got '$output'"
    exit 1
fi

# Test 5: Single word
output=$("$BINARY" "testing")
expected="testing"
if [ "$output" != "$expected" ]; then
    echo "Test 5 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All first_word tests passed!"
exit 0
