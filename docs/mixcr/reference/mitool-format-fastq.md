# `mitool format-fastq`

Usage: 

```shell
mitool format-fastq [OPTIONS] SOURCE...
```
Arguments:

`SOURCE`
: Input `*.fastq` or `*.fastq.gz` files

Options:

`-n, --limit <INT>`
: Limit number of output sequences

`-s, --skip <INT>`
: Skip sequences before printing

`-i, --index <INT>`
: Skip sequences before printing

`--read-strand`
: Don't reverse second read in paired-end data

`-h, --help`
: Show this message and exit
