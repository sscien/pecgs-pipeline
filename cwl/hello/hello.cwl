$namespaces:
  sbg: https://www.sevenbridges.com/
baseCommand:
- echo
class: CommandLineTool
cwlVersion: v1.0
id: hello
inputs:
- id: message
  inputBinding:
    position: '0'
  type: string
label: hello
outputs:
- id: output
  type: stdout
requirements:
- class: DockerRequirement
  dockerPull: python:3.6
- class: ResourceRequirement
  ramMin: 2000
