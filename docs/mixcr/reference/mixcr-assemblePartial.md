# `mixcr assemblePartial`

Overlaps alignments coming from the same molecule which partially cover CDR3 regions:

![img.png](pics/assemblePartial.svg)

This step is used in two cases:

- non targeted RNA-Seq data where there is only a tiny fraction of TCR/BCR reads and this step allows to resque more informative data from the input
- fragmented TCR/BCR data from e.g. 10x VDJ protocols, where each read covers random part of VDJ region 

In order to efficiently extract repertoire from such data one have to reconstruct initial CDR3s from fragments scattered all over the initial sequencing dataset. 

Depending on whether the initial data have or not have UMI and cell-barcodes MiXCR uses either sufficient part of NDN region (which gives high enough entropy) or, in addition to NDN, UMI and cell barcodes to find pairs of alignments derived from the same molecule. Once determined such pairs MiXCR aggregates them in a single alignment fully covering `CDR3` region.  Default thresholds in this procedure were [optimized](https://www.nature.com/articles/nbt.3979) to assemble as many contigs as possible while producing zero false overlaps.


To use `assemblePartial` step one has to specify the following parameters for [`align`](./mixcr-align.md):

```
mixcr align \
    -OallowPartialAlignments=true \
    -OallowNoCDR3PartAlignments=true \
    [-p rna-seq]
    [-OvParameters.geneFeatureToAlign=VGeneWithP] \
    input_R1.fastq[.gz] [input_R2.fastq[.gz]]
    alignments.vdjca
```

where

`-OallowPartialAlignments=true` and `-OallowNoCDR3PartAlignments=true`
: required to prevent MiXCR from filtering out partial alignments, that don’t fully cover CDR3 (the default behaviour)

`-p rna-seq`
: must be used  required if the data has non-enriched RNA-Seq origin

`-OvParameters.geneFeatureToAlign=VGeneWithP`
: is required if data has a genomic origin


## Command line options

```
mixcr assemblePartial [-f]
    [--cell-level] 
    [--drop-partial]
    [--overlapped-only] 
    [--report <reportFile>]
    [--json-report <jsonReport>] 
    [-O <String=String>]...
    alignments.vdjca
    alignments_corrected.vdjca
```
It takes a single `.vdjca` file containing initial alignments as input and writes new `.vdjca` file with corrected alignments. Sometimes it may be useful to inspect resulting alignments with [`exportAlignmentsPretty`](./mixcr-exportPretty.md#raw-alignments). Additionally, MiXCR produces a comprehensive [report](./report-assemblePartial.md) which provides a detailed summary of each stage of this partial assembly pipeline. 

`-f, --force-overwrite`
: Force overwrite of output file(s).

`--cell-level`
: Overlap sequences on the cell level instead of UMIs for tagged data with molecular and cell barcodes

`-d, --drop-partial`
: Drop partial sequences which were not assembled. Can be used to reduce output file size if no additional rounds of 
`assemblePartial` are required.

`-o, --overlapped-only`
: Write only overlapped sequences (needed for testing).

`-r, --report <reportFile>`
: Report file (human readable version, see -j / --json-report for machine readable report)

`-j, --json-report <jsonReport>`
: JSON formatted report file

`-O  <String=String>`
: Overrides default [partial assembler parameter](#partial-assembler-parameters) values.

## Partial assembler parameters

The following options are available for `assemblePartial`:

`-OkValue=12`
: Length of k-mer taken from VJ junction region and used for searching potentially overlapping sequences.

`-OkOffset=-7`
: Offset taken from [`VEndTrimmed`/`JBeginTrimmed`](geneFeatures.md)

`-OminimalAssembleOverlap=12`
: Minimal length of the overlapped VJ region: two sequences can be potentially merged only if they have at least `minimalAssembleOverlap`-wide overlap in the VJJunction region. No mismatches are allowed in the overlapped region.

`-OminimalNOverlap=5`
: Minimal number of non-template nucleotides (N region) that overlap region must cover to accept the overlap.

Example usage:
```shell
> mixcr assemblePartial -OminimalAssembleOverlap=10 alignments.vdjca alignmentsRescued.vdjca
```

## Multiple runs

Partial assembly algorithm works in a pairwise manner, aggregating a pair of alignments at a time. Sometimes the efficiency is increased if you perform two consecutive rounds of `assembplePartial`.

```
> mixcr assemblePartial alignments.vdjca alignments_rescued_1.vdjca
> mixcr assemblePartial alignments_rescued_1.vdjca alignments_rescued_2.vdjca
```

## Very short reads

In case of short reads input, even after `assemblePartial` some contigs/reads still only partially cover `CDR3`. A substantial fraction of such contigs needs only several nucleotides on the 5’ or the 3’ end to fill up the sequence up to a complete `CDR3`. These sequence parts can be taken from the germline, if corresponding V or J gene for the contig is uniquely determined (e.g. from second mate of a read pair). Such procedure is not safe for IGs, because of hypermutations, but for TCRs which have relatively conservative sequence near conserved Cys and Phe/Trp, it can reconstruct additional clonotypes with relatively small chance to introduce false ones. Described procedure is implemented in the [`mixcr extend`](mixcr-extend.md) action, by default it acts only on TCR sequences.
