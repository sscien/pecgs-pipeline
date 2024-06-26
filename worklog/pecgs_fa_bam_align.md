Example of how to run trimGalore:
```
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/BWA-alignment/trimGalore_then_BWA.compute1.36L.sh -c /storage1/fs1/dinglab/Active/Projects/austins2/tools/BWA-alignment/config.human.compute1.ini \
-t /storage1/fs1/dinglab/Active/Projects/pecgs_primary_bulk/WXS/BAM/pecgs_WXS_fastq_to_bam_runlist.txt \
-o /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq \
-p trimGalore
```


### WXS runs step1
```

export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/

bash /storage1/fs1/dinglab/Active/Projects/austins2/tools/BWA-alignment/trimGalore_then_BWA.compute1.36L.sh -c /storage1/fs1/dinglab/Active/Projects/austins2/tools/BWA-alignment/config.human.compute1.ini -t /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_fastq_bam/PECGS_WXS_fastq_to_bam_runlist_batch1.txt -o /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq -p trimGalore
```

```
rsync -avu /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/ /storage1/fs1/dinglab/Active/Projects/pecgs_primary_bulk/WXS/trimmed_fq/
```

## WXS runs step2 (with Gencode 36)
```

export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM/logs/

bsub -G compute-dinglab -q general -J 'pecgs[2-27]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM/logs/%J.%I.err.log -R "select[mem>120GB] span[hosts=1] rusage[mem=120GB]" -M 120GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM"
```


```

export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/logs/


bsub -G compute-dinglab -q general -J 'pecgs[12]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/logs/%J.%I.err.log -R "select[mem>120GB] span[hosts=1] rusage[mem=120GB]" -M 120GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2"

bsub -G compute-dinglab -q general -J 'pecgs[15]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/logs/%J.%I.err.log -R "select[mem>120GB] span[hosts=1] rusage[mem=120GB]" -M 120GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2"


bsub -G compute-dinglab -q general -J 'pecgs[17]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/logs/%J.%I.err.log -R "select[mem>120GB] span[hosts=1] rusage[mem=120GB]" -M 120GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2"
```


## rerun_ step2

```

export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/


bsub -G compute-dinglab -q general -J 'pecgs[12]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3"

bsub -G compute-dinglab -q general -J 'pecgs[15]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3"


bsub -G compute-dinglab -q general -J 'pecgs[17]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3"


bsub -G compute-dinglab -q general -J 'pecgs[29]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3"


bsub -G compute-dinglab -q general -J 'pecgs[2-11]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3"


bsub -G compute-dinglab -q general -J 'pecgs[13]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3"

bsub -G compute-dinglab -q general -J 'pecgs[14]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3"

bsub -G compute-dinglab -q general -J 'pecgs[16]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3"

bsub -G compute-dinglab -q general -J 'pecgs[18-28]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v3"
```
# copy this to storage1
```
rsync -avu /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/ /storage1/fs1/dinglab/Active/Projects/pecgs_primary_bulk/WXS/BAM/
```

## final_ step2

```
# 200GB MEM still fail some of the samples
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v4/logs/

bsub -G compute-dinglab -q general -J 'v4[2-29]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v4/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v4/logs/%J.%I.err.log -R "select[mem>200GB] rusage[mem=200GB]" -M 200GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v4"


export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v5/logs/

bsub -G compute-dinglab -q general -J 'v5[2-29]' -g /compute-dinglab/pecgs -n 8 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v5/logs/%J.%I.map.log -eo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v5/logs/%J.%I.err.log -R "select[mem>300GB] rusage[mem=300GB]" -M 300GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch_v2.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/map.20230613.tsv -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v5"



# generate bam catalog

# generate fastq catalog

# check fastq lines


# check bam coverage


## PECGS batch1 11 sample coverage summary

## check coverage
```
outdir="/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1"
BamPathFile="${outdir}/PECGS_batch1_re_aligned_bam.txt"

BamPathFile="/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1/PECGS_batch1_re_aligned_bam.txt"

mkdir -p "${outdir}/summary"
mkdir -p "${outdir}/logs"
cd "${outdir}" || exit 1
cut -f 1 "${BamPathFile}" > samples.txt

cp /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_04_read_depth_PON_MMRF/wes_coverage_from_table.sh $outdir

cp /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_04_read_depth_PON_MMRF/summary/parse_coverage_results.py $outdir/summary

cp /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/tools/read_depth_mosdepth_v3/read_depth_mosdepth_v3/summary/plot-dist.py $outdir/summary

## step1
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
bash wes_coverage_from_table.sh $BamPathFile
# step1
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
bash wes_coverage_from_table.sh "${BamPathFile}"

## step2
cd $outdir/summary
condapython
conda activate base
python plot-dist.py ../*.region.dist.txt

python plot-dist.py ../*.region.dist.txt >coverage_results_pecgs_align_v2_vs_Spencer_align.tsv
## step3
python parse_coverage_results.py -i dist.html -s ../samples.txt -o ./

## step2

cd $outdir/summary
bsub -G compute-dinglab -q dinglab -oo mosdepth_summary.log -R "select[mem>20000] rusage[mem=20000]" -M 20000000 -a 'docker(austins2/condapython:3.9.6.base)' python plot-dist.py ../*.region.dist.txt

# step2
cd "${outdir}/summary" || exit 1
bsub -G compute-dinglab -q dinglab -oo mosdepth_summary.log -R "select[mem>20000] rusage[mem=20000]" -M 20000000 -a 'docker(austins2/condapython:3.9.6.base)' python plot-dist.py ../*.region.dist.txt


## step3

bsub -G compute-dinglab -q general -oo parse_coverage.log -R "select[mem>20000] rusage[mem=20000] span[hosts=1]" -M 20000000 -a 'docker(austins2/condapython:3.9.6.base)' python parse_coverage_results.py -i dist.html -s ./samples.txt -o ./

```
```

## check coverage final

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

## In R, plot coverage 

```

```

# 401-600
```
bsub -G compute-dinglab -q general -J 'pecgs[401-600]' -g /compute-dinglab/pecgs -n 2 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/logs/%J.%I.map.log -R "select[mem>120GB] span[hosts=1] rusage[mem=120GB]" -M 120GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 2 -1 /storage1/fs1/dinglab/Active/Projects/pecgs_primary_bulk/WXS/catalog/WXS_trimmed_fq_catalog.txt -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2"
```

# 601-710
```
bsub -G compute-dinglab -q general -J 'pecgs[601-710]' -g /compute-dinglab/pecgs -n 2 -oo /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/logs/%J.%I.map.log -R "select[mem>120GB] span[hosts=1] rusage[mem=120GB]" -M 120GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 2 -1 /storage1/fs1/dinglab/Active/Projects/pecgs_primary_bulk/WXS/catalog/WXS_trimmed_fq_catalog.txt -O /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2"
```


outdir ="/scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2"
worklist="/storage1/fs1/dinglab/Active/Projects/pecgs_primary_bulk/WXS/catalog/WXS_trimmed_fq_catalog.txt"

bsub -G compute-dinglab -q general -J 'pecgs[2-3]' -g /compute-dinglab/pecgs -n 8 -oo $outdir/logs/%J.%I.map.log -eo $outdir/logs/%J.%I.err.log -R "select[mem>120GB] span[hosts=1] rusage[mem=120GB]" -M 120GB -a 'docker(austins2/bwa)' "bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/human.DNA.makeBamFromFq.batch.sh -C /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.gencode_36_compute1.ini -N 8 -1 $worklist -O $outdir"


    



```

export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/

bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/trimGalore_then_BWA.compute1.36L.sh -c /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/BWA-alignment/config.human.compute1.ini -t /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/trimmed_fq/batch2.tsv -o /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2 -p BWA 
```

```
rsync -avu /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/BAM_v2/ /storage1/fs1/dinglab/Active/Projects/pecgs_primary_bulk/WXS/BAM/

```

This is what I run when I do WES stuff. It should also work for WGS.


## PECGS pipeline

```
/storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs_dna_align_v2023_03/src/compute1/generate_run_commands.py

```

# step1 
```
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
export PATH="/miniconda/envs/pecgs/bin:$PATH"
bsub -q dinglab-interactive -G compute-dinglab -Is -a 'docker(estorrs/pecgs-pipeline:0.0.1)' '/bin/bash'
```

# step2

```
rm -r /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/*
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/

python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs_dna_align_v2023_03/src/compute1/generate_run_commands.py make-run --sequencing-info /storage1/fs1/dinglab/Active/Projects/andretargino/Draft/sequencing_info.txt --queue general pecgs_TN_wxs_fq /storage1/fs1/dinglab/Active/Projects/pecgs_primary_bulk/WXS/BAM/pecgs_WXS_fastq_pecgs_runlist.txt /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/
```


# step3 (NEW Terminal)

```
cd /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs/pecgs_wxs_fq_bam/
bash 1.run_jobs.sh
```

```
#!/bin/bash
python /storage1/fs1/dinglab/Active/Projects/estorrs/pecgs-pipeline/src/compute1/generate_run_commands.py tidy-run pecgs_TN_wxs_fq /storage1/fs1/dinglab/Active/Projects/andretargino/Draft/run_list-1.txt /scratch1/fs1/dinglab/Active/Projects/ysong/Wagma/pecgs_wxs_fq_2023_04/
```

3.summarize_run.sh
```
#!/bin/bash
python /storage1/fs1/dinglab/Active/Projects/estorrs/pecgs-pipeline/src/compute1/generate_run_commands.py summarize-run pecgs_TN_wxs_fq /storage1/fs1/dinglab/Active/Projects/andretargino/Draft/run_list-1.txt /scratch1/fs1/dinglab/Active/Projects/ysong/Wagma/pecgs_wxs_fq_2023_04/
```
4.move_run.sh
```
#!/bin/bash
python /storage1/fs1/dinglab/Active/Projects/estorrs/pecgs-pipeline/src/compute1/generate_run_commands.py move-run pecgs_TN_wxs_fq /storage1/fs1/dinglab/Active/Projects/andretargino/Draft/run_list-1.txt /scratch1/fs1/dinglab/Active/Projects/ysong/Wagma/pecgs_wxs_fq_2023_04/ --target-dir /storage1/fs1/dinglab/Active/Projects/ysong/Projects/Team_Members/Wagma/
```


```
mkdir -p /scratch1/fs1/dinglab/Active/Projects/ysong/atac_wxs_bam/
python /storage1/fs1/dinglab/Active/Projects/ysong/Projects/pecgs-cwl/pecgs_wxs_bam_Tindaisy_v2023_03/src/compute1/generate_run_commands.py make-run  --queue general pecgs_TN_wxs_bam /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/ATAC_Tindaisy_Somaticwrapper_comparision/ATAC_WXS_bam_run_list.txt /scratch1/fs1/dinglab/Active/Projects/ysong/atac_wxs_bam/
```

```
bash /scratch1/fs1/dinglab/Active/Projects/ysong/atac_wxs_bam/1.run_jobs.sh
```
