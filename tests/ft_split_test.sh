#!/bin/bash

# Test for ft_split
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_split
SOURCE="./answers/ft_split.c"
TEST_MAIN="./build/ft_split_main.c"
BINARY="./build/ft_split"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char **ft_split(char *str);

int main(void)
{
    // Test 1: Normal string
    char **result1 = ft_split("hello world test");
    if (!result1 || strcmp(result1[0], "hello") != 0 ||
        strcmp(result1[1], "world") != 0 ||
        strcmp(result1[2], "test") != 0 ||
        result1[3] != NULL) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Free memory
    for (int i = 0; result1[i]; i++) {
        free(result1[i]);
    }
    free(result1);

    // Test 2: Multiple spaces
    char **result2 = ft_split("  hello   world  ");
    if (!result2 || strcmp(result2[0], "hello") != 0 ||
        strcmp(result2[1], "world") != 0 ||
        result2[2] != NULL) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Free memory
    for (int i = 0; result2[i]; i++) {
        free(result2[i]);
    }
    free(result2);

    // Test 3: Single word
    char **result3 = ft_split("hello");
    if (!result3 || strcmp(result3[0], "hello") != 0 || result3[1] != NULL) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Free memory
    for (int i = 0; result3[i]; i++) {
        free(result3[i]);
    }
    free(result3);

    printf("All ft_split tests passed!\n");
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
