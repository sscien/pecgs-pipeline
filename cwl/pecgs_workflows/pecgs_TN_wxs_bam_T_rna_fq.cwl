class: Workflow
cwlVersion: v1.0
id: pecgs_TN_wxs_bam_T_rna_fq
inputs:
- id: sample
  type: string
- default: 40
  id: cpu
  type: int?
- id: tumor_wxs_bam
  type: File
- id: normal_wxs_bam
  type: File
- id: tumor_rna_fq_1
  type: File
- id: tumor_rna_fq_2
  type: File
- id: reference
  secondaryFiles:
  - .amb
  - .ann
  - .bwt
  - .fai
  - .pac
  - .sa
  - ^.dict
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
- id: reference_dir
  type: Directory
- id: target_interval_list
  type: File
- id: common_biallelic
  type: File
- id: protein_coding_gene
  type: File
- id: pool_of_normals
  type: File
- id: microsatellite
  type: File
- default: 1
  id: minimal_homopolymer_size
  type: int?
- default: 1
  id: minimal_microsatellite_size
  type: int?
- default: false
  id: rescue_clinvar
  type: boolean?
- default: false
  id: rescue_cosmic
  type: boolean?
- id: vep_cache_version
  type: string
- id: vep_cache_gz
  type: File
- id: clinvar_annotation
  type: File
- id: classification_config
  type: File
- id: af_config
  type: File
- id: call_regions
  type: File
- id: canonical_BED
  type: File
- default: $(inputs.sample).N
  id: normal_barcode
  type: string?
- default: $(inputs.sample).T
  id: tumor_barcode
  type: string?
- id: tindaisy_chrlist
  type: File
- id: strelka_config
  type: File
- id: centromere_bed
  type: File
- id: assembly
  type: string
- id: varscan_config
  type: File
- id: pindel_config
  type: File
- default: $(inputs.sample)
  id: sample_barcode
  type: string?
- id: centromere
  type: File
- id: tinjasmine_chrlist
  type: File
- id: Canonical_BED
  type: File
- id: ROI_BED
  type: File
- id: varscan_filter_config
  type: File
- id: pindel_filter_config
  type: File
- id: pindel_config_template
  type: File
- id: gatk_filter_config
  type: File
label: pecgs_TN_wxs_bam_T_rna_fq
outputs:
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
requirements: []
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
- id: run_cnv
  in:
  - id: sample
    source: sample
  - id: cpu
    source: cpu
  - id: tumor_bam
    source: tumor_wxs_bam
  - id: normal_bam
    source: normal_wxs_bam
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
  label: run_cnv
  out:
  - id: gene_level_cnv
  run: ../../submodules/pecgs-cnv/cwl/cnv_workflow.cwl
- id: run_msisensor
  in:
  - id: threads
    source: cpu
  - id: tumor_bam
    source: tumor_wxs_bam
  - id: normal_bam
    source: normal_wxs_bam
  - id: microsatellite
    source: microsatellite
  - id: minimal_homopolymer_size
    source: minimal_homopolymer_size
  - id: minimal_microsatellite_size
    source: minimal_microsatellite_size
  label: run_msisensor
  out:
  - id: output_summary
  - id: output_dis
  - id: output_germline
  - id: output_somatic
  run: ../msisensor/msisensor_workflow.cwl
- id: run_tindaisy
  in:
  - id: tumor_bam
    source: tumor_wxs_bam
  - id: normal_bam
    source: normal_wxs_bam
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
  label: run_tindaisy
  out:
  - id: output_maf_clean
  - id: output_vcf_clean
  - id: output_vcf_all
  run: ../../submodules/TinDaisy/cwl/workflows/tindaisy2.cwl
- id: run_tinjasmine
  in:
  - id: sample_barcode
    source: normal_barcode
  - id: bam
    source: normal_wxs_bam
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
  label: run_tinjasmine
  out:
  - id: clean_VCF
  - id: allCall_VCF
  - id: clean_MAF
  run: ../../submodules/TinJasmine/cwl/TinJasmine.cwl
