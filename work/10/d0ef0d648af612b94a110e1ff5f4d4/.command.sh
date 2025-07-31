#!/bin/bash -ue
# run merge command on tmp list
set +x

plink --merge-list chr4.mergelist.txt         --out chr4

plink2 --bfile chr4         --make-pgen         --sort-vars         --out chr4

#plink2 --pmerge-list chr4.mergelist.txt       #--make-pgen       #--sort-vars       #--out chr4
#plink2 --make-bed       #  --pfile chr4       #  --out chr4
