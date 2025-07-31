#!/usr/bin/env python3
import pandas as pd
import time
import sys

all_phenos = "y".split(',') if ',' in "y" else ["y"]
covars = "SEX age_at_baseline".split(' ')
d_pheno = pd.read_csv("phenotypes.tsv", sep="	", engine='c')
d_sample = pd.read_csv("EUR_control_filtered.pca.tsv", sep="	", engine='c')

d_result = pd.merge(d_pheno, d_sample, on='IID', how='inner')

if d_result.shape[0] > 0:
  #d_set = d_result.loc[:, ["#FID", "IID", "y"] + covars].copy()
  d_set = d_result.loc[:, ["#FID", "IID"] + all_phenos + covars].copy()
  d_set.to_csv("EUR_control_analyzed.tsv", sep="	", index=False)

time.sleep(10)
