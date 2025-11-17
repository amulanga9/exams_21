#!/bin/bash

# Test for hidenp
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for hidenp
SOURCE="./answers/hidenp.c"
BINARY="./build/hidenp"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Hidden
output=$("$BINARY" "fgex" "tyf34gdgf;'ektufjhgdgex..")
expected="1"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Not hidden
output=$("$BINARY" "abc" "2altrb53c.sse")
expected="1"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Not hidden
output=$("$BINARY" "abc" "btarc")
expected="0"
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

echo "All hidenp tests passed!"
exit 0
