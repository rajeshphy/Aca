#!/bin/bash

input_file="inf.txt"  # comma-separated: Journal, Title, DOI
pdf_dir="pdf"

mkdir -p "$pdf_dir"

error_count=1

while IFS=',' read -r journal title doi; do
    url="https://sci-hub.se/${doi}"
    echo "Fetching: $title from $url"

    # Make safe DOI filename for HTML temp file
    safe_doi=$(echo "$doi" | tr '/:' '_')
    html_file="${safe_doi}.html"

    # Get raw HTML
    curl -s "$url" -o "$html_file"

    # Extract PDF link from line 256
    pdf_link=$(sed -n '256p' "$html_file" | \
               grep -o 'src="[^"]*\.pdf' | \
               sed 's/src="//; s/^\/\///; s/^/https:\/\//')

    if [ -n "$pdf_link" ]; then
        # Create safe PDF filename: JournalName - PaperTitle.pdf
        pdf_name="${journal} - ${title}.pdf"
        pdf_name=$(echo "$pdf_name" | tr ' /:*?"<>|' '_' )

        # Try to download PDF
        if ! wget -q --show-progress "$pdf_link" -O "$pdf_dir/$pdf_name"; then
            # If failed, save as error-X.pdf
            pdf_name="error-${error_count}.pdf"
            wget -q --show-progress "$pdf_link" -O "$pdf_dir/$pdf_name"
            ((error_count++))
        fi
        echo "Saved PDF as $pdf_dir/$pdf_name"
    else
        echo "PDF link not found for DOI: $doi"
    fi

    # Remove HTML temp file
    rm -f "$html_file"

    echo
done < "$input_file"
