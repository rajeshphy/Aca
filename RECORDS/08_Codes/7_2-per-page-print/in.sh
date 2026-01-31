qpdf G500.pdf --pages G500.pdf \
$(for ((i=2;i<=500;i+=4)); do printf "%d,%d," "$i" "$((i+1))"; done | sed 's/,$//') \
-- in.pdf