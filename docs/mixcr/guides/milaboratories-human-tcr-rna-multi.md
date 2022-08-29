# MiLaboratories Human TCR RNA Multiplex kit

This kit allows to obtain TCR alpha and beta repertoires for different types of available RNA material, with high sensitivity and UMI-based accuracy.

Bellow you can see the structure of cDNA library.

<figure markdown>
![MiLabMultiTCR.svg](milaboratories-human-tcr-rna-multi/MiLabMultiTCR.svg)
</figure>

The data for this tutorial consists of two samples that represent two replicas of the same biological sample. Total RNA was isolated from PBMC and 25ng were used for each cDNA synthesis. Two cDNA libraries were prepared for each sample (one for TCR alpha and one for TCR betta) according to MiLaboratories Human TCR Repertoire RNA Multiplex Kit protocol. TCR sequencing was performed on an Illumina Miseq sequencer using the 300-cycle Miseq reagent kit(Illumina) with pair-end, 2x150 base pair reads.

## Upstream analysis

### One-line solution

The most straightforward way to get clonotype tables is to use a universal [`mixcr analyze`](../reference/mixcr-analyze.md) command. 

All files are located in `fastq/` folder and the commands given accordingly. For a single sample `mixcr analyze` command wil be is the follows:

```shell
> mixcr analyze amplicon \
    --species hsa \
    --starting-material hsa \
    --receptor-type tcr \
    --umi-pattern-name MiLaboratoriesMultiplexTCR \
    --5-end no-v-primers \
    --3-end c-primers \
    --adapters no-adapters \
    --report Multi_TRA_10ng_3.report:= \
    fastq/Multi_TRB_FS115_1_S153_R1_001.fastq.gz \
    fastq/Multi_TRB_FS115_1_S153_R2_001.fastq.gz \
    results/Multi_TRB_FS115_1
```

The meaning of these options is the following.

`--species`
:   is set to `hsa` for _Homo Sapiens_.

`--starting-material`
:   is set to `rna` and corresponds to `VTranscriptWithout5UTRWithP` alignment feature for V-gene (
see [Gene features and anchor points](../reference/ref-gene-features.md) for details)

`--receptor-type`
:  `tcr`. It affects the choice of alignment algorithms.

`--umi-pattern-name`
: `MiLaboratoriesMultiplexTCR` specifies a build in UMI pattern for MiLaboratories RNA Multiplex TCR repertoire kit. This name stands for the following pattern: `"^N{0:2}tggtatcaacgcagagt(UMI:NNNNTNNNNTNNNN)N{21}(R1:*) \ ^N{42}(R2:*)"`. It specifies the position of UMI barcode and also defines the rules for primer trimming, thus we can treat the data as if no primer sequences present in  it. MiXCR provides a powerful regex-like [language](../reference/ref-tag-pattern.md) allowing to specify almost arbitrary barcode structure.

`--5-end`
: is set to `no-v-primers` because we used a `umi-pattern` that ignores part of the sequence where primers are located. This choice leads to a global alignment algorithm to align the left bound of V.

`--3-end-primers`
: is set to `c-primers` since the primer used for library preparation is complimentary to C-region of TCR genes.
This leads to a global alignment algorithms to align the right bound of J and a local alignment at the right bound of C gene.

`--adapers`
: `no-adapters` because primer sequences were cut off by `umi-pattern`.



Running the command above will generate the following files:

```shell
> ls result/

# human-readable reports 
Multi_TRB_FS115_1.report
# raw alignments (highly compressed binary file)
Multi_TRB_FS115_1.vdjca
# alignments with corrected UMI barcode sequences 
Multi_TRB_FS115_1.corrected.vdjca
# TCRα & TCRβ CDR3 clonotypes (highly compressed binary file)
Multi_TRB_FS115_1.clns
# TCRα & TCRβ CDR3 clonotypes exported in tab-delimited txt
Multi_TRB_FS115_1.clonotypes.TRA.tsv
Multi_TRB_FS115_1.clonotypes.TRB.tsv
Multi_TRB_FS115_1.clonotypes.TRD.tsv
Multi_TRB_FS115_1.clonotypes.TRG.tsv 
```

Clonotype tables is the main result of the upstream analysis. They are stored in a highly compressed and efficient
binary `.clns` file and can be exported in many ways: detailed [tab-delimited format](../reference/mixcr-export.md) with dozens of customizable columns, [human readable](../reference/mixcr-exportPretty.md) for manual inspection, and [AIRR format](../reference/mixcr-exportAirr.md) suitable for many scientific downstream analysis tools. By default, MiXCR exports clonotypes in a tab-delimited format separately for each immunological chain.

In order to run the analysis for all samples in the project on Linux we can for example
use [GNU Parallel](https://www.gnu.org/software/parallel/) in the following way:

```shell
> ls /fastq/*R1* | \
  parallel -j2  \
  'mixcr analyze amplicon \
    --species hsa \
    --starting-material rna \
    --receptor-type tcr \
    --umi-pattern-name MiLaboratoriesMultiplexTCR \
    --5-end no-v-primers \
    --3-end c-primers \
    --adapters no-adapters \
    --report {=s:.*/:results/:;s:_S.*:.report:=} \
    {} \
    {=s:R1:R2:=} \
    {=s:.*/:results/:;s:_S.*::=}
```

### Under the hood pipeline


Under the hood, `mixcr analyze amplicon` executes the following pipeline of MiXCR actions:

#### `align`

[Performs](../reference/mixcr-align.md):

- alignment of raw sequencing reads against reference database of V-, D-, J- and C- gene segments
- pattern matching of tag pattern sequence and extraction of barcodes

```shell
 > mixcr align \
    --species mmu \
    --tag-pattern '^N{0:2}tggtatcaacgcagagt(UMI:NNNNTNNNNTNNNN)N{21}(R1:*) \ ^N{42}(R2:*)' \
    --report result/Multi_TRA_10ng_3.report \
    --json-report result/Multi_TRA_10ng_3.report.json \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=false \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    fastq/Multi_TRB_FS115_1_S153_R1_001.fastq.gz \
    fastq/Multi_TRB_FS115_1_S153_R1_001.fastq.gz \
    results/Multi_TRB_FS115_1.vdjca
```

Options `--report` and `--json-report` are specified here explicitly. Since we start from RNA data we use `VTranscriptWithout5UTRWithP` for the alignment of V segments (see [Gene features and anchor points](../reference/ref-gene-features.md)). 
Because we cut off the primers in V segment, we use global alignment on the left bound of V and since we have primers on C segment, we use global alignment for J and local on the right bound of C. This behavior is defined by the following options: `-OvParameters.parameters.floatingLeftBound=false`, `-OjParameters.parameters.floatingRightBound=false`, `-OcParameters.parameters.floatingRightBound=true`.

This step utilizes all available CPUs and scales perfectly. When there are a lot of CPUs, the only limiting factor is the speed of disk I/O. To limit the number of used CPUs one can pass `--threads N` option.

#### `correctAndSortTags`

[Corrects](../reference/mixcr-correctAndSortTags.md) artificial diversity caused by sequencing and PCR errors _inside_ barcode sequences. This step essential if any barcodes (UMI, Cel, etc.) present in the sample. In the considered example project it corrects only sequences of UMIs.

```shell
> mixcr correctAndSortTags \
    --report results/Multi_TRB_FS115_1.report \
    --json-report results/Multi_TRB_FS115_1.report.json \
    Multi_TRB_FS115_1.vdjca \
    Multi_TRB_FS115_1.corrected.vdjca
```

Options `--report` and `--json-report` are specified here explicitly so that the report files will be appended with the barcode correction report.

#### `assemble`

[Assembles](../reference/mixcr-assemble.md) clonotypes and applies several layers of errors correction:

- assembly consensus CDR3 sequence for each UMI
- quality-awared correction for sequencing errors
- clustering to correct for PCR errors, which still may present even in the case of UMI data, since a error may be introduced e.g. on the first reverse-transcription cycle

```shell
> mixcr assemble \
    --report results/Multi_TRA_10ng_3.report \
    --json-report results/Multi_TRA_10ng_3.report.json \
    Multi_TRB_FS115_1.corrected.vdjca \
    Multi_TRB_FS115_1.clns
```

Options `--report` and `--json-report` are specified here explicitly so that the report files will be appended with assembly report.

#### `exportClones`

Finally, to [export](../reference/mixcr-export.md#clonotype-tables) clonotype tables in tabular form `exportClones` is used:

```shell
> mixcr exportClones \
    -p full \
    -uniqueTagCount UMI \
    Multi_TRB_FS115_1.clns \
    Multi_TRB_FS115_1.tsv
```

Here `-p full` is a shorthand for the full preset of common export columns and `-uniqueTagCount UMI` adds a column with the UMI count for each clone.

## Quality control

Now when the upstream analysis is finished we can move on to quality control. First lets look at the alignment report plot.

```shell
# obtain alignment quality control
> mixcr exportQc align \
    result/*.vdjca \
    alignQc.pdf
```

<figure markdown>
![alignQcFS115.svg](milaboratories-human-tcr-rna-multi/alignQcFS115.svg)
</figure>

From this plot we can tell that all samples have high alignment rate, more than 90% of reads have been successfully aligned to the reference sequences and CDR3 has been established.

Now we can check chain distribution plot:

```shell
# obtain alignment quality control
> mixcr exportQc chainUsage \
    result/*.vdjca \
    alignQc.pdf
```

<figure markdown>
![chainUsageFS115.svg](milaboratories-human-tcr-rna-multi/chainUsageFS115.svg)
</figure>

Here we can see that no cross-contamination has occurred. TCR alpha samples consist only of TRA clones, and TCR betta only of TRB.