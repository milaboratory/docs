# `mixcr exportReadsForClones`

Exports raw sequencing reads that were used to build clonotypes from `.clna` file. Note that such export is possible only from `.clna` files, produced by MiXCR  [`assemble`](./mixcr-assemble.md) command with option `--write-alignments`.

```
mixcr exportReadsForClones [-fs]
    --id [<ids>...]
    clones.clna
    output.fastq.gz
```
Output file name will be transformed into `_R1`/`_R2` pair in case of paired end reads.

`--id [<ids>...]`

:   list of clonotype ids to export; use -1 to export reads that were not used in clonotypes

`-s`, `--separate`

:   create separate files for each clone. File or pair of `_R1`/`_R2` files, with `_clnN` suffix, where N is clone index, will be created for each clone index


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