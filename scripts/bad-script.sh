#!/bin/bash
# bad-script.sh - Contains ShellCheck violations (for demonstration)

file=$1
if [ $file = "test.txt" ]; then    # SC2086: Unquoted variable
    lines=`wc -l $file`            # SC2006: Use $() instead of backticks
    echo $lines                    # SC2086: Unquoted variable
fi

# Dangerous operations without quotes
rm $file                           # SC2086: Dangerous unquoted variable
cp $file backup                    # SC2086: Unquoted variable

# Unused variable
unused_var="this will trigger SC2034"

# Missing error handling
cat /nonexistent/file

# Poor practices
cd /tmp
ls *.txt                          # Will fail if no .txt files exist 