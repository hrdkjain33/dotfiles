#!/bin/bash
# Post-processing script to correct transcription with custom vocabulary

VOCAB_FILE="$HOME/tech_vocab.txt"

# Read input from stdin or argument
if [ -z "$1" ]; then
    INPUT_TEXT=$(cat)
else
    INPUT_TEXT="$1"
fi

# Start with the original text
OUTPUT="$INPUT_TEXT"

# Read vocabulary file and apply corrections
while IFS= read -r line; do
    # Skip comments and empty lines
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
    
    # Parse the line
    if [[ "$line" =~ ^([^-]+)\ -\>\ (.+)$ ]]; then
        wrong="${BASH_REMATCH[1]}"
        correct="${BASH_REMATCH[2]}"
        
        # Remove leading/trailing whitespace
        wrong=$(echo "$wrong" | xargs)
        correct=$(echo "$correct" | xargs)
        
        # Perform word boundary replacement (case-sensitive)
        OUTPUT=$(echo "$OUTPUT" | sed -E "s/\b$wrong\b/$correct/g")
    fi
done < "$VOCAB_FILE"

echo "$OUTPUT"
