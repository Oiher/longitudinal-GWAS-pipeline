#!/bin/bash -ue
set -x
KEY="EUR_control_y"

gallop --gallop            --rawfile EUR_control_chr2_chr2\:151464\:T\:C_chr2\:242059222\:T\:C.raw            --pheno "phenotypes.tsv"            --pheno-name "y"            --covar EUR_control_filtered.pca.tsv            --covar-name SEX age_at_baseline            --time-name study_days            --out "EUR_control_chr2_chr2:151464:T:C_chr2:242059222:T:C.null"

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
