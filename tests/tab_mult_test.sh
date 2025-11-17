#!/bin/bash

# Test for tab_mult
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for tab_mult
SOURCE="./answers/tab_mult.c"
BINARY="./build/tab_mult"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY" "5")
expected="1 x 5 = 5
2 x 5 = 10
3 x 5 = 15
4 x 5 = 20
5 x 5 = 25
6 x 5 = 30
7 x 5 = 35
8 x 5 = 40
9 x 5 = 45"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed"
    echo "Expected:"
    echo "$expected"
    echo "Got:"
    echo "$output"
    exit 1
fi

# Test 2
output=$("$BINARY" "3" | head -3)
expected="1 x 3 = 3
2 x 3 = 6
3 x 3 = 9"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed"
    exit 1
fi

echo "All tab_mult tests passed!"
exit 0
