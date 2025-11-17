#!/bin/bash

# Test for ft_strcspn
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_strcspn
SOURCE="./answers/ft_strcspn.c"
TEST_MAIN="./build/ft_strcspn_main.c"
BINARY="./build/ft_strcspn"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>

size_t ft_strcspn(const char *s, const char *reject);

int main(void)
{
    // Test 1
    if (ft_strcspn("hello world", "o") != strcspn("hello world", "o")) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2
    if (ft_strcspn("testing", "xyz") != strcspn("testing", "xyz")) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3
    if (ft_strcspn("abcdef", "d") != strcspn("abcdef", "d")) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4: Empty reject
    if (ft_strcspn("hello", "") != strcspn("hello", "")) {
        printf("Test 4 failed\n");
        return 1;
    }

    printf("All ft_strcspn tests passed!\n");
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
