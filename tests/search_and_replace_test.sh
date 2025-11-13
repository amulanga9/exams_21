#!/bin/bash

# Test for search_and_replace
SOURCE="./answers/search_and_replace.c"
BINARY="./build/search_and_replace"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Basic replacement
output=$("$BINARY" "hella" "e" "o")
expected="hello"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Multiple occurrences
output=$("$BINARY" "this is a test" "i" "y")
expected="thys ys a test"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: No replacement
output=$("$BINARY" "abc" "z" "y")
expected="abc"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 4: Wrong number of arguments
output=$("$BINARY" "hello")
expected=""
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected empty line"
    exit 1
fi

echo "All search_and_replace tests passed!"
exit 0
