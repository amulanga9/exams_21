#!/bin/bash

# Test for ft_list_size
SOURCE="./answers/ft_list_size.c"
TEST_MAIN="./build/ft_list_size_main.c"
BINARY="./build/ft_list_size"
HEADER="./answers/ft_list.h"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include "ft_list.h"

int ft_list_size(t_list *begin_list);

int main(void)
{
    // Test 1: Empty list
    if (ft_list_size(NULL) != 0) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: Single element
    t_list node1;
    node1.next = NULL;
    if (ft_list_size(&node1) != 1) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: Three elements
    t_list node2, node3;
    node1.next = &node2;
    node2.next = &node3;
    node3.next = NULL;
    if (ft_list_size(&node1) != 3) {
        printf("Test 3 failed: expected 3, got %d\n", ft_list_size(&node1));
        return 1;
    }

    // Test 4: Five elements
    t_list node4, node5;
    node3.next = &node4;
    node4.next = &node5;
    node5.next = NULL;
    if (ft_list_size(&node1) != 5) {
        printf("Test 4 failed: expected 5, got %d\n", ft_list_size(&node1));
        return 1;
    }

    printf("All ft_list_size tests passed!\n");
    return 0;
}
EOF

# Compile
gcc -Wall -Wextra -Werror -I./answers "$SOURCE" "$TEST_MAIN" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Run tests
"$BINARY"
exit $?
