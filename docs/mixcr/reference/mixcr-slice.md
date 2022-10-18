# `mixcr slice`

Slice vdjca|clns|clna|shmt file.

```
mixcr slice 
    (-i <id> [-i <id>]... | --ids-file <path>) 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    data.(vdjca|clns|clna|shmt) data_sliced.(vdjca|clns|clna|shmt)
```

`data.(vdjca|clns|clna|shmt)`
: Input data to filter by ids

`data_sliced.(vdjca|clns|clna|shmt)`
: Output file with filtered data

`-i, --id <id>`
: List of read (for .vdjca) / clone (for .clns/.clna) / tree (for .shmt) ids to export.

`--ids-file <path>`
: File with list of read (for .vdjca) / clone (for .clns/.clna) / tree (for .shmt) ids to export. Every id on separate line

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.
