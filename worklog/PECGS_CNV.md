## CNV debug when sample size of panel of normals are big (eg> 900 samples)

sucessfully run
```
11:32:59.494 INFO  SVDDenoisingUtils - After filtering, 186759 out of 196832 intervals remain...
11:32:59.494 INFO  SVDDenoisingUtils - Filtering samples with a median (across intervals) below the 2.50 percentile or above the 97.50 percentile...
11:33:01.657 INFO  SVDDenoisingUtils - After filtering, 336 out of 352 samples remain...
11:33:02.095 INFO  SVDDenoisingUtils - Heap utilization statistics [MB]:
11:33:02.096 INFO  SVDDenoisingUtils - Used memory: 2690
11:33:02.096 INFO  SVDDenoisingUtils - Free memory: 1146
11:33:02.096 INFO  SVDDenoisingUtils - Total memory: 3836
11:33:02.096 INFO  SVDDenoisingUtils - Maximum memory: 7282
11:33:02.096 INFO  SVDDenoisingUtils - Performing garbage collection...
11:33:02.637 INFO  SVDDenoisingUtils - Heap utilization statistics [MB]:
11:33:02.637 INFO  SVDDenoisingUtils - Used memory: 1089
11:33:02.637 INFO  SVDDenoisingUtils - Free memory: 2769
11:33:02.637 INFO  SVDDenoisingUtils - Total memory: 3859
11:33:02.637 INFO  SVDDenoisingUtils - Maximum memory: 7282
11:33:04.948 INFO  SVDDenoisingUtils - 4827 zero-coverage values were imputed to the median of the non-zero values in the corresponding interval...
11:33:07.024 INFO  SVDDenoisingUtils - 125502 values below the 0.10 percentile or above the 99.90 percentile were truncated to the corresponding value...
11:33:07.024 INFO  SVDDenoisingUtils - Panel read counts preprocessed.
11:33:07.024 INFO  SVDDenoisingUtils - Standardizing read counts...
11:33:07.024 INFO  SVDDenoisingUtils - Dividing by sample medians and transforming to log2 space...
11:33:09.676 INFO  SVDDenoisingUtils - Subtracting median of sample medians...
11:33:10.753 INFO  SVDDenoisingUtils - Panel read counts standardized.
11:33:10.760 INFO  HDF5SVDReadCountPanelOfNormals - Writing panel sample filenames (336)...
11:33:10.761 INFO  HDF5SVDReadCountPanelOfNormals - Writing panel intervals (186759)...
11:33:10.778 INFO  HDF5SVDReadCountPanelOfNormals - Writing panel interval fractional medians (186759)...
11:33:10.779 INFO  HDF5SVDReadCountPanelOfNormals - Performing SVD (truncated at 20 eigensamples) of standardized counts (transposed to 186759 x 336)...
11:33:12.074 INFO  SparkConverter - Converting matrix to distributed Spark matrix...
11:33:12.379 INFO  SparkConverter - Done converting matrix to distributed Spark matrix...
24/05/21 11:33:12 INFO SparkContext: Starting job: first at RowMatrix.scala:61
24/05/21 11:33:12 INFO DAGScheduler: Got job 0 (first at RowMatrix.scala:61) with 1 output partitions
24/05/21 11:33:12 INFO DAGScheduler: Final stage: ResultStage 0 (first at RowMatrix.scala:61)
24/05/21 11:33:12 INFO DAGScheduler: Parents of final stage: List()
24/05/21 11:33:12 INFO DAGScheduler: Missing parents: List()
24/05/21 11:33:12 INFO DAGScheduler: Submitting ResultStage 0 (ParallelCollectionRDD[0] at parallelize at SparkConverter.java:47), which has no missing parents
24/05/21 11:33:12 INFO MemoryStore: Block broadcast_0 stored as values in memory (estimated size 1840.0 B, free 4.1 GB)
24/05/21 11:33:12 INFO MemoryStore: Block broadcast_0_piece0 stored as bytes in memory (estimated size 1149.0 B, free 4.1 GB)
24/05/21 11:33:12 INFO BlockManagerInfo: Added broadcast_0_piece0 in memory on compute1-exec-263.ris.wustl.edu:44983 (size: 1149.0 B, free: 4.1 GB)
24/05/21 11:33:12 INFO SparkContext: Created broadcast 0 from broadcast at DAGScheduler.scala:1163
24/05/21 11:33:12 INFO DAGScheduler: Submitting 1 missing tasks from ResultStage 0 (ParallelCollectionRDD[0] at parallelize at SparkConverter.java:47) (first 15 tasks are for partitions Vector(0))
24/05/21 11:33:12 INFO TaskSchedulerImpl: Adding task set 0.0 with 1 tasks
24/05/21 11:33:12 WARN TaskSetManager: Stage 0 contains a task of very large size (4943 KB). The maximum recommended task size is 100 KB.
24/05/21 11:33:12 INFO TaskSetManager: Starting task 0.0 in stage 0.0 (TID 0, localhost, executor driver, partition 0, PROCESS_LOCAL, 5061978 bytes)
24/05/21 11:33:12 INFO Executor: Running task 0.0 in stage 0.0 (TID 0)
24/05/21 11:33:13 INFO Executor: Finished task 0.0 in stage 0.0 (TID 0). 3418 bytes result sent to driver
24/05/21 11:33:13 INFO TaskSetManager: Finished task 0.0 in stage 0.0 (TID 0) in 131 ms on localhost (executor driver) (1/1)
24/05/21 11:33:13 INFO TaskSchedulerImpl: Removed TaskSet 0.0, whose tasks have all completed, from pool 
24/05/21 11:33:13 INFO DAGScheduler: ResultStage 0 (first at RowMatrix.scala:61) finished in 0.600 s
```

failed run
```
19:24:02.046 INFO  SVDDenoisingUtils - Filtering samples with a median (across intervals) below the 2.50 percentile or above the 97.50 percentile...
19:24:07.755 INFO  SVDDenoisingUtils - After filtering, 946 out of 994 samples remain...
19:24:08.961 INFO  SVDDenoisingUtils - Heap utilization statistics [MB]:
19:24:08.961 INFO  SVDDenoisingUtils - Used memory: 4588
19:24:08.961 INFO  SVDDenoisingUtils - Free memory: 2337
19:24:08.961 INFO  SVDDenoisingUtils - Total memory: 6926
19:24:08.961 INFO  SVDDenoisingUtils - Maximum memory: 7282
19:24:08.961 INFO  SVDDenoisingUtils - Performing garbage collection...
19:24:09.581 INFO  SVDDenoisingUtils - Heap utilization statistics [MB]:
19:24:09.581 INFO  SVDDenoisingUtils - Used memory: 2911
19:24:09.581 INFO  SVDDenoisingUtils - Free memory: 4020
19:24:09.581 INFO  SVDDenoisingUtils - Total memory: 6931
19:24:09.581 INFO  SVDDenoisingUtils - Maximum memory: 7282
19:24:14.780 INFO  SVDDenoisingUtils - 10570 zero-coverage values were imputed to the median of the non-zero values in the corresponding interval...
19:24:18.688 INFO  SVDDenoisingUtils - 353116 values below the 0.10 percentile or above the 99.90 percentile were truncated to the corresponding value...
19:24:18.689 INFO  SVDDenoisingUtils - Panel read counts preprocessed.
19:24:18.689 INFO  SVDDenoisingUtils - Standardizing read counts...
19:24:18.689 INFO  SVDDenoisingUtils - Dividing by sample medians and transforming to log2 space...
19:24:25.745 INFO  SVDDenoisingUtils - Subtracting median of sample medians...
19:24:28.594 INFO  SVDDenoisingUtils - Panel read counts standardized.
19:24:28.600 INFO  HDF5SVDReadCountPanelOfNormals - Writing panel sample filenames (946)...
19:24:28.604 INFO  HDF5SVDReadCountPanelOfNormals - Writing panel intervals (186637)...
19:24:28.618 INFO  HDF5SVDReadCountPanelOfNormals - Writing panel interval fractional medians (186637)...
19:24:28.619 INFO  HDF5SVDReadCountPanelOfNormals - Performing SVD (truncated at 20 eigensamples) of standardized counts (transposed to 186637 x 946)...
/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA//src/2.run.gatk4scna.createPON.sh: line 44:    12 Killed                  ${JAVA} -Dsamjdk.use_async_io_read_samtools=false -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Dsamjdk.compression_level=2 -Xmx8g -jar ${GATK} CreateReadCountPanelOfNormals --minimum-interval-median-percentile 5.0 -O ${DIR}/gatk4scnaPON.Normal.hdf5 $all_normal_hdf5
```



## PECGS WXS CNV call 2023/11/02

### define the common input arguments as variables and reuse them in each command to avoid repetition

New config file that points to the IDT v2 interval list and the gencode v36 gene name set for testing purposes is ready:
/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/config/config.gatk4scna.compute1.ini.v1.1.pecgs
3:47
rest of the command can probably stay. Just need to use the updated config.

```
export LSF_DOCKER_VOLUMES="$HOME:$HOME $STORAGE1_DINGLAB:$STORAGE1_DINGLAB $STORAGE1_MATT:$STORAGE1_MATT $SCRATCH1_DINGLAB:$SCRATCH1_DINGLAB"

# Define common input arguments as variables
TUMOR_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch5_wxs_cnv_allTumorBAM_full.txt
NORMAL_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch5_wxs_cnv_normalBAM.txt
OUTPUT_DIR=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/cnv_run_05
CONFIG_FILE=/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/config/config.gatk4scna.compute1.ini.v1.1.pecgs

mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

# Step 1 (precall of normals)

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



## PECGS WXS CNV call 2023/10/12

### define the common input arguments as variables and reuse them in each command to avoid repetition

New config file that points to the IDT v2 interval list and the gencode v36 gene name set for testing purposes is ready:
/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/config/config.gatk4scna.compute1.ini.v1.1.pecgs
3:47
rest of the command can probably stay. Just need to use the updated config.

```
export LSF_DOCKER_VOLUMES="$HOME:$HOME $STORAGE1_DINGLAB:$STORAGE1_DINGLAB $STORAGE1_MATT:$STORAGE1_MATT $SCRATCH1_DINGLAB:$SCRATCH1_DINGLAB"

# Define common input arguments as variables
TUMOR_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_2_wxs_cnv_allTumorBAM_full.txt
NORMAL_BAM_LIST=/storage1/fs1/dinglab/Active/Projects/ysong/Projects/PECGS/Analysis/pecgs_run_list/PECGS_batch1_2_wxs_cnv_normalBAM.txt
OUTPUT_DIR=/storage1/fs1/dinglab/Active/Projects/PECGS/PECGS_analysis/pecgs_batch1/cnv_run_2
CONFIG_FILE=/storage1/fs1/dinglab/Active/Projects/austins2/tools/GATK4SCNA/config/config.gatk4scna.compute1.ini.v1.1.pecgs

mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

# Step 1 (precall of normals)

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
