class: Workflow
cwlVersion: v1.0
id: pecgs_TN_wgs_bam
inputs:
- id: tumor_wgs_bam
  secondaryFiles:
  - $(self.basename).bai
  type: File
- id: normal_wgs_bam
  secondaryFiles:
  - $(self.basename).bai
  type: File
- id: reference
  secondaryFiles:
  - $(self.basename).fai
  type: File
- default: true
  id: generate_evidence_bam
  type: boolean?
label: pecgs_TN_wgs_bam
outputs:
- id: somatic_sv_vcf
  outputSource: run_somatic_sv/output
  type: File
- id: somatic_sv_evidence_bam
  outputSource: run_somatic_sv/output_evidence
  type:
  - 'null'
  - File
  - items: File
    type: array
requirements: []
steps:
- id: run_somatic_sv
  in:
  - id: tumor
    source: tumor_wgs_bam
  - id: normal
    source: normal_wgs_bam
  - id: reference
    source: reference
  - id: generateEvidenceBam
    source: generate_evidence_bam
  label: run_somatic_sv
  out:
  - id: output
  - id: output_evidence
  run: ../../submodules/SomaticSV/cwl/SomaticSV.cwl
