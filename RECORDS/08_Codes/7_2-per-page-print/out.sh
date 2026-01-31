qpdf G500.pdf --pages G500.pdf \
$(for ((i=1;i<=500;i+=4)); do printf "%d,%d," "$i" "$((i+3))"; done | sed 's/,$//') \
-- out.pdf
