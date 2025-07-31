#!/bin/bash -ue
# run merge command on tmp list
set +x

plink --merge-list chr1.mergelist.txt         --out chr1

plink2 --bfile chr1         --make-pgen         --sort-vars         --out chr1

#plink2 --pmerge-list chr1.mergelist.txt       #--make-pgen       #--sort-vars       #--out chr1
#plink2 --make-bed       #  --pfile chr1       #  --out chr1
