# `mixcr exportAirr`

Exports alignments from `.vdjca` file or clonotypes from `.clns`/`.clna` files in [AIRR format](https://docs.airr-community.org/en/stable/datarep/rearrangements.html).

```
mixcr exportAirr [-f] [-n]
    [--from-alignment]
    [--imgt-gaps]
    [--target]
    input.(vdjca|clns|clna)
    output.tsv
```

Command line options:

`-n`, `--limit`

:   limit number of filtered alignments; no more than N alignments will be outputted

`--from-alignment`, `-a`

:   get fields like fwr1, cdr2, etc.. from alignment

`--imgt-gaps`, `-g`

:   if this option is specified, alignment fields will be padded with IMGT-style gaps.`

`--target <targetId>`, `-t <targetId>`

:   target id (use -1 to export from the target containing CDR3)

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