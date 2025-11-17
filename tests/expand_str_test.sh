#!/bin/bash

# Test for expand_str
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for expand_str
SOURCE="./answers/expand_str.c"
BINARY="./build/expand_str"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "vous   voyez   c'est   facile   d'afficher   la   meme   chose")
expected="vous   voyez   c'est   facile   d'afficher   la   meme   chose"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed"
    echo "Expected: '$expected'"
    echo "Got: '$output'"
    exit 1
fi

# Test 2
output=$("$BINARY" "   hello    world   ")
expected="hello   world"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3
output=$("$BINARY" "test")
expected="test"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All expand_str tests passed!"
exit 0
