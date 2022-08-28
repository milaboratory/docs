# `repseqio fromFasta`

Creates boilerplate JSON library from existing `fasta` file.

Usage: 
```
repseqio fromPaddedFasta [-f] \
    [--chains <chain>] \
    [--functionality-index <index>] \
    [--functionality-regexp <regexp>] \
    [--gene-feature <geneFeature>] \
    [--gene-type <gt>] \
    [--ignore-duplicates] \
    [--name-index <index>] \
    [--padding-character <char>] \
    [--species-name <species>] \
    [--taxon-id <id>] \
    [-Lkey=value]... \
    [-Pkey=value]... \
    input_padded.fasta \
    [output.fasta] \
    output.json[.gz]
```

Options:

`-f, --force`
: Force overwrite of output file(s).

`-c, --chain`
: Chain

`-j, --functionality-index`
: Functionality mark index (0-based) in `|`-separated FASTA description line (e.g. 3 for IMGT files). If this option is
omitted, all genes are considered functional.

`--functionality-regexp`
: Functionality regexp, gene is considered functional if field defined by `-j` / `--functionality-index` parameter matches this expression. Default: `[\(\[]?[Ff].?`. 

`--gene-feature`
: Defines gene feature which sequences are contained in the file (e.g. `VRegion`, `VGene`, `JRegion` etc..). 

`-g, --gene-type`
: Gene type (V/D/J/C)

`-i, --ignore-duplicates`
: Ignore duplicate genes. By default duplicate genes are not ignored.

`-n, --name-index`
: Gene name index (0-based) in `|`-separated FASTA description line (e.g. 1 for IMGT files). Default: 0.

`-s, --species-name`
: Species names (can be used multiple times). Default: `[]`.

`-t, --taxon-id`
: Taxon id

`-L`
: Amino-acid pattern of anchor point. Has higher priority than `-P` for the same anchor point. The syntax is `-Lkey=value`.

`-P`
: Positions of anchor points in padded / non-padded file. To define position relative to the end of sequence use negative values: -1 = sequence end, -2 = last but one letter. Example: `-PFR1Begin=0  -PVEnd=-1`, equivalent of `--gene-feature VRegion`.

