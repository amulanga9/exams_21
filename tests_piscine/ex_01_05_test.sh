#!/bin/bash

# Test for ex_01_05 - multiply by pi (3.141)

source ./tests/piscine_test_helper.sh

# Get source file
SOURCE=$(get_piscine_source "01" "05")
if [ $? -ne 0 ]; then
    echo "Source file not found"
    exit 2
fi

BINARY="./build/piscine_ex_01_05"

# Compile
compile_piscine_source "$SOURCE" "$BINARY" "no"
if [ $? -ne 0 ]; then
    echo "Compilation failed:"
    compile_piscine_source "$SOURCE" "$BINARY" "no"
    exit 1
fi

# Test 1: Basic calculation
test_piscine_program "1" "3.14" "1 * pi = 3.14" "$BINARY" || exit 1

# Test 2: Zero
test_piscine_program "0" "0.00" "0 * pi = 0.00" "$BINARY" || exit 1

# Test 3: Larger number
test_piscine_program "10" "31.41" "10 * pi = 31.41" "$BINARY" || exit 1

# Test 4: Invalid input
test_piscine_program "abc" "n/a" "invalid input" "$BINARY" || exit 1

echo "✓ All ex_01_05 tests passed!"
exit 0
