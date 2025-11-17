#!/bin/bash

# Test for do_op
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for do_op
SOURCE="./answers/do_op.c"
BINARY="./build/do_op"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Addition
output=$("$BINARY" "5" "+" "7")
expected="12"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Subtraction
output=$("$BINARY" "10" "-" "3")
expected="7"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Multiplication
output=$("$BINARY" "9" "*" "9")
expected="81"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 4: Division
output=$("$BINARY" "42" "/" "2")
expected="21"
if [ "$output" != "$expected" ]; then
    echo "Test 4 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 5: Modulo
output=$("$BINARY" "10" "%" "3")
expected="1"
if [ "$output" != "$expected" ]; then
    echo "Test 5 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All do_op tests passed!"
exit 0
