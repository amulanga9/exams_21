#!/bin/bash

# Test for ft_strdup
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_strdup
SOURCE="./answers/ft_strdup.c"
TEST_MAIN="./build/ft_strdup_main.c"
BINARY="./build/ft_strdup"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *ft_strdup(char *src);

int main(void)
{
    // Test 1: Normal string
    char *test1 = "Hello World";
    char *dup1 = ft_strdup(test1);
    if (strcmp(dup1, test1) != 0) {
        printf("Test 1 failed\n");
        return 1;
    }
    free(dup1);

    // Test 2: Empty string
    char *test2 = "";
    char *dup2 = ft_strdup(test2);
    if (strcmp(dup2, test2) != 0) {
        printf("Test 2 failed\n");
        return 1;
    }
    free(dup2);

    // Test 3: Long string
    char *test3 = "This is a longer test string with more characters";
    char *dup3 = ft_strdup(test3);
    if (strcmp(dup3, test3) != 0) {
        printf("Test 3 failed\n");
        return 1;
    }
    free(dup3);

    printf("All ft_strdup tests passed!\n");
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
