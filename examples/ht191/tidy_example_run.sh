#!/bin/bash
export LSF_DOCKER_VOLUMES=/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab
export PATH=/miniconda/envs/pecgs/bin:$PATH

bsub -q dinglab-interactive -G compute-dinglab -a 'docker(estorrs/pecgs-pipeline:0.0.1)' 'python ../../src/compute1/generate_run_commands.py tidy-run pecgs_TN_wxs_fq_T_rna_fq run_list.txt /storage1/fs1/dinglab/Active/Projects/estorrs/pecgs-pipeline/examples/ht191/example_run'
