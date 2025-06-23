#!/bin/bash

set -euo pipefail

# Input parameters
FILES_PATTERN="${1:-**/*.md}"
SEVERITY="${2:-warning}"
TOOL="${3:-both}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TOTAL_ISSUES=0
TOTAL_FILES=0

echo -e "${BLUE}🔍 Markdown Linting Action${NC}"
echo "================================="
echo "Files pattern: $FILES_PATTERN"
echo "Severity: $SEVERITY"
echo "Tool: $TOOL"
echo ""

# Find markdown files
mapfile -t MD_FILES < <(find . -name "*.md" -type f | grep -v ".git" || true)

if [ ${#MD_FILES[@]} -eq 0 ]; then
    echo -e "${YELLOW}⚠️  No Markdown files found${NC}"
    exit 0
fi

echo -e "${BLUE}Found ${#MD_FILES[@]} Markdown files${NC}"
echo ""

# Function to run write-good
run_write_good() {
    local file="$1"
    local issues=0
    
    echo -e "${BLUE}📝 Running write-good on: $file${NC}"
    
    if output=$(write-good "$file" 2>&1); then
        if [ -n "$output" ]; then
            echo -e "${YELLOW}Issues found:${NC}"
            echo "$output"
            # Count lines of output (approximate issue count)
            issues=$(echo "$output" | wc -l)
            echo ""
        else
            echo -e "${GREEN}✅ No issues found${NC}"
            echo ""
        fi
    else
        echo -e "${RED}❌ Error running write-good on $file${NC}"
        echo "$output"
        echo ""
        issues=1
    fi
    
    return $issues
}

# Function to run proselint
run_proselint() {
    local file="$1"
    local issues=0
    
    echo -e "${BLUE}📚 Running proselint on: $file${NC}"
    
    if output=$(proselint "$file" 2>&1); then
        if [ -n "$output" ]; then
            echo -e "${YELLOW}Issues found:${NC}"
            echo "$output"
            # Count lines of output (approximate issue count)
            issues=$(echo "$output" | wc -l)
            echo ""
        else
            echo -e "${GREEN}✅ No issues found${NC}"
            echo ""
        fi
    else
        # Proselint returns non-zero when issues are found
        if echo "$output" | grep -q ":" ; then
            echo -e "${YELLOW}Issues found:${NC}"
            echo "$output"
            issues=$(echo "$output" | wc -l)
            echo ""
        else
            echo -e "${RED}❌ Error running proselint on $file${NC}"
            echo "$output"
            echo ""
            issues=1
        fi
    fi
    
    return $issues
}

# Process each file
for file in "${MD_FILES[@]}"; do
    echo -e "${BLUE}🔍 Processing: $file${NC}"
    echo "----------------------------------------"
    
    file_issues=0
    
    case "$TOOL" in
        "write-good")
            run_write_good "$file"
            file_issues=$?
            ;;
        "proselint")
            run_proselint "$file"
            file_issues=$?
            ;;
        "both")
            run_write_good "$file"
            wg_issues=$?
            run_proselint "$file"
            ps_issues=$?
            file_issues=$((wg_issues + ps_issues))
            ;;
        *)
            echo -e "${RED}❌ Unknown tool: $TOOL${NC}"
            exit 1
            ;;
    esac
    
    TOTAL_ISSUES=$((TOTAL_ISSUES + file_issues))
    TOTAL_FILES=$((TOTAL_FILES + 1))
    
    echo ""
done

# Summary
echo "======================================="
echo -e "${BLUE}📊 Summary${NC}"
echo "Files processed: $TOTAL_FILES"
echo "Total issues found: $TOTAL_ISSUES"

# Set output for GitHub Actions
echo "results=$TOTAL_ISSUES" >> "$GITHUB_OUTPUT"

# Exit with appropriate code
if [ "$TOTAL_ISSUES" -gt 0 ]; then
    echo ""
    echo -e "${RED}❌ Linting failed with $TOTAL_ISSUES issues${NC}"
    
    # For severity levels (could be enhanced)
    case "$SEVERITY" in
        "error")
            exit 1
            ;;
        "warning")
            exit 1
            ;;
        "suggestion")
            exit 0  # Don't fail the build for suggestions
            ;;
        *)
            exit 1
            ;;
    esac
else
    echo ""
    echo -e "${GREEN}✅ All Markdown files passed linting!${NC}"
    exit 0
fi 