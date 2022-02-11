class: Workflow
cwlVersion: v1.0
id: align_dnaseq
inputs:
  bam_name: string
  job_uuid: string
  known_snp:
    secondaryFiles:
    - .tbi
    type: File
  readgroup_fastq_pe_file_list:
    type:
      items: ../../submodules/gdc-dnaseq-cwl/tools/readgroup.yml#readgroup_fastq_file
      type: array
  readgroup_fastq_se_file_list:
    default: []
    type:
      items: ../../submodules/gdc-dnaseq-cwl/tools/readgroup.yml#readgroup_fastq_file
      type: array
  readgroups_bam_file_list:
    default: []
    type:
      items: ../../submodules/gdc-dnaseq-cwl/tools/readgroup.yml#readgroups_bam_file
      type: array
  reference_sequence:
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .fai
    - .pac
    - .sa
    - ^.dict
    type: File
  run_markduplicates:
    default: true
    type: boolean?
  thread_count: long
label: align_dnaseq
outputs:
  output_bam:
    outputSource: gatk_applybqsr/output_bam
    type: File
requirements:
- class: InlineJavascriptRequirement
- class: MultipleInputFeatureRequirement
- class: ScatterFeatureRequirement
- class: SchemaDefRequirement
  types:
  - $import: ../../submodules/gdc-dnaseq-cwl/tools/readgroup.yml
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement
steps:
  bwa_pe:
    in:
      job_uuid: job_uuid
      readgroup_fastq_pe: merge_fastq_arrays/merged_pe_fastq_array
      reference_sequence: reference_sequence
      thread_count: thread_count
    out:
    - bam
    run: ../../submodules/gdc-dnaseq-cwl/subworkflows/align/bwa_pe.cwl
    scatter: readgroup_fastq_pe
  bwa_se:
    in:
      job_uuid: job_uuid
      readgroup_fastq_se: merge_fastq_arrays/merged_se_fastq_array
      reference_sequence: reference_sequence
      thread_count: thread_count
    out:
    - bam
    run: ../../submodules/gdc-dnaseq-cwl/subworkflows/align/bwa_se.cwl
    scatter: readgroup_fastq_se
  conditional_markduplicates:
    in:
      bam: dup_branch_decider/out_bam
      bam_name: bam_name
      job_uuid: job_uuid
      run_markduplicates: dup_branch_decider/do_markdup_workflow
      thread_count: thread_count
    out:
    - output
    - sqlite
    run: ../../submodules/gdc-dnaseq-cwl/subworkflows/utils/conditional_markduplicates.cwl
    scatter: run_markduplicates
  conditional_skip_markduplicates:
    in:
      bam: dup_branch_decider/out_bam
      bam_name: bam_name
      job_uuid: job_uuid
      skip_markduplicates: dup_branch_decider/skip_markdup_workflow
      thread_count: thread_count
    out:
    - output
    run: ../../submodules/gdc-dnaseq-cwl/subworkflows/utils/conditional_skip_markduplicates.cwl
    scatter: skip_markduplicates
  dup_branch_decider:
    in:
      bam:
        source:
        - bwa_pe/bam
        - bwa_se/bam
      run_markdups: run_markduplicates
    out:
    - do_markdup_workflow
    - skip_markdup_workflow
    - out_bam
    run: ../../submodules/gdc-dnaseq-cwl/tools/decider_markdup_input.cwl
  dup_outputs_decider:
    in:
      markdup_bam: conditional_markduplicates/output
      markdup_sqlite: conditional_markduplicates/sqlite
      skip_markdup_bam: conditional_skip_markduplicates/output
    out:
    - bam
    run: ../../submodules/gdc-dnaseq-cwl/tools/decider_markdup_output.cwl
  fastq_clean_pe:
    in:
      input: readgroup_fastq_pe_file_list
      job_uuid: job_uuid
    out:
    - output
    run: ../../submodules/gdc-dnaseq-cwl/subworkflows/utils/fastq_clean.cwl
    scatter: input
  fastq_clean_se:
    in:
      input: readgroup_fastq_se_file_list
      job_uuid: job_uuid
    out:
    - output
    run: ../../submodules/gdc-dnaseq-cwl/subworkflows/utils/fastq_clean.cwl
    scatter: input
  gatk_applybqsr:
    in:
      bqsr-recal-file: gatk_baserecalibrator/output_grp
      input: dup_outputs_decider/bam
    out:
    - output_bam
    run: ../../submodules/gdc-dnaseq-cwl/tools/gatk4_applybqsr.cwl
  gatk_baserecalibrator:
    in:
      input: dup_outputs_decider/bam
      known-sites: known_snp
      reference: reference_sequence
    out:
    - output_grp
    run: ../../submodules/gdc-dnaseq-cwl/tools/gatk4_baserecalibrator.cwl
  merge_fastq_arrays:
    in:
      bam_o1_fastqs: readgroups_bam_to_readgroups_fastq_lists/o1_file_list
      bam_o2_fastqs: readgroups_bam_to_readgroups_fastq_lists/o2_file_list
      bam_pe_fastqs: readgroups_bam_to_readgroups_fastq_lists/pe_file_list
      bam_se_fastqs: readgroups_bam_to_readgroups_fastq_lists/se_file_list
      fastqs_pe: fastq_clean_pe/output
      fastqs_se: fastq_clean_se/output
    out:
    - merged_pe_fastq_array
    - merged_se_fastq_array
    run: ../../submodules/gdc-dnaseq-cwl/subworkflows/utils/merge_fastq_array_workflow.cwl
  picard_validatesamfile_bqsr:
    in:
      INPUT: gatk_applybqsr/output_bam
      VALIDATION_STRINGENCY:
        valueFrom: STRICT
    out:
    - OUTPUT
    run: ../../submodules/gdc-dnaseq-cwl/tools/picard_validatesamfile.cwl
  readgroups_bam_to_readgroups_fastq_lists:
    in:
      readgroups_bam_file: readgroups_bam_file_list
    out:
    - pe_file_list
    - se_file_list
    - o1_file_list
    - o2_file_list
    run: ../../submodules/gdc-dnaseq-cwl/subworkflows/utils/readgroups_bam_to_readgroups_fastq_lists.cwl
    scatter: readgroups_bam_file
