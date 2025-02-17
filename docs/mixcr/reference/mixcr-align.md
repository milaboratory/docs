# `mixcr align`

Aligns raw sequencing data against V-, D-, J- and C- gene segment library database for selected species. For tagged data (molecular / cell / sample barcodes), MiXCR allows to extract tags using powerful [pattern matching syntax](ref-tag-pattern.md) and assign them to every alignment. Tags may be also extracted and assigned to alignments based on [sample sheets](ref-samples-table.md) or directly from the sequencing read headers using regex. Trimming of artificial sequences (primers or adapters) can be done using [tag patterns](ref-tag-pattern.md) before actual alignment happens. Quality-guided read trimming may be applied if corresponding options are used. A powerful [file name expansion](ref-input-file-name-expansion.md) functionality allows to take and process a batch of raw sequencing files at once on the fly and optionally assign molecular, cell and sample barcodes extracted from the file names. [Sample tables](ref-samples-table.md) allow to analyze several patient samples at once using sample barcodes that may be picked up from all possible sources. MiXCR supports paired-end and single-end [`.fastq`](https://en.wikipedia.org/wiki/FASTQ_format), [`.fasta`](https://en.wikipedia.org/wiki/FASTA_format), [`.bam` and `.sam`](https://en.wikipedia.org/wiki/Binary_Alignment_Map) formats.

![](./pics/align-light.svg#only-light)
![](./pics/align-dark.svg#only-dark)

Raw alignments are the basic pieces of information in MiXCR. They are used to assemble clones and reconstruct contigs. Alignments are also used to debug sequencing library and identify wet lab issues.

The aligners are rigorously optimized to take into account a great variety of peculiarities caused by the complex nature of adaptive immunity, different library preparation protocols and various wet lab issues. In most cases, to get maximum of your data one just need to pick up a right preset from the [comprehensive list of available ones](overview-built-in-presets.md). Preset contains all the optimized parameters for the corresponding type of data / protocol. For custom protocols, MiXCR provides a set of high-level parameters allowing to specify the basic library architecture; aligners will use it to automatically fine tune every aspect of the procedure and produce the most precise alignments. One can also access the low level of the aligners and modify any of the hundreds parameters such as various thresholds, scoring matrices, gene alignment algorithm types and others.


## Command line options

```
mixcr align --preset <name> 
    [--trimming-quality-threshold <n>] 
    [--trimming-window-size <n>] 
    [--write-all] 
    [--tag-pattern-file <path>] 
    [--tag-parse-unstranded] 
    [--tag-max-budget <n>] 
    [--read-id-as-cell-tag]
    [--read-buffer <n>] 
    [--high-compression] 
    [--not-aligned-I1 <path.fastq[.gz]>] 
    [--not-aligned-I2 <path.fastq[.gz]>] 
    [--not-aligned-R1 <path.fastq[.gz]>] 
    [--not-aligned-R2 <path.fastq[.gz]>] 
    [--not-parsed-I1 <path.fastq[.gz]>] 
    [--not-parsed-I2 <path.fastq[.gz]>] 
    [--not-parsed-R1 <path.fastq[.gz]>] 
    [--not-parsed-R2 <path.fastq[.gz]>] 

    [--repor) <path>] 
    [--json-report <path>] 
    [--threads <n>] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help]

    # mix-ins

    [--species <species>] 
    [--library <library>] 
    [--split-by-sample]
    [--dont-split-by-sample]
    [--sample-table sample_table.tsv]
    [--dna] 
    [--rna] 
    [--floating-left-alignment-boundary [<anchor_point>]] 
    [--rigid-left-alignment-boundary [<anchor_point>]] 
    [--floating-right-alignment-boundary (<gene_type>|<anchor_point>)] 
    [--rigid-right-alignment-boundary [(<gene_type>|<anchor_point>)]] 
    [--tag-pattern <pattern>] 
    [--keep-non-CDR3-alignments] 
    [--drop-non-CDR3-alignments] 
    [--limit-input <n>] 
    [--assemble-clonotypes-by <gene_features>] 
    [--split-clones-by <gene_type>]... 
    [--dont-split-clones-by <gene_type>]... 
    [--assemble-contigs-by <gene_features>] 
    [--impute-germline-on-export] 
    [--dont-impute-germline-on-export] 
    [--prepend-export-clones-field <field> [<param>...]]... 
    [--append-export-clones-field <field> [<param>...]]...
    [--prepend-export-alignments-field <field> [<param>...]]... 
    [--append-export-alignments-field <field> [<param>...]]... 
    [--add-export-clone-table-splitting <(geneLabel|tag):key>]
    [--reset-export-clone-table-splitting] 
    [--add-export-clone-grouping <(geneLabel|tag):key>]
    [--reset-export-clone-grouping]
    [-O <key=value>]... 
    [-M <key=value>]... 
    
    # inputs and outputs

	([I1.fastq[.gz] [I2.fastq[.gz]]] R1.fastq[.gz] [R2.fastq[.gz]] 
	 | file.(fasta|bam|sam)) 
	alignments.vdjca
```
The command produces a highly-compressed, memory- and CPU-efficient binary `.vdjca` file that holds exhaustive information about alignments. Alignments can be further extracted in tabular form using [`exportAlignments`](./mixcr-export.md#alignments) or in human-readable form using [`exportAlignmentsPretty`](./mixcr-exportPretty.md#raw-alignments). Additionally, MiXCR produces a comprehensive [report](./report-align.md) which provides a detailed overview of the quality of input library.

To take and process a batch of input sequencing files at once and optionally assign molecular, cell and sample barcodes extracted from the file names one can use a powerful [file name expansion](ref-input-file-name-expansion.md) functionality. [Sample tables](ref-samples-table.md) allow to analyze several patient samples at once using sample barcodes that may be picked up from all possible sources.

For [FASTQ](https://en.wikipedia.org/wiki/FASTQ_format) input MiXCR can process paired-end and single-end data. Optionally, it can take index `.fastq` files, used to extract barcodes in some protocols. It can also process [FASTA](https://en.wikipedia.org/wiki/FASTA_format) and [BAM](https://en.wikipedia.org/wiki/Binary_Alignment_Map) formats. 

Basic command line options:

`-p, --preset <name>`
: Analysis preset. Sets key parameters of this and all downstream analysis steps. It is critical to carefully select the most appropriate preset for the data you analyse. See [list of presets](overview-built-in-presets.md). 

`--trimming-quality-threshold <n>`
: Read pre-processing: trimming quality threshold. Zero value can be used to skip trimming. Default value is determined by the preset.

`--trimming-window-size <n>`
: Read pre-processing: trimming window size. Default value is determined by the preset.

`--write-all`
: Write alignment results for all input reads (even if alignment failed). Default value determined by the preset.

`--tag-pattern-file <path>`
: Read tag pattern from a file. Default value determined by the preset.

`--tag-pattern <pattern>`
: Specify tag pattern for barcoded data.

`--tag-parse-unstranded`
: If paired-end input is used, determines whether to try all combinations of mate-pairs or only match reads to the corresponding pattern sections (i.e. first file to first section etc). Default value is determined by the preset.

`--tag-max-budget <n>`
: Maximal bit budget controlling mismatches (substitutions) in tag pattern. Higher values allows more substitutions in small letters. Default value is determined by the preset.

`--read-id-as-cell-tag`
: Marks reads, coming from different files, but having the same positions in those files, as reads coming from the same cells. Main use-case is protocols with overlapped alpha-beta, gamma-delta or heavy-light cDNA molecules, where each side was sequenced by separate mate pairs in a paired-end sequencer. Use special [expansion group](ref-input-file-name-expansion.md) `CELLSPLIT` instead of R index `(i.e. "my_file_R{{CELLSPLIT:n}}.fastq.gz")`. Default value determined by the preset.

`-s, --species <species>`
: Species (organism). Possible values: `hsa` (or HomoSapiens), `mmu` (or MusMusculus), `rat`, `spalax`, `alpaca`, `lamaGlama`, `mulatta` (_Macaca Mulatta_), `fascicularis` (_Macaca Fascicularis_) or any species from [IMGT ® library](../guides/external-libraries.md).

`-b, --library <library>`
: V/D/J/C gene library. By default, the `default` MiXCR reference library is used. One can also use [external libraries](../guides/external-libraries.md)

`--limit-input <n>`
: Maximal number of reads to process.

`--read-buffer <n>`
: Size of buffer for FASTQ readers in bytes. Default: 4Mb

`--high-compression`
: Use higher compression for output file, 10~25% slower, minus 30~50% of file size.

`--not-aligned-I1 <path.fastq[.gz]>`
: Pipe not aligned I1 reads into separate file.

`--not-aligned-I2 <path.fastq[.gz]>`
: Pipe not aligned I2 reads into separate file.

`--not-aligned-R1 <path.fastq[.gz]>`
: Pipe not aligned R1 reads into separate file.

`--not-parsed-I1 <path.fastq[.gz]>`
: Pipe not parsed I1 reads into separate file.

`--not-parsed-I2 <path.fastq[.gz]>`
: Pipe not parsed I2 reads into separate file.

`--not-aligned-R2 <path.fastq[.gz]>`
: Pipe not aligned R2 reads into separate file.

`--not-parsed-R1 <path.fastq[.gz]>`
: Pipe not parsed R1 reads into separate file.

`--not-parsed-R2 <path.fastq[.gz]>`
: Pipe not parsed R2 reads into separate file.

`-O <key=value>`
: Overrides aligner parameters from the selected preset (see below)

`-M  <key=value>`
: Overrides preset parameters

`-r, --report <path>`
: [Report](report-align.md) file (human readable version, see `-j / --json-report` for machine readable report).

`-j, --json-report <path>`
: JSON formatted [report](report-align.md) file.

`-t, --threads <n>`
: Number of processing threads

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.


In addition to these parameters, any of the [available mix-in options](overview-mixins-list.md) may be additionally used at `align`.

## Aligner parameters

MiXCR has a [wide range of parameters](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/parameters/vdjcaligner_parameters.json) that control aligners behaviour. There are global parameters and gene-specific parameters organized in groups: `vParameters`, `dParameters`, `jParameters` and `cParameters`. Each group of parameters may contain further subgroups of parameters. In order to override a parameter value one can use `-O` followed by fully qualified parameter name and parameter value (e.g. `-Ogroup1.group2.parameter=value`).

Global aligner parameters include:

`-OsaveOriginalReads=false`
: Save original sequencing reads in `.vdjca` file (default `false`).

`-OallowPartialAlignments=false`
: Save incomplete alignments (e.g. only V / only J) in `.vdjca` file. 

`-OallowNoCDR3PartAlignments=false`
: Save alignments which do not fully cover CDR3 region.

`-OallowChimeras=false`
: Accept alignments with different loci of V and J genes (by default such alignments are dropped). 

`-OminSumScore=120`
: Minimal total alignment score value of V and J genes. 

`-OmaxHits=5`
: Maximal number of hits for each gene type: if input sequence align to more than `maxHits` targets, then only top `maxHits` hits will be kept. 

`-OvjAlignmentOrder=VThenJ` (only for single-end analysis)
: Order in which V and J genes aligned in target (possible values `JThenV` and `VThenJ`). Parameter affects only *single-read* alignments and alignments of overlapped paired-end reads. Non-overlapping paired-end reads are always processed in `VThenJ` mode. `JThenV` can be used for short reads (~100bp) with full (or nearly full) J gene coverage. 

`-OrelativeMinVFR3CDR3Score=0.7` (only for paired-end analysis)
: Relative minimal alignment score of `FR3+VCDR3Part` region for V gene. V hit will be kept only if its `FR3+VCDR3Part` part aligns with score greater than `relativeMinVFR3CDR3Score * maxFR3CDR3Score`, where `maxFR3CDR3Score` is the maximal alignment score for `FR3+VCDR3Part` region among all of V hits for current input reads pair. 

`-OreadsLayout=Opposite` (only for paired-end analysis)
: Relative orientation of paired reads. Available values: `Opposite`, `Collinear`, `Unknown` 

`-OrelativeMinVScore=0.7` (only for paired-end analysis)
: Relative minimum score of V gene. Only those V hits will be considered, which score is greater then `relativeMinVScore * maxVScore`, where `maxVScore` is the maximum score throw all obtained V hits.

`-OalignmentBoundaryTolerance=5`
: Force alignment of opposite mate pair if another mate alignment almost reach its boundary (left for right read and right for left read), keeping at most `alignmentBoundaryTolerance` letters not ailgned.

`-OminChimeraDetectionScore=120`
: Used in V/J chimera detection and elimination mechanism: both
alignments in R1 and R2 should be greater than this value.

`-OvjOverlapWindow=3`
: Maximal possible overlap between V and J alignments

`includeDScore=false`
: Add D alignment score to the overall alignment score 

`includeCScore=false`
: Add C alignment score to the overall alignment score

To override these parameters one can e.g. do:
```shell
> mixcr align --species hs \
    -OallowPartialAlignments=true \
    -OallowNoCDR3PartAlignments=true \
    input_file1 [input_file2] output_file.vdjca
```

### Merging algorithm parameters

MiXCR overlaps R1 and R2 reads if corresponding alignments overlap. There several parameters controlling merging behaviour:  

`-OmergerParameters.qualityMergingAlgorithm=MaxSubtraction`
: Algorithm used to compute Phred quality of overlapping region. Possible values: `SumMax`, `SumSubtraction`, `MaxSubtraction` and `MaxMax`.

`-OmergerParameters.minimalOverlap=17`
: Minimal length of R1 and R2 to proceed with overlap algorithm.

`-OmergerParameters.minimalIdentity=0.9`
: Minimal allowed percent of matched letters in overlapping region. 

To override these parameters one can e.g. do:
```shell
> mixcr align --species hs \
    -OmergerParameters.minimalIdentity=0.8 \
    input_file1 [input_file2] output_file.vdjca
```

### Gene features to align

MiXCR allows to specify particular [`gene features`](ref-gene-features.md) that will be extracted from reference and used as a targets for alignments. Thus, each sequencing read will be aligned to these extracted reference regions. Parameters responsible for target gene regions are:

`-OvParameters.geneFeatureToAlign=VRegionWithP`
: region in V gene which will be used as target

`-OdParameters.geneFeatureToAlign=DRegionWithP`
: region in D gene which will be used as target

`-OjParameters.geneFeatureToAlign=JRegionWithP`
: region in J gene which will be used as target

`-OcParameters.geneFeatureToAlign=CExon1`
: region in C gene which will be used as target

It is important to specify these gene regions such that they will fully cover target clonal gene region which will be used in [`assemble`](./mixcr-assemble.md) (e.g. CDR3).

To override these parameters one can e.g. do:
```shell
> mixcr align --species hs \
    -OvParameters.geneFeatureToAlign=VTranscriptWithP \
    input_file1 [input_file2] output_file.vdjca
```

### V, J and C aligners parameters

MiXCR has two types of aligners to align V, J and C genes:

- `kAligner` — better suited for linear scoring and better works with T-cell data
- `kAligner2` — specifically designed for affine scoring, better handles large number of mutations (e.g. hypermutations) and long indels typical for B-cell data

These aligners are based on k-mer seed-and-vote algorithms inspired by [this paper](http://nar.oxfordjournals.org/content/41/10/e108).

There are many parameters that may be tuned individually for each aligner for each gene type. MiXCR offers a number of default preset parameters that may be chosen with [`--preset`](#command-line-options) command line option:

 - `default` — for T-cell and non-targeted B-cell data
 - `rna-seq` — for non-targeted RNA-Seq (shotgun) data with 
 - `kAligner2` — for targeted B-cell data

 For `default` and `rna-seq` presets MiXCR uses `kAligner` for all gene types. For `kAligner2` preset MiXCR uses `kAligner2` for Variable and Joining segments and `kAligner` for Constant region.

#### Parameters for `kAligner`

The following parameters can be specified for `kAligner`:

`mapperKValue`             
: Length of seeds used in aligner.

`floatingLeftBound`        
: Specifies whether left bound of  alignment is fixed or float: if `floatingLeftBound` set to false, the left bound of 
either target or query will be aligned. Default values are suitable in most cases. If your target molecules have no
primer sequences in V Region (e.g. 5'RACE) (or your `-OvParameters.geneFeatureToAlign` does not cover the region where
primer is located) you can change value of this parameter for V gene to `false` to increase V gene identification 
accuracy and overall specificity of alignments.

`floatingRightBound`       
: Specifies whether right bound of alignment is fixed or float: if `floatingRightBound` set to false, the right bound of
either target or query will be aligned. Default values are suitable in most cases. If your target molecules have no 
primer sequences in J Region (e.g. library was amplified using primer to the C region) you can change value of this
parameter for J gene to `false` to increase J gene identification accuracy and overall specificity of alignments.

`minAlignmentLength`       
: Minimal length of aligned region.

`maxAdjacentIndels`        
: Maximum number of indels between two seeds.

`absoluteMinScore`         
: Minimal score of alignment: alignments with smaller score will be dropped.

`relativeMinScore`         
: Minimal relative score of  alignments: if alignment score is smaller than `relativeMinScore * maxScore`,  where `maxScore` is the best score among all alignments for particular gene type (V, J or C) and input sequence, it will be dropped.

`maxHits`                  
: Maximal number of hits: if input sequence align with more than `maxHits` queries, only top `maxHits` hits will be kept.

`mapperAbsoluteMinScore`   
: k-mer mapper absolute min score

`mapperRelativeMinScore`   
: k-mer mapper relative min score

`mapperMatchScore`         
: Match score for single k-mer match.

`mapperMismatchPenalty`    
: Mismatch penalty for single k-mer mismatch.

`mapperOffsetShiftPenalty`
: Penalty for k-mer position shift.

`mapperMinSeedsDistance`   
: Min distance between seeds in seed-and-vote strategy.

`mapperMaxSeedsDistance`   
: Max distance between neighbor seeds during seeding.

`alignmentStopPenalty`     
: Stop penalty.

Default values for these parameters are:

| Parameter                  | Default V value | Default J value | Default C value | RNA-Seq V value | RNA-Seq J value | RNA-Seq C value | kAligner2 C value |
|----------------------------|-----------------|-----------------|-----------------|-----------------|-----------------|-----------------|-------------------|
| `mapperKValue`             | 5               | 5               | 5               | 5               | 5               | 5               | 5                 |
| `floatingLeftBound`        | true            | true            | false           | false           | true            | false           | false             |
| `floatingRightBound`       | true            | false           | false           | true            | false           | false           | false             |
| `minAlignmentLength`       | 15              | 15              | 15              | 15              | 15              | 15              | 15                |
| `maxAdjacentIndels`        | 2               | 2               | 2               | 2               | 2               | 2               | 2                 |
| `absoluteMinScore`         | 40              | 40.0            | 40.0            | 55.0            | 50.0            | 40.0            | 40.0              |
| `relativeMinScore`         | 0.87            | 0.87            | 0.87            | 0.87            | 0.87            | 0.87            | 0.87              |
| `maxHits`                  | 7               | 7               | 7               | 7               | 7               | 7               | 7                 |
| `mapperAbsoluteMinScore`   | 1.5             | 1.5             | 1.5             | 1.5             | 1.5             | 1.5             | 1.5               |
| `mapperRelativeMinScore`   | 0.7             | 0.75            | 0.75            | 0.7             | 0.75            | 0.75            | 0.75              |
| `mapperMatchScore`         | 1.0             | 1.0             | 1.0             | 1.0             | 1.0             | 1.0             | 1.0               |
| `mapperMismatchPenalty`    | -0.1            | -0.1            | -0.1            | -0.1            | -0.1            | -0.1            | -0.1              |
| `mapperOffsetShiftPenalty` | -0.3            | -0.3            | -0.3            | -0.3            | -0.3            | -0.3            | -0.3              |
| `mapperMinSeedsDistance`   | 4               | 4               | 4               | 4               | 4               | 4               | 4                 |
| `mapperMaxSeedsDistance`   | 10              | 8               | 10              | 10              | 8               | 10              | 10                |
| `alignmentStopPenalty`     | -1000           | -1000           | -1000           | -1000           | -1000           | -1000           | -1000             |


To override these parameters one can e.g. do:
```shell
> mixcr align --species hs  \
    -OvParameters.parameters.minAlignmentLength=30 \
    -OjParameters.parameters.relativeMinScore=0.7 \ 
    input_file1 [input_file2] output_file.vdjca
```

Scoring used in aligners is specified by `scoring` subgroup of parameters. It contains the following parameters:

`subsMatrix=simple(match = <match>, mismatch = <mismatch>>)` 
: Substitution matrix. Available types:

    - `simple` - a matrix with diagonal elements equal to `match` and other elements equal to `mismatch`
    - `raw` - a complete set of 16 matrix elements should be specified;  for  example: 
    `raw(5,-9,-9,-9,-9,5,-9,-9,-9,-9,5,-9,-9,-9,-9,5)`(*equivalent to the  default value*)
 
`gapPenalty=<penalty>`
: Penalty for a gap.

For `default` preset MiXCR uses `simple(match = 5, mismatch = -9)` and `gapPenalty=-12` for V-, J- and C- aligners. For `rna-seq` preset MiXCR uses `simple(match = 5, mismatch = -11)` and `gapPenalty=-21` values.

Scoring parameters can be overridden in the following way:
    
```shell
> mixcr align --species hs \
    -OvParameters.parameters.scoring.gapPenalty=-20 \
    -OvParameters.parameters.scoring.subsMatrix=simple(match=4,mismatch=-11) \
    input_file1 [input_file2] output_file.vdjca
```

#### Parameters for `kAligner2`

The following parameters can be tuned for `kAligner2`:

`mapperNValue`             
: Length of k-mer seeds used in aligner.

`mapperKValue`             
: Allowed number of mutations in k-mer

`floatingLeftBound`        
: Specifies whether left bound of  alignment is fixed or float: if `floatingLeftBound` set to false, the left bound of either
target or query will be aligned. Default values are suitable in most cases. If your target molecules have no
primer sequences in V Region (e.g. 5'RACE) you can change value of this parameter for V gene to `false` to increase V
gene identification accuracy and overall specificity of alignments.

`floatingRightBound`       
: Specifies whether right bound of alignment is fixed or float: if `floatingRightBound` set to `false`, the right bound of
either target or query will be aligned. Default values are suitable in most cases. If your target molecules have no 
primer sequences in J Region (e.g. library was amplified using primer to the C region) or your
`-OjParameters.geneFeatureToAlign` does not cover the region where primer is located, then you can change value of this
parameter for J gene to `false` to increase J gene identification accuracy and overall specificity of alignments.

`absoluteMinScore`         
: Minimal score of alignment: alignments with smaller score will be dropped.

`relativeMinScore`         
: Minimal relative score of  alignments: if alignment score is smaller than `relativeMinScore * maxScore`,  where `maxScore` is the best score among all alignments for particular gene type (V, J or C) and input sequence, it will be dropped.

`maxHits`                  
: Maximal number of hits: if input sequence align with more than `maxHits` queries, only top `maxHits` hits will be kept.

`mapperAbsoluteMinClusterScore`
: Minimal allowed absolute hit score obtained by mapper to consider hit as reliable candidate

`mapperExtraClusterScore`
: Extra score for good cluster.

`mapperMatchScore`
: Score for single k-mer match.

`mapperMismatchScore`
: Mismatch penalty for single k-mer mismatch.

`mapperOffsetShiftScore`
: Penalty for k-mer position shift.

`mapperSlotCount`
: Number of simultaneously constructed clusters in one-pass initial cluster detection algorithm.

`mapperMaxClusters`
: Max allowed clusters.

`mapperMaxClusterIndels`
: Max indels inside a cluster (if indel is bigger, alignment will be divided into several clusters).

`mapperKMersPerPosition`
: If `mapperKValue > 0`, it is possible to map several seeds with holes in different places to the same position in target sequence. This parameter control the maximum.

`mapperAbsoluteMinScore`   
: k-mer mapper absolute min score

`mapperRelativeMinScore`   
: k-mer mapper relative min score

`mapperMinSeedsDistance`   
: min distance between seeds in seed-and-vote strategy

`mapperMaxSeedsDistance`   
: max distance between neighbor seeds during seeding

`alignmentStopPenalty`     
: stop penalty


Default values are:

| Parameter                     | Default V value | Default J value |
|-------------------------------|-----------------|-----------------|
| mapperNValue                  | 8               | 8               |
| mapperKValue                  | 1               | 1               |
| floatingLeftBound             | true            | true            |
| floatingRightBound            | true            | false           |
| mapperAbsoluteMinClusterScore | 102             | 102             |
| mapperExtraClusterScore       | -38             | -38             |
| mapperMatchScore              | 95              | 95              |
| mapperMismatchScore           | -14             | -14             |
| mapperOffsetShiftScore        | -82             | -82             |
| mapperSlotCount               | 6               | 6               |
| mapperMaxClusters             | 4               | 4               |
| mapperMaxClusterIndels        | 4               | 4               |
| mapperKMersPerPosition        | 4               | 4               |
| mapperAbsoluteMinScore        | 100             | 100             |
| mapperRelativeMinScore        | 0.8             | 0.8             |
| mapperMinSeedsDistance        | 5               | 5               |
| mapperMaxSeedsDistance        | 15              | 5               |
| alignmentStopPenalty          | 0               | 0               |
| absoluteMinScore              | 150             | 140             |
| relativeMinScore              | 0.8             | 0.8             |
| maxHits                       | 3               | 3               |


To override these parameters one can e.g. do:
```shell
> mixcr align --species hs --preset kAligner2 \
    -OvParameters.parameters.maxHits=5 \ 
    input_file1 [input_file2] output_file.vdjca
```

MiXCR uses affine scoring for `kAligner2`:

`subsMatrix=simple(match = <match>, mismatch = <mismatch>>)`
: Substitution matrix. Available types:

    - `simple` - a matrix with diagonal elements equal to `match` and other elements equal to `mismatch`
    - `raw` - a complete set of 16 matrix elements should be specified; for  example: 
    `raw(5,-9,-9,-9,-9,5,-9,-9,-9,-9,5,-9,-9,-9,-9,5)` (equivalent to the  default value)

`gapOpenPenalty=<penalty>`
: Penalty for opening a gap.

`gapExtensionPenalty=<penalty>`
: Penalty gap extension.


Default values used with `kAligner2` preset are:
```
subsMatrix=simple(match = 10, mismatch = -19)
gapOpenPenalty=-62
gapExtensionPenalty=-11
```

Scoring parameters can be overridden in the following way:
```shell
> mixcr align --species hs --preset kAligner2 \
    -OvParameters.parameters.scoring.gapOpenPenalty=-30 \
    -OvParameters.parameters.scoring.subsMatrix=simple(match=4,mismatch=-11) \
    input_file1 [input_file2] output_file.vdjca
```


### D aligner parameters

The following parameters can be overridden for D aligner:

`-OdParameters.absoluteMinScore=25.0`
: Minimal score of alignment: alignments with smaller scores will be dropped.   

`-OdParameters.relativeMinScore=.85`
: Minimal relative score of alignment: if alignment score is smaller than `relativeMinScore * maxScore`, where `maxScore` is the best score among all alignments for particular sequence, it will be dropped.
 
`-OdParameters.maxHits=3`
: Maximal number of hits: if input sequence align with more than `maxHits` queries, only top `maxHits` hits will be kept.			                

One can override these parameters like in the following example:"
```shell
> mixcr align \
    --species hs \
    -OdParameters.absoluteMinScore=10 \
    input_file1 [input_file2] output_file.vdjca
```

Scoring parameters for D aligner are the following:

`-OdParameters.type=linear`
: Type of scoring. Possible values: `affine`, `linear`.

`-OdParameters.subsMatrix=simple(match = 5,mismatch = -9)`
: Substitution matrix. Available types:

    - `simple` - a matrix with diagonal elements equal to `match` and 
    other elements equal to `mismatch`
    - `raw` - a complete set of 16 matrix elements should be 
    specified; for  example: `raw(5,-9,-9,-9,-9,5,-9,-9,-9,-9,5,-9,-9,-9,-9,5)` (equivalent to the default value) 

`-OdParameters.gapPenalty=-12`
: Penalty for a gap.			                

D aligner parameters can be overridden in the following way:
```shell
> mixcr align \
    --species hs \
    -OdParameters.scoring.gapExtensionPenalty=-5 \
    input_file1 [input_file2] output_file.vdjca
```

## Hardware recommendations

Alignment step is CPU-consuming. It utilizes all available CPU kernels (unless `--threads` option is specified) and scales nearly linearly with the increase of CPU count. The only factor limiting linear scaling is I/O speed (disk read) and decompression of gzipped fastq data. It consumes low amount of RAM and 4Gb should be enough for any size of input files. 
