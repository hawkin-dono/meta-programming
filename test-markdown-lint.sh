#!/bin/bash
# test-markdown-lint.sh - Test our custom markdown linting action locally

set -euo pipefail

echo "🧪 Testing Custom Markdown Linting Action"
echo "=========================================="

# Check if required tools are installed
echo "🔍 Checking dependencies..."

if ! command -v docker >/dev/null 2>&1; then
    echo "❌ Docker not found. Please install Docker first."
    exit 1
fi

if ! command -v write-good >/dev/null 2>&1; then
    echo "⚠️  write-good not found locally. Installing..."
    if command -v npm >/dev/null 2>&1; then
        npm install -g write-good
    else
        echo "❌ npm not found. Please install Node.js and npm first."
        exit 1
    fi
fi

if ! command -v proselint >/dev/null 2>&1; then
    echo "⚠️  proselint not found locally. Installing..."
    if command -v pip3 >/dev/null 2>&1; then
        pip3 install proselint
    else
        echo "❌ pip3 not found. Please install Python3 and pip first."
        exit 1
    fi
fi

echo "✅ Dependencies checked"
echo ""

# Test locally first (without Docker)
echo "🔍 Testing tools locally..."
echo "=============================="

echo "📝 Testing write-good on good example:"
if write-good docs/good-example.md; then
    echo "✅ No issues found (expected)"
else
    echo "⚠️  Some issues found in 'good' example"
fi

echo ""
echo "📝 Testing write-good on bad example:"
if write-good docs/bad-example.md; then
    echo "❌ No issues found (unexpected)"
else
    echo "✅ Issues found (expected)"
fi

echo ""
echo "📚 Testing proselint on good example:"
if proselint docs/good-example.md; then
    echo "✅ No issues found (expected)"
else
    echo "⚠️  Some issues found in 'good' example"
fi

echo ""
echo "📚 Testing proselint on bad example:"
if proselint docs/bad-example.md; then
    echo "❌ No issues found (unexpected)"
else
    echo "✅ Issues found (expected)"
fi

echo ""
echo "🐳 Testing Docker action locally..."
echo "=================================="

# Build the Docker image
echo "Building Docker image..."
if docker build -t markdown-lint-action .github/actions/markdown-lint/; then
    echo "✅ Docker image built successfully"
else
    echo "❌ Failed to build Docker image"
    exit 1
fi

echo ""
echo "Running Docker action..."
# Simulate running the action
if docker run --rm -v "$(pwd):/github/workspace" -w /github/workspace \
    -e "GITHUB_OUTPUT=/tmp/github_output" \
    markdown-lint-action "**/*.md" "warning" "both"; then
    echo "✅ Docker action completed"
else
    echo "⚠️  Docker action found issues (this might be expected)"
fi

echo ""
echo "📁 Checking project structure..."
echo "================================"

required_files=(
    ".github/actions/markdown-lint/action.yml"
    ".github/actions/markdown-lint/Dockerfile"
    ".github/actions/markdown-lint/entrypoint.sh"
    ".github/workflows/markdown-lint.yml"
    "docs/good-example.md"
    "docs/bad-example.md"
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
echo "🚀 Next Steps:"
echo "============="
echo "1. Commit and push your changes:"
echo "   git add ."
echo "   git commit -m 'Add custom markdown linting action'"
echo "   git push origin main"
echo ""
echo "2. Test with a pull request:"
echo "   - Create a new branch with markdown changes"
echo "   - Include some writing issues to test the action"
echo "   - Open a pull request"
echo "   - Check the Actions tab for results"
echo ""
echo "3. The action will:"
echo "   - Run automatically on markdown file changes"
echo "   - Comment on PRs with issues found"
echo "   - Provide detailed feedback in the logs"

echo ""
echo "✨ Custom Markdown Linting Action setup complete!" 