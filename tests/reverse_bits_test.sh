#!/bin/bash

# Test for reverse_bits
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for reverse_bits
SOURCE="./answers/reverse_bits.c"
TEST_MAIN="./build/reverse_bits_main.c"
BINARY="./build/reverse_bits"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>

unsigned char reverse_bits(unsigned char octet);

int main(void)
{
    // Test 1: 0x41 (01000001) should become 0x82 (10000010)
    if (reverse_bits(0x41) != 0x82) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: 0xFF (11111111) should stay 0xFF (11111111)
    if (reverse_bits(0xFF) != 0xFF) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: 0x00 (00000000) should stay 0x00 (00000000)
    if (reverse_bits(0x00) != 0x00) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4: 0x01 (00000001) should become 0x80 (10000000)
    if (reverse_bits(0x01) != 0x80) {
        printf("Test 4 failed\n");
        return 1;
    }

    printf("All reverse_bits tests passed!\n");
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
