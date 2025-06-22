#!/bin/bash
# utility.sh - Common utility functions

set -euo pipefail

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $*" >&2
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

# File validation
validate_file() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        log_error "File '$file' does not exist"
        return 1
    fi
    
    if [[ ! -r "$file" ]]; then
        log_error "File '$file' is not readable"
        return 1
    fi
    
    return 0
}

# Safe directory creation
create_dir() {
    local dir="$1"
    
    if [[ ! -d "$dir" ]]; then
        log_info "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

# Backup function
backup_file() {
    local file="$1"
    local backup_dir="${2:-./backups}"
    
    validate_file "$file" || return 1
    create_dir "$backup_dir"
    
    local backup_name
    backup_name="$(basename "$file").$(date +%Y%m%d_%H%M%S).bak"
    
    cp "$file" "$backup_dir/$backup_name"
    log_info "Backed up '$file' to '$backup_dir/$backup_name'"
}

# Example usage (only if script is run directly)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    log_info "Utility script loaded successfully"
    echo "Available functions:"
    echo "  - log_info, log_warn, log_error"
    echo "  - validate_file <file>"
    echo "  - create_dir <directory>"
    echo "  - backup_file <file> [backup_dir]"
fi 