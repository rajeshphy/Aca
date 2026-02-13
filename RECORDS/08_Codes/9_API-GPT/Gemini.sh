#!/bin/bash

# export GOOGLE_API_KEY="AIza..."

INPUT="names.txt"
OUTPUT="output.txt"
MODEL="gemini-2.5-flash"

> "$OUTPUT"

while IFS= read -r name || [ -n "$name" ]; do
  echo "Processing: $name"
  echo "## $name" >> "$OUTPUT"

  for i in {1..3}; do
    result=$(curl -s \
      -H "Content-Type: application/json" \
      "https://generativelanguage.googleapis.com/v1/models/${MODEL}:generateContent?key=${GOOGLE_API_KEY}" \
      -d "{
        \"contents\": [{
          \"parts\": [{
            \"text\": \"Write one concise academic paragraph about the life and contributions of ${name}.\"
          }]
        }]
      }" | jq -r '.candidates[0].content.parts[0].text')

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