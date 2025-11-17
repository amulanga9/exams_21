#!/bin/bash

# Test for ft_putstr
SOURCE="./answers/ft_putstr.c"
TEST_MAIN="./build/ft_putstr_main.c"
BINARY="./build/ft_putstr"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
void ft_putstr(char *str);

int main(void)
{
    ft_putstr("Hello");
    ft_putstr(" ");
    ft_putstr("World");
    ft_putstr("\n");

    ft_putstr("Testing ft_putstr function\n");

    return 0;
}
EOF

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" "$TEST_MAIN" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Run and check output
output=$("$BINARY")
expected="Hello World
Testing ft_putstr function"

if [ "$output" != "$expected" ]; then
    echo "Test failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All ft_putstr tests passed!"
exit 0
