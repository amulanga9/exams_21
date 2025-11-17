#!/bin/bash

# Test for flood_fill
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Test for flood_fill
SOURCE="./answers/flood_fill.c"
TEST_MAIN="./build/flood_fill_main.c"
BINARY="./build/flood_fill"
HEADER="./answers/flood_fill.t_point.h"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include "flood_fill.t_point.h"

void flood_fill(char **tab, t_point size, t_point begin);

int main(void)
{
    // Test 1: Simple flood fill
    char **tab = malloc(sizeof(char*) * 5);
    for (int i = 0; i < 5; i++) {
        tab[i] = malloc(8);
    }

    // Create test map
    char *lines[] = {
        "11111111",
        "10001001",
        "10010001",
        "10110001",
        "11100001"
    };

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 8; j++) {
            tab[i][j] = lines[i][j];
        }
    }

    t_point size = {8, 5};
    t_point begin = {1, 1};

    flood_fill(tab, size, begin);

    // Check if flood fill worked (area should be filled with 'F')
    if (tab[1][1] == 'F' && tab[1][2] == 'F') {
        printf("All flood_fill tests passed!\n");

        // Free memory
        for (int i = 0; i < 5; i++) {
            free(tab[i]);
        }
        free(tab);
        return 0;
    } else {
        printf("Test failed\n");

        // Free memory
        for (int i = 0; i < 5; i++) {
            free(tab[i]);
        }
        free(tab);
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
