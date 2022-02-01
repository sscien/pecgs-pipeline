class: Workflow
cwlVersion: v1.0
id: msisensor_workflow
inputs:
- id: microsatellite
  type: File
- id: normal_bam
  type: File
- id: tumor_bam
  type: File
- id: minimal_homopolymer_size
  type: string?
- id: minimal_microsatellite_size
  type: string?
- id: threads
  type: string?
label: msisensor_workflow
outputs:
- id: output_summary
  outputSource: msisensor/output_summary
  type: File
- id: output_dis
  outputSource: msisensor/output_dis
  type: File
- id: output_germline
  outputSource: msisensor/output_germline
  type: File
- id: output_somatic
  outputSource: msisensor/output_somatic
  type: File
requirements:
- class: ScatterFeatureRequirement
steps:
- id: msisensor
  in:
  - id: microsatellite
    source: microsatellite
  - id: minimal_homopolymer_size
    source: minimal_homopolymer_size
  - id: minimal_microsatellite_size
    source: minimal_microsatellite_size
  - id: threads
    source: threads
  - id: normal_bam
    source: stage_normal_bam/output
  - id: tumor_bam
    source: stage_tumor_bam/output
  label: msisensor
  out:
  - id: output_summary
  - id: output_dis
  - id: output_germline
  - id: output_somatic
  run: ./msisensor.cwl
- id: stage_normal_bam
  in:
  - id: BAM
    source: normal_bam
  label: stage_normal_bam
  out:
  - id: output
  run: ../stage_bam/stage_bam.cwl
- id: stage_tumor_bam
  in:
  - id: BAM
    source: tumor_bam
  label: stage_tumor_bam
  out:
  - id: output
  run: ../stage_bam/stage_bam.cwl
