# `repseqio fasta`

Exports sequences of genes to fasta file.

Usage: 
```
repseqio fasta [-f] \
    [--chain <chain>] \
    [--gene-feature <geneFeature>] \
    [--imgt] \
    [--name <regexp>] \
    [--species <species>] \
    [--taxon-id <id>] \
    input_library.json|default \
    [output.fasta]
```

Command line options:

`-f, --force` (*default*: does not overwrite)
: Force overwrite of output file(s).

`-c, --chain <chain>`
: Chain pattern, regexp string, all genes with matching chain record will be exported.

`-g, --gene-feature <geneFeature>`
: Gene feature to export (e.g. `VRegion`, `JRegion`, `VTranscript`,  etc...)

`--imgt`
: Format output similar to IMGT's reference (add IMGT gaps, similar header structure))

`-n, --name <regexp>`
: Gene name pattern, regexp string, all genes with matching gene name will be exported.

`-s, --species <species>`
: Species name, used in the same way as `--taxon-id`.

`-t, --taxon-id <id>`
: Taxon id (filter multi-library file to leave single library for specified taxon id)