#!/bin/bash

input_file="inf.txt"  # comma-separated: Journal, Title, DOI
pdf_dir="pdf"

mkdir -p "$pdf_dir"

error_count=1

while IFS=',' read -r year title doi _; do
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
    pdf_name="${year} - ${title}.pdf"
    pdf_name=$(echo "$pdf_name" \
      | sed -E 's/λ/lambda/g; s/Λ/Lambda/g; s/π/pi/g; s/Δ/Delta/g;' \
      | sed -E 's/=/ -eq- /g; s/\+/ -plus- /g; s/−/ -minus- /g; s/–/ -minus- /g;' \
      | tr ' /:*?"<>|' '_' \
      | sed -E 's/\.[Pp][Dd][Ff]$/<<PDFEXT>>/;
                s/[;,]+/-/g;
                s/_+/-/g;
                s/\b([A-Za-z])\-([A-Za-z])\b/\1\2/g;
                s/\)\^([0-9]+)/\1/g;
                s/[()]+//g;
                s/[._-]+/-/g;
                s/^_+//; s/_+$//; s/^-+//; s/-+$//;
                s/<<PDFEXT>>$/.pdf/i')
# Limit to 50 dash-separated words but always preserve .pdf
pdf_name=$(echo "$pdf_name" | sed -E 's/\.pdf$//I')   # strip extension safely
pdf_name=$(echo "$pdf_name" | awk -F'-' '{
    max=20; out="";
    for(i=1;i<=NF && i<=max;i++){
        if(out=="") out=$i; else out=out"-"$i
    }
    print out (NF>max ? "-etc" : "")
}')
pdf_name="${pdf_name}.pdf"

        
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
