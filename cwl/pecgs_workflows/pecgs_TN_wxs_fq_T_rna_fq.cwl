class: Workflow
cwlVersion: v1.0
id: pecgs_TN_wxs_fq_T_rna_fq
inputs:
  Canonical_BED:
    type: File
  ROI_BED:
    type: File
  af_config:
    type: File
  assembly:
    type: string
  bwts:
    type: Directory
  call_regions:
    type: File
  canonical_BED:
    type: File
  centromere:
    type: File
  centromere_bed:
    type: File
  classification_config:
    type: File
  clinvar_annotation:
    type: File
  common_biallelic:
    type: File
  cpu:
    default: 40
    type: int?
  filter_database:
    type: Directory
  fusion_annotator_dir:
    type: Directory
  gatk_filter_config:
    type: File
  genome_db:
    type: Directory
  genome_lib_dir:
    type: Directory
  integrate_annotations:
    type: File
  integrate_executable:
    type: File
  integrate_fasta:
    type: File
  known_sites:
    secondaryFiles:
    - .tbi
    type: File
  microsatellite:
    type: File
  minimal_homopolymer_size:
    default: 1
    type: int?
  minimal_microsatellite_size:
    default: 1
    type: int?
  normal_barcode:
    default: $(inputs.sample).N
    type: string?
  normal_sample:
    default: $(inputs.sample).WXS.N
    type: string?
  normal_wxs_fq_1:
    type: File
  normal_wxs_fq_2:
    type: File
  pindel_config:
    type: File
  pindel_config_template:
    type: File
  pindel_filter_config:
    type: File
  pool_of_normals:
    type: File
  protein_coding_gene:
    type: File
  reference:
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .fai
    - .pac
    - .sa
    - ^.dict
    type: File
  reference_dir:
    type: Directory
  rescue_clinvar:
    default: false
    type: boolean?
  rescue_cosmic:
    default: false
    type: boolean?
  sample: string
  sample_barcode:
    default: $(inputs.sample)
    type: string?
  strelka_config:
    type: File
  target_interval_list:
    type: File
  tindaisy_chrlist:
    type: File
  tinjasmine_chrlist:
    type: File
  tumor_barcode:
    default: $(inputs.sample).T
    type: string?
  tumor_rna_fq_1:
    type: File
  tumor_rna_fq_2:
    type: File
  tumor_sample:
    default: $(inputs.sample).WXS.T
    type: string?
  tumor_wxs_fq_1:
    type: File
  tumor_wxs_fq_2:
    type: File
  varscan_config:
    type: File
  varscan_filter_config:
    type: File
  vep_cache_gz:
    type: File
  vep_cache_version:
    type: string
  wxs_normal_flowcell:
    default: flowcellABCDE
    type: string?
  wxs_normal_index_sequencer:
    default: sequencerABCDE
    type: string?
  wxs_normal_lane:
    default: '1'
    type: string?
  wxs_normal_library_preparation:
    default: lib1
    type: string?
  wxs_normal_platform:
    default: ILLUMINA
    type: string?
  wxs_tumor_flowcell:
    default: flowcellABCDE
    type: string?
  wxs_tumor_index_sequencer:
    default: sequencerABCDE
    type: string?
  wxs_tumor_lane:
    default: '1'
    type: string?
  wxs_tumor_library_preparation:
    default: lib1
    type: string?
  wxs_tumor_platform:
    default: ILLUMINA
    type: string?
label: pecgs_TN_wxs_fq_T_rna_fq
outputs:
- id: tumor_wxs_output_bam
  outputSource: align_tumor_wxs/output_bam
  secondaryFiles:
  - ^.bai
  type: File
- id: normal_wxs_output_bam
  outputSource: align_normal_wxs/output_bam
  secondaryFiles:
  - ^.bai
  type: File
- id: filtered_fusions
  outputSource: run_fusion/filtered_fusions
  type: File
- id: total_fusions
  outputSource: run_fusion/total_fusions
  type: File
- id: gene_level_cnv
  outputSource: run_cnv/gene_level_cnv
  type: File
- id: msisensor_output_summary
  outputSource: run_msisensor/output_summary
  type: File
- id: msisensor_output_dis
  outputSource: run_msisensor/output_dis
  type: File
- id: msisensor_output_germline
  outputSource: run_msisensor/output_germline
  type: File
- id: msisensor_output_somatic
  outputSource: run_msisensor/output_somatic
  type: File
- id: tindaisy_output_maf_clean
  outputSource: run_tindaisy/output_maf_clean
  type: File
- id: tindaisy_output_vcf_clean
  outputSource: run_tindaisy/output_vcf_clean
  type: File
- id: tindaisy_output_vcf_all
  outputSource: run_tindaisy/output_vcf_all
  type: File
- id: tinjasmine_output_maf_clean
  outputSource: run_tinjasmine/clean_MAF
  type: File
- id: tinjasmine_output_vcf_clean
  outputSource: run_tinjasmine/clean_VCF
  type: File
- id: tinjasmine_output_vcf_all
  outputSource: run_tinjasmine/allCall_VCF
  type: File
requirements:
- class: InlineJavascriptRequirement
- class: ScatterFeatureRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement
steps:
  align_normal_wxs:
    in:
    - id: sample
      source: normal_sample
    - id: cpu
      source: cpu
    - id: fq_1
      source: normal_wxs_fq_1
    - id: fq_2
      source: normal_wxs_fq_2
    - id: known_sites
      source: known_sites
    - id: reference
      source: reference
    - id: flowcell
      source: wxs_normal_flowcell
    - id: lane
      source: wxs_normal_lane
    - id: index_sequencer
      source: wxs_normal_index_sequencer
    - id: library_preparation
      source: wxs_normal_library_preparation
    - id: platform
      source: wxs_normal_platform
    out:
    - id: output_bam
    run: ../../submodules/align-dnaseq/cwl/align_dnaseq.cwl
  align_tumor_wxs:
    in:
    - id: sample
      source: tumor_sample
    - id: cpu
      source: cpu
    - id: fq_1
      source: tumor_wxs_fq_1
    - id: fq_2
      source: tumor_wxs_fq_2
    - id: known_sites
      source: known_sites
    - id: reference
      source: reference
    - id: flowcell
      source: wxs_tumor_flowcell
    - id: lane
      source: wxs_tumor_lane
    - id: index_sequencer
      source: wxs_tumor_index_sequencer
    - id: library_preparation
      source: wxs_tumor_library_preparation
    - id: platform
      source: wxs_tumor_platform
    out:
    - id: output_bam
    run: ../../submodules/align-dnaseq/cwl/align_dnaseq.cwl
  run_cnv:
    in:
    - id: sample
      source: sample
    - id: cpu
      source: cpu
    - id: tumor_bam
      source: align_tumor_wxs/output_bam
    - id: normal_bam
      source: align_normal_wxs/output_bam
    - id: reference_dir
      source: reference_dir
    - id: target_interval_list
      source: target_interval_list
    - id: common_biallelic
      source: common_biallelic
    - id: protein_coding_gene
      source: protein_coding_gene
    - id: pool_of_normals
      source: pool_of_normals
    out:
    - id: gene_level_cnv
    run: ../../submodules/pecgs-cnv/cwl/cnv_workflow.cwl
  run_fusion:
    in:
    - id: sample
      source: sample
    - id: cpu
      source: cpu
    - id: fq1
      source: tumor_rna_fq_1
    - id: fq2
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
    out:
    - id: filtered_fusions
    - id: total_fusions
    run: ../../submodules/pecgs-fusion/cwl/fusion.cwl
  run_msisensor:
    in:
    - id: threads
      source: cpu
    - id: tumor_bam
      source: align_tumor_wxs/output_bam
    - id: normal_bam
      source: align_normal_wxs/output_bam
    - id: microsatellite
      source: microsatellite
    - id: minimal_homopolymer_size
      source: minimal_homopolymer_size
    - id: minimal_microsatellite_size
      source: minimal_microsatellite_size
    out:
    - id: output_summary
    - id: output_dis
    - id: output_germline
    - id: output_somatic
    run: ../msisensor/msisensor_workflow.cwl
  run_tindaisy:
    in:
    - id: tumor_bam
      source: align_tumor_wxs/output_bam
    - id: normal_bam
      source: align_normal_wxs/output_bam
    - id: reference_fasta
      source: reference
    - id: pindel_config
      source: pindel_config
    - id: varscan_config
      source: varscan_config
    - id: assembly
      source: assembly
    - id: centromere_bed
      source: centromere_bed
    - id: strelka_config
      source: strelka_config
    - id: chrlist
      source: tindaisy_chrlist
    - id: tumor_barcode
      source: tumor_barcode
    - id: normal_barcode
      source: normal_barcode
    - id: canonical_BED
      source: canonical_BED
    - id: call_regions
      source: call_regions
    - id: af_config
      source: af_config
    - id: classification_config
      source: classification_config
    - id: clinvar_annotation
      source: clinvar_annotation
    - id: vep_cache_gz
      source: vep_cache_gz
    - id: vep_cache_version
      source: vep_cache_version
    - id: rescue_cosmic
      source: rescue_cosmic
    - id: rescue_clinvar
      source: rescue_clinvar
    out:
    - id: output_maf_clean
    - id: output_vcf_clean
    - id: output_vcf_all
    run: ../../submodules/TinDaisy/cwl/workflows/tindaisy2.cwl
  run_tinjasmine:
    in:
    - id: sample_barcode
      source: normal_barcode
    - id: bam
      source: align_normal_wxs/output_bam
    - id: reference
      source: reference
    - id: gatk_filter_config
      source: gatk_filter_config
    - id: pindel_config_template
      source: pindel_config_template
    - id: pindel_filter_config
      source: pindel_filter_config
    - id: varscan_filter_config
      source: varscan_filter_config
    - id: ROI_BED
      source: ROI_BED
    - id: vep_cache_gz
      source: vep_cache_gz
    - id: vep_cache_version
      source: vep_cache_version
    - id: assembly
      source: assembly
    - id: Canonical_BED
      source: Canonical_BED
    - id: chrlist
      source: tinjasmine_chrlist
    - id: centromere
      source: centromere
    out:
    - id: clean_VCF
    - id: allCall_VCF
    - id: clean_MAF
    run: ../../submodules/TinJasmine/cwl/TinJasmine.cwl
