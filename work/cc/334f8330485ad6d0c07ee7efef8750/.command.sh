#!/usr/bin/env python3
import pandas as pd
import time

ancestry = "EUR"
study_id_colname = "study_arm"

ancestry_df = pd.read_hdf("EUR_samplelist_p2out.h5", key="ancestry_keep")
outlier_df = pd.read_hdf("EUR_samplelist_p2out.h5", key="outliers")
kin_df = pd.read_hdf("EUR_samplelist_p2out.h5", key="kin")
data_df = pd.read_csv('covariates.tsv', sep="\t", engine='c')

cohorts = data_df[study_id_colname].unique().tolist()
cohorts = filter(lambda x: x == "control", cohorts)

kin_df = kin_df[kin_df.KINSHIP >= 0.177]
# TODO: address case when single cohort present
# TODO: currently does not address longitudinal covariates
for cohort in cohorts:
  print(f'---- {cohort} ----')

  if not outlier_df.empty:
    samples = data_df[ (data_df.IID.isin(ancestry_df.IID)) &
                       (data_df[study_id_colname] == cohort) &
                       ~(data_df.IID.isin(outlier_df.IID)) ].copy(deep=True)
    print(f'Samples removed (outliers) = {data_df.IID.isin(outlier_df.IID).sum()}')
  else:
    samples = data_df[ (data_df.IID.isin(ancestry_df.IID)) &
                       (data_df[study_id_colname] == cohort)].copy(deep=True)

  r = kin_df[(kin_df['#IID1'].isin(samples.IID)) & (kin_df.IID2.isin(samples.IID))].copy()
  samples = samples[~samples.IID.isin(r.IID2)].copy()
  samples.to_csv(f"{ancestry}_{cohort}_filtered.tsv", sep="	", index=False)
  print(f'Samples removed (kinship) = {r.shape[0]}')
  print(f'Samples remaining = {len(samples)}')
  print('')

time.sleep(5)
