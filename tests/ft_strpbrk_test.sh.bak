#!/bin/bash

# Test for ft_strpbrk
SOURCE="./answers/ft_strpbrk.c"
TEST_MAIN="./build/ft_strpbrk_main.c"
BINARY="./build/ft_strpbrk"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>

char *ft_strpbrk(const char *s1, const char *s2);

int main(void)
{
    // Test 1: Found
    char *str1 = "hello world";
    char *res1 = ft_strpbrk(str1, "wo");
    char *exp1 = strpbrk(str1, "wo");
    if ((res1 == NULL && exp1 != NULL) || (res1 != NULL && exp1 == NULL) ||
        (res1 != NULL && exp1 != NULL && res1 != exp1)) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: Not found
    char *str2 = "hello";
    char *res2 = ft_strpbrk(str2, "xyz");
    char *exp2 = strpbrk(str2, "xyz");
    if (res2 != exp2) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: First char
    char *str3 = "test";
    char *res3 = ft_strpbrk(str3, "t");
    char *exp3 = strpbrk(str3, "t");
    if (res3 != exp3) {
        printf("Test 3 failed\n");
        return 1;
    }

    printf("All ft_strpbrk tests passed!\n");
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
