#!/bin/bash

# Output file
OUTPUT="producer_xml_fail_context.txt"
> "$OUTPUT"  # Clear existing output

# Search all files recursively
grep -r -n --include="*" "\[producer_xml\] failed to load producer" . | while IFS=: read -r FILE LINE TEXT; do
    echo "=== File: $FILE | Line: $LINE ===" >> "$OUTPUT"
    START=$((LINE - 7))
    [ "$START" -lt 1 ] && START=1
    END=$((LINE + 7))
    sed -n "${START},${END}p" "$FILE" >> "$OUTPUT"
    echo -e "\n---\n" >> "$OUTPUT"
done

echo "Done. Output saved to: $OUTPUT"
