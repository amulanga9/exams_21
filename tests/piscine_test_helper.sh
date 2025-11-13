#!/bin/bash

# Piscine Test Helper Functions
# For testing programs that use stdin/stdout

# Test a piscine program with stdin input
# Usage: test_piscine_program "input_string" "expected_output" "test_description"
test_piscine_program() {
    local input="$1"
    local expected="$2"
    local test_desc="$3"
    local binary="$4"

    # Run program with input
    local output=$(echo -e "$input" | "$binary" 2>&1)
    local exit_code=$?

    # Check output
    if [ "$output" = "$expected" ]; then
        return 0
    else
        echo "Test failed: $test_desc"
        echo "  Input: '$input'"
        echo "  Expected: '$expected'"
        echo "  Got: '$output'"
        echo "  Exit code: $exit_code"
        return 1
    fi
}

# Compile piscine source
compile_piscine_source() {
    local source="$1"
    local binary="$2"
    local math_lib="$3"

    if [ "$math_lib" = "yes" ]; then
        gcc -Wall -Wextra -Werror "$source" -o "$binary" -lm 2>&1
    else
        gcc -Wall -Wextra -Werror "$source" -o "$binary" 2>&1
    fi

    return $?
}

# Get source file (from student submission or reference)
get_piscine_source() {
    local ex_num="$1"
    local task_num="$2"

    # Try student submission first
    if [ -f "./submissions/piscine_ex_${ex_num}/ex_${ex_num}_${task_num}.c" ]; then
        echo "./submissions/piscine_ex_${ex_num}/ex_${ex_num}_${task_num}.c"
        return 0
    fi

    # Fall back to reference
    if [ -f "./answers_piscine/ex_${ex_num}/ex_${ex_num}_${task_num}.c" ]; then
        echo "./answers_piscine/ex_${ex_num}/ex_${ex_num}_${task_num}.c"
        return 0
    fi

    return 1
}
