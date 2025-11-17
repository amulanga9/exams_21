#!/bin/bash

# Test for rev_wstr
SOURCE="./answers/rev_wstr.c"
BINARY="./build/rev_wstr"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "the time of contempt precedes that of indifference")
expected="indifference of that precedes contempt of time the"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "hello world")
expected="world hello"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Single word
output=$("$BINARY" "test")
expected="test"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All rev_wstr tests passed!"
exit 0
