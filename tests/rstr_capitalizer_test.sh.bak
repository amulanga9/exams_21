#!/bin/bash

# Test for rstr_capitalizer
SOURCE="./answers/rstr_capitalizer.c"
BINARY="./build/rstr_capitalizer"

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "a FiRSt LiTTlE TESt")
expected="A firsT littlE tesT"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "SecONd teST A LITtle BiT   Moar comPLEX")
expected="seconD tesT A littlE biT   moaR compleX"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

# Test 3
output=$("$BINARY" "hello" "world")
expected="hellO
worlD"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

echo "All rstr_capitalizer tests passed!"
exit 0
