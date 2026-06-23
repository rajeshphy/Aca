#!/usr/bin/env bash
set -euo pipefail

MAIN="presentation"
BUILD="gar"
mkdir -p "$BUILD"

pdflatex -interaction=nonstopmode -halt-on-error -output-directory="$BUILD" "$MAIN.tex"
pdflatex -interaction=nonstopmode -halt-on-error -output-directory="$BUILD" "$MAIN.tex"

cp "$BUILD/$MAIN.pdf" ./presentation.pdf
printf 'Done: presentation.pdf\nAuxiliary files are inside: %s/\n' "$BUILD"
