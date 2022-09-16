# `mixcr assembleContigs`

Assembles longest possible TCR/Ig receptor contig sequences.

![img.png](pics/assembleContigs.svg)

This step may be used in the following cases:

- for non-enriched RNA-Seq (shotgun) data in order to reconstruct the longest possible VDJ contigs
- for single-cell fragmented libraries (like 10x Genomics) to assemble full V-D-J consensus sequences in each cell
- for poor quality targeted amplicon data with no UMI barcodes and with a high rates of sequencing and PCR errors in order to build full-length (or as long as possible) V-D-J contigs using consensus algorithms

In the first two cases the data is fragmented, reads do not have a fixed position on the reference, so it's not possible to specify a fixed [`assemblingFeature`](./mixcr-assemble.md#core-assembler-parameters). MiXCR uses alignment-guided assembly algorithms to build the full-length consensus V-D-J sequence.

In the last case of poor quality targeted libraries, though the exact assembling feature may be known in advance, high mutation rate may lead to the situation when there aren't any true (error-free) full-length V-D-J sequences in the data. Error correction algorithms used in [clonotype assembly](./mixcr-assemble.md) will not have any "anchor" sequence to determine the original clone. In this case we might benefit from assembling clonotypes by CDR3 region at first and then use a consensus algorithm to determine true clones and distinguish errors from hypermutations.

The algorithm iterates through alignments that were used to build a particular clonotype, and aggregates information per each position in V-D-J reference. It takes into account cell barcodes (if present) to assembly full-length contigs inside cells. It also takes care of hypermutations and splits clonotypes into hypermutated variants (see `-OsubCloningRegion` [option](#full-sequence-assembler-parameters)).

Note that since `assembleContigs` uses original alignments, it takes `.clna` (clones & alignments) file as input, produced by [`assemble`](./mixcr-assemble.md) command with option `--write-alignments`.

## Command line options

```
mixcr assembleContigs [-f] [-t <threads>]
    [--ignore-tags]
    [--report <reportFile>]
    [--json-report <jsonReport>]
    [-O <String=String>]...
    clonotypes.clna
    clonotypes.clns
```

The command returns a highly-compressed, memory- and CPU-efficient binary `.clns` file that holds exhaustive information on consensus clonotype contigs. Clonotype table may be further extracted in a human-readable form using [`exportClonesPretty`](./mixcr-exportPretty.md#clonotypes) or in a tabular form using [`exportClones`](./mixcr-export.md#clonotype-tables). It is also possible to [impute](./mixcr-export.md#export-contigs-with-imputation) uncovered V-D-J contig parts from germline (marking such nucleotides lowercase). Additionally, MiXCR produces a comprehensive [report](./report-assembleContigs.md).

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-t, --threads <threads>`
: Processing threads

`--ignore-tags`
: Ignore tags (UMIs, cell-barcodes)

`-r, --report <reportFile>`
: [Report](./report-assembleContigs.md) file (human-readable version, see `-j / --json-report` for a machine-readable report)

`-j, --json-report <jsonReport>`
: JSON formatted [report](./report-assembleContigs.md) file

`-O<String=String>`
: Overrides default parameter values.

## Example

Here is the typical workflow for full receptor assembly of e.g. mouse B-cells.

Align raw sequences using [kAligner2](./mixcr-align.md#v-j-and-c-aligners-parameters) specifically designed to work with highly mutated data:

```shell
> mixcr align \
    --species mmu \
    -p kAligner2 \
    --report report.txt \
    input_R1.fq \
    input_R2.fq \
    alignments.vdjca
```

Assemble default CDR3 clonotypes (note: `--write-alignments` is required for further contig assembly):

```shell
> mixcr assemble \
    -OassemblingFeatures=CDR3 \
    --write-alignments \
    --report report.txt \
    alignments.vdjca \
    clones.clna
```

Assembly full BCR receptor consensus sequences and clonotype into hypermutated variants:

```shell
> mixcr assembleContigs \
    --report report.txt \
    -OsubCloningRegion=VDJRegion \
    clones.clna \
    contigs.clns
```

Export full BCR receptors sequences and [impute](./mixcr-export.md#export-contigs-with-imputation) uncovered regions from germline (marked lowercase):

```shell
mixcr exportClones \
    --chains IG \
    --preset fullImputed \
    contigs.clns \
    contigs.tsv
```

## Full sequence assembler parameters

Full sequence assembler parameters that may be tuned:

`-OsubCloningRegion=null`
: Region where clonotype variants are allowed (typically that are hypermutated variants); `null` stands for no variants allowed (one consensus per one clone)

`-(minimalContigLength=20`
: Minimal contiguous sequence length

`-OalignedRegionsOnly=false`
: Assemble only parts of sequences covered by alignments

`-ObranchingMinimalQualityShare=0.1`
: Minimal quality fraction (variant may be marked significant if variantQuality > totalSumQuality * branchingMinimalQualityShare

`-ObranchingMinimalSumQuality=80`
: Minimal variant quality threshold (variant may be marked significant if variantQuality > branchingMinimalSumQuality

`-OdecisiveBranchingSumQualityThreshold=120`
: Variant quality that guaranties that variant will be marked significant (even if other criteria are not satisfied)

`-OoutputMinimalQualityShare=0.5`
: Positions having quality share less then this value, will not be represented in the output

`-OoutputMinimalSumQuality=50`
: Positions having sum quality less then this value, will not be represented in the output

`-OalignedSequenceEdgeDelta=3`
: Maximal number of not aligned nucleotides at the edge of sequence so that sequence is still considered aligned “to the end”

`-OalignmentEdgeRegionSize=7`
: Number of nucleotides at the edges of alignments (with almost fully aligned seq2) that are “not trusted”

`-OminimalNonEdgePointsFraction=0.25`
: Minimal fraction of non-edge points in variant that must be reached to consider the variant significant
