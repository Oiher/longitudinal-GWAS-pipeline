# Command line Parameters

Users can specify the following parameters when running the longGWAS Nextflow pipeline:

## --ancestry

This parameter is used to specify the ancestry group to perform the analysis. Valid values for this parameter
are `['EUR', 'SAS', 'EAS', 'AFR', ...]`

## --assembly

This parameter is used to specify the genome assembly of the input genotyping files. The outputs of the pipeline
will all be in relation to hg38. If you supply genotypes from a different reference assembly specify one of the 
following options `['hg18', 'hg19']` so the positions can be lifted over to hg38. The default value is `'hg38'`

## --chunk_flag

Set to `true` to divide the genetic files into smaller chunks (specified by `--chunk-size`), which allows us to run the QC steps in parallel for increased efficiency.

## --chunk_size

Specify the chunk size used to split the genetic files for genetic QC. The default value `30000`, meaning the genetic files will be split into chunks of 30,000 SNPs.

## --covarfile

This parameter is used to specify the path of the covariates to include in the model. Each subject to be included in 
the analysis needs to have their own covariates. For more details, see the page on file inputs to the pipeline.

## --covariates

This parameter is used to specify the covariates to include in the model from the input covariates file and the
genetic principle components from the ancestry steps. This parameter should be populated with a space-delimited
string of the column names to include in the model from the `--covarfile` option. By default, the model is fit with
`"SEX PC1 PC2 PC3"`

## --dataset

This parameter is used to specify an identifier for the input genotype files so that subsequent re-runs of the 
pipeline can use cached results from the variant filtering and ancestry + outlier detection steps. The default
value is null (`''`), and it is **highly recommended** to set this parameter to avoid misusing cached results.

## --input_vcf

This parameter is used to specify the paths of the genotyping files. The pipeline requires genotypes in 
uncompressed (\*.vcf) or compressed (\*.vcf.gz) files. Genotype files should be shredded at the chromosome level
and each file should contain the chromosome number prefix with 'chr' case insensitive.

_Note:_ The inclusion of  wildcard (\*) in the path requires the use of quotes

Acceptable filenames

```text
--input_vcf "/path/to/dataset_prefix_chr*.vcf"
--input_vcf "/path/to/dataset_chr*_suffix.vcf.gz"
--input_vcf "/path/to/chr*.vcf"
--input_vcf "/path/to/*chr[1-5].vcf"
```
## --kinship

This parameter specifies the relatedness level to filter against from the pairwise kinship between subjects. By 
default this value is "0.177" to filter out first-degree relations.

## --longitudinal_flag

This flag is used to specify the estimation of longitudinal associations via the GALLOP algorithm. If the option 
is not supplied then the pipeline performs a cross-sectional GWAS using plink2.

_Note:_ performing longitudinal analysis requires the inclusion of a `study_days` variable in the input 
phenotype. This variable should correspond to the timepoint (in days) since the start of the study at which the 
measurement for the outcome was taken. Initial measurements taken at baseline will have a `study_days` of 0.

## --mh_plot

Set to `true` to produce a Manhattan Plot to visualise the results of the analysis, as well as a QQ plot for diagnostic purposes.

## --minor_allele_freq

Set the maf threshold to filter out variants. For example, to filter out variants with maf<5%:
```text
minor_allele_freq: "0.05"
```

## --minor_allele_ct

Set the mac threshold to filter out variants. For example, to filter out variants with mac<"20":

```text
minor_allele_ct: "20"
```

## --model

This parameter can be used to specify a custom model with higher order terms when the `--longitudinal_flag` is 
invoked. To include higher-order terms in the cross-sectional analysis, include them as a column in the 
`--covarfile` and declare them in the `--covariates` parameter.

## --out

This parameter is used to specify the output suffix of the files to distinguish results or re-runs of the 
pipeline.

## --phenofile

This parameter is used to specify the path of the outcome file to do the association on. For cross-sectional 
analysis, the pipeline expects data to be formatted in at least 2 columns, `IID` and `y`.

For longitudinal analysis, a third column is required containing information about the time point in the study that the 
observation was taken. More specifically, this variable should represent the number of days since the starting point of your analysis. The name of this variable should be passed using the `--time-col` flag.

## --pheno_name

This parameter can be used to specify the column in the `--phenofile` containing the outcome of interest. Additionally, longGWAS enables running the analysis using multiple outcomes simultaneously. If multiple outcomes are present, they must be passed in a comma-separated manner `y,y_2,z,z_2`.

## --plink_chunk_size

Used to specify the chunk size to split the data for Plink analysis. This is only required for the Longitudinal and Survival analyses. The default value is `10000`, meaning the genetic files will be split into chunks of 10,000 SNPs.

## --r2thres

This parameter is used to filter out imputed genotypes of low quality if the input genotyping files include 
imputed variants.

## --study_col

Specify the name of the study_arm column in the `--covarfile`.

## --time_col

Used for survival analyses: specify the column name in the `--phenofile` which contains the time-to-event information in days.


