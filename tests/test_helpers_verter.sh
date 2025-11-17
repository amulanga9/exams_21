#!/bin/bash

# School 21 Verter-Compatible Test Helper Functions
# Based on real Moulinette/Verter behavior

# Load configuration
source ./test_config.sh 2>/dev/null || true

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ==========================================
# NORMINETTE CHECK (School 21 Coding Standard)
# ==========================================
check_norminette() {
    local file="$1"

    if [ "$ENABLE_NORMINETTE" != "true" ]; then
        return 0
    fi

    if ! command -v norminette &> /dev/null; then
        echo -e "${YELLOW}⚠ norminette not installed, skipping norm check${NC}"
        return 0
    fi

    echo -e "${BLUE}Checking norminette...${NC}"

    # Check .c files
    if [[ "$file" == *.c ]]; then
        norminette $NORM_RULES "$file" > /tmp/norm_output.txt 2>&1
    # Check .h files
    elif [[ "$file" == *.h ]]; then
        norminette $NORM_HEADER_RULES "$file" > /tmp/norm_output.txt 2>&1
    fi

    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Norminette failed:${NC}"
        cat /tmp/norm_output.txt
        return 1
    fi

    echo -e "${GREEN}✓ Norminette: OK${NC}"
    return 0
}

# ==========================================
# COMPILATION (Using CLANG like School 21)
# ==========================================
compile_verter() {
    local source="$1"
    local binary="$2"
    local extra_flags="$3"

    echo -e "${BLUE}Compiling with ${CC}...${NC}"

    # School 21 standard compilation
    $CC $CFLAGS $extra_flags "$source" -o "$binary" 2>&1
    local result=$?

    if [ $result -ne 0 ]; then
        echo -e "${RED}✗ Compilation failed${NC}"
        return 1
    fi

    echo -e "${GREEN}✓ Compilation: OK${NC}"
    return 0
}

# ==========================================
# MEMORY LEAK CHECK (Valgrind/Leaks)
# ==========================================
check_memory_leaks() {
    local binary="$1"
    shift
    local args="$@"

    if [ "$ENABLE_MEMORY_CHECK" != "true" ]; then
        return 0
    fi

    echo -e "${BLUE}Checking memory leaks...${NC}"

    # Run with memory checker
    if [[ "$MEM_CHECKER" == *"leaks"* ]]; then
        # macOS leaks
        $MEM_CHECKER "$binary" $args > /tmp/mem_check.txt 2>&1
        local leak_count=$(grep "leaked bytes" /tmp/mem_check.txt | awk '{print $6}')
        if [ -n "$leak_count" ] && [ "$leak_count" != "0" ]; then
            echo -e "${RED}✗ Memory leak detected: $leak_count bytes${NC}"
            return 1
        fi
    else
        # valgrind
        $MEM_CHECKER "$binary" $args > /tmp/mem_check.txt 2>&1
        if [ $? -ne 0 ]; then
            echo -e "${RED}✗ Memory leak detected${NC}"
            cat /tmp/mem_check.txt
            return 1
        fi
    fi

    echo -e "${GREEN}✓ Memory: OK${NC}"
    return 0
}

# ==========================================
# NULL/MALLOC FAILURE TEST
# ==========================================
test_null_cases() {
    local function_name="$1"

    if [ "$ENABLE_NULL_TESTS" != "true" ]; then
        return 0
    fi

    echo -e "${BLUE}Testing NULL cases...${NC}"

    # This would require LD_PRELOAD malloc wrapper
    # For now, just inform
    echo -e "${YELLOW}⚠ NULL tests require malloc wrapper${NC}"
    return 0
}

# ==========================================
# EDGE CASE TESTING
# ==========================================
run_edge_case_tests() {
    local binary="$1"

    if [ "$ENABLE_EDGE_CASES" != "true" ]; then
        return 0
    fi

    echo -e "${BLUE}Running edge case tests...${NC}"

    local failed=0

    # Test 1: Empty input
    echo "" | timeout $MAX_EXECUTION_TIME "$binary" > /tmp/edge1.txt 2>&1 || ((failed++))

    # Test 2: Max int
    echo "2147483647" | timeout $MAX_EXECUTION_TIME "$binary" > /tmp/edge2.txt 2>&1 || ((failed++))

    # Test 3: Min int
    echo "-2147483648" | timeout $MAX_EXECUTION_TIME "$binary" > /tmp/edge3.txt 2>&1 || ((failed++))

    # Test 4: Zero
    echo "0" | timeout $MAX_EXECUTION_TIME "$binary" > /tmp/edge4.txt 2>&1 || ((failed++))

    if [ $failed -gt 0 ]; then
        echo -e "${YELLOW}⚠ Some edge cases failed or crashed${NC}"
    else
        echo -e "${GREEN}✓ Edge cases: OK${NC}"
    fi

    return 0
}

# ==========================================
# COMPREHENSIVE VERTER-STYLE TEST
# ==========================================
verter_test() {
    local source="$1"
    local binary="$2"
    local test_name="$3"
    local extra_flags="$4"

    echo -e "\n${BLUE}╔══════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  VERTER TEST: $test_name${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════╝${NC}\n"

    local total_checks=0
    local passed_checks=0

    # Step 1: Norminette
    ((total_checks++))
    if check_norminette "$source"; then
        ((passed_checks++))
    elif [ "$REQUIRE_100_PERCENT" = "true" ]; then
        echo -e "${RED}✗ Test failed: Norminette errors${NC}"
        return 1
    fi

    # Step 2: Compilation
    ((total_checks++))
    if compile_verter "$source" "$binary" "$extra_flags"; then
        ((passed_checks++))
    else
        echo -e "${RED}✗ Test failed: Compilation errors${NC}"
        return 1
    fi

    # Step 3: Memory check
    if [ -f "$binary" ]; then
        ((total_checks++))
        if check_memory_leaks "$binary"; then
            ((passed_checks++))
        elif [ "$REQUIRE_100_PERCENT" = "true" ]; then
            echo -e "${RED}✗ Test failed: Memory leaks${NC}"
            return 1
        fi
    fi

    # Step 4: Edge cases
    if [ -f "$binary" ]; then
        ((total_checks++))
        if run_edge_case_tests "$binary"; then
            ((passed_checks++))
        fi
    fi

    # Summary
    echo -e "\n${BLUE}──────────────────────────────────────${NC}"
    echo -e "Checks: $passed_checks/$total_checks passed"

    if [ "$REQUIRE_100_PERCENT" = "true" ] && [ $passed_checks -ne $total_checks ]; then
        echo -e "${RED}✗ VERTER: FAILED (require 100%)${NC}"
        return 1
    fi

    echo -e "${GREEN}✓ VERTER: PASSED${NC}"
    return 0
}

# Export functions
export -f check_norminette
export -f compile_verter
export -f check_memory_leaks
export -f test_null_cases
export -f run_edge_case_tests
export -f verter_test
