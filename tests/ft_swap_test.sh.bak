#!/bin/bash

# Test for ft_swap
SOURCE="./answers/ft_swap.c"
TEST_MAIN="./build/ft_swap_main.c"
BINARY="./build/ft_swap"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>

void ft_swap(int *a, int *b);

int main(void)
{
    // Test 1: Swap two positive numbers
    int a1 = 5, b1 = 10;
    ft_swap(&a1, &b1);
    if (a1 != 10 || b1 != 5) {
        printf("Test 1 failed: a=%d, b=%d (expected a=10, b=5)\n", a1, b1);
        return 1;
    }

    // Test 2: Swap negative and positive
    int a2 = -5, b2 = 42;
    ft_swap(&a2, &b2);
    if (a2 != 42 || b2 != -5) {
        printf("Test 2 failed: a=%d, b=%d (expected a=42, b=-5)\n", a2, b2);
        return 1;
    }

    // Test 3: Swap zeros
    int a3 = 0, b3 = 0;
    ft_swap(&a3, &b3);
    if (a3 != 0 || b3 != 0) {
        printf("Test 3 failed: a=%d, b=%d (expected a=0, b=0)\n", a3, b3);
        return 1;
    }

    // Test 4: Swap large numbers
    int a4 = 999999, b4 = -999999;
    ft_swap(&a4, &b4);
    if (a4 != -999999 || b4 != 999999) {
        printf("Test 4 failed: a=%d, b=%d (expected a=-999999, b=999999)\n", a4, b4);
        return 1;
    }

    printf("All ft_swap tests passed!\n");
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
