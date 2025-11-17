#!/bin/bash

# Test for ft_atoi_base
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_atoi_base
SOURCE="./answers/ft_atoi_base.c"
TEST_MAIN="./build/ft_atoi_base_main.c"
BINARY="./build/ft_atoi_base"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>

int ft_atoi_base(const char *str, int str_base);

int main(void)
{
    // Test 1: Binary
    if (ft_atoi_base("101", 2) != 5) {
        printf("Test 1 failed: expected 5, got %d\n", ft_atoi_base("101", 2));
        return 1;
    }

    // Test 2: Hexadecimal
    if (ft_atoi_base("FF", 16) != 255) {
        printf("Test 2 failed: expected 255, got %d\n", ft_atoi_base("FF", 16));
        return 1;
    }

    // Test 3: Decimal
    if (ft_atoi_base("42", 10) != 42) {
        printf("Test 3 failed: expected 42, got %d\n", ft_atoi_base("42", 10));
        return 1;
    }

    // Test 4: Octal
    if (ft_atoi_base("10", 8) != 8) {
        printf("Test 4 failed: expected 8, got %d\n", ft_atoi_base("10", 8));
        return 1;
    }

    // Test 5: Negative hex
    if (ft_atoi_base("-FF", 16) != -255) {
        printf("Test 5 failed: expected -255, got %d\n", ft_atoi_base("-FF", 16));
        return 1;
    }

    printf("All ft_atoi_base tests passed!\n");
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
