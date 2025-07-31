#!/bin/bash -ue
echo EUR_intermediate_y
COUNTER=0
for file in EUR_intermediate_chr6.null.y.glm.linear EUR_intermediate_chr4.null.y.glm.linear EUR_intermediate_chr3.null.y.glm.linear EUR_intermediate_chr5.null.y.glm.linear EUR_intermediate_chr2.null.y.glm.linear EUR_intermediate_chr1.null.y.glm.linear
do
  COUNTER=$((COUNTER+1))
  if [[ $COUNTER -eq 1 ]]
  then
    cat ${file} > "EUR_intermediate_y_allresults.tsv"
  else
    tail -n +2 ${file} >> "EUR_intermediate_y_allresults.tsv"
  fi
done
bedtools sort -i "EUR_intermediate_y_allresults.tsv" -header > "EUR_intermediate_y_allresults.tsv.tmp"
mv "EUR_intermediate_y_allresults.tsv.tmp" "EUR_intermediate_y_allresults.tsv"
