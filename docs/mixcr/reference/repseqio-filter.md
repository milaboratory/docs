# `repseqio filter`

Filters libraries and library records.

Usage:

```
repseqio filter [-f] \
    [--chain <chain>] \
    [--species <species>] \
    [--taxon-id <id>] \
    input_library.json[.gz] output_library.json[.gz]
```

`-f, --force` (*default*: false)
: Force overwrite of output file(s).

`-c, --chain`
: Chain pattern, regexp string, all genes with matching chain record will be collected.

`-s, --species <species>`
: Species name, used in the same way as `--taxon-id`.

`-t, --taxon-id <id>`
: Taxon id (filter multi-library file to leave single library for specified taxon id)