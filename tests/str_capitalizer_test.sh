#!/bin/bash

# Test for str_capitalizer
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for str_capitalizer
SOURCE="./answers/str_capitalizer.c"
BINARY="./build/str_capitalizer"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "a FiRSt LiTTlE TESt")
expected="A First Little Test"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "SecONd teST A LITtle BiT   Moar comPLEX")
expected="Second Test A Little Bit   Moar Complex"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

# Test 3
output=$("$BINARY" "hello world" "test 123")
expected="Hello World
Test 123"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

echo "All str_capitalizer tests passed!"
exit 0
