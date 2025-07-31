#!/bin/bash

# Output file
output_file="_data/urls.yml"

# Make sure _data exists
mkdir -p _data

# Empty the output file
echo "" > "$output_file"

# Loop through each top-level directory in RECORDS
for section in RECORDS/*/; do
    section_name=$(basename "$section")
    echo "$section_name:" >> "$output_file"

    # Loop through each subdirectory within the section
    for subsection in "$section"*/; do
        subsection_name=$(basename "$subsection")
        echo "  $subsection_name:" >> "$output_file"

        # Get sorted list of files (descending)
        sorted_files=$(ls -1 "$subsection" 2>/dev/null | sort -r)

        if [ -z "$sorted_files" ]; then
            echo "    []" >> "$output_file"
        else
            has_files=false
            while IFS= read -r filename; do
                filepath="$subsection/$filename"
                if [ -f "$filepath" ]; then
                    echo "    - $filename" >> "$output_file"
                    has_files=true
                fi
            done <<< "$sorted_files"

            if [ "$has_files" = false ]; then
                echo "    []" >> "$output_file"
            fi
        fi
    done
    echo "" >> "$output_file"
done

echo "✅ URLs YAML generated at $output_file"
