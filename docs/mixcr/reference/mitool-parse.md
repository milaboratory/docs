# `mitool parse`

Parse a given pattern in FASTQ file.

Usage: 

```shell
mitool parse [OPTIONS] [SOURCE]... DESTINATION
```

Arguments:

`<SOURCE>`
: Input `*.fastq` or `*.fastq.gz` files. Use "{{n}}" if you want to concatenate files from multiple lines.
    !!! note "Example"
        `my_file_L{{n}}_R1.fastq.gz my_file_L{{n}}_R2.fastq.gz`

`<DESTINATION>`
: Output `*.mic` file.

Options:

`--pattern <VALUE>`
: Pattern to parse against

`--pattern-file <VALUE>`
: Load pattern from file

`--preset <VALUE>`
: Load pattern and other options from built-in pattern library using a specific preset name, this also implies different
default settings for other steps executed for the output file.

`--threads <INT>`
: Number of processing threads

`-u, --unstranded`
: If paired-end input is used, determines whether to try all combinations of mate-pairs or only match reads to the 
corresponding pattern sections (i.e. first file to first section, etc...)

`-n, --limit <INT>`
: Limit number of reads

`-b, --max-error-budget <FLOAT>` (*default*: `10.0` or from preset)
: Maximal bit budget, higher values allows more substitutions in small letters.

`--unmatched <PATH>`
: File(s) to write reads that were not matched against the pattern. Specify this option the same number of times as 
there are input reads.

`-r, --report <PATH>`
: Human readable report file. If file already exists, it will be overwritten.

`-h, --help`
: Show this message and exit

