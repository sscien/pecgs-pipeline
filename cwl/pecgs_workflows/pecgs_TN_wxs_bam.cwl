class: Workflow
cwlVersion: v1.0
id: pecgs_TN_wxs_bam
inputs:
- id: sample
  type: string
- default: ''
  id: disease
  type: string?
- default: 40
  id: cpu
  type: int?
- id: tumor_wxs_bam
  type: File
- id: normal_wxs_bam
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
- id: reference_dir
  type: Directory
- id: target_interval_list
  type: File
- id: common_biallelic
  type: File
- id: protein_coding_gene
  type: File
- id: cytoband
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
- id: tindaisy_vep_cache_version
  type: string
- id: tindaisy_vep_cache_gz
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
- id: tindaisy_rescue_bed
  type: File
- id: centromere
  type: File
- id: tinjasmine_chrlist
  type: File
- id: Canonical_BED
  type: File
- id: ROI_BED
  type: File
- id: pindel_config_template
  type: File
- id: tinjasmine_vep_cache_gz
  type: File
- id: neoscan_ref_dir
  type: Directory
- id: neoscan_bed
  type: File
- default: dna
  id: neoscan_input_type
  type: string?
- id: charger_inheritance_gene_list
  type: File
- id: charger_pp2_gene_list
  type: File
- id: charger_pathogenic_variants
  type: File
- id: charger_hotspot3d_clusters
  type: File
- id: charger_clinvar_alleles
  type: File
label: pecgs_TN_wxs_bam
outputs:
- id: gene_level_cnv
  outputSource: run_cnv/gene_level_cnv
  type: File
- id: arm_level_cnv
  outputSource: run_cnv/arm_level_cnv
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
- id: somaticwrapper_dnp_annotated_maf
  outputSource: run_somaticwrapper/dnp_annotated_maf
  type: File
- id: somaticwrapper_dnp_annotated_coding_maf
  outputSource: run_somaticwrapper/dnp_annotated_coding_maf
  type: File
- id: somaticwrapper_withmutect_maf
  outputSource: run_somaticwrapper/withmutect_maf
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
  outputSource: run_tinjasmine/all_call_vcf
  type: File
- id: neoscan_snv_summary
  outputSource: run_neoscan/snv_summary
  type: File
- id: neoscan_indel_summary
  outputSource: run_neoscan/indel_summary
  type: File
- id: charger_filtered_tsv
  outputSource: run_charger/filtered_tsv
  type: File
- id: charger_rare_threshold_filtered_tsv
  outputSource: run_charger/rare_threshold_filtered_tsv
  type: File
- id: druggability_output
  outputSource: run_druggability/output
  type: File
- id: druggability_aux_trials_output
  outputSource: run_druggability/aux_trials_output
  type: File
requirements: []
steps:
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
  - id: cytoband
    source: cytoband
  - id: pool_of_normals
    source: pool_of_normals
  label: run_cnv
  out:
  - id: gene_level_cnv
  - id: arm_level_cnv
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
- id: run_somaticwrapper
  in:
  - id: sample
    source: sample
  - id: tumor_bam
    source: tumor_wxs_bam
  - id: normal_bam
    source: normal_wxs_bam
  - id: reference
    source: reference
  - id: rescue_genes
    source: tindaisy_rescue_bed
  label: run_somaticwrapper
  out:
  - id: dnp_annotated_maf
  - id: dnp_annotated_coding_maf
  - id: withmutect_maf
  run: ../../submodules/pecgs-somaticwrapper/cwl/somaticwrapper.cwl
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
    source: sample
    valueFrom: $(self).T
  - id: normal_barcode
    source: sample
    valueFrom: $(self).N
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
    source: tindaisy_vep_cache_gz
  - id: vep_cache_version
    source: tindaisy_vep_cache_version
  - id: rescue_cosmic
    source: rescue_cosmic
  - id: rescue_clinvar
    source: rescue_clinvar
  - id: VAFRescueBED
    source: tindaisy_rescue_bed
  label: run_tindaisy
  out:
  - id: output_maf_clean
  - id: output_vcf_clean
  - id: output_vcf_all
  run: ../../submodules/TinDaisy/cwl/workflows/tindaisy2.7.0-vep102_vafrescue.cwl
- id: run_tinjasmine
  in:
  - id: samples
    source: sample
  - id: bam
    source: normal_wxs_bam
  - id: reference
    source: reference
  - id: pindel_config_template
    source: pindel_config_template
  - id: ROI_BED
    source: ROI_BED
  - id: vep_cache_gz
    source: tinjasmine_vep_cache_gz
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
  - id: all_call_vcf
  - id: clean_MAF
  run: ../../submodules/TinJasmine/cwl/TinJasmine.v1.4.vep-102.cwl
- id: run_neoscan
  in:
  - id: maf
    source: run_tindaisy/output_maf_clean
  - id: bam
    source: tumor_wxs_bam
  - id: ref_dir
    source: neoscan_ref_dir
  - id: bed
    source: neoscan_bed
  - id: input_type
    source: neoscan_input_type
  label: run_neoscan
  out:
  - id: snv_summary
  - id: indel_summary
  run: ../../submodules/pecgs-neoscan/cwl/neoscan.cwl
- id: run_charger
  in:
  - id: vcf
    source: run_tinjasmine/clean_VCF
  - id: inheritance_gene_list
    source: charger_inheritance_gene_list
  - id: pp2_gene_list
    source: charger_pp2_gene_list
  - id: pathogenic_variants
    source: charger_pathogenic_variants
  - id: hotspot3d_clusters
    source: charger_hotspot3d_clusters
  - id: clinvar_alleles
    source: charger_clinvar_alleles
  - id: sample
    source: sample
  label: run_charger
  out:
  - id: filtered_tsv
  - id: rare_threshold_filtered_tsv
  run: ../../submodules/pecgs-charger/cwl/charger.cwl
- id: run_druggability
  in:
  - id: variant_filepath
    source: run_tindaisy/output_maf_clean
  - id: annotate_trials_keyword
    source: disease
  - id: tumor_sample_name
    source: sample
    valueFrom: $(self).T
  - id: normal_sample_name
    source: sample
    valueFrom: $(self).N
  label: run_druggability
  out:
  - id: output
  - id: aux_trials_output
  run: ../../submodules/pecgs-druggability/cwl/druggability.cwl
