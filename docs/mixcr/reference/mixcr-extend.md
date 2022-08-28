# `mixcr extend`

Imputes germline sequences to the uncovered edges of CDR3, if corresponding V or J gene for is uniquely determined (e.g. from the second mate of a read pair).

![extend.svg](pics/extend.svg)

This procedure is typically used as a part of non-targeted RNA-Seq analysis pipeline for T-cells, to recover some of useful TCRs. It is not safe to use it for IGs, because of hypermutations. Tor TCRs which have relatively conservative sequence near conserved Cys and Phe/Trp, it can reconstruct additional clonotypes with relatively small chance to
introduce false ones. Default parameters are specifically optimized to show [zero false-positive rate](https://www.nature.com/articles/nbt.3979#Sec1). By default `mixcr extend` acts only on TCR sequences.

## Command line options

```
mixcr extend [-f] [-t <threads>]
    [--chains <chains>]
    [--report <reportFile>]
    [--json-report <jsonReport>]
    [--v-anchor <vAnchorPoint>]
    [--j-anchor <jAnchorPoint>]
    [--quality <extensionQuality>]
    [--min-j-score <minimalJScore>]
    [--min-v-score <minimalVScore>]
    input.(vdjca|clns|clna)
    extended.(vdjca|clns|clna)
```

The command takes alignments (`.vdjca`) or clones (`.clnx`) file as input and produces the same format as output. Additionally, it produces a comprehensive [report](./report-extend.md).

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-t, --threads <threads>`
: Processing threads

`-c, --chains <chains>`
: Apply procedure only to alignments with specific immunological receptor chains (`TCR` by default).

`-r, --report <reportFile>`
: [Report](./report-extend.md) file (human readable version, see -j / --json-report for machine readable report)

`-j, --json-report <jsonReport>`
: JSON formatted [report](./report-extend.md) file

`--v-anchor`
: V extension [anchor point](./ref-gene-features.md)  (default: `CDR3Begin`).

`--j-anchor`
: J extension [anchor point](./ref-gene-features.md) (default: `CDR3End`).

`-q, --quality`
: Quality score of extended sequence (default: `30`).

`--min-v-score`
: Minimal V hit score to perform left extension (default: `100`).

`--min-j-score`
: Minimal J hit score alignment to perform right extension (default: `70`).