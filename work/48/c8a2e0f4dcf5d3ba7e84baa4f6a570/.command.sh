#!/bin/bash -ue
# run merge command on tmp list
set +x

plink --merge-list chr6.mergelist.txt         --out chr6

plink2 --bfile chr6         --make-pgen         --sort-vars         --out chr6

#plink2 --pmerge-list chr6.mergelist.txt       #--make-pgen       #--sort-vars       #--out chr6
#plink2 --make-bed       #  --pfile chr6       #  --out chr6
