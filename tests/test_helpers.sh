#!/bin/bash

# Test Helper Functions
# Provides common functionality for all test scripts

# Get the source file to test (from environment variable or default)
get_source_file() {
    local task_name="$1"

    # If CURRENT_SOURCE_FILE is set, use it
    if [ -n "$CURRENT_SOURCE_FILE" ]; then
        echo "$CURRENT_SOURCE_FILE"
        return 0
    fi

    # Otherwise, fall back to answers directory
    if [ -f "./answers/${task_name}.c" ]; then
        echo "./answers/${task_name}.c"
        return 0
    fi

    return 1
}

# Compile a source file
compile_source() {
    local source_file="$1"
    local binary="$2"
    local additional_files="$3"

    if [ -n "$additional_files" ]; then
        gcc -Wall -Wextra -Werror "$source_file" $additional_files -o "$binary" 2>&1
    else
        gcc -Wall -Wextra -Werror "$source_file" -o "$binary" 2>&1
    fi

    return $?
}

# Compile source with a test main
compile_with_main() {
    local source_file="$1"
    local test_main="$2"
    local binary="$3"
    local additional_flags="$4"

    gcc -Wall -Wextra -Werror $additional_flags "$source_file" "$test_main" -o "$binary" 2>&1
    return $?
}
