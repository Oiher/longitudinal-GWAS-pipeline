#!/bin/bash -ue
set -x
KEY="EUR_control_y"
glm_phenocovar.py         --pheno_covar /home/oiher/longGWAS/longitudinal-GWAS-pipeline/work/9a/f78be4204f5269f9110f5092cc4f70/EUR_control_analyzed.tsv         --phenname y         --covname "SEX age_at_baseline"

plink2 --pfile chr4             --glm hide-covar omit-ref cols=+beta,+a1freq             --pheno "pheno.tsv"             --pheno-name y             --covar "covar.tsv"             --covar-name SEX,age_at_baseline             --covar-variance-standardize             --keep "pheno.tsv"             --output-chr chrM             --mac 20             --hwe 1e-6             --threads 4             --memory 12288             --out EUR_control_chr4.null

# capture process environment
set +u
set +e
cd "$NXF_TASK_WORKDIR"

nxf_eval_cmd() {
    {
        IFS=$'\n' read -r -d '' "${1}";
        IFS=$'\n' read -r -d '' "${2}";
        (IFS=$'\n' read -r -d '' _ERRNO_; return ${_ERRNO_});
    } < <((printf '\0%s\0%d\0' "$(((({ shift 2; "${@}"; echo "${?}" 1>&3-; } | tr -d '\0' 1>&4-) 4>&2- 2>&1- | tr -d '\0' 1>&4-) 3>&1- | exit "$(cat)") 4>&1-)" "${?}" 1>&2) 2>&1)
}

echo '' > .command.env
#
echo KEY="${KEY[@]}" >> .command.env
echo /KEY/ >> .command.env
