#!/bin/bash

# Test for rev_print
SOURCE="./answers/rev_print.c"
BINARY="./build/rev_print"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Basic string
output=$("$BINARY" "rainbow")
expected="wobniar"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Another string
output=$("$BINARY" "kakaka")
expected="akakak"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: No arguments
output=$("$BINARY")
expected=""
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected empty line"
    exit 1
fi

# Test 4: Single character
output=$("$BINARY" "a")
expected="a"
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All rev_print tests passed!"
exit 0
