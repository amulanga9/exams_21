#!/bin/bash

# School 21 Verter-like Test Runner
# Automatically tests all C assignments from student submissions

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0
SKIPPED_TESTS=0

# Directories
SUBMISSIONS_DIR="./submissions"
ANSWERS_DIR="./answers"
TESTS_DIR="./tests"
BUILD_DIR="./build"
RESULTS_DIR="./test_results"

# Create necessary directories
mkdir -p "$BUILD_DIR"
mkdir -p "$RESULTS_DIR"

# Log file
LOG_FILE="$RESULTS_DIR/test_results_$(date +%Y%m%d_%H%M%S).log"

# Export directories for test scripts
export SUBMISSIONS_DIR
export ANSWERS_DIR
export BUILD_DIR

# Function to print header
print_header() {
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                       ║${NC}"
    echo -e "${CYAN}║       ${BLUE}🎓 School 21 Verter Auto-Checker 🎓${CYAN}        ║${NC}"
    echo -e "${CYAN}║                                                       ║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${MAGENTA}Mode: ${NC}Testing student submissions from ${YELLOW}${SUBMISSIONS_DIR}${NC}"
    echo -e "${MAGENTA}Date: ${NC}$(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
}

# Function to log and print
log_print() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

# Function to find source file (check submissions first, then answers)
find_source_file() {
    local task_name="$1"
    local level="$2"

    # Check in submissions directory first
    if [ -n "$level" ]; then
        if [ -f "$SUBMISSIONS_DIR/level_${level}/${task_name}.c" ]; then
            echo "$SUBMISSIONS_DIR/level_${level}/${task_name}.c"
            return 0
        fi
    fi

    # Check all level directories in submissions
    for lv in 1 2 3 4; do
        if [ -f "$SUBMISSIONS_DIR/level_${lv}/${task_name}.c" ]; then
            echo "$SUBMISSIONS_DIR/level_${lv}/${task_name}.c"
            return 0
        fi
    done

    # Fall back to answers directory (reference implementation)
    if [ -f "$ANSWERS_DIR/${task_name}.c" ]; then
        echo "$ANSWERS_DIR/${task_name}.c"
        return 0
    fi

    return 1
}

# Function to run a test
run_test() {
    local test_name="$1"
    local test_script="$2"
    local level="$3"

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    # Find the source file
    local source_file=$(find_source_file "$test_name" "$level")

    if [ -z "$source_file" ]; then
        log_print "${YELLOW}⊘ SKIPPED${NC}: ${test_name} ${RED}(file not found)${NC}"
        log_print "  ${CYAN}Expected file: ${NC}submissions/level_${level}/${test_name}.c"
        log_print ""
        SKIPPED_TESTS=$((SKIPPED_TESTS + 1))
        return 2
    fi

    # Determine if using student code or reference
    local source_type="reference"
    if [[ "$source_file" == *"$SUBMISSIONS_DIR"* ]]; then
        source_type="student"
    fi

    log_print "${YELLOW}Testing: ${NC}${test_name} ${CYAN}[${source_type}]${NC}"
    log_print "  ${MAGENTA}Source: ${NC}${source_file}"

    # Run the test script
    export CURRENT_SOURCE_FILE="$source_file"
    export CURRENT_TEST_NAME="$test_name"

    bash "$test_script" > "$BUILD_DIR/${test_name}_output.txt" 2>&1
    local result=$?

    if [ $result -eq 0 ]; then
        log_print "  ${GREEN}✓ PASSED${NC}"
        log_print ""
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        log_print "  ${RED}✗ FAILED${NC}"
        log_print "  ${RED}┌─ Error Details:${NC}"

        # Show detailed error output
        while IFS= read -r line; do
            log_print "  ${RED}│${NC} $line"
        done < "$BUILD_DIR/${test_name}_output.txt"

        log_print "  ${RED}└────────────────${NC}"
        log_print ""
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

# Function to test Level 1 tasks
test_level1() {
    log_print "${BLUE}╔═══════════════════════════════════════════════════════╗${NC}"
    log_print "${BLUE}║              Testing Level 1 Tasks                    ║${NC}"
    log_print "${BLUE}╚═══════════════════════════════════════════════════════╝${NC}"
    log_print ""

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
            run_test "$task" "$TESTS_DIR/${task}_test.sh" "1"
        else
            log_print "${YELLOW}⚠ Test not found: ${task}${NC}\n"
        fi
    done
}

# Function to test Level 2 tasks
test_level2() {
    log_print "${BLUE}╔═══════════════════════════════════════════════════════╗${NC}"
    log_print "${BLUE}║              Testing Level 2 Tasks                    ║${NC}"
    log_print "${BLUE}╚═══════════════════════════════════════════════════════╝${NC}"
    log_print ""

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
            run_test "$task" "$TESTS_DIR/${task}_test.sh" "2"
        else
            log_print "${YELLOW}⚠ Test not found: ${task}${NC}\n"
        fi
    done
}

# Function to test Level 3 tasks
test_level3() {
    log_print "${BLUE}╔═══════════════════════════════════════════════════════╗${NC}"
    log_print "${BLUE}║              Testing Level 3 Tasks                    ║${NC}"
    log_print "${BLUE}╚═══════════════════════════════════════════════════════╝${NC}"
    log_print ""

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
            run_test "$task" "$TESTS_DIR/${task}_test.sh" "3"
        else
            log_print "${YELLOW}⚠ Test not found: ${task}${NC}\n"
        fi
    done
}

# Function to test Level 4 tasks
test_level4() {
    log_print "${BLUE}╔═══════════════════════════════════════════════════════╗${NC}"
    log_print "${BLUE}║              Testing Level 4 Tasks                    ║${NC}"
    log_print "${BLUE}╚═══════════════════════════════════════════════════════╝${NC}"
    log_print ""

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
            run_test "$task" "$TESTS_DIR/${task}_test.sh" "4"
        else
            log_print "${YELLOW}⚠ Test not found: ${task}${NC}\n"
        fi
    done
}

# Function to test Piscine tasks
test_piscine() {
    log_print "${BLUE}╔═══════════════════════════════════════════════════════╗${NC}"
    log_print "${BLUE}║           Testing Piscine Exercises (stdin)          ║${NC}"
    log_print "${BLUE}╚═══════════════════════════════════════════════════════╝${NC}"
    log_print ""

    # Test Ex_01 tasks
    local piscine_tests=(
        "ex_01_01:tests_piscine/ex_01_01_test.sh"
        "ex_01_05:tests_piscine/ex_01_05_test.sh"
    )

    for test_entry in "${piscine_tests[@]}"; do
        IFS=':' read -r test_name test_script <<< "$test_entry"

        if [ -f "$test_script" ]; then
            TOTAL_TESTS=$((TOTAL_TESTS + 1))

            log_print "${YELLOW}Testing: ${NC}${test_name} ${CYAN}[piscine]${NC}"

            bash "$test_script" > "$BUILD_DIR/${test_name}_output.txt" 2>&1
            local result=$?

            if [ $result -eq 0 ]; then
                log_print "  ${GREEN}✓ PASSED${NC}"
                log_print ""
                PASSED_TESTS=$((PASSED_TESTS + 1))
            elif [ $result -eq 2 ]; then
                log_print "  ${YELLOW}⊘ SKIPPED${NC} ${RED}(file not found)${NC}"
                log_print ""
                SKIPPED_TESTS=$((SKIPPED_TESTS + 1))
            else
                log_print "  ${RED}✗ FAILED${NC}"
                log_print "  ${RED}┌─ Error Details:${NC}"
                while IFS= read -r line; do
                    log_print "  ${RED}│${NC} $line"
                done < "$BUILD_DIR/${test_name}_output.txt"
                log_print "  ${RED}└────────────────${NC}"
                log_print ""
                FAILED_TESTS=$((FAILED_TESTS + 1))
            fi
        fi
    done
}

# Function to print summary
print_summary() {
    log_print ""
    log_print "${CYAN}╔═══════════════════════════════════════════════════════╗${NC}"
    log_print "${CYAN}║                   Test Summary                        ║${NC}"
    log_print "${CYAN}╚═══════════════════════════════════════════════════════╝${NC}"
    log_print ""
    log_print "  Total tests:  ${MAGENTA}$TOTAL_TESTS${NC}"
    log_print "  ${GREEN}✓ Passed:     $PASSED_TESTS${NC}"
    log_print "  ${RED}✗ Failed:     $FAILED_TESTS${NC}"
    log_print "  ${YELLOW}⊘ Skipped:    $SKIPPED_TESTS${NC}"
    log_print ""

    if [ $TOTAL_TESTS -gt 0 ]; then
        local tested=$((TOTAL_TESTS - SKIPPED_TESTS))
        if [ $tested -gt 0 ]; then
            local percentage=$((PASSED_TESTS * 100 / tested))
            log_print "  ${CYAN}Success rate: ${MAGENTA}${percentage}%${NC} ${CYAN}(of tested files)${NC}"
        fi
    fi

    log_print ""
    log_print "  ${BLUE}📄 Full report: ${NC}$LOG_FILE"

    if [ $SKIPPED_TESTS -gt 0 ]; then
        log_print ""
        log_print "  ${YELLOW}💡 Tip: ${NC}Add your solutions to ${YELLOW}${SUBMISSIONS_DIR}/level_X/${NC}"
        log_print "     Example: ${CYAN}${SUBMISSIONS_DIR}/level_1/first_word.c${NC}"
    fi

    log_print ""
    log_print "${CYAN}╚═══════════════════════════════════════════════════════╝${NC}"
    log_print ""
}

# Main execution
main() {
    print_header

    log_print "${MAGENTA}Starting tests at $(date)${NC}\n"

    # Run tests by level
    test_level1
    test_level2
    test_level3
    test_level4

    # Run piscine tests
    test_piscine

    # Print summary
    print_summary

    # Exit with appropriate code
    if [ $FAILED_TESTS -eq 0 ]; then
        if [ $SKIPPED_TESTS -gt 0 ]; then
            log_print "${YELLOW}⚠ All tested files passed, but some tasks were skipped${NC}"
        else
            log_print "${GREEN}🎉 Perfect! All tests passed!${NC}"
        fi
        exit 0
    else
        log_print "${RED}❌ Some tests failed. Review the errors above.${NC}"
        exit 1
    fi
}

# Run main
main
