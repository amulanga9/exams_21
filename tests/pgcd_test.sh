#!/bin/bash

# Test for pgcd
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for pgcd
SOURCE="./answers/pgcd.c"
BINARY="./build/pgcd"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "42" "10")
expected="2"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "42" "12")
expected="6"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3
output=$("$BINARY" "14" "77")
expected="7"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 4: Wrong number of arguments
output=$("$BINARY" "42")
expected=""
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected empty line"
    exit 1
fi

echo "All pgcd tests passed!"
exit 0
