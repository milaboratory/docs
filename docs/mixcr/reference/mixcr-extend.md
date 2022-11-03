# `mixcr extend`

Imputes germline sequences to the uncovered edges of CDR3, if corresponding V or J gene for is uniquely determined (e.g. from the second mate of a read pair).

![extend.svg](pics/extend-light.svg#only-light)
![extend.svg](pics/extend-dark.svg#only-dark)

This procedure is typically used as a part of non-targeted RNA-Seq analysis pipeline for T-cells, to recover some of useful TCRs. It is not safe to use it for IGs, because of hypermutations. Tor TCRs which have relatively conservative sequence near conserved Cys and Phe/Trp, it can reconstruct additional clonotypes with relatively small chance to
introduce false ones. Default parameters are specifically optimized to show [zero false-positive rate](https://www.nature.com/articles/nbt.3979#Sec1). By default `mixcr extend` acts only on TCR sequences.

## Command line options

```
mixcr extend 
    [--v-anchor <anchor_point>] 
    [--j-anchor <anchor_point>] 
    [--min-v-score <n>] 
    [--min-j-score <n>] 
    [--chains <chains>] 
    [--quality <n>] 
    [--report <path>] 
    [--json-report <path>] 
    [--threads <n>] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help]
    data.(vdjca|clns|clna) extendeed.(vdjca|clns|clna)
```

The command takes alignments (`.vdjca`) or clones (`.clnx`) file as input and produces the same format as output. Additionally, it produces a comprehensive [report](./report-extend.md).

Basic command line options are:

`data.(vdjca|clns|clna)`
: Path to input file.

`extendeed.(vdjca|clns|clna)`
: Path where to write output. Will have the same file type.

`--v-anchor <anchor_point>`
: V extension [anchor point](./ref-gene-features.md). Default value determined by the preset.

`--j-anchor <anchor_point>`
: J extension [anchor point](./ref-gene-features.md). Default value determined by the preset.

`--min-v-score <n>`
: Minimal V hit score to perform left extension. Default value determined by the preset.

`--min-j-score <n>`
: Minimal J hit score to perform right extension. Default value determined by the preset.

`-c, --chains <chains>`
: Apply procedure only to alignments with specific immunological-receptor chains. Default: TCR

`-q, --quality <n>`
: Quality score value to assign imputed sequences. Default: 30

`-r, --report <path>`
: [Report](./report-extend.md) file (human readable version, see `-j / --json-report` for machine readable report).

`-j, --json-report <path>`
: JSON formatted [report](./report-extend.md) file.

`-t, --threads <n>`
: Processing threads

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.
