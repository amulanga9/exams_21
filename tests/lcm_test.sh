#!/bin/bash

# Test for lcm
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for lcm
SOURCE="./answers/lcm.c"
TEST_MAIN="./build/lcm_main.c"
BINARY="./build/lcm"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>

unsigned int lcm(unsigned int a, unsigned int b);

int main(void)
{
    // Test 1: lcm(5, 3) = 15
    if (lcm(5, 3) != 15) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: lcm(12, 8) = 24
    if (lcm(12, 8) != 24) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: lcm(0, 5) = 0
    if (lcm(0, 5) != 0) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4: lcm(7, 7) = 7
    if (lcm(7, 7) != 7) {
        printf("Test 4 failed\n");
        return 1;
    }

    // Test 5: lcm(1, 100) = 100
    if (lcm(1, 100) != 100) {
        printf("Test 5 failed\n");
        return 1;
    }

    printf("All lcm tests passed!\n");
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
