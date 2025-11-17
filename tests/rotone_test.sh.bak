#!/bin/bash

# Test for rotone
SOURCE="./answers/rotone.c"
BINARY="./build/rotone"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Basic test
output=$("$BINARY" "abc")
expected="bcd"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: End of alphabet
output=$("$BINARY" "xyz")
expected="yza"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Mixed case
output=$("$BINARY" "AkjhZ zLKIJz , 23y ")
expected="BlkiA aMLJKa , 23z "
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

echo "All rotone tests passed!"
exit 0
