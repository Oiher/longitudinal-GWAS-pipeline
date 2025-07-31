#!/usr/bin/env python3
import pandas as pd
import time

study_id_colname = "study_arm"

data_df = pd.read_csv('covariates.tsv', sep="\t", engine='c')
cohorts = data_df[study_id_colname].unique().tolist()

with open("phenos_list.txt", 'w') as f:
  f.write('\n'.join(cohorts))

time.sleep(5)
