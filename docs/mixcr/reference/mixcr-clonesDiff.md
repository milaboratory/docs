# `mixcr clonesDiff`

Calculates the difference between two .clns files.

```
mixcr clonesDiff 
    [-v] 
    [-j] 
    [-c] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    input1.clns input2.clns [report.txt]
```

`input1.clns`
: input2.clns

`[report.txt]`
: Path where to write report. Will write to output if omitted.

`-v`
: Use V gene in clone comparison (include it as a clone key along with a clone sequence).

`-j`
: Use J gene in clone comparison (include it as a clone key along with a clone sequence).

`-c`
: Use C gene in clone comparison (include it as a clone key along with a clone sequence).

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.
