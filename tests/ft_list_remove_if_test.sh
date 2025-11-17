#!/bin/bash

# Test for ft_list_remove_if
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for ft_list_remove_if
SOURCE="./answers/ft_list_remove_if.c"
TEST_MAIN="./build/ft_list_remove_if_main.c"
BINARY="./build/ft_list_remove_if"
HEADER="./answers/ft_list.h"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ft_list.h"

void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)());

int cmp_int(void *a, void *b)
{
    return (*(int*)a - *(int*)b);
}

void free_fct(void *data)
{
    // Simple free for test
    (void)data;
}

int main(void)
{
    // Test 1: Remove from middle
    int val1 = 1, val2 = 2, val3 = 3;

    t_list *node1 = malloc(sizeof(t_list));
    t_list *node2 = malloc(sizeof(t_list));
    t_list *node3 = malloc(sizeof(t_list));

    node1->data = &val1;
    node1->next = node2;
    node2->data = &val2;
    node2->next = node3;
    node3->data = &val3;
    node3->next = NULL;

    int ref = 2;
    ft_list_remove_if(&node1, &ref, cmp_int);

    // Check if node with value 2 is removed
    if (node1 && node1->data == &val1 && node1->next && node1->next->data == &val3) {
        printf("All ft_list_remove_if tests passed!\n");
        free(node1->next);
        free(node1);
        return 0;
    } else {
        printf("Test failed\n");
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
