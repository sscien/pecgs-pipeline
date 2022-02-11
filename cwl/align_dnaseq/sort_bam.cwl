arguments:
- position: 1
  prefix: -o
  valueFrom: output.bam
baseCommand:
- /usr/bin/samtools
- sort
class: CommandLineTool
cwlVersion: v1.0
id: sort_bam
inputs:
- id: input_bam
  inputBinding:
    position: 0
  type: File
- default: 1
  id: cpu
  inputBinding:
    position: 1
    prefix: -@
  type: int?
label: sort_bam
outputs:
- id: output_bam
  outputBinding:
    glob: output.bam
  type: File
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/samtools:v1.9-4-deb_cv1
- class: ResourceRequirement
  coresMin: $(inputs.cpu)
  ramMin: 28000
