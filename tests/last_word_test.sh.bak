#!/bin/bash

# Test for last_word
SOURCE="./answers/last_word.c"
BINARY="./build/last_word"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Normal case
output=$("$BINARY" "FOR PONY")
expected="PONY"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: With trailing spaces
output=$("$BINARY" "this        ...       is sparta, then again, maybe    not")
expected="not"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Single word
output=$("$BINARY" "hello")
expected="hello"
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

echo "All last_word tests passed!"
exit 0
