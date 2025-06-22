#!/bin/bash
# test-setup.sh - Validate the exercise setup

set -euo pipefail

echo "🧪 Testing GitHub Pages + ShellCheck Exercise Setup"
echo "=================================================="

# Check if ShellCheck is available
if command -v shellcheck >/dev/null 2>&1; then
    echo "✅ ShellCheck is installed: $(shellcheck --version | head -1)"
else
    echo "❌ ShellCheck not found. Install with:"
    echo "   sudo apt install shellcheck"
    echo "   # or"
    echo "   brew install shellcheck"
    exit 1
fi

echo ""
echo "🔍 Running ShellCheck on all scripts..."
echo "======================================="

# Test good script (should pass)
echo "Testing good-script.sh:"
if shellcheck scripts/good-script.sh; then
    echo "✅ good-script.sh passes ShellCheck"
else
    echo "❌ good-script.sh failed ShellCheck"
fi

echo ""

# Test bad script (should fail)
echo "Testing bad-script.sh (expected to fail):"
if shellcheck scripts/bad-script.sh; then
    echo "❌ bad-script.sh unexpectedly passed ShellCheck"
else
    echo "✅ bad-script.sh correctly failed ShellCheck (this is expected)"
fi

echo ""

# Test utility script (should pass)
echo "Testing utility.sh:"
if shellcheck scripts/utility.sh; then
    echo "✅ utility.sh passes ShellCheck"
else
    echo "❌ utility.sh failed ShellCheck"
fi

echo ""
echo "📁 Checking project structure..."
echo "================================"

required_files=(
    ".github/workflows/shellcheck.yml"
    "scripts/good-script.sh"
    "scripts/bad-script.sh" 
    "scripts/utility.sh"
    "index.html"
    "README.md"
)

all_present=true
for file in "${required_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✅ $file"
    else
        echo "❌ Missing: $file"
        all_present=false
    fi
done

echo ""
if [[ "$all_present" == true ]]; then
    echo "🎉 All required files are present!"
else
    echo "⚠️  Some files are missing. Please check the setup."
fi

echo ""
echo "🌐 GitHub Pages Setup Instructions:"
echo "==================================="
echo "1. Push this repository to GitHub"
echo "2. Go to Settings → Pages"
echo "3. Set source to 'Deploy from a branch'"
echo "4. Select 'main' branch and '/ (root)' folder"
echo "5. Your site will be available at:"
echo "   https://USERNAME.github.io/REPOSITORY-NAME/"

echo ""
echo "🔄 GitHub Actions Setup:"
echo "========================"
echo "The workflow will automatically run when you:"
echo "- Push commits to main branch"
echo "- Create pull requests"
echo ""
echo "Check the Actions tab in your GitHub repository to see results."

echo ""
echo "✨ Setup validation complete!" 