#!/bin/bash -ue
echo EUR_affected_y
COUNTER=0
for file in EUR_affected_chr1.null.y.glm.linear EUR_affected_chr3.null.y.glm.linear EUR_affected_chr2.null.y.glm.linear
do
  COUNTER=$((COUNTER+1))
  if [[ $COUNTER -eq 1 ]]
  then
    cat ${file} > "EUR_affected_y_allresults.tsv"
  else
    tail -n +2 ${file} >> "EUR_affected_y_allresults.tsv"
  fi
done
bedtools sort -i "EUR_affected_y_allresults.tsv" -header > "EUR_affected_y_allresults.tsv.tmp"
mv "EUR_affected_y_allresults.tsv.tmp" "EUR_affected_y_allresults.tsv"
