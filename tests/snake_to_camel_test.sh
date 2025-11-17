#!/bin/bash

# Test for snake_to_camel
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for snake_to_camel
SOURCE="./answers/snake_to_camel.c"
BINARY="./build/snake_to_camel"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "hello_world")
expected="helloWorld"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "here_is_a_message")
expected="hereIsAMessage"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: No underscores
output=$("$BINARY" "helloworld")
expected="helloworld"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All snake_to_camel tests passed!"
exit 0
