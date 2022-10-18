# `mixcr exportReadsForClones`

Exports raw sequencing reads that were used to build clonotypes from `.clna` file. Note that such export is possible only from `.clna` files, produced by MiXCR  [`assemble`](./mixcr-assemble.md) command with option `--write-alignments`.

```
mixcr exportReadsForClones 
    [--id [<id>...]]... 
    [--separate] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    input.clna output.(fastq[.gz]|fasta)
```

`input_file.clna`
: Path to input file

`output_file.(fastq[.gz]|fasta)`
: Output file name will be transformed into `_R1`/`_R2` pair in case of paired end reads.

`--id [<id>...]`
: Clone ids to export. If no clone ids are specified all reads assigned to clonotypes will be exported. Use --id -1 to export alignments not assigned to any clone (not assembled).

`-s, --separate`
: Create separate files for each clone. File or pair of `_R1`/`_R2` files, with `_clnN` suffix, where N is clone index, will be created for each clone index.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.


Extract reads in for specified clonotypes into separate files:
```shell
> mixcr exportReadsForClones \
  -s --id 2 12 45 \
  clones.clna \
  reads.fastq.gz
```

Extract into a single file:
```shell
> mixcr exportReadsForClones \
  --id 2 12 45 \
  clones.clna \
  reads.fastq.gz
```
