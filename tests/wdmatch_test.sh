#!/bin/bash

# Test for wdmatch
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for wdmatch
SOURCE="./answers/wdmatch.c"
BINARY="./build/wdmatch"

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1: Match found
output=$("$BINARY" "faya" "fgvvfdxcacpolhyghbreda")
expected="faya"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: No match
output=$("$BINARY" "faya" "fgvvfdxcacpolhyghbred")
expected=""
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected empty line"
    exit 1
fi

# Test 3: Exact match
output=$("$BINARY" "forty two" "qfqfsoudf arzgrsayns tsryegftdgs sjytwdekuooixq ")
expected="forty two"
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

echo "All wdmatch tests passed!"
exit 0
