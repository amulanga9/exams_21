#!/bin/bash

# Test for fizzbuzz
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for fizzbuzz
SOURCE="./answers/fizzbuzz.c"
BINARY="./build/fizzbuzz"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test: Check output (first 20 lines)
output=$("$BINARY" | head -20)
expected="1
2
fizz
4
buzz
fizz
7
8
fizz
buzz
11
fizz
13
14
fizzbuzz
16
17
fizz
19
buzz"

if [ "$output" != "$expected" ]; then
    echo "Test failed: output doesn't match expected fizzbuzz pattern"
    exit 1
fi

# Check total line count (should be 100)
line_count=$("$BINARY" | wc -l)
if [ $line_count -ne 100 ]; then
    echo "Test failed: expected 100 lines, got $line_count"
    exit 1
fi

# Check specific values
line_15=$("$BINARY" | sed -n '15p')
if [ "$line_15" != "fizzbuzz" ]; then
    echo "Test failed: line 15 should be 'fizzbuzz', got '$line_15'"
    exit 1
fi

line_30=$("$BINARY" | sed -n '30p')
if [ "$line_30" != "fizzbuzz" ]; then
    echo "Test failed: line 30 should be 'fizzbuzz', got '$line_30'"
    exit 1
fi

echo "All fizzbuzz tests passed!"
exit 0
