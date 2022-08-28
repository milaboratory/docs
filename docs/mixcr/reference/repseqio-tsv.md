# `repseqio tsv`

Export gene region coordinates to `.tsv` file. To output 1-based coordinates add `-1` / `--one-based` option.

Usage: 
```
repseqio tsv [-f] \
    [--chain <chain>] \
    [--gene-feature <geneFeature>] \
    [--name <regex>] \
    [--one-based] \
    [--species <species>] \
    [--taxon-id <id>] \
    input_library.json|default [output.txt]
```

Options:

`-f, --force`
: Force overwrite of output file(s).

`-c, --chain <chain>`
: Chain pattern, regexp string, all genes with matching chain record will be exported.

`-g, --gene-feature <geneFeature>`
: Gene feature(s) to export (e.g. `VRegion`, `JRegion`, `VTranscript`, etc...). To specify several features use this option several times or separate multiple regions with commas.

`-n, --name <regex>`
: Gene name pattern, regexp string, all genes with matching gene name will be exported.

`-1, --one-based`
: Use one-based coordinates instead of zero-based and output inclusive end position. By default, zero-based coordinates are used.

`-s, --species <species>`
: Species name, used in the same way as `--taxon-id`.

`-t, --taxon-id <id>`
: Taxon id (filter multi-library file to leave single library for specified taxon id)