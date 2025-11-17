#!/bin/bash

# Test for ft_list_foreach
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_list_foreach
SOURCE="./answers/ft_list_foreach.c"
TEST_MAIN="./build/ft_list_foreach_main.c"
BINARY="./build/ft_list_foreach"
HEADER="./answers/ft_list.h"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include "ft_list.h"

void ft_list_foreach(t_list *begin_list, void (*f)(void *));

int call_count = 0;

void test_func(void *data)
{
    call_count++;
}

int main(void)
{
    // Test 1: Empty list
    call_count = 0;
    ft_list_foreach(NULL, &test_func);
    if (call_count != 0) {
        printf("Test 1 failed: expected 0 calls, got %d\n", call_count);
        return 1;
    }

    // Test 2: Single element
    t_list node1;
    node1.next = NULL;
    node1.data = NULL;
    call_count = 0;
    ft_list_foreach(&node1, &test_func);
    if (call_count != 1) {
        printf("Test 2 failed: expected 1 call, got %d\n", call_count);
        return 1;
    }

    // Test 3: Three elements
    t_list node2, node3;
    node1.next = &node2;
    node2.next = &node3;
    node3.next = NULL;
    call_count = 0;
    ft_list_foreach(&node1, &test_func);
    if (call_count != 3) {
        printf("Test 3 failed: expected 3 calls, got %d\n", call_count);
        return 1;
    }

    printf("All ft_list_foreach tests passed!\n");
    return 0;
}
EOF

# Compile
$CC $CFLAGS -Wall -Wextra -Werror -I./answers "$SOURCE" "$TEST_MAIN" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Run tests
"$BINARY"
exit $?
