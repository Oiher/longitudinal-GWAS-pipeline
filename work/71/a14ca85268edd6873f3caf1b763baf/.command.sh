#!/bin/bash -ue
# run merge command on tmp list
set +x

plink --merge-list chr3.mergelist.txt         --out chr3

plink2 --bfile chr3         --make-pgen         --sort-vars         --out chr3

#plink2 --pmerge-list chr3.mergelist.txt       #--make-pgen       #--sort-vars       #--out chr3
#plink2 --make-bed       #  --pfile chr3       #  --out chr3
