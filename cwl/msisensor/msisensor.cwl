$namespaces:
  sbg: https://www.sevenbridges.com/
arguments:
- position: 0
  prefix: -o
  valueFrom: output
baseCommand:
- msisensor
- msi
class: CommandLineTool
cwlVersion: v1.0
id: msisensor
inputs:
- id: microsatellite
  inputBinding:
    position: '0'
    prefix: -d
  type: File
- id: normal_bam
  inputBinding:
    position: '0'
    prefix: -n
  type: File
- id: tumor_bam
  inputBinding:
    position: '0'
    prefix: -t
  type: File
- id: minimal_homopolymer_size
  inputBinding:
    position: '0'
    prefix: -l
  type: string?
- id: minimal_microsatellite_size
  inputBinding:
    position: '0'
    prefix: -q
  type: string?
- id: threads
  inputBinding:
    position: '0'
    prefix: -b
  type: string?
label: msisensor
outputs:
- id: output_summary
  outputBinding:
    glob: output
  type: File
- id: output_dis
  outputBinding:
    glob: output_dis
  type: File
- id: output_germline
  outputBinding:
    glob: output_germline
  type: File
- id: output_somatic
  outputBinding:
    glob: output_somatic
  type: File
requirements:
- class: DockerRequirement
  dockerPull: informationsea/msisensor:0.6
- class: ResourceRequirement
  ramMin: 20000
