# Check BAM coverage

### Step 1 prepare input file
```
# the input file has two columns, 1st column is sample_name( or file_name,sample_id), the 2nd column is bam_path.

head /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_pecgs_batch1_coverage_final_review/PECGS_batch1_re_aligned_bam_v5.txt
PE001C1.N.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE001C1.N/PE001C1.N.human.sorted.bam
PE001C1.T.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE001C1.T/PE001C1.T.human.sorted.bam
PE002C1.N.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE002C1.N/PE002C1.N.human.sorted.bam
PE002C1.T.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE002C1.T/PE002C1.T.human.sorted.bam
PE003C1.N.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE003C1.N/PE003C1.N.human.sorted.bam
PE003C1.T.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE003C1.T/PE003C1.T.human.sorted.bam
PE005A1.N.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE005A1.N/PE005A1.N.human.sorted.bam
PE005A1.T.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE005A1.T/PE005A1.T.human.sorted.bam
PE006A1.N.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE006A1.N/PE006A1.N.human.sorted.bam
PE006A1.T.human.sorted.bam	/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/aligned_bam/PE006A1.T/PE006A1.T.human.sorted.bam

```

### step 2 Set up working directory and scripts

```
# define alias of python docker
alias condapython="LSF_DOCKER_VOLUMES='$HOME:$HOME $STORAGE1_DINGLAB:$STORAGE1_DINGLAB $STORAGE1_MATT:$STORAGE1_MATT $SCRATCH1_DINGLAB:$SCRATCH1_DINGLAB' PATH='$STORAGE1_DINGLAB:$PATH $STORAGE1_MATT:$PATH' \
bsub -Is -q 'general-interactive dinglab-interactive' -G compute-dinglab -M 55G -R 'select[mem>55G] span[hosts=1] rusage[mem=55G]' -a 'docker(austins2/condapython:3.9.6.base)' /bin/bash -l"

outdir="/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_pecgs_batch1_coverage_final_review"
BamPathFile="/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1/PECGS_batch1_re_aligned_bam.txt"
call_coverage="/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Script/check_bam_coverage/src/1.wes_coverage_from_table.sh"
summarize_coverage="/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Script/check_bam_coverage/src/plot-dist.py"


mkdir -p "${outdir}/summary"
mkdir -p "${outdir}/logs"

# copy scripts to your working directory

cp /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_04_read_depth_PON_MMRF/summary/parse_coverage_results.py $outdir/summary

cp /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/tools/read_depth_mosdepth_v3/read_depth_mosdepth_v3/summary/plot-dist.py $outdir/summary

# generate sample_id file
cd "${outdir}" || exit 1
cut -f 1 "${BamPathFile}" > samples.txt

```

### Step 3 Call coverage
```
cd "${outdir}"
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
bash "${call_coverage}" "${BamPathFile}" "${outdir}"

# check bjobs, after all jobs are done, proceed with Step4
```

### Step 4 Summarize coverage (after step 3 is done)
```
# Initiate the docker in a new terminal
condapython
conda activate base

cd $outdir/summary
python "${summarize_coverage}" $outdir/*.region.dist.txt >coverage_results_pecgs_align_v5.tsv

# coverage_results_pecgs_align_v5.tsv is the output file that has coverage of each bam at each chromosome

head /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_pecgs_batch1_coverage_final_review/summary/coverage_results_pecgs_align_v5.tsv
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr1	79	0.510
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr2	71	0.510
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr3	72	0.510
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr4	58	0.520
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr5	70	0.510
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr6	71	0.510
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr7	79	0.510
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr8	71	0.510
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr9	75	0.510
../PE0002A1.T.human.MarkDup.bam.mosdepth.region.dist.txt	chr10	69	0.520
```
