# `mixcr groupClones`

Groups clones in .clna/.clns files by Cell tags. Grouped clones can be exported using [`mixcr exportCloneGroups`](./mixcr-export.md#clone-groups-by-cell). 

```
mixcr exportClonesOverlap 
    [--report <path>] 
    [--json-report <path>] 
    [--use-local-temp]
    [--force-overwrite]
    [--no-warnings]
    [--verbose]
    [--help] 
    clones.(clns|clna) 
    grouped.(clns|clna)
```

`clones.(clns|clna)`
: Path to input file.

`grouped.(clns|clna)`
: Path where to write output. Will have the same file type.

`-r, --report <path>`
: Report file (human-readable version, see `-j / --json-report` for machine readable report).

`-j, --json-report <path>`
: JSON formatted report file.

`--use-local-temp`
: Put temporary files in the same folder as the output files.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.
