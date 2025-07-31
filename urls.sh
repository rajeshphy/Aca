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
        
        # List only PDF or all files (customize here)
        files=("$subsection"*)

        echo "  $subsection_name:" >> "$output_file"

        if [ ${#files[@]} -eq 0 ]; then
            echo "    []" >> "$output_file"
        else
            for file in "${files[@]}"; do
                filename=$(basename "$file")
                # Skip if it's a directory
                if [ -f "$file" ]; then
                    echo "    - $filename" >> "$output_file"
                fi
            done
            # If no files were added, ensure empty list
            if ! grep -q "^    - " "$output_file"; then
                echo "    []" >> "$output_file"
            fi
        fi
    done
    echo "" >> "$output_file"
done

echo "✅ URLs YAML generated at $output_file"
