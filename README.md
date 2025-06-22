# Shell Script Quality Demo with GitHub Pages & Actions

[![ShellCheck](https://github.com/username/repo/workflows/ShellCheck/badge.svg)](https://github.com/username/repo/actions)

This repository demonstrates modern DevOps practices by combining:
- **GitHub Pages** for automatic static site hosting
- **GitHub Actions** for CI/CD pipeline automation  
- **ShellCheck** for shell script quality validation

## 🌐 Live Demo

Visit the live site at: `https://username.github.io/repository-name/`

## 📁 Project Structure

```
ex4/
├── .github/workflows/
│   └── shellcheck.yml          # GitHub Actions workflow
├── scripts/
│   ├── good-script.sh          # ✅ Well-written shell script
│   ├── bad-script.sh           # ❌ Script with ShellCheck violations
│   └── utility.sh              # 🔧 Utility functions library
├── index.html                  # 📖 GitHub Pages main page
└── README.md                   # 📋 This documentation
```

## 🚀 Features

### Automated Quality Assurance
- **ShellCheck Integration**: Validates all shell scripts on push/PR
- **CI/CD Pipeline**: Prevents merging of problematic code
- **Quality Badges**: Visual indicators of code health

### GitHub Pages Integration
- **Automatic Deployment**: Site updates on every push
- **Professional Documentation**: Clean, responsive design
- **Code Examples**: Live demonstrations of good vs. bad practices

### Shell Script Examples
- **Best Practices**: Modern bash scripting techniques
- **Error Handling**: Proper exit codes and validation
- **Security**: Safe variable handling and quoting

## 🔧 GitHub Actions Workflow

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

### Workflow Features:
- **Trigger Events**: Runs on push and pull requests
- **Multi-file Support**: Checks all `.sh` files in the repository
- **Configurable Severity**: Fail on warnings and above
- **Clear Output**: GCC format for better CI integration

## 📝 Shell Script Examples

### ✅ Good Script (`scripts/good-script.sh`)
- Uses `set -euo pipefail` for strict error handling
- Proper variable quoting and validation
- Local variables and function organization
- Safe file processing with proper IFS handling

### ❌ Bad Script (`scripts/bad-script.sh`)
- Unquoted variables (SC2086)
- Legacy backtick syntax (SC2006)  
- Missing error handling
- Dangerous file operations

### 🔧 Utility Script (`scripts/utility.sh`)
- Reusable logging functions
- File validation utilities
- Safe backup operations
- Color-coded output

## 🧪 Testing the Setup

### 1. Test ShellCheck Locally
```bash
# Install ShellCheck
sudo apt install shellcheck

# Check a script
shellcheck scripts/good-script.sh
shellcheck scripts/bad-script.sh
```

### 2. Test GitHub Actions
```bash
# Push changes to trigger workflow
git add .
git commit -m "Test ShellCheck workflow"
git push origin main
```

### 3. View Results
- Check GitHub Actions tab for workflow results
- Visit GitHub Pages site to see documentation
- Review ShellCheck feedback in PR comments

## 🛠️ Setup Instructions

### Enable GitHub Pages
1. Go to repository Settings
2. Navigate to Pages section
3. Set Source to "Deploy from a branch"
4. Select `main` branch and `/ (root)` folder
5. Save settings

### Configure Branch Protection (Optional)
1. Go to Settings → Branches
2. Add rule for `main` branch
3. Require status checks to pass
4. Select "ShellCheck" workflow
5. Require branches to be up to date

## 📊 ShellCheck Configuration

Our workflow uses these ShellCheck options:

```yaml
env:
  SHELLCHECK_OPTS: -e SC2034 -e SC1091
with:
  severity: warning
  format: gcc
```

### Disabled Checks:
- **SC2034**: Unused variables (common in utility scripts)
- **SC1091**: Source file not found (for external dependencies)

### Severity Levels:
- **error**: Critical issues that break functionality
- **warning**: Important issues that should be fixed
- **info**: Suggestions for improvement
- **style**: Cosmetic improvements

## 🎯 Learning Objectives

This exercise demonstrates:

1. **CI/CD Integration**: Automated quality checks in development workflow
2. **Static Analysis**: Using tools to catch bugs before runtime
3. **Documentation**: Professional project presentation with GitHub Pages
4. **DevOps Practices**: Combining multiple tools for better development experience

## 🔗 Useful Links

- [ShellCheck Documentation](https://github.com/koalaman/shellcheck)
- [GitHub Actions Marketplace](https://github.com/marketplace/actions/shellcheck)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Bash Best Practices](https://mywiki.wooledge.org/BashGuide/Practices)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add your shell scripts to `scripts/` directory
4. Ensure ShellCheck passes locally
5. Submit a pull request

The CI/CD pipeline will automatically validate your changes!

---

**Built with ❤️ using GitHub Pages, GitHub Actions, and ShellCheck**
