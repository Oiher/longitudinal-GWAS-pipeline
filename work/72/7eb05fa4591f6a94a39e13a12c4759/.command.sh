#!/bin/bash -ue
set -x
KEY="EUR_intermediate_surv_y"

survival.R --rawfile EUR_intermediate_chr3_chr3\:63289\:A\:G_chr3\:198073373\:T\:C.raw                --pheno "phenotypes.tsv"                --covar EUR_intermediate_filtered.pca.tsv                --covar-name "SEX age_at_baseline"                --pheno-name "surv_y"                --out EUR_intermediate_chr3_chr3:63289:A:G_chr3:198073373:T:C.null.coxph

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
