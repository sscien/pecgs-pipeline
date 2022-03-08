# pecgs-pipeline

A CWL pipeline for running dinglab tools downstream from fastqs/bams. Built for PE-CGS project, but also generally useful :).

Currently runs on WashU RIS compute1.

## Overview

#### Tools

The following tools are incorporated into the pecgs-pipeline:

+ DNA-seq alignment (input dependent)
  + Only run in pipelines where wxs/wgs fastqs are present as inputs
  + [github repo](https://github.com/estorrs/align-dnaseq)
+ Somatic variant calling
  + Runs TinDaisy variant caller
  + [github repo](https://github.com/ding-lab/TinDaisy)
+ Germline variant calling
  + Runs TinJasmine variant caller
  + [github repo](https://github.com/ding-lab/TinJasmine)
+ Fusions
  + Runs dinglab fusion pipeline
  + [github repo](https://github.com/estorrs/pecgs-fusion)
    + original non-cwl fusion pipeline [repo](https://github.com/ding-lab/Fusion_hg38)
+ Copy number variants (CNV)
  + Runs dinglab cnv pipeline (which is gatk4 based)
  + [github repo](https://github.com/estorrs/pecgs-cnv)
    + original non-cwl cnv pipeline [repo](https://github.com/ding-lab/GATK4SCNA)
+ Microsatellite instability
  + Runs [MSIsensor](https://github.com/ding-lab/msisensor)
+ Pathogenic germline variants
  + coming soon
+ Druggability
  + coming soon
+ Structural variants
  + coming soon
+ Ancestry
  + coming soon

#### Inputs

There are multiple pipeline variants that are dependent on available input data types. Currently there are only three variants, but more will be available soon.

The inputs to the pipeline are specified in a **run list** file. See an example run list [here](https://github.com/ding-lab/pecgs-pipeline/blob/master/examples/MMRF_1250/run_list.txt). This is a tab-sperated file with the following columns (some input related columns are dependent on pipeline variant, and are listed below):

*Common columns*

+ run_id
  + a unique identifier for each sample being run in the batch. This id must be unique among samples in the batch. It is recommended the `run_id` be a concatenation of the `sample_id` and `run_uuid`, i.e. `{sample_id}_{run_uuid}`.
+ case_id
  + case name of the case being run.
+ run_uuid
  + [universally unique identifier (UUID)](https://en.wikipedia.org/wiki/Universally_unique_identifier) for the run. This identifier is for tracking purposes, so if you don't care too much about that you can just use integers or make up a random string here. For PE-CGS runs please use a valid uuid. In python this can be done using [uuid.uuid4()](https://docs.python.org/3/library/uuid.html) and in R with [UUIDgenerate](https://rdrr.io/cran/uuid/man/UUIDgenerate.html)

*Input dependent columns*

These columns will change depending on which pipeline variant is being used and are listed below. Each input data type will have two columns in the run list: one specifying the filepath, and another specifying the [universally unique identifier (UUID)](https://en.wikipedia.org/wiki/Universally_unique_identifier) of the file. The file uuid is for tracking purposes, so if you don't care too much about that you can just use integers or make up a random string here. For PE-CGS runs please use the uuid for the file that is in the bammap.


The following pipelines are available:

+ **pecgs_TN_wxs_fq**
  + inputs
    + Tumor WXS fastqs
    + Normal WXS fastqs
  + run list columns
    + `run_id`, `case_id`, `run_uuid`, `wxs_normal_R1.filepath`, `wxs_normal_R1.uuid`, `wxs_normal_R2.filepath`, `wxs_normal_R2.uuid`, `wxs_tumor_R1.filepath`, `wxs_tumor_R1.uuid`, `wxs_tumor_R2.filepath`, `wxs_tumor_R2.uuid`
  + [example run list](https://github.com/ding-lab/pecgs-pipeline/blob/master/examples/pecgs_TN_wxs_fq_ht191/run_list.txt)
+ **pecgs_TN_wxs_bam**
  + inputs
    + Tumor WXS bam
    + Normal WXS bam
  + run list columns
    + `run_id`, `case_id`, `run_uuid`, `wxs_normal_bam.filepath`, `wxs_normal_bam.uuid`, `wxs_tumor_bam.filepath`, `wxs_tumor_bam.uuid`
  + [example run list](https://github.com/ding-lab/pecgs-pipeline/blob/master/examples/pecgs_TN_wxs_bam_C3L-00677/run_list.txt)
+ **pecgs_T_rna_fq**
  + inputs
    + Tumor RNA-seq fastqs
  + run list columns
    + `run_id`, `case_id`, `run_uuid`, `rna-seq_tumor_R1.filepath`, `rna-seq_tumor_R1.uuid`, `rna-seq_tumor_R2.filepath`, `rna-seq_tumor_R2.uuid`
  + [example run list](https://github.com/ding-lab/pecgs-pipeline/blob/master/examples/pecgs_T_rna_fq_ht191/run_list.txt)

#### Outputs

The pecgs pipelines output a variety of files associated with the various tools incorporated in the pipeline.

The outputs are the following and seperated by pipeline input data type:

+ **WXS**
  + DNA-seq alignment (input dependent)
    + aligned, sorted, and indexed wxs tumor bam
    + aligned, sorted, and indexed wxs normal bam
  + Somatic variant calling
    + output_vcf_all
    + output_vcf_clean
    + output_maf_clean
  + Germline variant calling
    + output_vcf_all
    + output_vcf_clean
    + output_maf_clean
  + CNV
    + gene_level_cnv
  + Microsatellite instability
    + output_summary
    + output_dis
    + output_somatic
    + output_germline
+ **RNA-seq**
  + Fusions
    + filtered_fusions
    + total_fusions

If you require an intermediate output for any of the tools, they can be extracted from the cromwell working directory of the sample of interest. This run directory is listed in `run_summary.txt`

## Running the pipeline

First, clone the repository with the following command (note that it is different from the usual github clone command).

Then navigate inside the src/compute1 directory

```bash
git clone --recurse-submodules https://github.com/ding-lab/pecgs-pipeline.git
cd pecgs-pipeline/src/compute1
```

There are three main steps to running the pecgs pipelines: 1) generation of run directory/scripts required to run the pipeline, 2) removal of large unnecessary intermediate files generated during pipeline run, and 3) generation of pipeline run summary files.

Compute1 will only allow a small number of jobs to run at the same time by default. To allow for more jobs to run in parallel you will need to adjust the number of jobs that can be run by the default job group. To do this run the below command (replace USERNAME with your compute1 username and N_JOBS with how many jobs you would like to run in parallel). A value of N_JOBS around ~25 is usually good (this number is NOT how many samples will be run in parallel, but how many pipeline steps accross samples will be run in parallel. You may want to increase or decrease this number depending on how many samples you want to run in parallel.

```bash
bgmod -L N_JOBS /USERNAME/default
```

You will also need at least **3** compute1 terminals open. I strongly recommend running from within a TMUX session.

For example:

```bash
tmux new -s pecgs_pipeline_runs
```

#### Step 1: Generation of run directory and scripts

The pecgs-pipeline is most easily run on compute1 from an interactive docker session. To launch this session run the following command:

```bash
export LSF_DOCKER_VOLUMES="/storage1/fs1/dinglab/Active:/storage1/fs1/dinglab/Active /scratch1/fs1/dinglab:/scratch1/fs1/dinglab"
export PATH="/miniconda/envs/pecgs/bin:$PATH"
bsub -q dinglab-interactive -G compute-dinglab -Is -a 'docker(estorrs/pecgs-pipeline:0.0.1)' '/bin/bash'
```
NOTE: if the directory you intend to use for pipeline outputs is not in `/storage1/fs1/dinglab/Active` or `/scratch1/fs1/dinglab` you will need to add that path to the LSF_DOCKER_VOLUMES environmental variable in the first line.

You should now be inside a running container.

To generate the run directory, execute the following command. Replace PIPELINE_NAME with the pipeline variant you would like to run (i.e. pecgs_TN_wxs_bam), RUN_LIST with the filepath of the run list describing samples you would like to run (see inputs section for more details), and RUN_DIR with the absolute filepath where you would like the runs to execute

```bash
python generate_run_commands.py make-run PIPELINE_NAME RUN_LIST RUN_DIR
```

NOTE: for additinal arguments to generate_run_commands.py see **Additional arguments to generate_run_commands.py** section.

Following execution of this command, a directory should now exist at whatever path was specified for RUN_DIR. Inside that directory you should see three files: `1.start_server.sh`, `2.start_cromwell.sh`, and `3.run_jobs.sh`. There should also be three directories: `inputs`, `logs`, and `runs`.

`inputs` holds input configs and files used while running the pipeline. `runs` is the directory where all runs will execute. `logs` will contain the log file for each run in the run list.

To start the run **open a new compute1 terminal** (i.e. not the same terminal running the container that was created in the step above).

Then navigate to RUN_DIR. From inside RUN_DIR run `1.start_server.sh`.

```bash
bash 1.start_server.sh
```

Then from the running container run `2.start_cromwell.sh`.

```bash
bash 2.start_cromwell.sh
```

These two commands will start the cromwell server that is reponsible for coordinating the running of different samples.

After running the above commands, **open another new compute1 terminal** (i.e. not inside the running container).

Now navigate back to RUN_DIR and run 3.run_jobs.sh`.

```bash
bash 3.run_jobs.sh
```

Your pipeline runs should now be running :).

To check on progress you can view log files for each run inside the `logs` directory.

You can see currently running jobs with the `bjobs` command.

#### Step 2: Deletion of large intermediate files

Cromwell leaves behind a lot of intermediary files that can be quite large. To clean up the workflow directory run the following command from **the first terminal used at the beginning of step 1**.

```bash
python generate_run_commands.py tidy-run PIPELINE_NAME RUN_LIST RUN_DIR
```

There should now be a file called `4.tidy_run.sh` in RUN_DIR.

This file will contain commands to remove all **finished and successfully completed** pipeline runs. If you have multiple runs in your run_list then only runs that finished and completed successfully will have files to be deleted inside `4.tidy_run.sh`.

If you are performing a large number of runs it is usually a good idea to periodically run the above command to clean out intermediarry files, otherwise they may fill up memory in whatever directory you are using to execute your runs.

To run `4.tidy_run.sh`, in a compute1 terminal not inside a running container run this script to delete large intermediary files.

```bash
bash 4.tidy_run.sh
```

#### Step 3: Generation of analysis summary and run summary files

The pecgs-pipeline also has tooling to track output files and run metadata.

To generate result files run the following command from the terminal at the beginning of step 1.

```bash
python generate_run_commands.py summarize-run PIPELINE_NAME RUN_LIST RUN_DIR
```

After running this command, there should be three new files in RUN_DIR (assuming there are runs that have successfully completed): `analysis_summary.txt`, `run_summary.txt`, and `runlist.txt`.

+ `analysis_summary.txt`
  + A tab-seperated txt file containing output files and various metadata.
  + [example analysis summary file](https://github.com/ding-lab/pecgs-pipeline/blob/master/examples/summary_files/analysis_summary.txt)
+ `run_summary.txt`
  + A tab-sperated txt file containing run metadata for each run in the run list.
  + [example run summary file](https://github.com/ding-lab/pecgs-pipeline/blob/master/examples/summary_files/run_summary.txt)

Important Note: Only runs that have completed will be in the summary files. i.e. if you are running 10 runs and 4 have completed, outputs for those 4 runs will be included in the summary files, but not the 6 runs that are still ongoing. **If you run this command multiple times throughout a run new UUIDs will be assigned to each output file in analysis_summary.txt**.


## Examples

Example inputs and commands for **pecgs_TN_wxs_fq**, **pecgs_TN_wxs_bam**, and **pecgs_T_rna_fq** can be found [here](https://github.com/ding-lab/pecgs-pipeline/tree/master/examples/pecgs_TN_wxs_fq_ht191), [here](https://github.com/ding-lab/pecgs-pipeline/tree/master/examples/pecgs_TN_wxs_bam_C3L-00677), and [here](https://github.com/ding-lab/pecgs-pipeline/tree/master/examples/pecgs_T_rna_fq_ht191) respectively.

A run directory for the [pecgs_TN_wxs_fq](https://github.com/ding-lab/pecgs-pipeline/tree/master/examples/pecgs_TN_wxs_fq_ht191) test example with all logs, inputs, runs, and generated scripts/summary files can be found at `/scratch1/fs1/dinglab/estorrs/cromwell-data/pecgs/testing/pecgs_TN_wxs_fq`.

A run directory for the [pecgs_TN_wxs_bam](https://github.com/ding-lab/pecgs-pipeline/tree/master/examples/pecgs_TN_wxs_bam_C3L-00677) test example with all logs, inputs, runs, and generated scripts/summary files can be found at `/scratch1/fs1/dinglab/estorrs/cromwell-data/pecgs/testing/pecgs_TN_wxs_bam`.

A run directory for the [pecgs_T_rna_fq](https://github.com/ding-lab/pecgs-pipeline/tree/master/examples/pecgs_T_rna_fq_ht191) test example with all logs, inputs, runs, and generated scripts/summary files can be found at `/scratch1/fs1/dinglab/estorrs/cromwell-data/pecgs/testing/pecgs_T_rna_fq`.

## Additional arguments to generate_run_commands.py

usage: generate_run_commands.py [-h] [--sequencing-info SEQUENCING_INFO] [--input-config INPUT_CONFIG] [--proxy-run-dir PROXY_RUN_DIR] [--additional-volumes ADDITIONAL_VOLUMES] [--cromwell-port CROMWELL_PORT] {make-run,tidy-run,summarize-run} {pecgs_TN_wxs_fq_T_rna_fq,pecgs_TN_wxs_bam_T_rna_fq} run_list run_dir

positional arguments:
+ {make-run,tidy-run,summarize-run}
  + Which command to execute. make-run will generate scripts needed to run pipeline. tidy-run will clean up large, uneccessary input files. summarize-run will create summary files with run metadata.
+ {pecgs_TN_wxs_fq_T_rna_fq,pecgs_TN_wxs_bam_T_rna_fq}
  + Which pipeline version to run.
+ run_list
  + Filepath of table containing run inputs.
+ run_dir
  + Directory on compute1 that will be used for the pipeline runs.

optional arguments:
+ -h, --help
  + show this help message and exit
+ --sequencing-info
  + Sequencing info for fastqs if you want aligned bams to have correct metadata. Table must have a row for every dna-seq fastq and the following columns: run_id, sample_id, run_uuid, experimental_strategy, sample_type, flowcell, lane, index_sequencer, library_preparation, platform. If inputs are wxs or wgs fastqs and no sequencing info is provided then default dummy values will be used during alignment. An example sequencing info table is located [here](https://github.com/ding-lab/pecgs-pipeline/blob/master/examples/ht191/sequencing_info.txt).
+ --input-config
  + YAML file containing inputs that will override the default pipeline parameters. All default parameters are listed [here](https://github.com/estorrs/wombat/blob/master/wombat/templates/compute1.defaults.pecgs_TN_wxs_bam_T_rna_fq.yaml).
+ --proxy-run-dir
  + Use if running this script on a system that is not compute1. Will write inputs to a proxy directory that can then be copied to compute1.
+ --additional-volumes
  + Additional volumnes to map on compute1 on top of /storage1/fs1/dinglab and /scratch1/fs1/dinglab. For example if your input files do not have /storage1/fs1/dinglab and /scratch1/fs1/dinglab in their filepath then you need to include their directory here.
+ --cromwell-port
  + Port to use for cromwell server. By default a random port between 8000-12000 is selected. Sometimes when launching the cromwell server there will be an error because the port is already in use. To avoid this either rerun the make-run command or selected a port with --cromwell-port.

## Common Issues

+ Getting a `bash: /usr/bin/java: No such file or directory` error when running `2.start_cromwell.sh`
  + This likely means `1.start_server.sh` was run from inside an already running container. Step 1 must not be run from a running container/interactive session.












