## PECGS WXS CNV call 2023/10/12

### define the common input arguments as variables and reuse them in each command to avoid repetition
```
export LSF_DOCKER_VOLUMES="$HOME:$HOME $STORAGE1_DINGLAB:$STORAGE1_DINGLAB $STORAGE1_MATT:$STORAGE1_MATT $SCRATCH1_DINGLAB:$SCRATCH1_DINGLAB"

# Define common input arguments as variables
TUMOR_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_2_wxs_cnv_allTumorBAM_full.txt
NORMAL_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_2_wxs_cnv_normalBAM.txt
OUTPUT_DIR=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/cnv_run_2
CONFIG_FILE=/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/config/config.gatk4scna.compute1.ini

mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

# Step 1 (precall)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p precall -t $TUMOR_BAM_LIST -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 2 (PON)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p pon -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 3 (CNV calls all using tumor-only version)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p callcn_tumor_only -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 3.5 (CNV calls normal)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p callnormal -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 4 (plot all Tumor)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p plot -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 4.5 (plot normals)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh -p plotNormal -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5 (Calls gene-level)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p geneLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6 (Merge gene-level files to one file)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p merge -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5.5 (Calls chr_arm-level)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p chrarmLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6.5 (Merge arm-level files to one file)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p chrarmmerge -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5.7 (Calls chr_band-level)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p chrarmLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6.7 (Merge band-level files to one file)
bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh -p chrarmmerge -o $OUTPUT_DIR -c $CONFIG_FILE


```
