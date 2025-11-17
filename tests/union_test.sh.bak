#!/bin/bash

# Test for union
SOURCE="./answers/union.c"
BINARY="./build/union"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Mixed strings
output=$("$BINARY" "zpadinton" "paqefwtdjetyiytjneytjoeyjnejeyj")
expected="zpadintoqefwjy"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Some overlap
output=$("$BINARY" "ddf6vewg64f" "gtwthgdwthdwfteewhrtag6h4ffdhsd")
expected="df6vewg4thras"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: No overlap
output=$("$BINARY" "abc" "def")
expected="abcdef"
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

echo "All union tests passed!"
exit 0
