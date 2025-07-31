#!/bin/bash -ue
echo EUR_control_y
COUNTER=0
for file in EUR_control_chr2_chr2\:151464\:T\:C_chr2\:242059222\:T\:C.null.y.gallop EUR_control_chr1_chr1\:953279\:T\:C_chr1\:248864040\:A\:C.null.y.gallop EUR_control_chr3_chr3\:63289\:A\:G_chr3\:198073373\:T\:C.null.y.gallop
do
  COUNTER=$((COUNTER+1))
  if [[ $COUNTER -eq 1 ]]
  then
    cat ${file} > "EUR_control_y_allresults.tsv"
  else
    tail -n +2 ${file} >> "EUR_control_y_allresults.tsv"
  fi
done
bedtools sort -i "EUR_control_y_allresults.tsv" -header > "EUR_control_y_allresults.tsv.tmp"
mv "EUR_control_y_allresults.tsv.tmp" "EUR_control_y_allresults.tsv"
