#!/bin/bash

# Test for ft_strrev
SOURCE="./answers/ft_strrev.c"
TEST_MAIN="./build/ft_strrev_main.c"
BINARY="./build/ft_strrev"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>

char *ft_strrev(char *str);

int main(void)
{
    // Test 1
    char test1[] = "hello";
    ft_strrev(test1);
    if (strcmp(test1, "olleh") != 0) {
        printf("Test 1 failed: got '%s'\n", test1);
        return 1;
    }

    // Test 2
    char test2[] = "a";
    ft_strrev(test2);
    if (strcmp(test2, "a") != 0) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3
    char test3[] = "12345";
    ft_strrev(test3);
    if (strcmp(test3, "54321") != 0) {
        printf("Test 3 failed: got '%s'\n", test3);
        return 1;
    }

    // Test 4: Even length
    char test4[] = "abcd";
    ft_strrev(test4);
    if (strcmp(test4, "dcba") != 0) {
        printf("Test 4 failed: got '%s'\n", test4);
        return 1;
    }

    printf("All ft_strrev tests passed!\n");
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
