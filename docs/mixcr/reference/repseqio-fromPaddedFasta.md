# `repseqio fromPaddedFasta`

Converts library from padded `fasta` file (IMGT-like) to json library. This command can operate in two modes:

1. if three input files are specified, it will create separate non-padded `fasta` and put links inside newly created library pointing to it.

2. if 2 input files are specified, it will create only library file, and embed sequences directly  into it.
 
To use library generated using mode (1) one need both output files, (see also [repseqio compile](repseqio-compile.md)). If library is intended for further editing and/or submission to version control system option (1) is recommended.

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

`-c, --chain <chain>`
: Chain.
  
`-j, --functionality-index <index>`
: Functionality mark index (0-based) in `|`-separated FASTA  description line (e.g. 3 for IMGT files). If this option is omitted, all genes are considered functional.
  
`--functionality-regexp <regexp>`
: Functionality regexp, gene is considered functional if field defined by -j / --functionality-index parameter matches this expression. Default: `[\(\[]?[Ff].?`.

`--gene-feature <geneFeature>`
: Defines gene feature which sequences are contained in the file(e.g. `VRegion`, `VGene`, `JRegion` etc..).

`-g, --gene-type <gt>`
: Gene type (V/D/J/C)

`-i, --ignore-duplicates`
: Ignore duplicate genes. Default behavior: duplicates are not ignored.

`-n, --name-index <index>`
: Gene name index (0-based) in `|`-separated FASTA description line(e.g. 1 for IMGT files). Default is `0`.

`-p, --padding-character <char>`
: Padding character. Default: `.`.

`-s, --species-name <species>`
: Species names (can be used multiple times)

`-t, --taxon-id <id>`
: Taxon id

`-L`
: Amino-acid pattern of anchor point. Has higher priority than `-P` for the same anchor point. Syntax is `-Lkey=value`.

`-P`
: Positions of anchor points in padded / non-padded file. To define position relative to the end of sequence use negative values: -1 = sequence end, -2 = last but one letter. Example: `-PFR1Begin=0  -PVEnd=-1` , equivalent of `--gene-feature VRegion`.