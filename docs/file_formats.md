# Input File Format

## Input Genotype

The pipeline requires genotype information to be given in the form of uncompressed VCF or compressed VCF.gz 
files.

If missing variants have been imputed, specify the optional parameter `--r2thres` to filter out poorly imputed
variants

## Input Covariates

Covariates for each subject to be passed into the model can be provided via a tab-delimited file (\*.tsv)

For both cross-sectional and longitudinal analysis, the pipeline expects covariates to be defined in the 
following format

_Note:_ the Plink-style columns `#FID` and `PHENO` must be present but can be populated with `0`

```text
#FID  IID SEX PHENO study_arm apoe4 levodopa_usage age_at_baseline
0 sid-1 1 0 control 0 0 35
0 sid-2 1 0 control 0 0 40
0 sid-3 0 0 control 1 0 32
.
.
.
0 sid-98  1 0 PD  1 0 55
0 sid-99  0 0 PD  0 1 66
0 sid-100 1 0 PD  0 0 58
```


## Input Phenotype / Outcomes

Phenotype and measured outcomes can be passed into the pipeline via a tab-delimited file (\*.tsv)

For cross-sectional analysis, the pipeline expects a minimum of 2 columns in the following format

```text
IID y
sid-1 1
sid-2 0
sid-3 1
.
.
.
sid-98 0
sid-99 0
sid-100 1
```

For longitudinal analyses, the input phenotype file must contain a column specifying the days passed since the start of the study, as shown here under `study_days`:

```text
IID y	study_days
sid-414	95.2206895626295	0.0
sid-414	102.30085429524436	182.625
sid-414	114.79879923749795	365.25
.
.
.
sid-204	81.12926520637295	730.5
sid-204	104.79350859619713	1095.75
sid-204	91.52620016527872	1461.0
```

For survival analyses, apart from the time-to-event column (`study_days`), a column must be present specifying whether the event outcome was reached (0/1), as shown here under `surv_y`. 

```text
IID	y	study_days	surv_y	tstart	tend
sid-1	115.97392441028578	730.5	1	0	730.5
sid-10	86.8996551417189	182.625	1	0	182.625
sid-100	150.4507827126939	2556.75	1	0	2556.75
.
.
.
sid-103	66.2393727266641	365.25	1	0	365.25
sid-104	137.98518827246627	730.5	1	0	730.5
sid-105	102.64954194365411	1826.25	1	0	1826.25
```
