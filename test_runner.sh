#!/bin/bash

# School 21 Verter-like Test Runner
# Automatically tests all C assignments

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Directories
ANSWERS_DIR="./answers"
TESTS_DIR="./tests"
BUILD_DIR="./build"
RESULTS_DIR="./test_results"

# Create necessary directories
mkdir -p "$BUILD_DIR"
mkdir -p "$RESULTS_DIR"

# Log file
LOG_FILE="$RESULTS_DIR/test_results_$(date +%Y%m%d_%H%M%S).log"

# Function to print header
print_header() {
    echo -e "${BLUE}=================================${NC}"
    echo -e "${BLUE}  School 21 Verter Test Runner  ${NC}"
    echo -e "${BLUE}=================================${NC}"
    echo ""
}

# Function to log and print
log_print() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

# Function to compile a C file
compile_c_file() {
    local source_file="$1"
    local output_file="$2"
    local additional_flags="$3"

    gcc -Wall -Wextra -Werror $additional_flags "$source_file" -o "$output_file" 2>&1
    return $?
}

# Function to run a test
run_test() {
    local test_name="$1"
    local test_script="$2"

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    log_print "${YELLOW}Testing: ${test_name}${NC}"

    # Run the test script
    bash "$test_script" > "$BUILD_DIR/${test_name}_output.txt" 2>&1
    local result=$?

    if [ $result -eq 0 ]; then
        log_print "${GREEN}✓ PASSED${NC}\n"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        log_print "${RED}✗ FAILED${NC}"
        log_print "  Error output:"
        cat "$BUILD_DIR/${test_name}_output.txt" | tee -a "$LOG_FILE"
        log_print ""
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

# Function to test Level 1 tasks
test_level1() {
    log_print "${BLUE}=== Testing Level 1 Tasks ===${NC}\n"

    local level1_tasks=(
        "first_word"
        "fizzbuzz"
        "ft_strcpy"
        "ft_strlen"
        "ft_swap"
        "ft_putstr"
        "repeat_alpha"
        "rev_print"
        "rot_13"
        "rotone"
        "search_and_replace"
        "ulstr"
    )

    for task in "${level1_tasks[@]}"; do
        if [ -f "$TESTS_DIR/${task}_test.sh" ]; then
            run_test "$task" "$TESTS_DIR/${task}_test.sh"
        else
            log_print "${YELLOW}⚠ Test not found: ${task}${NC}\n"
        fi
    done
}

# Function to test Level 2 tasks
test_level2() {
    log_print "${BLUE}=== Testing Level 2 Tasks ===${NC}\n"

    local level2_tasks=(
        "alpha_mirror"
        "do_op"
        "ft_atoi"
        "ft_strcmp"
        "ft_strcspn"
        "ft_strdup"
        "ft_strpbrk"
        "ft_strrev"
        "ft_strspn"
        "inter"
        "is_power_of_2"
        "last_word"
        "max"
        "print_bits"
        "reverse_bits"
        "snake_to_camel"
        "swap_bits"
        "union"
        "wdmatch"
    )

    for task in "${level2_tasks[@]}"; do
        if [ -f "$TESTS_DIR/${task}_test.sh" ]; then
            run_test "$task" "$TESTS_DIR/${task}_test.sh"
        else
            log_print "${YELLOW}⚠ Test not found: ${task}${NC}\n"
        fi
    done
}

# Function to test Level 3 tasks
test_level3() {
    log_print "${BLUE}=== Testing Level 3 Tasks ===${NC}\n"

    local level3_tasks=(
        "add_prime_sum"
        "epur_str"
        "expand_str"
        "ft_atoi_base"
        "ft_list_size"
        "ft_range"
        "ft_rrange"
        "hidenp"
        "lcm"
        "paramsum"
        "pgcd"
        "print_hex"
        "rstr_capitalizer"
        "str_capitalizer"
        "tab_mult"
    )

    for task in "${level3_tasks[@]}"; do
        if [ -f "$TESTS_DIR/${task}_test.sh" ]; then
            run_test "$task" "$TESTS_DIR/${task}_test.sh"
        else
            log_print "${YELLOW}⚠ Test not found: ${task}${NC}\n"
        fi
    done
}

# Function to test Level 4 tasks
test_level4() {
    log_print "${BLUE}=== Testing Level 4 Tasks ===${NC}\n"

    local level4_tasks=(
        "flood_fill"
        "fprime"
        "ft_itoa"
        "ft_list_foreach"
        "ft_list_remove_if"
        "ft_split"
        "rev_wstr"
        "rostring"
        "sort_int_tab"
        "sort_list"
    )

    for task in "${level4_tasks[@]}"; do
        if [ -f "$TESTS_DIR/${task}_test.sh" ]; then
            run_test "$task" "$TESTS_DIR/${task}_test.sh"
        else
            log_print "${YELLOW}⚠ Test not found: ${task}${NC}\n"
        fi
    done
}

# Function to print summary
print_summary() {
    log_print "\n${BLUE}=================================${NC}"
    log_print "${BLUE}         Test Summary            ${NC}"
    log_print "${BLUE}=================================${NC}"
    log_print "Total tests:  $TOTAL_TESTS"
    log_print "${GREEN}Passed:       $PASSED_TESTS${NC}"
    log_print "${RED}Failed:       $FAILED_TESTS${NC}"

    if [ $TOTAL_TESTS -gt 0 ]; then
        local percentage=$((PASSED_TESTS * 100 / TOTAL_TESTS))
        log_print "Success rate: ${percentage}%"
    fi

    log_print "\nResults saved to: $LOG_FILE"
    log_print "${BLUE}=================================${NC}\n"
}

# Main execution
main() {
    print_header

    log_print "Starting tests at $(date)\n"

    # Run tests by level
    test_level1
    test_level2
    test_level3
    test_level4

    # Print summary
    print_summary

    # Exit with appropriate code
    if [ $FAILED_TESTS -eq 0 ]; then
        exit 0
    else
        exit 1
    fi
}

# Run main
main
