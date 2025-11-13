#!/bin/bash

# Test for inter
SOURCE="./answers/inter.c"
BINARY="./build/inter"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Common characters
output=$("$BINARY" "padinton" "paqefwtdjetyiytjneytjoeyjnejeyj")
expected="padinto"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: No common characters
output=$("$BINARY" "abc" "xyz")
expected=""
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected empty line"
    exit 1
fi

# Test 3: All common
output=$("$BINARY" "hello" "hello")
expected="helo"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 4: Wrong number of arguments
output=$("$BINARY" "test")
expected=""
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected empty line"
    exit 1
fi

echo "All inter tests passed!"
exit 0
