# Shell Script Quality Demo with GitHub Pages & Actions

[![ShellCheck](https://github.com/username/repo/workflows/ShellCheck/badge.svg)](https://github.com/username/repo/actions)
[![Markdown Linting](https://github.com/username/repo/workflows/Markdown%20Linting/badge.svg)](https://github.com/username/repo/actions)

This repository demonstrates modern DevOps practices by combining:
- **GitHub Pages** for automatic static site hosting
- **GitHub Actions** for CI/CD pipeline automation  
- **ShellCheck** for shell script quality validation
- **Custom Markdown Linting** for documentation quality assurance

## 🌐 Live Demo

Visit the live site at: `https://username.github.io/repository-name/`

## 📁 Project Structure

```
ex4/
├── .github/
│   ├── actions/
│   │   └── markdown-lint/          # 🆕 Custom GitHub Action
│   │       ├── action.yml          # Action definition
│   │       ├── Dockerfile          # Container configuration
│   │       └── entrypoint.sh       # Main linting script
│   └── workflows/
│       ├── shellcheck.yml          # ShellCheck workflow
│       └── markdown-lint.yml       # 🆕 Markdown linting workflow
├── scripts/
│   ├── good-script.sh              # ✅ Well-written shell script
│   ├── bad-script.sh               # ❌ Script with ShellCheck violations
│   └── utility.sh                  # 🔧 Utility functions library
├── docs/                           # 🆕 Documentation examples
│   ├── good-example.md             # ✅ Well-written documentation
│   └── bad-example.md              # ❌ Documentation with writing issues
├── index.html                      # 📖 GitHub Pages main page
├── test-markdown-lint.sh           # 🆕 Local testing script
└── README.md                       # 📋 This documentation
```

## 🚀 Features

### Automated Quality Assurance
- **ShellCheck Integration**: Validates all shell scripts on push/PR
- **Custom Markdown Linting**: 🆕 Checks documentation quality with write-good and proselint
- **CI/CD Pipeline**: Prevents merging of problematic code and documentation
- **Quality Badges**: Visual indicators of code and documentation health

### GitHub Pages Integration
- **Automatic Deployment**: Site updates on every push
- **Professional Documentation**: Clean, responsive design
- **Code Examples**: Live demonstrations of good vs. bad practices

### Shell Script Examples
- **Best Practices**: Modern bash scripting techniques
- **Error Handling**: Proper exit codes and validation
- **Security**: Safe variable handling and quoting

### 🆕 Custom GitHub Action
- **Markdown Linting**: Custom action for documentation quality
- **Multi-tool Support**: Combines write-good and proselint
- **Docker-based**: Consistent environment across all runs
- **PR Integration**: Automatic comments on pull requests with issues

## 🔧 GitHub Actions Workflows

### ShellCheck Workflow
Our `.github/workflows/shellcheck.yml` automatically:

```yaml
name: ShellCheck
on: [push, pull_request]
jobs:
  shellcheck:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ludeeus/action-shellcheck@master
        with:
          severity: warning
          format: gcc
```

### 🆕 Markdown Linting Workflow
Our `.github/workflows/markdown-lint.yml` automatically:

```yaml
name: Markdown Linting
on:
  push:
    paths: ['**/*.md']
  pull_request:
    paths: ['**/*.md']
jobs:
  markdown-lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ./.github/actions/markdown-lint
        with:
          files: '**/*.md'
          tool: 'both'
```

## 📝 Examples

### ✅ Good Shell Script (`scripts/good-script.sh`)
- Uses `set -euo pipefail` for strict error handling
- Proper variable quoting and validation
- Local variables and function organization
- Safe file processing with proper IFS handling

### ❌ Bad Shell Script (`scripts/bad-script.sh`)
- Unquoted variables (SC2086)
- Legacy backtick syntax (SC2006)  
- Missing error handling
- Dangerous file operations

### 🔧 Utility Script (`scripts/utility.sh`)
- Reusable logging functions
- File validation utilities
- Safe backup operations
- Color-coded output

### 🆕 Documentation Examples

#### ✅ Good Documentation (`docs/good-example.md`)
- Clear, concise writing
- Active voice usage
- Simple, direct language
- Well-structured content

#### ❌ Bad Documentation (`docs/bad-example.md`)
- Passive voice overuse
- Wordy, complex phrases
- Redundant expressions
- Poor writing patterns

## 🧪 Testing the Setup

### 1. Test ShellCheck Locally
```bash
# Install ShellCheck
sudo apt install shellcheck

# Check a script
shellcheck scripts/good-script.sh
shellcheck scripts/bad-script.sh
```

### 2. 🆕 Test Markdown Linting Locally
```bash
# Install tools
npm install -g write-good
pip3 install proselint

# Test documentation
write-good docs/good-example.md
write-good docs/bad-example.md
proselint docs/good-example.md
proselint docs/bad-example.md

# Or use our test script
./test-markdown-lint.sh
```

### 3. Test GitHub Actions
```bash
# Push changes to trigger workflows
git add .
git commit -m "Test both ShellCheck and Markdown linting"
git push origin main
```

### 4. Test Pull Request Integration
```bash
# Create a test branch
git checkout -b test-markdown-issues

# Edit a markdown file with intentional issues
echo "This was written by the team in order to test the linting." >> docs/test.md

# Push and create PR
git add docs/test.md
git commit -m "Add test documentation with issues"
git push origin test-markdown-issues
# Then create PR via GitHub UI
```

## 🛠️ Custom Action Details

### Action Inputs
- **files**: Pattern for files to check (default: `**/*.md`)
- **severity**: Minimum severity level (default: `warning`)
- **tool**: Linting tool (`write-good`, `proselint`, `both`)

### Action Outputs
- **results**: Number of issues found

### Tools Used
- **write-good**: Grammar and style checking
  - Detects passive voice
  - Identifies wordy phrases
  - Catches adverb overuse
  
- **proselint**: Writing style analysis
  - Checks for redundancy and jargon
  - Identifies clichés
  - Suggests clarity improvements

## 🎯 Learning Objectives

This exercise demonstrates:

1. **CI/CD Integration**: Automated quality checks for code and documentation
2. **Static Analysis**: Using tools to catch issues before publication
3. **Custom Action Development**: Building reusable GitHub Actions
4. **Documentation Quality**: Maintaining high writing standards
5. **DevOps Practices**: Combining multiple tools for comprehensive quality assurance

## 🔗 Useful Links

- [ShellCheck Documentation](https://github.com/koalaman/shellcheck)
- [GitHub Actions Marketplace](https://github.com/marketplace/actions/shellcheck)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Write-Good Tool](https://github.com/btford/write-good)
- [Proselint Tool](https://github.com/amperser/proselint)
- [Creating GitHub Actions](https://docs.github.com/en/actions/creating-actions)
- [Bash Best Practices](https://mywiki.wooledge.org/BashGuide/Practices)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add your shell scripts to `scripts/` directory
4. Add your documentation to `docs/` directory
5. Ensure both ShellCheck and Markdown linting pass locally
6. Submit a pull request

Both CI/CD pipelines will automatically validate your changes!

---

**Built with ❤️ using GitHub Pages, GitHub Actions, ShellCheck, and Custom Markdown Linting**
