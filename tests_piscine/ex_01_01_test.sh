#!/bin/bash

# Test for ex_01_01 - multiply two integers

source ./tests/piscine_test_helper.sh

# Get source file
SOURCE=$(get_piscine_source "01" "01")
if [ $? -ne 0 ]; then
    echo "Source file not found"
    exit 2
fi

BINARY="./build/piscine_ex_01_01"

# Compile
compile_piscine_source "$SOURCE" "$BINARY" "no"
if [ $? -ne 0 ]; then
    echo "Compilation failed:"
    compile_piscine_source "$SOURCE" "$BINARY" "no"
    exit 1
fi

# Test 1: Basic multiplication
test_piscine_program "5 3" "15" "5 * 3 = 15" "$BINARY" || exit 1

# Test 2: Zero multiplication
test_piscine_program "0 10" "0" "0 * 10 = 0" "$BINARY" || exit 1

# Test 3: Negative numbers
test_piscine_program "-5 3" "-15" "-5 * 3 = -15" "$BINARY" || exit 1

# Test 4: Large numbers
test_piscine_program "100 200" "20000" "100 * 200 = 20000" "$BINARY" || exit 1

# Test 5: Invalid input (single number)
test_piscine_program "5" "n/a" "invalid input (single number)" "$BINARY" || exit 1

# Test 6: Invalid input (not numbers)
test_piscine_program "abc def" "n/a" "invalid input (not numbers)" "$BINARY" || exit 1

echo "✓ All ex_01_01 tests passed!"
exit 0
