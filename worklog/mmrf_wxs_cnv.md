# WXS call
### define the common input arguments as variables and reuse them in each command to avoid repetition
```

export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"

# Define common input arguments as variables

TUMOR_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/runlist/MMRF_WES_allTumorBAM_v2.txt
NORMAL_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/runlist/MMRF_WES_allNormaBAM_v1.txt
OUTPUT_DIR=/scratch1/fs1/dinglab/Active/Projects/ysong/mmrf/WES_CNV_v2/
CONFIG_FILE=/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/config/config.gatk4scna.compute1.ini
Script=/storage1/fs1/dinglab/Active/Projects/ysong/pipelines/GATK4SCNA_v2/gatk_somatic.cnv.compute1.sh

mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

# Step 1 (precall)

bash $Script -p precall -t $TUMOR_BAM_LIST -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 2 (PON)
bash $Script -p pon -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 3 (CNV calls all using tumor-only version)
bash $Script -p callcn_tumor_only -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 3.5 (CNV calls normal)
bash $Script -p callnormal -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE
# Step 4.5 (plot normals)
bash $Script -p plotNormal -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 4 (plot all Tumor)
bash $Script -p plot -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5 (Calls gene-level)
bash $Script -p geneLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6 (Merge gene-level files to one file)
bash $Script -p merge -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5.5 (Calls chr_arm-level)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p chrarmLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6.5 (Merge arm-level files to one file)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p chrarmmerge -o $OUTPUT_DIR -c $CONFIG_FILE

# rename merged.segment_level.hg38.log2ratio.tsv to merged.arm_level.hg38.log2ratio.tsv

# then proceeding Step5.7

# Step 5.7 (Calls chr_band-level)
bash $Script -p chrarmLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6.7 (Merge band-level files to one file)
bash $Script -p chrarmmerge -o $OUTPUT_DIR -c $CONFIG_FILE
```

# WXS call
### define the common input arguments as variables and reuse them in each command to avoid repetition
```

export LSF_DOCKER_VOLUMES="$HOME:$HOME $STORAGE1_DINGLAB:$STORAGE1_DINGLAB $STORAGE1_MATT:$STORAGE1_MATT $SCRATCH1_DINGLAB:$SCRATCH1_DINGLAB"

# Define common input arguments as variables
TUMOR_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/runlist/MMRF_WES_allTumorBAM_v1.txt
NORMAL_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/runlist/MMRF_WES_allNormaBAM_v1.txt
OUTPUT_DIR=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/WES_CNV/
CONFIG_FILE=/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/config/config.gatk4scna.compute1.ini

TUMOR_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/runlist/MMRF_WES_allTumorBAM_v1.txt
NORMAL_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/runlist/MMRF_WES_allNormaBAM_v1.txt
OUTPUT_DIR=/scratch1/fs1/dinglab/Active/Projects/ysong/mmrf/WES_CNV/
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

# WGS call
```
# Define common input arguments as variables
TUMOR_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/PanRCC/Data/Analysis/KIRC_RNA/KIRC_CNV_run_list/WGS_allTumorBAM.list
NORMAL_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/PanRCC/Data/Analysis/KIRC_RNA/KIRC_CNV_run_list/WGS_normalBAM.list
OUTPUT_DIR=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/WGS_CNV/
CONFIG_FILE=/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/wgs/config/config.gatk4scna.wgs.compute1.ini

OUTPUT_DIR=/scratch1/fs1/dinglab/Active/Projects/ysong/mmrf/WGS_CNV/

mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

# Step 1 (precall)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh \
  -p precall \
  -t $TUMOR_BAM_LIST \
  -M $NORMAL_BAM_LIST \
  -o $OUTPUT_DIR \
  -c $CONFIG_FILE

# Step 2 (PON)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh \
  -p pon \
  -o $OUTPUT_DIR \
  -c $CONFIG_FILE

# Step 3 (CNV calls all using tumor-only version)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh \
  -p callcn_tumor_only \
  -t $TUMOR_BAM_LIST \
  -o $OUTPUT_DIR \
  -c $CONFIG_FILE

# Step 3.5 (CNV calls normal)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh \
  -p callnormal \
  -M $NORMAL_BAM_LIST \
  -o $OUTPUT_DIR \
  -c $CONFIG_FILE

# Step 4 (plot all Tumor)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh \
  -p plot \
  -t $TUMOR_BAM_LIST \
  -o $OUTPUT_DIR \
  -c $CONFIG_FILE

# Step 4.5 (plot normals)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh \
  -p plotNormal \
  -M $NORMAL_BAM_LIST \
  -o $OUTPUT_DIR \
  -c $CONFIG_FILE

# Step 5 (Calls gene-level)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh \
  -p geneLevel \
  -t $TUMOR_BAM_LIST \
  -o $OUTPUT_DIR \
  -c $CONFIG_FILE

# Step 6 (Merge gene-level files to one file)
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh \
  -p merge \
  -o $OUTPUT_DIR \
  -c $CONFIG_FILE

Step 5.5 (Calls chr_arm-level)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh
-p chrarmLevel \
-t $TUMOR_BAM_LIST \
-o $OUTPUT_DIR \
-c $CONFIG_FILE

Step 6.5 (Merge arm-level files to one file)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh
-p chrarmmerge \
-o $OUTPUT_DIR \
-c $CONFIG_FILE
```

# WGS call
### define the common input arguments as variables and reuse them in each command to avoid repetition
```

export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"

# Define common input arguments as variables
TUMOR_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/runlist/MMRF_WGS_allTumorBAM_v2.txt
NORMAL_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/runlist/MMRF_WGS_allNormaBAM_v2.txt
#OUTPUT_DIR=/storage1/fs1/dinglab/Active/Projects/MMRF_analysis_bulk/WXS/3.CNV/WGS_CNV/
CONFIG_FILE=/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/wgs/config/config.gatk4scna.wgs.compute1.ini
OUTPUT_DIR=/scratch1/fs1/dinglab/Active/Projects/ysong/mmrf/WGS_CNV/
Script=/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.wgs.cnv.compute1.sh

mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

# Step 1 (precall)

bash $Script -p precall -t $TUMOR_BAM_LIST -M $NORMAL_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 2 (PON)
bash $Script -p pon -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 3 (CNV calls all using tumor-only version)
bash $Script -p callcn_tumor_only -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE


# Step 4 (plot all Tumor)
bash $Script -p plot -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5 (Calls gene-level)
bash $Script -p geneLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6 (Merge gene-level files to one file)
bash $Script -p merge -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 5.5 (Calls chr_arm-level)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p chrarmLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6.5 (Merge arm-level files to one file)

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/gatk_somatic.cnv.compute1.sh -p chrarmmerge -o $OUTPUT_DIR -c $CONFIG_FILE

# rename merged.segment_level.hg38.log2ratio.tsv to merged.arm_level.hg38.log2ratio.tsv

# then proceeding Step5.7

# Step 5.7 (Calls chr_band-level)
bash $Script -p chrarmLevel -t $TUMOR_BAM_LIST -o $OUTPUT_DIR -c $CONFIG_FILE

# Step 6.7 (Merge band-level files to one file)
bash $Script -p chrarmmerge -o $OUTPUT_DIR -c $CONFIG_FILE
```
