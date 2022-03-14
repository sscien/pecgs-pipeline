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
- default:
  - $(inputs.tumor_rna_fq_1)
  id: bulk_expression_fq_1_list
  type: File[]
- default:
  - $(inputs.tumor_rna_fq_2)
  id: bulk_expression_fq_2_list
  type: File[]
- id: star_index
  type: Directory
- id: gtf
  type: File
- id: gene_info
  type: File
label: pecgs_T_rna_fq
outputs:
- id: readcounts_and_fpkm_tsv
  outputSource: run_bulk_expression/readcounts_and_fpkm_tsv
  type: File
- id: output_bam
  outputSource: run_bulk_expression/output_bam
  type: File
requirements:
- class: MultipleInputFeatureRequirement
steps:
- id: run_bulk_expression
  in:
  - id: cpu
    source: cpu
  - id: fq_1
    source: bulk_expression_fq_1_list
  - id: fq_2
    source: bulk_expression_fq_2_list
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
