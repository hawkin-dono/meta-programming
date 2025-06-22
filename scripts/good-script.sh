#!/bin/bash
# good-script.sh - Follows ShellCheck best practices

set -euo pipefail  # Exit on error, undefined vars, pipe failures

main() {
    local input_file="${1:-}"
    
    if [[ -z "$input_file" ]]; then
        echo "Usage: $0 <input_file>" >&2
        exit 1
    fi
    
    if [[ ! -f "$input_file" ]]; then
        echo "Error: File '$input_file' not found" >&2
        exit 1
    fi
    
    echo "Processing file: $input_file"
    local line_count
    line_count=$(wc -l < "$input_file")
    echo "Lines in file: $line_count"
    
    # Safe file processing
    while IFS= read -r line; do
        echo "Line: $line"
    done < "$input_file"
}

# Only run main if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 