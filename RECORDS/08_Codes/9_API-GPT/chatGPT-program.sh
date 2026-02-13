#!/bin/bash

# export OPENAI_API_KEY="sk-xxxx"

INPUT="names.txt"
OUTPUT="output.txt"
MODEL="gpt-4.1-mini"

> "$OUTPUT"

while IFS= read -r name || [ -n "$name" ]; do
  echo "Processing: $name"
  echo "## $name" >> "$OUTPUT"

  for i in {1..3}; do
    result=$(curl -s https://api.openai.com/v1/responses \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $OPENAI_API_KEY" \
      -d "{
        \"model\": \"$MODEL\",
        \"input\": \"Write one concise paragraph about the history of ${name}.\"
      }" | jq -r '.output_text')

    if [ -n "$result" ] && [ "$result" != "null" ]; then
      echo "$result" >> "$OUTPUT"
      break
    fi

    echo "Retry $i..."
    sleep 2
  done

  echo "" >> "$OUTPUT"

done < "$INPUT"

echo "Done. Output saved in $OUTPUT"