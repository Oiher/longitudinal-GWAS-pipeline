#!/usr/bin/env python3
import pandas as pd
import time   
import os

print(f"Merging PCA results for EUR_control_filtered.tsv")

print(os.listdir())
sample_fn = "EUR_control_filtered.tsv"
cohort = sample_fn[:-(len('_filtered.tsv'))]
pc_fn = cohort + '.pca.eigenvec'

print(pc_fn, cohort)
pc_df = pd.read_csv(pc_fn, sep="	")
samples_df = pd.read_csv(sample_fn, sep="	")
pc_df.rename(columns={"#IID": "IID"}, inplace=True)
samples_df = samples_df.merge(pc_df, on="IID")

samples_df.to_csv(cohort + '_filtered.pca.tsv', sep="	", index=False)
time.sleep(5)
