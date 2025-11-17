#!/bin/bash

# Test for ft_strcpy
SOURCE="./answers/ft_strcpy.c"
TEST_MAIN="./build/ft_strcpy_main.c"
BINARY="./build/ft_strcpy"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>

char *ft_strcpy(char *s1, char *s2);

int main(void)
{
    char dest1[50];
    char dest2[50];

    // Test 1: Normal string
    char *src1 = "Hello World";
    ft_strcpy(dest1, src1);
    strcpy(dest2, src1);
    if (strcmp(dest1, dest2) != 0) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: Empty string
    char *src2 = "";
    ft_strcpy(dest1, src2);
    strcpy(dest2, src2);
    if (strcmp(dest1, dest2) != 0) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: Long string
    char *src3 = "This is a much longer string for testing purposes!";
    ft_strcpy(dest1, src3);
    strcpy(dest2, src3);
    if (strcmp(dest1, dest2) != 0) {
        printf("Test 3 failed\n");
        return 1;
    }

    printf("All ft_strcpy tests passed!\n");
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
