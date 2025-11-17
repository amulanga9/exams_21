#!/bin/bash

# Test for ft_rrange
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_rrange
SOURCE="./answers/ft_rrange.c"
TEST_MAIN="./build/ft_rrange_main.c"
BINARY="./build/ft_rrange"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <stdlib.h>

int *ft_rrange(int start, int end);

int main(void)
{
    // Test 1: Ascending range (reversed)
    int *arr1 = ft_rrange(1, 3);
    if (!arr1 || arr1[0] != 3 || arr1[1] != 2 || arr1[2] != 1) {
        printf("Test 1 failed\n");
        return 1;
    }
    free(arr1);

    // Test 2: Descending range (reversed)
    int *arr2 = ft_rrange(3, 1);
    if (!arr2 || arr2[0] != 1 || arr2[1] != 2 || arr2[2] != 3) {
        printf("Test 2 failed\n");
        return 1;
    }
    free(arr2);

    // Test 3: Single element
    int *arr3 = ft_rrange(5, 5);
    if (!arr3 || arr3[0] != 5) {
        printf("Test 3 failed\n");
        return 1;
    }
    free(arr3);

    // Test 4: Negative numbers
    int *arr4 = ft_rrange(-1, 2);
    if (!arr4 || arr4[0] != 2 || arr4[1] != 1 || arr4[2] != 0 || arr4[3] != -1) {
        printf("Test 4 failed\n");
        return 1;
    }
    free(arr4);

    printf("All ft_rrange tests passed!\n");
    return 0;
}
EOF

# Compile
$CC $CFLAGS -Wall -Wextra -Werror "$SOURCE" "$TEST_MAIN" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Run tests
"$BINARY"
exit $?
