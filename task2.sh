wget https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa
head NC_000913.faa
seq_count=$(grep '^>' NC_000913.faa | wc -l)
echo "No. of sequences : $seq_count"
aa_count=$(grep -v '^>' NC_000913.faa | tr -d '\n' | wc -c)
echo "Total no. of amino acids : $aa_count"
echo "Average length of protein : $(($aa_count/$seq_count))"
