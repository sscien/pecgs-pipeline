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
  filtered_fusions:
    outputSource: run_fusion/filtered_fusions
    type: File
  gene_level_cnv:
    outputSource: run_cnv/gene_level_cnv
    type: File
  msisensor_output_dis:
    outputSource: run_msisensor/output_dis
    type: File
  msisensor_output_germline:
    outputSource: run_msisensor/output_germline
    type: File
  msisensor_output_somatic:
    outputSource: run_msisensor/output_somatic
    type: File
  msisensor_output_summary:
    outputSource: run_msisensor/output_summary
    type: File
  normal_wxs_output_bam:
    outputSource: align_normal_wxs/output_bam
    secondaryFiles:
    - ^.bai
    type: File
  tindaisy_output_maf_clean:
    outputSource: run_tindaisy/output_maf_clean
    type: File
  tindaisy_output_vcf_all:
    outputSource: run_tindaisy/output_vcf_all
    type: File
  tindaisy_output_vcf_clean:
    outputSource: run_tindaisy/output_vcf_clean
    type: File
  tinjasmine_output_maf_clean:
    outputSource: run_tinjasmine/clean_MAF
    type: File
  tinjasmine_output_vcf_all:
    outputSource: run_tinjasmine/allCall_VCF
    type: File
  tinjasmine_output_vcf_clean:
    outputSource: run_tinjasmine/clean_VCF
    type: File
  total_fusions:
    outputSource: run_fusion/total_fusions
    type: File
  tumor_wxs_output_bam:
    outputSource: align_tumor_wxs/output_bam
    secondaryFiles:
    - ^.bai
    type: File
requirements:
- class: InlineJavascriptRequirement
- class: MultipleInputFeatureRequirement
- class: ScatterFeatureRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement
steps:
  align_normal_wxs:
    in:
      cpu: cpu
      flowcell: wxs_normal_flowcell
      fq_1: normal_wxs_fq_1
      fq_2: normal_wxs_fq_1
      index_sequencer: wxs_normal_index_sequencer
      known_sites: known_sites
      lane: wxs_normal_lane
      library_preparation: wxs_normal_library_preparation
      platform: wxs_normal_platform
      reference: reference
      sample: normal_sample
    out:
    - id: output_bam
    run: ../../submodules/align-dnaseq/cwl/align_dnaseq.cwl
  align_tumor_wxs:
    in:
      cpu: cpu
      flowcell: wxs_tumor_flowcell
      fq_1: tumor_wxs_fq_1
      fq_2: tumor_wxs_fq_1
      index_sequencer: wxs_tumor_index_sequencer
      known_sites: known_sites
      lane: wxs_tumor_lane
      library_preparation: wxs_tumor_library_preparation
      platform: wxs_tumor_platform
      reference: reference
      sample: tumor_sample
    out:
    - id: output_bam
    run: ../../submodules/align-dnaseq/cwl/align_dnaseq.cwl
  run_cnv:
    in:
      common_biallelic: common_biallelic
      cpu: cpu
      normal_bam: align_normal_wxs/output_bam
      pool_of_normals: pool_of_normals
      protein_coding_gene: protein_coding_gene
      reference_dir: reference_dir
      sample: sample
      target_interval_list: target_interval_list
      tumor_bam: align_tumor_wxs/output_bam
    out:
    - id: gene_level_cnv
    run: ../../submodules/pecgs-cnv/cwl/cnv_workflow.cwl
  run_fusion:
    in:
      bwts: bwts
      cpu: cpu
      filter_database: filter_database
      fq1: tumor_rna_fq_1
      fq2: tumor_rna_fq_2
      fusion_annotator_dir: fusion_annotator_dir
      genome_db: genome_db
      genome_lib_dir: genome_lib_dir
      integrate_annotations: integrate_annotations
      integrate_executable: integrate_executable
      integrate_fasta: integrate_fasta
      sample: sample
    out:
    - id: filtered_fusions
    - id: total_fusions
    run: ../../submodules/pecgs-fusion/cwl/fusion.cwl
  run_msisensor:
    in:
      microsatellite: microsatellite
      minimal_homopolymer_size: minimal_homopolymer_size
      minimal_microsatellite_size: minimal_microsatellite_size
      normal_bam: align_normal_wxs/output_bam
      threads: cpu
      tumor_bam: align_tumor_wxs/output_bam
    out:
    - id: output_summary
    - id: output_dis
    - id: output_germline
    - id: output_somatic
    run: ../msisensor/msisensor_workflow.cwl
  run_tindaisy:
    in:
      af_config: af_config
      assembly: assembly
      call_regions: call_regions
      canonical_BED: canonical_BED
      centromere_bed: centromere_bed
      chrlist: tindaisy_chrlist
      classification_config: classification_config
      clinvar_annotation: clinvar_annotation
      normal_bam: align_normal_wxs/output_bam
      normal_barcode: normal_barcode
      pindel_config: pindel_config
      reference_fasta: reference
      rescue_clinvar: rescue_clinvar
      rescue_cosmic: rescue_cosmic
      strelka_config: strelka_config
      tumor_bam: align_tumor_wxs/output_bam
      tumor_barcode: tumor_barcode
      varscan_config: varscan_config
      vep_cache_gz: vep_cache_gz
      vep_cache_version: vep_cache_version
    out:
    - id: output_maf_clean
    - id: output_vcf_clean
    - id: output_vcf_all
    run: ../../submodules/TinDaisy/cwl/workflows/tindaisy2.cwl
  run_tinjasmine:
    in:
      Canonical_BED: Canonical_BED
      ROI_BED: ROI_BED
      assembly: assembly
      bam: align_normal_wxs/output_bam
      centromere: centromere
      chrlist: tinjasmine_chrlist
      gatk_filter_config: gatk_filter_config
      pindel_config_template: pindel_config_template
      pindel_filter_config: pindel_filter_config
      reference: reference
      sample_barcode: normal_barcode
      varscan_filter_config: varscan_filter_config
      vep_cache_gz: vep_cache_gz
      vep_cache_version: vep_cache_version
    out:
    - id: clean_VCF
    - id: allCall_VCF
    - id: clean_MAF
    run: ../../submodules/TinJasmine/cwl/TinJasmine.cwl
