#!/bin/bash
# PreToolUse hook to validate file paths before operations
# Prevents accidental modifications outside content directory

TOOL_NAME="$1"
TOOL_INPUT="$2"

# Only validate Write and Edit operations
if [[ "$TOOL_NAME" != "Write" && "$TOOL_NAME" != "Edit" ]]; then
    exit 0
fi

# Extract file_path from tool input (simple JSON parsing)
FILE_PATH=$(echo "$TOOL_INPUT" | grep -o '"file_path":"[^"]*"' | cut -d'"' -f4)

if [[ -z "$FILE_PATH" ]]; then
    exit 0
fi

# Validate path is within content directory or .claude directory
if [[ "$FILE_PATH" =~ ^content/modules/ROOT/ || "$FILE_PATH" =~ ^\.claude/ ]]; then
    exit 0
fi

# Warn about operations outside expected directories
echo "⚠️  Warning: Attempting to modify file outside content directory: $FILE_PATH" >&2
echo "   Expected: content/modules/ROOT/ or .claude/" >&2
exit 0  # Don't block, just warn
