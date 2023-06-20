
```

cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl

git clone --recurse-submodules https://github.com/ding-lab/pecgs-pipeline.git

cp -r /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline_SV_CNV_v2023_06


```

export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
export PATH="/miniconda/envs/pecgs/bin:$PATH"
bsub -q general-interactive -G compute-dinglab -Is -a 'docker(estorrs/pecgs-pipeline:0.0.1)' '/bin/bash'

```

# generate run
```
outdir="/scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_sv/"
mkdir -p "${outdir}"

#!/bin/bash
python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline_SV_CNV_v2023_06/src/compute1/generate_run_commands.py make-run  --queue dinglab pecgs_TN_wgs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_run_list.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_sv/


#!/bin/bash
python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline_SV_CNV_v2023_06/src/compute1/generate_run_commands.py tidy-run pecgs_TN_wgs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_run_list.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_sv

python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline_SV_CNV_v2023_06/src/compute1/generate_run_commands.py tidy-run pecgs_TN_wgs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_run_list.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_sv_v2

python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline_SV_CNV_v2023_06/src/compute1/generate_run_commands.py summarize-run pecgs_TN_wgs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_run_list.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_sv_v2


python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline_SV_CNV_v2023_06/src/compute1/generate_run_commands.py summarize-run pecgs_TN_wgs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_run_list.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_sv


outdir="/scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_sv_v2/"
mkdir -p "${outdir}"

python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline_SV_CNV_v2023_06/src/compute1/generate_run_commands.py make-run  --queue dinglab pecgs_TN_wgs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_run_list.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_sv_v2
```

## run
```
 cd ${outdir}
 cd /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_sv
 bash 1.run_jobs.sh
```
## wxs bam run 

# generate run
```

export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
export PATH="/miniconda/envs/pecgs/bin:$PATH"
bsub -q general-interactive -G compute-dinglab -Is -a 'docker(estorrs/pecgs-pipeline:0.0.1)' '/bin/bash'

outdir="/scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam/"
mkdir -p "${outdir}"

# generate run
python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline/src/compute1/generate_run_commands.py make-run  --queue general pecgs_TN_wxs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_runlist_updated_2023_06_15.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam

# tidy run
python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline/src/compute1/generate_run_commands.py tidy-run  --queue general pecgs_TN_wxs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_runlist_updated_2023_06_15.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam

# summarize run

python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline/src/compute1/generate_run_commands.py summarize-run pecgs_TN_wxs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_runlist_updated_2023_06_15.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam 
#>> /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam/summarize_run_log.txt

## impute the run_uuid with A, B ,C ,D 
python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline/src/compute1/generate_run_commands.py summarize-run pecgs_TN_wxs_bam /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam/runlist.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam 

# move run
python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline/src/compute1/generate_run_commands.py move-run pecgs_TN_wxs_bam /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam/analysis_summary.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam --target-dir /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/run_wxs_bam


python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline/src/compute1/generate_run_commands.py move-run pecgs_TN_wxs_bam /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam/runlist.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam --target-dir /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/pecgs_wxs_bam

# generate run
python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline/src/compute1/generate_run_commands.py make-run  --queue general pecgs_TN_wxs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_runlist_updated_2023_06_15.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam

```

```
cd /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_bam/

bash 

```

# CNV pecgs run
# generate run
```
outdir="/scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_cnv/"
mkdir -p "${outdir}"

#!/bin/bash
python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs-pipeline_SV_CNV_v2023_06/src/compute1/generate_run_commands.py make-run  --queue dinglab pecgs_TN_wxs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_bam_cnv_run_list.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_cnv

```

```
cd /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_cnv
bash 1.run_jobs.sh
```

# CNV seperate run
export LSF_DOCKER_VOLUMES="$HOME:$HOME $STORAGE1_DINGLAB:$STORAGE1_DINGLAB $STORAGE1_MATT:$STORAGE1_MATT $SCRATCH1_DINGLAB:$SCRATCH1_DINGLAB"

# Define common input arguments as variables
TUMOR_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_cnv_allTumorBAM_full.txt
NORMAL_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_wxs_cnv_normalBAM.txt
OUTPUT_DIR=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/cnv_run
CONFIG_FILE=/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/config/config.gatk4scna.compute1.ini

mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

# Step 1 (precall)

bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p precall -t $TUMOR_BAM_LIST -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 2 (PON)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p pon -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 3 (CNV calls all using tumor-only version)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p callcn_tumor_only -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 3.5 (CNV calls normal)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p callnormal -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 4 (plot all Tumor)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p plot -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 4.5 (plot normals)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p plotNormal -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5 (Calls gene-level)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p geneLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6 (Merge gene-level files to one file)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p merge -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5.5 (Calls chr_arm-level)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p chrarmLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6.5 (Merge arm-level files to one file)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p chrarmmerge -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5.7 (Calls chr_band-level)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p chrarmLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6.7 (Merge band-level files to one file)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p chrarmmerge -o $OUTPUT_DIR -c $CONFIG_FILE


