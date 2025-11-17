#!/bin/bash

# Test for is_power_of_2
SOURCE="./answers/is_power_of_2.c"
TEST_MAIN="./build/is_power_of_2_main.c"
BINARY="./build/is_power_of_2"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>

int is_power_of_2(unsigned int n);

int main(void)
{
    // Test 1: Powers of 2
    if (is_power_of_2(1) != 1) {
        printf("Test 1 failed: 1 is 2^0\n");
        return 1;
    }
    if (is_power_of_2(2) != 1) {
        printf("Test 2 failed: 2 is 2^1\n");
        return 1;
    }
    if (is_power_of_2(4) != 1) {
        printf("Test 3 failed: 4 is 2^2\n");
        return 1;
    }
    if (is_power_of_2(1024) != 1) {
        printf("Test 4 failed: 1024 is 2^10\n");
        return 1;
    }

    // Test 2: Not powers of 2
    if (is_power_of_2(0) != 0) {
        printf("Test 5 failed: 0 is not a power of 2\n");
        return 1;
    }
    if (is_power_of_2(3) != 0) {
        printf("Test 6 failed: 3 is not a power of 2\n");
        return 1;
    }
    if (is_power_of_2(42) != 0) {
        printf("Test 7 failed: 42 is not a power of 2\n");
        return 1;
    }

    printf("All is_power_of_2 tests passed!\n");
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
