#!/bin/bash

# Test for sort_int_tab
SOURCE="./answers/sort_int_tab.c"
TEST_MAIN="./build/sort_int_tab_main.c"
BINARY="./build/sort_int_tab"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>

void sort_int_tab(int *tab, unsigned int size);

int main(void)
{
    // Test 1: Normal array
    int arr1[] = {5, 3, 9, 1, 7};
    sort_int_tab(arr1, 5);
    if (arr1[0] != 1 || arr1[1] != 3 || arr1[2] != 5 || arr1[3] != 7 || arr1[4] != 9) {
        printf("Test 1 failed\n");
        return 1;
    }

    // Test 2: Already sorted
    int arr2[] = {1, 2, 3, 4, 5};
    sort_int_tab(arr2, 5);
    if (arr2[0] != 1 || arr2[1] != 2 || arr2[2] != 3 || arr2[3] != 4 || arr2[4] != 5) {
        printf("Test 2 failed\n");
        return 1;
    }

    // Test 3: Reverse sorted
    int arr3[] = {5, 4, 3, 2, 1};
    sort_int_tab(arr3, 5);
    if (arr3[0] != 1 || arr3[1] != 2 || arr3[2] != 3 || arr3[3] != 4 || arr3[4] != 5) {
        printf("Test 3 failed\n");
        return 1;
    }

    // Test 4: Negative numbers
    int arr4[] = {-5, 3, -1, 0, 2};
    sort_int_tab(arr4, 5);
    if (arr4[0] != -5 || arr4[1] != -1 || arr4[2] != 0 || arr4[3] != 2 || arr4[4] != 3) {
        printf("Test 4 failed\n");
        return 1;
    }

    printf("All sort_int_tab tests passed!\n");
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
