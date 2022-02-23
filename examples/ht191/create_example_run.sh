#!/bin/bash
export LSF_DOCKER_VOLUMES=/storage1/fs1/dinglab/Active/Projects/estorrs/pecgs-pipeline/examples/ht191/example_run
export PATH=/miniconda/envs/pecgs/bin:$PATH
bsub -q dinglab-interactive -G compute-dinglab -a 'docker(estorrs/pecgs-pipeline:0.0.1)' 'python ../../src/compute1/generate_run_commands.py make-run --sequencing-info  sequencing_info.txt pecgs_TN_wxs_fq_T_rna_fq run_list.txt /storage1/fs1/dinglab/Active/Projects/estorrs/pecgs-pipeline/examples/ht191/example_run'

# if running this script from a non-compute1 system you can set a proxy run directory where the run directory will be written. You can then copy this directory to compute1 and start the run
# python ../../src/compute1/generate_run_commands.py make-run --proxy-run-dir example_run --sequencing-info  sequencing_info.txt pecgs_TN_wxs_fq_T_rna_fq run_list.txt /storage1/fs1/dinglab/Active/Projects/estorrs/pecgs-pipeline/examples/ht191/example_run
