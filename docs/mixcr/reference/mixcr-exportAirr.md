# `mixcr exportAirr`

Exports alignments from `.vdjca` file or clonotypes from `.clns`/`.clna` files in [AIRR format](https://docs.airr-community.org/en/stable/datarep/rearrangements.html).

```
mixcr exportAirr 
    [--target <n>] 
    [--imgt-gaps] 
    [--from-alignment] 
    [--limit <n>] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help]
    input.(vdjca|clna|clns) [output.tsv]
```

Command line options:

`input_file.(vdjca|clna|clns)`
: Path to input file

`[output.tsv]`
: Path where to write export. Will write to output if omitted.

`-t, --target <n>`
: Target id (use -1 to export from the target containing CDR3).

`-g, --imgt-gaps`
: If this option is specified, alignment fields will be padded with IMGT-style gaps.

`-a, --from-alignment`
: Get fields like fwr1, cdr2, etc.. from alignment.

`-n, --limit <n>`
: Limit number of filtered alignments; no more than N alignments will be outputted

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

For some downstream analysis tools one also should prepare gapped reference using `--imgt` option for [repseqio](./repseqio-fasta.md):

```shell
# from built-in MiXCR reference
> repseqio fasta --imgt \
    --species hs \
    -g 'VRegion' \
    default \
    vregion_gapped.fasta

# from IMGT reference
> repseqio fasta --imgt \
    --species hs \
    -g 'VRegion' \
    imgt.202209-1.sv7.json.gz \
    vregion_gapped.fasta
```
