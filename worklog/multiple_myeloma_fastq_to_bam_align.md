# step 0 generate catalog of WXS fastqs
```
#!/bin/bash

# Define the base directory containing the sample subdirectories

BASE_DIR="/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MM_proteomic/WXS/FASTQ"

# Output file

OUTPUT_FILE="/storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MM_proteomic/Catalog/MM_proteomics_WXS_tumor_FASTQ_tracking_sheet.csv"

# Header
echo -e "SampleID\tfastq1_compute1\tfastq2_compute1" > $OUTPUT_FILE

# Loop through each subdirectory in the base directory
find $BASE_DIR -type d -mindepth 1 -maxdepth 1 | while read -r SAMPLE_DIR; do
    SAMPLE_ID=$(basename "$SAMPLE_DIR")
    # Assuming the naming convention for fastq files is consistent with your example
    FASTQ1_PATH="${SAMPLE_DIR}/${SAMPLE_ID}_1.fastq.gz"
    FASTQ2_PATH="${SAMPLE_DIR}/${SAMPLE_ID}_2.fastq.gz"
    # Check if both FASTQ files exist
    if [[ -f "$FASTQ1_PATH" && -f "$FASTQ2_PATH" ]]; then
        echo -e "${SAMPLE_ID}.T\t$FASTQ1_PATH\t$FASTQ2_PATH" >> $OUTPUT_FILE
    fi
done
```

# step1 fq to trimmed fq
```
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"

mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/multiple_myeloma/MM_proteomic/WXS/trimmed_fq/logs/
```
# use scratch1 as output folder, storage1 will fail because too big temp files being generated
```
bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/BWA-alignment/trimGalore_then_BWA.compute1.36L.sh -c /storage1/fs1/dinglab/Active/Projects/austins2/tools/BWA-alignment/config.human.compute1.ini -t /storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MM_proteomic/Catalog/MM_proteomics_WXS_tumor_FASTQ_tracking_sheet.csv -o /scratch1/fs1/dinglab/Active/Projects/ysong/multiple_myeloma/MM_proteomic/WXS/trimmed_fq -p trimGalore
```

```
# bash: Command to execute a shell script.
# /storage1/fs1/dinglab/Active/Projects/austins2/tools/BWA-alignment/trimGalore_then_BWA.compute1.36L.sh: Path to the script.
# -c: Specifies the configuration file.
# -t: Indicates the path to the tracking sheet (CSV file) containing the list of FASTQ files to process.
# -o: Output directory where the trimmed and aligned files will be stored.
# -p: options for the script to run trimGalore
```

# step2 trimmed fq to bam

```
# again we use scratch 1
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"

mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/multiple_myeloma/MM_proteomic/WXS/BAM/Tumor/logs/

# normally 70GB would be sufficient for most cancer bams, multiple myeloma needs 150GB

bsub -G compute-dinglab -q general -J 'tumor[2-95]' -g /compute-dinglab/EJ -n 4 -oo /storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MM_proteomic/WXS/BAM/logs/%J.%I.map.log -eo /storage1/fs1/dinglab/Active/Projects/multiple_myeloma/MM_proteomic/WXS/BAM/logs/%J.%I.err.log -R "select[mem>150GB] rusage[mem=150GB]" -M 150GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2_Mark_Dup.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 4 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/multiple_myeloma/MM_proteomic/WXS/trimmed_fq/map.20240226.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/multiple_myeloma/MM_proteomic/WXS/BAM/Tumor"
```

```
# bsub: Command to submit a job to the LSF batch system.
# -G compute-dinglab: Specifies the user group.
# -q general: Submits the job to the 'general' queue.
# -J 'tumor[2-95]': Defines a job array named 'tumor' with tasks numbered from 2 to 95.
# -g /compute-dinglab/EJ: Sets the job group for easier management.
# -n 4: Requests 4 cores for each job task.
# -oo and -eo: Directs the standard output and error to specified log files, with %J and %I placeholders for job and task IDs.
# -R "select[mem>150GB] rusage[mem=150GB]": Resource requirement, here requesting more than 150GB memory.
# -M 150GB: Sets the maximum memory limit.
# -a 'docker(austins2/bwa)': Specifies the Docker image to use for the job.
```

```
# bash: Unix shell command to execute the following script.
# /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2_Mark_Dup.sh: The script that will be executed. This script responsible for running the BWA alignment and subsequent processing steps like sorting, marking duplicates, and converting to BAM format.
# -C: Option indicating the path to the configuration file follows.
# /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini: The configuration file used by the script, which likely contains settings and parameters for the alignment process.
# -N 4: Specifies the number of cores to use for each job. It should match the number of cores requested in the bsub command (-n 4).
# -1: Indicates the input file for the script, typically a TSV (Tab Separated Values) file listing the FASTQ files to be processed.
# /scratch1/fs1/dinglab/Active/Projects/ysong/multiple_myeloma/MM_proteomic/WXS/trimmed_fq/map.20240226.tsv: The input TSV file containing paths to the FASTQ files for alignment.
# -O: Specifies the output directory for the resulting BAM files.
# /scratch1/fs1/dinglab/Active/Projects/ysong/multiple_myeloma/MM_proteomic/WXS/BAM/Tumor: The directory where the output BAM files will be stored.
```
