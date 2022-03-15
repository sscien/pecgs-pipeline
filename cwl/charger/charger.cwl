arguments:
- position: 0
  prefix: -o
  valueFrom: output.tsv
baseCommand:
- charger
class: CommandLineTool
cwlVersion: v1.0
id: charger
inputs:
- id: vcf
  inputBinding:
    position: 0
    prefix: -f
  type: File
- default: /miniconda/envs/charger/bin:$PATH
  id: environ_PATH
  type: string?
label: charger
outputs:
- id: charger_tsv
  outputBinding:
    glob: output.tsv
  type: File
requirements:
- class: DockerRequirement
  dockerPull: estorrs/charger:v0.5.4_patch
- class: ResourceRequirement
  ramMin: 5000
- class: EnvVarRequirement
  envDef:
    PATH: $(inputs.environ_PATH)
