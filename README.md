# teltale

**teltale** is a program that computes the fraction of telomeric reads in a BAM file.  A read is
considered telomeric if it contains at least seven consecutive occurrences of the telomere motif
TTAGGG or its reverse complement CCCTAA.  The fraction of telomeric reads is the number of
telomeric reads divided by the total number of reads in the BAM file.  Reads marked as Duplicate
or Failed QC are ignored and are excluded from the counts.  This program is intended for BAM files
containing whole-genome sequencing (WGS) data.

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
