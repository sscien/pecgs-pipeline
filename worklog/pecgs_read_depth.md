## PECGS batch1 11 sample coverage summary

```
outdir="/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1"
BamPathFile="${outdir}/PECGS_batch1_aligned_bam.txt"
BamPathFile="/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1/PECGS_batch1_mgi_aligned_bam.txt"

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

#
condapython
python plot-dist.py ../*.region.dist.txt
python parse_coverage_results.py -i dist.html -s ./samples.txt -o ./

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
mkdir -p /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1/summary
mkdir -p /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1/logs
cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1


export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1
  bash /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/tools/read_depth_mosdepth_v3/read_depth_mosdepth_v3/wes_coverage_from_table.sh /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1/PECGS_batch1_aligned_bam.txt




cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1/summary
bsub -G compute-dinglab -q dinglab -oo mosdepth_summary.log -R "select[mem>20000] rusage[mem=20000]" -M 20000000 -a 'docker(austins2/condapython:3.9.6.base)' python plot-dist.py ../*.region.dist.txt

bsub -G compute-dinglab -q general -oo parse_coverage.log -R "select[mem>20000] rusage[mem=20000] span[hosts=1]" -M 20000000 -a 'docker(austins2/condapython:3.9.6.base)' python parse_coverage_results.py -i dist.html -s /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_06_read_depth_batch1/PECGS_batch1_aligned_bam.txt -o ./


```
 
 
 
```
cd /storage1/fs1/dinglab/Active/Projects/austins2/pancan-ATAC/bulk-WXS/v7/read_depth_mosdepth_v3/
bash wes_coverage_from_table.sh /storage1/fs1/dinglab/Active/Projects/austins2/pancan-ATAC/bulk-WXS/v7/read_depth_mosdepth_v3/sample_bam_table.tsv
```

cd /storage1/fs1/dinglab/Active/Projects/austins2/pancan-ATAC/bulk-WXS/v7/read_depth_mosdepth_v3/summary
cut -f 1 ../sample_bam_table.tsv > samples.txt

bsub -G compute-dinglab -q dinglab -oo mosdepth_summary.log -R "select[mem>20000] rusage[mem=20000]" -M 20000000 -a 'docker(austins2/condapython:3.9.6.base)' python plot-dist.py ../*.region.dist.txt
bsub -G compute-dinglab -q general -oo parse_coverage.log -R "select[mem>20000] rusage[mem=20000] span[hosts=1]" -M 20000000 -a 'docker(austins2/condapython:3.9.6.base)' python parse_coverage_results.py -i dist.html -s samples.txt -o ./

mkdir -p /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/tools/read_depth_mosdepth_v3
cp -r /storage1/fs1/dinglab/Active/Projects/austins2/pancan-ATAC/bulk-WXS/v7/read_depth_mosdepth_v3 /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/tools/read_depth_mosdepth_v3

```
mkdir -p /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_04_read_depth/summary
mkdir -p /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_04_read_depth/logs
cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_04_read_depth/
cut -f 1 bam_file_paths.txt > samples.txt
```

/storage1/fs1/dinglab/Active/Projects/ysong/pipelines/tools/read_depth_mosdepth_v3/read_depth_mosdepth_v3/wes_coverage_from_table.sh

```
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
cd /storage1/fs1/dinglab/Active/Projects/ysong/pipelines/tools/read_depth_mosdepth_v3/read_depth_mosdepth_v3/
bash wes_coverage_from_table.sh /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_04_read_depth/bam_file_paths.txt
```

```
cd /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/2023_04_read_depth/summary
bsub -G compute-dinglab -q dinglab -oo mosdepth_summary.log -R "select[mem>20000] rusage[mem=20000]" -M 20000000 -a 'docker(austins2/condapython:3.9.6.base)' python plot-dist.py ../*.region.dist.txt

bsub -G compute-dinglab -q general -oo parse_coverage.log -R "select[mem>20000] rusage[mem=20000] span[hosts=1]" -M 20000000 -a 'docker(austins2/condapython:3.9.6.base)' python parse_coverage_results.py -i dist.html -s samples.txt -o ./


```
