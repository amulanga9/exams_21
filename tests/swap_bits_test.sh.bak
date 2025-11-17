#!/bin/bash

# Test for swap_bits
SOURCE="./answers/swap_bits.c"
TEST_MAIN="./build/swap_bits_main.c"
BINARY="./build/swap_bits"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>

unsigned char swap_bits(unsigned char octet);

int main(void)
{
    // Test 1: 0x41 (01000001) should become 0x14 (00010100)
    if (swap_bits(0x41) != 0x14) {
        printf("Test 1 failed: got 0x%02X, expected 0x14\n", swap_bits(0x41));
        return 1;
    }

    // Test 2: 0xFF (11111111) should stay 0xFF (11111111)
    if (swap_bits(0xFF) != 0xFF) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: 0x00 (00000000) should stay 0x00 (00000000)
    if (swap_bits(0x00) != 0x00) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4: 0xF0 (11110000) should become 0x0F (00001111)
    if (swap_bits(0xF0) != 0x0F) {
        printf("Test 4 failed\n");
        return 1;
    }

    printf("All swap_bits tests passed!\n");
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
