cd /scratch1/fs1/dinglab/Active/Projects/ysong/

git clone --recurse-submodules https://github.com/ding-lab/pecgs-pipeline.git


```
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
export PATH="/miniconda/envs/pecgs/bin:$PATH"
bsub -q dinglab-interactive -G compute-dinglab -Is -a 'docker(estorrs/pecgs-pipeline:0.0.1)' '/bin/bash'
```

```
python /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs-pipeline/src/compute1/generate_run_commands.py tidy-run pecgs_TN_wxs_fq /storage1/fs1/dinglab/Active/Projects/andretargino/Draft/run_list-2.txt /scratch1/fs1/dinglab/andretargino/Draft/pecgs-pipeline-2/
```

## summarize-run
```
python /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs-pipeline/src/compute1/generate_run_commands.py summarize-run pecgs_TN_wxs_fq /storage1/fs1/dinglab/Active/Projects/andretargino/Draft/run_list-2.txt /scratch1/fs1/dinglab/andretargino/Draft/pecgs-pipeline-2/
```

```
python /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs-pipeline/src/compute1/generate_run_commands.py summarize-run pecgs_TN_wxs_fq /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/ATAC_Tindaisy_Somaticwrapper_comparision/atac_wxs_bam_v2/runlist.txt /storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/ATAC_Tindaisy_Somaticwrapper_comparision/atac_wxs_bam_v2/
```

## move run 
```
python /scratch1/fs1/dinglab/Active/Projects/ysong/pecgs-pipeline/src/compute1/generate_run_commands.py move-run pecgs_TN_wxs_fq /scratch1/fs1/dinglab/andretargino/Draft/pecgs-pipeline-2/analysis_summary.txt /scratch1/fs1/dinglab/andretargino/Draft/pecgs-pipeline-2 --target-dir /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/run2/
```

cp -r /scratch1/fs1/dinglab/andretargino/Draft/pecgs-pipeline-2/runs/PE0034U1_d958c5f0-5ee0-4189-83c5-15d881db0e77 /storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/run2/pecgs-pipeline-2/runs

#!/bin/bash
python /storage1/fs1/dinglab/Active/Projects/estorrs/pecgs-pipeline/src/compute1/generate_run_commands.py move-run pecgs_TN_wxs_fq run_list.txt /scratch1/fs1/dinglab/estorrs/cromwell-data/pecgs/testing/pecgs_TN_wxs_fq --target-dir /storage1/fs1/dinglab/Active/Projects/estorrs/wombat/tests/data/pecgs_TN_wxs_fq/run

#!/bin/bash
python /storage1/fs1/dinglab/Active/Projects/estorrs/pecgs-pipeline/src/compute1/generate_run_commands.py summarize-run pecgs_TN_wxs_fq run_list.txt /scratch1/fs1/dinglab/estorrs/cromwell-data/pecgs/testing/pecgs_TN_wxs_fq
