{
    "class": "CommandLineTool",
    "cwlVersion": "v1.2",
    "$namespaces": {
        "sbg": "https://sevenbridges.com"
    },
    "baseCommand": [],
    "inputs": [
        {
            "id": "input_file",
            "type": "File",
            "inputBinding": {
                "shellQuote": false,
                "position": 1
            },
            "label": "Input BAM file",
            "doc": "Aligned BAM of whole genome sequencing data",
            "sbg:fileTypes": "BAM"
        }
    ],
    "outputs": [
        {
            "id": "standardout",
            "type": "stdout"
        },
        {
            "id": "#output_file",
            "type": "File",
            "outputBinding": {
                "glob": "output.txt"
            }
        }
    ],
    "doc": "`teltale` is a program that computes the fraction of telomeric reads in a BAM file. A read is considered telomeric if it contains at least seven consecutive occurrences of the telomere motif `TTAGGG` or its reverse complement `CCCTAA`. The fraction of telomeric reads is the number of telomeric reads divided by the total number of reads in the BAM file. Reads marked as Duplicate or Failed QC are ignored and are excluded from the counts. This program is intended for BAM files containing whole-genome sequencing (WGS) data.\n\n## Inputs\n* **BAM** - Whole-genome sequencing BAM file to search for telomeric reads\n\n## Outputs\n* **Telomere report** - Report including the total number of reads in the BAM, number of telomeric reads in the BAM, the fraction of telomeric reads, and the name of the BAM file",
    "label": "teltale",
    "requirements": [
        {
            "class": "ShellCommandRequirement"
        }
    ],
    "hints": [
        {
            "class": "DockerRequirement",
            "dockerPull": "cgc-images.sbgenomics.com/stjude/teltale:latest"
        }
    ],
    "stdout": "output.txt",
    "sbg:links": [
        {
            "id": "https://github.com/stjude/teltale",
            "label": "Source Code"
        }
    ],
    "sbg:wrapperLicense": "Apache 2.0 License",
    "sbg:license": "Apache 2.0 License",
    "sbg:categories": [
        "WGS"
    ]
}
