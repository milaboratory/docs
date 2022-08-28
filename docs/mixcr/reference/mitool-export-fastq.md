# `mitool export-fastq`

Export sequences from `mic` file into a FASTQ formatted file. Allows to export sequences with different tags into separate
FASTQ files.

Usage: 

```shell
mitool export-fastq [OPTIONS] SOURCE
```
Arguments:

`SOURCE`
: Input `*.mic` file

Options:

`-O <VALUE>`
: Tag names to output file names mapping (i.e. `-OUMI=my_file.fastq.gz` or `-OR1=my_R1.fastq.gz`)

`-t, --header-tag <TEXT>`  
: Will add the sequence and quality score lines of the corresponding tags to the header line of exported fastq records

`-h, --help`
: Show this message and exit

