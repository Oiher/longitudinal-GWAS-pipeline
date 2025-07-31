#!/bin/bash -ue
# run merge command on tmp list
set +x

plink --merge-list chr2.mergelist.txt         --out chr2

plink2 --bfile chr2         --make-pgen         --sort-vars         --out chr2

#plink2 --pmerge-list chr2.mergelist.txt       #--make-pgen       #--sort-vars       #--out chr2
#plink2 --make-bed       #  --pfile chr2       #  --out chr2
