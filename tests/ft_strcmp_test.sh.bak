#!/bin/bash

# Test for ft_strcmp
SOURCE="./answers/ft_strcmp.c"
TEST_MAIN="./build/ft_strcmp_main.c"
BINARY="./build/ft_strcmp"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>

int ft_strcmp(char *s1, char *s2);

int sign(int n) {
    if (n > 0) return 1;
    if (n < 0) return -1;
    return 0;
}

int main(void)
{
    // Test 1: Equal strings
    if (sign(ft_strcmp("hello", "hello")) != sign(strcmp("hello", "hello"))) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: First string greater
    if (sign(ft_strcmp("world", "hello")) != sign(strcmp("world", "hello"))) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: First string smaller
    if (sign(ft_strcmp("abc", "xyz")) != sign(strcmp("abc", "xyz"))) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4: Empty strings
    if (sign(ft_strcmp("", "")) != sign(strcmp("", ""))) {
        printf("Test 4 failed\n");
        return 1;
    }

    // Test 5: Different lengths
    if (sign(ft_strcmp("hello", "hello world")) != sign(strcmp("hello", "hello world"))) {
        printf("Test 5 failed\n");
        return 1;
    }

    printf("All ft_strcmp tests passed!\n");
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
