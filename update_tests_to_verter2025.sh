#!/bin/bash

# Script to update all test files to Verter 2025 compliance
# Replaces gcc with $CC and adds Verter config loading

echo "Updating all test scripts to Verter 2025 compliance..."

# Find all test files
test_files=$(find tests -name "*_test.sh" -type f)

updated_count=0
total_count=0

for test_file in $test_files; do
    ((total_count++))

    # Skip if already updated (check for test_config.sh source)
    if grep -q "source ./test_config.sh" "$test_file"; then
        echo "⊘ Skipped (already updated): $test_file"
        continue
    fi

    # Create backup
    cp "$test_file" "${test_file}.bak"

    # Create temporary file
    temp_file=$(mktemp)

    # Process the file
    {
        # Add shebang
        echo "#!/bin/bash"
        echo ""

        # Extract test name from filename
        test_name=$(basename "$test_file" | sed 's/_test.sh//')
        echo "# Test for $test_name"
        echo "# Verter 2025 compliant"
        echo ""

        # Add config loading
        echo "# Load Verter configuration"
        echo "source ./test_config.sh 2>/dev/null || true"
        echo ""

        # Process rest of file
        tail -n +2 "$test_file" | \
            sed 's/^gcc /\$CC \$CFLAGS /' | \
            sed 's/ gcc / \$CC \$CFLAGS /'

    } > "$temp_file"

    # Replace original
    mv "$temp_file" "$test_file"
    chmod +x "$test_file"

    echo "✓ Updated: $test_file"
    ((updated_count++))
done

echo ""
echo "════════════════════════════════════════"
echo "Update Summary:"
echo "  Total tests found:  $total_count"
echo "  Updated:            $updated_count"
echo "  Backups created:    ${updated_count} (.bak files)"
echo "════════════════════════════════════════"
echo ""
echo "✓ All tests updated to Verter 2025 compliance"
echo "  Using: \$CC (clang) instead of gcc"
echo "  Using: \$CFLAGS (-Wall -Wextra -Werror)"
echo ""
