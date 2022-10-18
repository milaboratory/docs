# `mixcr sortClones`

Sort clones by sequence. Clones in the output file will be sorted by clonal sequence, which allows to build overlaps between clonesets.

```
mixcr sortClones 
    [--use-system-temp] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    clones.(clns|clna) clones.sorted.clns
```

`--use-system-temp`
: Use system temp folder for temporary files, the output folder will be used if this option is omitted.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.
