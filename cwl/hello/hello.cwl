$namespaces:
  sbg: https://www.sevenbridges.com/
arguments:
- position: 2
  valueFrom: hello.txt
baseCommand:
- cp
class: CommandLineTool
cwlVersion: v1.0
id: hello
inputs:
- id: message
  inputBinding:
    position: '1'
  type: File
label: hello
outputs:
- id: output_message
  outputBinding:
    glob: hello.txt
  type: File
requirements:
- class: DockerRequirement
  dockerPull: python:3.6
- class: ResourceRequirement
  ramMin: 2000
