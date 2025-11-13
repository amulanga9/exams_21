#!/bin/bash

# Test for max
SOURCE="./answers/max.c"
TEST_MAIN="./build/max_main.c"
BINARY="./build/max"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>

int max(int* tab, unsigned int len);

int main(void)
{
    // Test 1: Normal array
    int arr1[] = {1, 5, 3, 9, 2};
    if (max(arr1, 5) != 9) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: Negative numbers
    int arr2[] = {-5, -2, -10, -1};
    if (max(arr2, 4) != -1) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: Single element
    int arr3[] = {42};
    if (max(arr3, 1) != 42) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4: All same
    int arr4[] = {7, 7, 7, 7};
    if (max(arr4, 4) != 7) {
        printf("Test 4 failed\n");
        return 1;
    }

    // Test 5: Max at beginning
    int arr5[] = {100, 1, 2, 3};
    if (max(arr5, 4) != 100) {
        printf("Test 5 failed\n");
        return 1;
    }

    printf("All max tests passed!\n");
    return 0;
}
EOF

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" "$TEST_MAIN" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Run tests
"$BINARY"
exit $?
