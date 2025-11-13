#!/bin/bash

# Test for ft_itoa
SOURCE="./answers/ft_itoa.c"
TEST_MAIN="./build/ft_itoa_main.c"
BINARY="./build/ft_itoa"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *ft_itoa(int nbr);

int main(void)
{
    // Test 1: Positive number
    char *str1 = ft_itoa(42);
    if (strcmp(str1, "42") != 0) {
        printf("Test 1 failed: expected '42', got '%s'\n", str1);
        return 1;
    }
    free(str1);

    // Test 2: Negative number
    char *str2 = ft_itoa(-42);
    if (strcmp(str2, "-42") != 0) {
        printf("Test 2 failed: expected '-42', got '%s'\n", str2);
        return 1;
    }
    free(str2);

    // Test 3: Zero
    char *str3 = ft_itoa(0);
    if (strcmp(str3, "0") != 0) {
        printf("Test 3 failed: expected '0', got '%s'\n", str3);
        return 1;
    }
    free(str3);

    // Test 4: INT_MIN
    char *str4 = ft_itoa(-2147483648);
    if (strcmp(str4, "-2147483648") != 0) {
        printf("Test 4 failed: expected '-2147483648', got '%s'\n", str4);
        return 1;
    }
    free(str4);

    printf("All ft_itoa tests passed!\n");
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
