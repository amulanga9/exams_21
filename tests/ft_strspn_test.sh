#!/bin/bash

# Test for ft_strspn
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_strspn
SOURCE="./answers/ft_strspn.c"
TEST_MAIN="./build/ft_strspn_main.c"
BINARY="./build/ft_strspn"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <string.h>

size_t ft_strspn(const char *s, const char *accept);

int main(void)
{
    // Test 1
    if (ft_strspn("hello", "helo") != strspn("hello", "helo")) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2
    if (ft_strspn("12345abc", "0123456789") != strspn("12345abc", "0123456789")) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3
    if (ft_strspn("", "abc") != strspn("", "abc")) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4
    if (ft_strspn("abcdef", "xyz") != strspn("abcdef", "xyz")) {
        printf("Test 4 failed\n");
        return 1;
    }

    printf("All ft_strspn tests passed!\n");
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
