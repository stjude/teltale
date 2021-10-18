<p align="center">

  <h1 align="center">
    Teltale
  </h1>

  <p align="center">
   <a href="https://github.com/stjude/teltale" target="_blank">
     <img alt="Status"
          src="https://img.shields.io/badge/status-active-success.svg" />
   </a>
   <a href="https://github.com/stjude/teltale/issues" target="_blank">
     <img alt="Github Issues"
          src="https://img.shields.io/github/issues/stjude/teltale" />
   </a>
   <a href="https://github.com/stjude/teltale/pulls" target="_blank">
     <img alt="Pull Requests"
          src="https://img.shields.io/github/issues-pr/stjude/teltale" />
   </a>
   <a href="https://github.com/stjude/teltale/blob/master/LICENSE.md" target="_blank">
     <img alt="License: MIT"
          src="https://img.shields.io/badge/License-MIT-blue.svg" />
   </a>
   <br />
   <a href="https://github.com/stjude/teltale/actions?query=workflow%3ADocumentation" target="_blank">
     <img alt="Actions: Documentation Status"
          src="https://github.com/stjude/teltale/workflows/Documentation/badge.svg" />
   </a>
   <a href="https://github.com/stjude/teltale/actions?query=workflow%3APackage" target="_blank">
     <img alt="Actions: Package Status"
          src="https://github.com/stjude/teltale/workflows/Package/badge.svg" />
   </a>
  </p>
  </p>

<p align="center">
  <code>teltale</code> is a program that computes the fraction of telomeric reads in a BAM file. A read is considered telomeric if it contains at least seven consecutive occurrences of the telomere motif <code>TTAGGG<code/> or its reverse complement <code>CCCTAA<code/>. The fraction of telomeric reads is the number of telomeric reads divided by the total number of reads in the BAM file. Reads marked as Duplicate or Failed QC are ignored and are excluded from the counts. This program is intended for BAM files containing whole-genome sequencing (WGS) data.
   <br />
   <a href="https://stjude.github.io/teltale/"><strong>Explore the docs »</strong></a>
   <br />
   <br />
   <a href="https://github.com/stjude/teltale/issues/new?assignees=&labels=&template=feature_request.md&title=Descriptive%20Title&labels=enhancement">Request Feature</a>
    | 
   <a href="https://github.com/stjude/teltale/issues/new?assignees=&labels=&template=bug_report.md&title=Descriptive%20Title&labels=bug">Report Bug</a>
   <br />
    ⭐ Consider starring the repo! ⭐
   <br />

</p>

---

## Build

**teltale** uses the [BamTools API](https://github.com/pezmaster31/bamtools), version 2.4.0 or later.
Modify the paths below to refer to the BamTools include and lib directories.

```
$ g++ -std=c++0x -O3 -o teltale -I ~/bamtools/include/ -L ~/bamtools/lib/ teltale.cpp -lbamtools -lz
```

## Usage

```
$ teltale --help

teltale 2.0

Usage: teltale bam_file
```

## Input

The input is a single BAM file.  Its name is specifed as the sole command-line argument.

## Output

The output is a single line written to the standard output stream containing four tab-delimited
values:
* total number of reads in the BAM file
* number of telomeric reads in the BAM file
* fraction of telomeric reads
* name of the BAM file

## Errors

An error message is written to the standard error stream if the input file cannot be opened or if it
is not a valid BAM file.

## Notes

The time taken by the program is proportional to the size of the input file.

When comparing the fraction of telomeric reads from several BAM files, be sure that the BAM files
have the same read length.  The fraction computed for a BAM file having a read length of 150 is not
directly comparable to the fraction computed for a BAM file having a read length of 100, because it
is easier to find a sequence of seven consecutive occurrences in longer reads.

## Contact

Contact Stephen V. Rice with questions, suggestions, and other feedback.
