class: Workflow
cwlVersion: v1.0
id: pecgs_T_rna_fq
inputs:
- id: sample
  type: string
- default: 40
  id: cpu
  type: int?
- id: tumor_rna_fq_1
  type: File
- id: tumor_rna_fq_2
  type: File
- id: genome_lib_dir
  type: Directory
- id: genome_db
  type: Directory
- id: bwts
  type: Directory
- id: integrate_executable
  type: File
- id: integrate_fasta
  type: File
- id: integrate_annotations
  type: File
- id: filter_database
  type: Directory
- id: fusion_annotator_dir
  type: Directory
- id: star_index
  type: Directory
- id: gtf
  type: File
- id: gene_info
  type: File
label: pecgs_T_rna_fq
outputs:
- id: filtered_fusions
  outputSource: run_fusion/filtered_fusions
  type: File
- id: total_fusions
  outputSource: run_fusion/total_fusions
  type: File
- id: readcounts_and_fpkm_tsv
  outputSource: run_bulk_expression/readcounts_and_fpkm_tsv
  type: File
- id: output_bam
  outputSource: run_bulk_expression/output_bam
  type: File
requirements:
- class: MultipleInputFeatureRequirement
steps:
- id: run_fusion
  in:
  - id: sample
    source: sample
  - id: cpu
    source: cpu
  - id: fq_1
    source: tumor_rna_fq_1
  - id: fq_2
    source: tumor_rna_fq_2
  - id: filter_database
    source: filter_database
  - id: bwts
    source: bwts
  - id: fusion_annotator_dir
    source: fusion_annotator_dir
  - id: genome_db
    source: genome_db
  - id: genome_lib_dir
    source: genome_lib_dir
  - id: integrate_annotations
    source: integrate_annotations
  - id: integrate_executable
    source: integrate_executable
  - id: integrate_fasta
    source: integrate_fasta
  label: run_fusion
  out:
  - id: filtered_fusions
  - id: total_fusions
  run: ../../submodules/pecgs-fusion/cwl/fusion.cwl
- id: run_bulk_expression
  in:
  - id: cpu
    source: cpu
  - id: fq_1
    source:
    - tumor_rna_fq_1
  - id: fq_2
    source:
    - tumor_rna_fq_2
  - id: star_index
    source: star_index
  - id: gtf
    source: gtf
  - id: gene_info
    source: gene_info
  label: run_bulk_expression
  out:
  - id: readcounts_and_fpkm_tsv
  - id: output_bam
  run: ../../submodules/pecgs-bulk-expression/cwl/bulk_expression.cwl
