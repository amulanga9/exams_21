#!/bin/bash

# Test for sort_list
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for sort_list
SOURCE="./answers/sort_list.c"
TEST_MAIN="./build/sort_list_main.c"
BINARY="./build/sort_list"
HEADER="./answers/sort_list.list.h"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include "sort_list.list.h"

t_list *sort_list(t_list *lst, int (*cmp)(int, int));

int ascending(int a, int b)
{
    return (a <= b);
}

int main(void)
{
    // Test 1: Sort unsorted list
    t_list *node1 = malloc(sizeof(t_list));
    t_list *node2 = malloc(sizeof(t_list));
    t_list *node3 = malloc(sizeof(t_list));

    node1->data = 5;
    node1->next = node2;
    node2->data = 3;
    node2->next = node3;
    node3->data = 7;
    node3->next = NULL;

    t_list *sorted = sort_list(node1, ascending);

    // Check if sorted
    if (sorted && sorted->data == 3 &&
        sorted->next && sorted->next->data == 5 &&
        sorted->next->next && sorted->next->next->data == 7) {
        printf("All sort_list tests passed!\n");

        // Free memory
        free(node1);
        free(node2);
        free(node3);
        return 0;
    } else {
        printf("Test failed\n");

        // Free memory
        free(node1);
        free(node2);
        free(node3);
        return 1;
    }
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
