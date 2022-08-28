# `repseqio inferPoints`

Try to infer anchor point positions from gene sequences of other libraries. If no reference libraries are specified, built-in library will be used.

Usage: 
```
repseqio inferPoints [-f] \
    [--gene-feature <geneFeature>] \
    [--min-score <score>] \
    [--name <name>] \
    [--only-modified] \
    input_library.json \
    [reference_library1.json [reference_library2.json [....]]] \
    output.json
```

Options:

`-f, --force`
: Force overwrite of output file(s). 

`-g, --gene-feature <geneFeature>`
: Reference gene feature to use (e.g. `VRegion`, `JRegion`, `VTranscript`, etc...). This feature will be used to align target genes with reference genes. Target genes must have this gene feature. This option can be used several times, to specify several target gene features. Inference will be performed in order options are specified.

`-m, --min-score <score>`
: Absolute minimal score. Alignment is performed using amino acid sequences (target is queried using all three reading frames) using BLOSUM62 matrix. Default for V gene is 200 and for J gene is 50. 

`-n, --name <name>`
: Gene name pattern, regexp string, all genes with matching gene name will be exported.

`-o, --only-modified`
: Output only modified records.
