#!/bin/bash

# Test for ft_range
SOURCE="./answers/ft_range.c"
TEST_MAIN="./build/ft_range_main.c"
BINARY="./build/ft_range"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <stdlib.h>

int *ft_range(int start, int end);

int main(void)
{
    // Test 1: Ascending range
    int *arr1 = ft_range(1, 3);
    if (!arr1 || arr1[0] != 1 || arr1[1] != 2 || arr1[2] != 3) {
        printf("Test 1 failed\n");
        return 1;
    }
    free(arr1);

    // Test 2: Descending range
    int *arr2 = ft_range(3, 1);
    if (!arr2 || arr2[0] != 3 || arr2[1] != 2 || arr2[2] != 1) {
        printf("Test 2 failed\n");
        return 1;
    }
    free(arr2);

    // Test 3: Single element
    int *arr3 = ft_range(5, 5);
    if (!arr3 || arr3[0] != 5) {
        printf("Test 3 failed\n");
        return 1;
    }
    free(arr3);

    // Test 4: Negative numbers
    int *arr4 = ft_range(-1, 2);
    if (!arr4 || arr4[0] != -1 || arr4[1] != 0 || arr4[2] != 1 || arr4[3] != 2) {
        printf("Test 4 failed\n");
        return 1;
    }
    free(arr4);

    printf("All ft_range tests passed!\n");
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
