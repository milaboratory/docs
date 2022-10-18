# `mixcr assemble`

Assembles clonotypes. MiXCR allows to assemble clonotypes by arbitrary [gene features](./ref-gene-features.md). It also applies several layers of error-correction:

 - quality guided error correction to fix sequencing errors and rescue low-quality reads
 - clustering to correct for PCR errors both in case of non-barcoded and UMI-barcoded data
 - specific barcode-guided correction for UMI and single-cell data

![assemble](./pics/assemble-light.svg#only-light)
![assemble](./pics/assemble-dark.svg#only-dark)

Briefly, assemble pipeline consists of the following steps:

1. Input.
   
    Assembler sequentially processes records (aligned reads) from input `.vdjca` file produced by [`align`](./mixcr-align.md).

2. Pre-clone assembler.

    If data have barcodes, MiXCR aggregates alignments with same barcode values in groups and assembly consensus "pre-clones" using special [consensus algorithms](./mitool-consensus.md). Note that there may be several consensus pre-clones for a single barcode.

3. Core assembler.

    Core assembler tries to extract gene feature sequences (clonal sequence) from pre-clones or aligned reads (for non-barcoded data) specified by `assemblingFeatures` parameter (`CDR3` by default); the clonotypes are assembled with respect to clonal sequence. If aligned read does not contain clonal sequence (e.g. `CDR3` region), it will be dropped. If clonal sequence contains at least one nucleotide with low quality (less than `badQualityThreshold` parameter value), then this record will be deferred for further processing by mapping procedure. If fraction of low quality nucleotides in deferred record is greater than `maxBadPointsPercent` parameter value, then this record will be finally dropped. Records with clonal sequence containing only good quality nucleotides are used to build core clonotypes by grouping records by equality of clonal sequences (e.g. CDR3). The sequence quality of the resulting core clonotype will be equal to the total of qualities of the assembled reads. Each core clonotype has two main properties: clonal sequence and `count` — a number of records aggregated by this clonotype.

4. Sequencing errors correction (mapping).

    After the core clonotypes are built, MiXCR runs _mapping procedure_ that processes records deferred on the previous step. Mapping is aimed at rescuing of quantitative information from low quality reads. For this, each deferred record is mapped onto already assembled clonotypes: if there is a fuzzy match, then this record will be aggregated by the corresponding clonotype; in case of several matched clonotypes, a single one will be randomly chosen with weights equal to clonotype counts. If no matches found, the record will be finally dropped.

5. Pre-clustering. 

    Pre-clustering is performed if `separateByV`, `separateByJ` or `separateByC` is true. Clones with the same `assemblingFeature` that were previously split due to the erroneous `separateBy` segment sequence are aggregated back together.

6. PCR error correction (clustering).

    After clonotypes are assembled by pre-clone assembler, initial assembler and mapper, MiXCR proceeds to *clustering*. The clustering algorithm tries to find fuzzy matches between clonotypes and organize matched clonotypes in hierarchical tree (*cluster*), where each child layer is highly similar to its parent but has significantly smaller `count`. Thus, clonotypes with small counts will be attached to highly similar "parent" clonotypes with significantly greater count. After all clusters are built, only their heads are considered as final clones. The maximal depths of cluster, fuzzy matching criteria, relative counts of parent/childs and other parameters can be customized using `clusteringStrategy` parameters described below.

7. Alignment refining.

    Finally, MiXCR re-aligns clonal sequences to reference V,D,J and C genes using classical strict alignment algorithms (variants of classical Smith-Waterman and Needleman–Wunsch algorithms). Compared to [k-aligners](./mixcr-align.md#aligner-parameters) these algorithms does not have source of randomness and guarantee best result.   


In case of single-cell data MiXCR also assembles paired B-cell heavy/light and T-cell alpha/beta clonotypes.

![assembleSingleCell](./pics/assembleSingleCell-light.svg#only-light)
![assembleSingleCell](./pics/assembleSingleCell-dark.svg#only-dark)

## Command line options

```
mixcr assemble 
    [--write-alignments] 
    [--cell-level] 
    [--sort-by-sequence] 
    [--dont-infer-threshold] 
    [--high-compression] 
    [--assemble-clonotypes-by <gene_features>] 
    [--split-clones-by <gene_type>]... 
    [--dont-split-clones-by <gene_type>]... 
    [-O <key=value>]... 
    [-P <key=value>]... 
    [--report <path>] 
    [--json-report <path>] 
    [--use-local-temp] 
    [--force-overwrite] 
    [--no-warnings]
    [--verbose] 
    [--help]
    alignments.vdjca clones.[clns|clna]
```
The command returns a highly-compressed, memory- and CPU-efficient binary `.clns` (clones) or `.clna` (clones & alignments) file that holds exhaustive information about clonotypes. Clonotype tables can be further extracted in tabular form using [`exportClones`](./mixcr-export.md#clonotype-tables) or in human-readable form using [`exportClonesPretty`](./mixcr-exportPretty.md#clonotypes). Additionally, MiXCR produces a comprehensive [report](./report-assemble.md) which provides a detailed summary of each stage of assembly pipeline.

Basic command line options are:

`alignments.vdjca`
: Path to input file with alignments.

`clones.[clns|clna]`
: Path where to write assembled clones.

`-a, --write-alignments`
: If this option is specified, output file will be written in "Clones & Alignments" `.clna` format, containing clones and all corresponding alignments. This file then can be used to build [wider contigs](./mixcr-assembleContigs.md) for clonal sequence or [extract original reads](./mixcr-exportReadsForClones.md) for each clone (if -OsaveOriginalReads=true was use on 'align' stage). Default value determined by the preset.

`--cell-level`
: If tags are present, do assemble pre-clones on the cell level rather than on the molecular level. If there are no molecular tags in the data, but cell tags are present, this option will be used by default. This option has no effect on the data without tags. Default value determined by the preset.

`-s, --sort-by-sequence`
: Sort by sequence. Clones in the output file will be sorted by clonal sequence,which allows to build overlaps between clonesets. Default value determined by the preset.

`--dont-infer-threshold`
: Turns off automatic inference of minRecordsPerConsensus parameter.  Default value determined by the preset.

`--split-clones-by <gene_type>`
: Clones with equal clonal sequence but different gene will not be merged.

`--assemble-clonotypes-by <gene_features>`
: Specify gene features used to assemble clonotypes. One may specify any custom gene region (e.g. `FR3+CDR3`); target clonal sequence can even be disjoint. Note that `assemblingFeatures` must cover CDR3

`--dont-split-clones-by <gene_type>`
: Clones with equal clonal sequence but different gene will be merged into single clone.

`--high-compression`
: Use higher compression for output file.

`-O  <key=value>`
: Overrides default parameter values.

`-P  <key=value>`
: Overrides default pre-clone assembler parameter values.

`-r, --report <path>`
: [Report](./report-assemble.md) file (human readable version, see `-j / --json-report` for machine readable report).

`-j, --json-report <path>`
: JSON formatted [report](./report-assemble.md) file.

`--use-local-temp`
: Store temp files in the same folder as output file.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

## Pre-clone assembler parameters

Pre-clone assembler parameters tunes the behavior of consensus algorithms and error correction for UMI-barcoded and single-cell data. There is one global parameter: 

`-PminTagSuffixShare`
: Only pre-clones having at least this share among reads with the same tag suffix will be preserved. This option is useful when assembling consensuses inside cell groups, but still want to decontaminate results using molecular barcodes.

A group of `-Passembler.*` parameters is used for pre-assemble clone assembling feature sequence inside read groups having the same tags:

`-Passembler.maxIterations`
: Maximal number of iterations for reference refinement.

`-Passembler.minAltSeedQualityScore`
: Minimal quality score for all positions for the sequence to be used as an alternative seed (main seed sequence may have lower quality score)

`-Passembler.minAltSeedNormalizedPenalty`
: Minimal normalized penalty (as in distance) that must be reached relative to all current consensuses by the record to form a new seed.

`-Passembler.altSeedPenaltyTolerance`
: How far in relative terms to step back from the farthest record to search for the best alternative seed. Higher number (1.0 being maximal) widens the set of records among which the search is performed.

`-Passembler.minRecordSharePerConsensus`
: Minimal share of records (from whole number of records) assembled into a consensus for the consensus to be considered viable

`-Passembler.minRecordsPerConsensus`
: Minimal number of records for single consensus

`-Passembler.minRecursiveRecordShare`
: Minimal share of records assembled into a consensus, from records left after removal of all more abundant consensuses for the consensus to be considered viable

`-Passembler.minQualityScore`
: Final consensuses having positions with lower quality scores will be discarded

`-Passembler.maxConsensuses`
: Maximum number of consensuses to assemble


Group of `-Passembler.aAssemblerParameters.*` parameters used for consensus assembly:

`-Passembler.aAssemblerParameters.bandWidth`
: Effective number of indels the procedure can correctly process

`-Passembler.aAssemblerParameters.scoring.type`
: Alignment scoring type. Possible values: `linear`, `affine`

`-Passembler.aAssemblerParameters.scoring.subsMatrix`
: Substitution matrix. Available types:

    - `simple` - a matrix with diagonal elements equal to `match` and other elements equal to `mismatch`
    - `raw` - a complete set of 16 matrix elements should be specified;  for  example: 
    `raw(5,-9,-9,-9,-9,5,-9,-9,-9,-9,5,-9,-9,-9,-9,5)`(*equivalent to the  default value*)

`-Passembler.aAssemblerParameters.scoring.gapPenalty`
: Penalty for a gap for `linear` scoring.

`-Passembler.aAssemblerParameters.scoring.gapOpenPenalty`
: Penalty for a gap open for `affine` scoring.

`-Passembler.aAssemblerParameters.scoring.gapExtensionPenalty`
: Penalty for a gap extension for `affine` scoring.

`-Passembler.aAssemblerParameters.minAlignmentScore`
: Records aligned with score less than this threshold will not be used for consensus assembly

`-Passembler.aAssemblerParameters.maxNormalizedAlignmentPenalty`
: Maximal delta from the maximum possible alignment score divided by max score. Records aligned with higher penalty will not be used for consensus assembly. Bigger positive values of this parameter allows worse alignments to be accepted.

`-Passembler.aAssemblerParameters.trimMinimalSumQuality`
: Minimal sum quality for a particular variant threshold used to trim regions with low coverage from the sides

`-Passembler.aAssemblerParameters.trimReferenceRegion`
: If true, trimming will also be applied to the reference region

`-Passembler.aAssemblerParameters.maxQuality`
: Maximal quality score value for the assembled consensus


Default values for these parameters are different depending whether `--cell-level` option is specified or not.

??? note "Show default values"
    === "with --cell-level"
        ```json
        {
          "assembler": {
            "aAssemblerParameters": {
              "bandWidth": 4,
              "scoring": {
                "type": "linear",
                "alphabet": "nucleotide",
                "subsMatrix": "simple(match = 5, mismatch = -4)",
                "gapPenalty": -14
              },
              "minAlignmentScore": 40,
              "maxNormalizedAlignmentPenalty": 0.15,
              "trimMinimalSumQuality": 0,
              "trimReferenceRegion": false,
              "maxQuality": 45
            },
            "maxIterations": 6,
            "minAltSeedQualityScore": 11,
            "minAltSeedNormalizedPenalty": 0.35,
            "altSeedPenaltyTolerance": 0.3,
            "minRecordSharePerConsensus": 0.01,
            "minRecordsPerConsensus": 1,
            "minRecursiveRecordShare": 0.2,
            "minQualityScore": 0,
            "maxConsensuses": 0
          },
          "minTagSuffixShare": 0.8
        }
        ```
    === "without --cell-level"
        ```json
        {
          "assembler": {
            "aAssemblerParameters": {
              "bandWidth": 4,
              "scoring": {
                "type": "linear",
                "alphabet": "nucleotide",
                "subsMatrix": "simple(match = 5, mismatch = -4)",
                "gapPenalty": -14
              },
              "minAlignmentScore": 40,
              "maxNormalizedAlignmentPenalty": 0.15,
              "trimMinimalSumQuality": 0,
              "trimReferenceRegion": false,
              "maxQuality": 45
            },
            "maxIterations": 6,
            "minAltSeedQualityScore": 11,
            "minAltSeedNormalizedPenalty": 0.35,
            "altSeedPenaltyTolerance": 0.3,
            "minRecordSharePerConsensus": 0.2,
            "minRecordsPerConsensus": 1,
            "minRecursiveRecordShare": 0.4,
            "minQualityScore": 0,
            "maxConsensuses": 3
          },
          "minTagSuffixShare": 0.0
        }
        ```

## Core assembler parameters

Basic core [assembler parameters](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/parameters/assembler_parameters.json) are:

`-OassemblingFeatures=CDR3`
: Specify [gene feature](./ref-gene-features.md) used to assemble clonotypes. One may specify any custom gene region (e.g. `FR3+CDR3`); target clonal sequence can even be disjoint. Note that `assemblingFeatures` must cover CDR3. Example:
    
    ```shell
      > mixcr assemble -OassemblingFeatures="[V5UTR+L1+L2+FR1,FR3+CDR3]" alignments.vdjca output.clns
    ```

`-OminimalClonalSequenceLength=12`
: Minimal length of clonal sequence

`-ObadQualityThreshold=20`
: Minimal value of sequencing quality score: nucleotides with lower quality are considered as "bad". If sequencing read contains at least one "bad" nucleotide within the target gene region, it will be deferred at initial assembling stage, for further processing by mapper.

`-OmaxBadPointsPercent=0.7`
: Maximal allowed fraction of "bad" points in sequence: if sequence contains more than `maxBadPointsPercent` "bad" nucleotides, it will be completely dropped and will not be used for further processing by mapper. Sequences with the allowed percent of “bad” points will be mapped to the assembled core clonotypes. Set `-OmaxBadPointsPercent=0` in order to completely drop all sequences that contain at least one "bad" nucleotide.

`-OqualityAggregationType=Max`
: Algorithm used for aggregation of total clonal sequence quality during assembling of sequencing reads. Possible values: `Max` (maximal quality across all reads for each position), `Min` (minimal quality across all reads for each position), `Average` (average quality across all reads for each position), `MiniMax` (all letters has the same quality which is the maximum of minimal quality of clonal sequence in each read).

`-OminimalQuality=0`
: Minimal allowed quality of each nucleotide of assembled clone. If at least one nucleotide in the assembled clone has quality lower than `minimalQuality`, this clone will be dropped (remember that qualities of reads are aggregated according to selected aggregation strategy during core clonotypes assembly; see `qualityAggregationType`).

`-OaddReadsCountOnClustering=false`
: Aggregate cluster counts when assembling final clones: if `addReadsCountOnClustering` is `true`, then all children clone counts will be added to the head clone; thus head clone count will be a total of its initial count and counts of all its children. Refers to further clustering strategy (see below). Does not refer to mapping of low quality sequencing reads described above.

Usage example: turn-off mapping (consider all alignment as good quality)
```shell
> mixcr assemble -ObadQualityThreshold=0 alignments.vdjca output.clns
```

## Pre-clustering parameters

MiXCR can separate clones with equal clonal sequence and different V, J and C (e.g. do distinguish clones with different IG isotype) genes. Additionally, to make analysis more robust to sequencing errors there is an additional pre-clustering step to shrink  artificial diversity generated by this separation mechanism (see `maximalPreClusteringRatio` option).

`-OmaximalPreClusteringRatio=1.0`
: more abundant clone (`clone1`) absorbs smaller clone (`clone2`) if `clone2.count < clone1.count * maximalPreClusteringRatio` (`cloneX.count` denotes number of reads in corresponding clone) and `clone2` contain top V/J/C gene from `clone1` in it’s corresponding gene list.

`-OseparateByV=false`
: if false clones with equal clonal sequence but different V gene will be merged into single clone.

`-OseparateByJ=false`
: if false clones with equal clonal sequence but different J gene will be merged into single clone.

`-OseparateByC=false`
: if false clones with equal clonal sequence but different C gene will be merged into single clone.

Usage example: separate IG clones by isotypes:
```shell
> mixcr assemble -OseparateByC=true alignments.vdjca output.clns
```

## Clustering parameters

Parameters that control clustering procedure and determines the rules for the frequency-based correction of PCR and sequencing errors:

`-OcloneClusteringParameters.searchDepth=2`
: Maximum number of cluster layers (not including head).

`-OcloneClusteringParameters.allowedMutationsInNRegions=1`
: Maximum allowed number of mutations in N regions (non-template nucleotides in VD, DJ or VJ junctions): if two fuzzy matched clonal sequences will contain more than `allowedMutationsInNRegions` mismatches in N-regions, they will not be clustered together (one cannot be a direct child of another).

`-OcloneClusteringParameters.searchParameters=twoMismatchesOrIndels`
: Parameters that control fuzzy match criteria between clones in adjacent layers. Available predefined values: `oneMismatch`, `oneIndel`, `oneMismatchOrIndel`, `twoMismatches`, `twoIndels`, `twoMismatchesOrIndels`,  ..., `fourMismatchesOrIndels`. By default, `twoMismatchesOrIndels` allows two mismatches or indels (not more than two errors of both types) between two adjacent clones (parent and direct child).

`-OcloneClusteringParameters.clusteringFilter.specificMutationProbability=1E-3`
: Probability of a single nucleotide mutation in clonal sequence which has non-hypermutation origin (i.e. PCR or sequencing error). This parameter controls relative counts between two clones in adjacent  layers: a smaller clone can be attached to a larger one if its count smaller than count of parent multiplied by `(clonalSequenceLength * specificMutationProbability) ^ numberOfMutations`

Usage example: change maximum allowed number of mutations:
```shell
> mixcr assemble -OcloneClusteringParameters.searchParameters=oneMismatchOrIndel alignments.vdjca output.clns
```

Turn clustering off:
```shell
> mixcr assemble -OcloneClusteringParameters=null alignments.vdjca output.clns
```

## Hardware recommendations

Assembly step is memory consuming. Reading and decompression of `.vdjca` file is handled in parallel and highly efficient way. MiXCR needs amount of RAM sufficient to store clonotype table in memory. In an exterme case of one million of full-length UMI-assembled clonotypes, it is recommended to supply at least 32GB of RAM. Speed almost does not scale with the increase of CPU.
