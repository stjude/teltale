class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://sevenbridges.com'
baseCommand: []
inputs:
  - id: input_file
    type: File
    inputBinding:
      position: 1
    label: Input BAM file
    'sbg:fileTypes': BAM
outputs:
  - id: standardout
    type: stdout
  - id: '#output_file'
    type: File
    outputBinding:
      glob: output.txt
label: teltale
hints:
  - class: DockerRequirement
    dockerPull: 'ghcr.io/stjude/teltale:latest'
stdout: output.txt
