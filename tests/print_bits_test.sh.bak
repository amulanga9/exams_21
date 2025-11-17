#!/bin/bash

# Test for print_bits
SOURCE="./answers/print_bits.c"
TEST_MAIN="./build/print_bits_main.c"
BINARY="./build/print_bits"

# Create test main
cat > "$TEST_MAIN" << 'EOF'
void print_bits(unsigned char octet);

int main(void)
{
    print_bits(2);   // Should print: 00000010
    return 0;
}
EOF

# Compile
gcc -Wall -Wextra -Werror "$SOURCE" "$TEST_MAIN" -o "$BINARY" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Test 1
output=$("$BINARY")
expected="00000010"
if [ "$output" != "$expected" ]; then
    echo "Test 1 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 2: Test with 255
cat > "$TEST_MAIN" << 'EOF'
void print_bits(unsigned char octet);

int main(void)
{
    print_bits(255);
    return 0;
}
EOF

gcc -Wall -Wextra -Werror "$SOURCE" "$TEST_MAIN" -o "$BINARY" 2>/dev/null
output=$("$BINARY")
expected="11111111"
if [ "$output" != "$expected" ]; then
    echo "Test 2 failed: expected '$expected', got '$output'"
    exit 1
fi

# Test 3: Test with 0
cat > "$TEST_MAIN" << 'EOF'
void print_bits(unsigned char octet);

int main(void)
{
    print_bits(0);
    return 0;
}
EOF

gcc -Wall -Wextra -Werror "$SOURCE" "$TEST_MAIN" -o "$BINARY" 2>/dev/null
output=$("$BINARY")
expected="00000000"
if [ "$output" != "$expected" ]; then
    echo "Test 3 failed: expected '$expected', got '$output'"
    exit 1
fi

echo "All print_bits tests passed!"
exit 0
