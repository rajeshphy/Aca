#!/bin/sh
# Extract Paper title (between "> and #####)
grep -o '">[^#]*#####' info.txt | sed 's/">//; s/#####//' > titles.txt

# Extract DOI number (after DOI:)
grep -o 'DOI:[^ <]*' info.txt | sed 's/DOI:[ \t]*//' > dois.txt

# Combine into one CSV
paste -d ',' titles.txt dois.txt > inf.txt
