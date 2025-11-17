#!/bin/bash

# Test for ft_atoi
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_atoi
SOURCE="./answers/ft_atoi.c"
TEST_MAIN="./build/ft_atoi_main.c"
BINARY="./build/ft_atoi"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <stdlib.h>

int ft_atoi(const char *str);

int main(void)
{
    // Test 1: Simple positive number
    if (ft_atoi("42") != atoi("42")) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: Negative number
    if (ft_atoi("-42") != atoi("-42")) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: With spaces
    if (ft_atoi("  123") != atoi("  123")) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4: With plus sign
    if (ft_atoi("+456") != atoi("+456")) {
        printf("Test 4 failed\n");
        return 1;
    }

    // Test 5: With tabs and spaces
    if (ft_atoi("  \t\n  -789") != atoi("  \t\n  -789")) {
        printf("Test 5 failed\n");
        return 1;
    }

    // Test 6: Zero
    if (ft_atoi("0") != atoi("0")) {
        printf("Test 6 failed\n");
        return 1;
    }

    printf("All ft_atoi tests passed!\n");
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
