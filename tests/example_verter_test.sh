#!/bin/bash

# Test for example_verter
# Verter 2025 compliant

# Load Verter configuration
source ./test_config.sh 2>/dev/null || true


# Example Verter-Style Test
# Demonstrates new testing capabilities

# Load Verter helpers
source ./tests/test_helpers_verter.sh

# Test configuration
SOURCE="${CURRENT_SOURCE_FILE:-./answers/first_word.c}"
BINARY="./build/first_word_verter"
TEST_NAME="first_word"

echo "================================================="
echo "  SCHOOL 21 VERTER TEST: $TEST_NAME"
echo "================================================="

# Run comprehensive Verter-style test
verter_test "$SOURCE" "$BINARY" "$TEST_NAME"
if [ $? -ne 0 ]; then
    exit 1
fi

# Custom functional tests
echo -e "\n${BLUE}Running functional tests...${NC}"

# Test 1: Normal case
output=$(timeout 2 "$BINARY" "hello world" 2>&1)
expected="hello"
if [ "$output" != "$expected" ]; then
    echo -e "${RED}✗ Test 1 failed: expected '$expected', got '$output'${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Test 1: Normal case${NC}"

# Test 2: Multiple spaces
output=$(timeout 2 "$BINARY" "  FOR PONY" 2>&1)
expected="FOR"
if [ "$output" != "$expected" ]; then
    echo -e "${RED}✗ Test 2 failed: expected '$expected', got '$output'${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Test 2: Multiple spaces${NC}"

# Test 3: No arguments
output=$(timeout 2 "$BINARY" 2>&1)
expected=""
if [ "$output" != "$expected" ]; then
    echo -e "${RED}✗ Test 3 failed: expected empty line${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Test 3: No arguments${NC}"

# Test 4: Single word
output=$(timeout 2 "$BINARY" "testing" 2>&1)
expected="testing"
if [ "$output" != "$expected" ]; then
    echo -e "${RED}✗ Test 4 failed: expected '$expected', got '$output'${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Test 4: Single word${NC}"

# Test 5: Tabs and spaces
output=$(timeout 2 "$BINARY" "	hello	world" 2>&1)
expected="hello"
if [ "$output" != "$expected" ]; then
    echo -e "${RED}✗ Test 5 failed: expected '$expected', got '$output'${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Test 5: Tabs and spaces${NC}"

echo -e "\n${GREEN}════════════════════════════════════════${NC}"
echo -e "${GREEN}  ✓ ALL TESTS PASSED (Verter-style)${NC}"
echo -e "${GREEN}════════════════════════════════════════${NC}"

exit 0
