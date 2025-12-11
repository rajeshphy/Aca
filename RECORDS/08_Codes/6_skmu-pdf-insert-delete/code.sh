#!/bin/bash

# Usage:
# ./process_pdfs.sh <input_dir> <att_dir> <output_dir>
# CSV file: t.csv must be in same folder as script

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_dir> <att_dir> <output_dir>"
    exit 1
fi

# --- Directories ---
INPUT_DIR="$(realpath "$1")"
ATT_DIR="$(realpath "$2")"
OUTPUT_DIR="$(realpath "$3")"
mkdir -p "$OUTPUT_DIR"

CSV_FILE="task.csv"
if [ ! -f "$CSV_FILE" ]; then
    echo "ERROR: CSV file '$CSV_FILE' not found!"
    exit 1
fi

# --- Functions ---

# Delete pages from PDF
# Delete pages from PDF (supports multiple ranges e.g., 2,4-5,7)
deletepdf() {
    local main="$1"
    local del="$2"
    local out="$3"

    # Split delete pages by comma into array
    IFS=',' read -ra ranges <<< "$del"

    # Prepare keep pages string for qpdf
    local keep_pages=""
    local total_pages=$(qpdf --show-npages "$main")

    # Start with all pages
    for ((i=1; i<=total_pages; i++)); do
        skip=false
        for r in "${ranges[@]}"; do
            if [[ "$r" == *-* ]]; then
                start="${r%-*}"
                end="${r#*-}"
                if (( i >= start && i <= end )); then
                    skip=true
                    break
                fi
            else
                if (( i == r )); then
                    skip=true
                    break
                fi
            fi
        done
        if [ "$skip" = false ]; then
            if [ -z "$keep_pages" ]; then
                keep_pages="$i"
            else
                keep_pages="$keep_pages,$i"
            fi
        fi
    done

    # Run qpdf to keep only desired pages
    qpdf "$main" --pages "$main" $keep_pages -- "$out"
}

# Insert ATT PDF at given position
insertpdf() {
    local main="$1"
    local insert="$2"
    local pos="$3"
    local out="$4"

    # Pages before insert
    local before=""
    local after=""
    if (( pos > 1 )); then
        before="1-$((pos-1))"
        after="$pos-z"
    else
        before=""
        after="1-z"
    fi

    if [[ -n "$before" ]]; then
        qpdf "$main" --pages "$main" $before "$insert" "$main" $after -- "$out"
    else
        qpdf "$main" --pages "$insert" "$main" $after -- "$out"
    fi
}

# --- Main processing ---
echo "Processing tasks from $CSV_FILE ..."
echo

# Convert CSV to Unix line endings to avoid ^M issues
TMP_CSV=$(mktemp)
tr -d '\r' < "$CSV_FILE" > "$TMP_CSV"

# Create temp directory for intermediate PDFs
TMP_DIR=$(mktemp -d)

tail -n +2 "$TMP_CSV" | while IFS=',' read -r c1 c2 c3 c4 c5; do
    BASE_NAME=$(echo "$c2" | xargs)
    ATT_NAME=$(echo "$c3" | xargs)
    INSERT_POS=$(echo "$c4" | xargs)
    DELETE_PAGES=$(echo "$c5" | xargs)

    [ -z "$BASE_NAME" ] && continue

    INPUT_PDF="$INPUT_DIR/$BASE_NAME.pdf"
    ATT_PDF="$ATT_DIR/$ATT_NAME.pdf"
    TMP_PDF="$TMP_DIR/${BASE_NAME}-tmp.pdf"
    FINAL_PDF="$OUTPUT_DIR/${BASE_NAME}.pdf"

    if [ ! -f "$INPUT_PDF" ]; then
        echo "⚠️  Input PDF not found: $INPUT_PDF (skipping)"
        continue
    fi

    echo "→ Processing: $BASE_NAME.pdf  (delete: $DELETE_PAGES, insert at: $INSERT_POS)"

    # Step 1: Delete pages
    if [ -n "$DELETE_PAGES" ]; then
        deletepdf "$INPUT_PDF" "$DELETE_PAGES" "$TMP_PDF"
    else
        cp "$INPUT_PDF" "$TMP_PDF"
    fi

    # Step 2: Insert ATT PDF if exists
    if [ -f "$ATT_PDF" ] && [[ "$INSERT_POS" =~ ^[0-9]+$ ]]; then
        TMP_PDF2="$TMP_DIR/${BASE_NAME}-final.pdf"
        insertpdf "$TMP_PDF" "$ATT_PDF" "$INSERT_POS" "$TMP_PDF2"
        TMP_PDF="$TMP_PDF2"
    fi

    # Step 3: Move final PDF to output directory
    mv "$TMP_PDF" "$FINAL_PDF"

    if [ -f "$FINAL_PDF" ]; then
        echo "   ✓ Output saved: $FINAL_PDF"
    else
        echo "   ✗ ERROR creating output for: $BASE_NAME.pdf"
    fi

    echo
done

# Clean up
rm -f "$TMP_CSV"
rm -rf "$TMP_DIR"

echo "✔ All tasks completed."
echo "Output directory: $OUTPUT_DIR"
