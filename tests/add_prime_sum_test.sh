#!/bin/bash

# Test for add_prime_sum
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for add_prime_sum
SOURCE="./answers/add_prime_sum.c"
BINARY="./build/add_prime_sum"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "5")
expected="10"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "10")
expected="17"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Invalid input
output=$("$BINARY" "0")
expected="0"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 4: No arguments
output=$("$BINARY")
expected="0"
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All add_prime_sum tests passed!"
exit 0
