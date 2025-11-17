#!/bin/bash

# Test for ft_strlen
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_strlen
SOURCE="./answers/ft_strlen.c"
TEST_MAIN="./build/ft_strlen_main.c"
BINARY="./build/ft_strlen"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>

int ft_strlen(char *str);

int main(void)
{
    // Test 1: Normal string
    char *test1 = "Hello";
    if (ft_strlen(test1) != strlen(test1)) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: Empty string
    char *test2 = "";
    if (ft_strlen(test2) != strlen(test2)) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: Long string
    char *test3 = "This is a much longer string for testing purposes";
    if (ft_strlen(test3) != strlen(test3)) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4: String with spaces
    char *test4 = "   spaces   ";
    if (ft_strlen(test4) != strlen(test4)) {
        printf("Test 4 failed\n");
        return 1;
    }

    printf("All ft_strlen tests passed!\n");
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
