#!/bin/bash

# Test for fprime
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for fprime
SOURCE="./answers/fprime.c"
BINARY="./build/fprime"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "225225")
expected="3*3*5*5*7*11*13"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "8333325")
expected="3*3*5*5*7*11*13*37"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Prime number
output=$("$BINARY" "7")
expected="7"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 4: 1
output=$("$BINARY" "1")
expected="1"
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All fprime tests passed!"
exit 0
