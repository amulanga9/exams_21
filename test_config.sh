#!/bin/bash

# School 21 Verter-Compatible Test Configuration
# Based on 2025 requirements research

# ==========================================
# CRITICAL: School 21 uses CLANG, not GCC!
# ==========================================

# Compiler Configuration
export CC="clang"                    # School 21 standard compiler
export CFLAGS="-Wall -Wextra -Werror"  # Required compilation flags

# Alternative: Check if clang is available, fall back to gcc
if command -v clang &> /dev/null; then
    export CC="clang"
    echo "✓ Using clang (School 21 standard)"
else
    export CC="gcc"
    echo "⚠ Warning: clang not found, using gcc as fallback"
fi

# Test Configuration
export ENABLE_NORMINETTE=false    # Set to true when norminette is installed
export ENABLE_MEMORY_CHECK=true   # Memory leak detection
export ENABLE_NULL_TESTS=true     # NULL pointer/malloc failure tests
export ENABLE_EDGE_CASES=true     # Extended edge case testing
export STRICT_MODE=false          # Moulinette-like strict mode

# Memory Checker (valgrind on Linux, leaks on macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    export MEM_CHECKER="leaks -atExit --"
else
    export MEM_CHECKER="valgrind --leak-check=full --error-exitcode=1 --quiet"
fi

# Test Execution Settings
export MAX_EXECUTION_TIME=5       # Seconds
export CASCADE_FAIL=true          # Stop on first failure (moulinette style)
export DETAILED_OUTPUT=true       # Show detailed error messages

# Norminette Configuration
export NORM_RULES="-R CheckForbiddenSourceHeader"  # For .c files
export NORM_HEADER_RULES=""                        # For .h files

# Score Calculation
export PARTIAL_CREDIT=false       # All tests must pass (like real Verter)
export REQUIRE_100_PERCENT=true   # Require 100% to pass

echo "School 21 Verter Test Configuration Loaded"
echo "Compiler: $CC"
echo "Flags: $CFLAGS"
echo "Memory Check: $ENABLE_MEMORY_CHECK"
echo "Norminette: $ENABLE_NORMINETTE"
