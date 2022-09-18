# SMARTer Human BCR IgG IgM H/K/L Profiling Sequencing Kit (Takara Bio Inc.)

Here we will discuss how to process BCR cDNA libraries obtained with [SMARTer Human BCR IgG IgM H/K/L Profiling Sequencing Kit](https://www.takarabio.com/products/next-generation-sequencing/immune-profiling/human-repertoire/human-bcr-profiling-kit-for-illumina-sequencing) (Takara Bio Inc.).

## Data libraries

This tutorial uses the data from the following publication: *The autoimmune signature of hyperinflammatory multisystem inflammatory syndrome in children* Rebecca A. Porritt, et al,JCI (2021)
[doi:10.1172/JCI151520](https://doi.org/10.1172/JCI151520)

Library construction was performed using the SMARTer Human BCR IgG IgM H/K/L Profiling Sequencing Kit (Takara Bio Inc.). Up to 50 ng of total RNA per sample was used for reverse transcription, followed by 4 separate PCR amplification reactions for IgG, IgM, IgK, and IgL. A second round of PCR amplified the entire BCR variable region and a small portion of the constant region. After size selection, quantification and fragment analysis of the individual libraries were performed. Individual chains were then pooled and sequenced on the MiSeq (Illumina) using 2 × 300 bp sequencing. Fastq raw data have been deposited in the European Nucleotide Archive (ENA) under accession number PRJEB44566. 

!!! note
    FASTQ files have been merged, thus every pair of FASTQ files holds sequences for all chains corresponding to a sample.

On the scheme bellow you can see structure of cDNA library. UMI is located in the first 12 bp of R2.

![SMARTerHumanBCRIgG-IgM-H-K-L.svg](takara-hsa-bcr/figs/10-SMARTerHumanBCRIgG-IgM-H-K-L.svg)


All data may be downloaded directly from SRA using e.g. [SRA Explorer](https://sra-explorer.info).
??? tip "Use this script to download the full data set with the proper filenames for the tutorial:"
    ```shell title="download.sh"
    --8<-- "takara-hsa-bcr/scripts/10-download.sh"
    ```

## Upstream analysis

The most straightforward way to get clonotype tables is to use a universal [`mixcr analyze`](../reference/mixcr-analyze.md) command.

According to the library preparation protocol, the library does not have any V primers on 5'-end and has C primers on 3' end. Thus, the command for a single sample is the following:

```shell
> mixcr analyze amplicon \
    --species hsa \
    --starting-material rna \
    --receptor-type bcr \
    --5-end no-v-primers \
    --3-end c-primers \
    --adapters no-adapters \
    --assemble "-OassemblingFeatures={FR1Begin:FR4End}" \
    --umi-pattern "^N{7}(R1:*) \ ^(UMI:N{12})N{4}(R2:*)" \
    raw/FebControl1_R1.fastq.gz \
    raw/FebControl1_R2.fastq.gz \
    results/FebControl1
```

The meaning of these options is the following.

`--species`
:   is set to `hsa` for _Homo Sapience_

`--starting-material`
:   RNA or DNA. It affects the choice of V gene region which will be used as target in [`align`](../reference/mixcr-align.md) step (`vParameters.geneFeatureToAlign`, see [`align` documentation](../reference/mixcr-align.md)): `rna` corresponds to the `VTranscriptWithout5UTRWithP` and `dna` to `VGeneWithP` (see [Gene features and anchor points](../reference/ref-gene-features.md) for details)

`--receptor-type`
:   `bcr`. It affects the choice of underlying alignment algorithms: MiXCR uses fundamentally different algorithms for TCRs and BCRs because BCRs have somatic hypermutations and long indels.

`--umi-pattern`
:   is used to specify UMI pattern for the library. MiXCR provides a powerful regex-like [language](../reference/ref-tag-pattern.md) allowing to specify almost arbitrary barcode structure. Here we use `^N{7}(R1:*) \ ^(UMI:N{12})N{4}(R2:*)` pattern to specify the location of UMI.

`--5-end`
: is set to `no-v-primers`, because the library was obtained using 5'RACE. This leads to a global alignment algorithm on the left bound of V gene.

`--3-end-primers`
:  is set `c-primers` according to the cDNA library preparation protocol.

`--adapers`
:  is set to `no-adapters`. Presence or absence of adapter sequences results in the choice between local and global alignment algorithms on the edges of the target sequence.

`--assemble`
: `"-OassemblingFeatures={FR1Begin:FR4End}"`. We pass an extra parameter to `mixcr assemble` step of the pipeline. By default, clones are assembled by `CDR3` sequence, but in case of full-length BCR data we want to extend this assembling feature to capture hypermutations in V gene.

Running the command above will generate the following files:

```shell
> ls result/

# human-readable reports 
FebControl1.report
# raw alignments (highly compressed binary file)
FebControl1.vdjca
# alignments with corrected UMI barcode sequences 
FebControl1.corrected.vdjca
# IGH, IGK and IGL CDR3 clonotypes (highly compressed binary file)
FebControl1.clns
# IGH, IGK and IGL CDR3 clonotypes exported in tab-delimited txt
FebControl1.clonotypes.IGH.tsv
FebControl1.clonotypes.IGK.tsv
FebControl1.clonotypes.IGL.tsv  

```

Obtained `*.tsv` files can be used for manual examination. `*.clns` files can be used for downstream analysis using [`mixcr postanalisis`](../reference/mixcr-postanalysis.md). By default, MiXCR exports clonotypes in a tab-delimited format separately for each immunological chain.

In order to run the analysis for all samples in the project on Linux we can use [GNU Parallel](https://www.gnu.org/software/parallel/) in the following way:

```shell
--8<-- "takara-hsa-bcr/scripts/20-upstream.sh"
```

### Under the hood pipeline:

Under the hood the command above actually executes the following pipeline:


#### `align`

Alignment of raw sequencing reads against reference database of V-, D-, J- and C- gene segments.

```shell
# align raw reads
> mixcr align -s hsa \
    -p kAligner2 \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=false \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=false \
    --report results/13_d60_lymph_node_germinal_center_B_cell.report \
    --tag-pattern '^N{7}(R1:*) \ ^(UMI:N{12})N{4}(R2:*)' \
    fastq/FebControl1_R1.fastq.gz \
    fastq/FebControl1_R2.fastq.gz \
    FebControl1.vdjca
```

- `--report` option is specified here explicitly,
- `-p kAligner2` specifies an BCR aligner,
- `-OvParameters.parameters.floatingLeftBound=false`, `-OjParameters.parameters.floatingRightBound=false`, `-OcParameters.parameters.floatingRightBound=false` are all set to `false` which results in a global aligning algorithm on all segment bounds.

#### `correctAndSortTags`

[Corrects](../reference/mixcr-correctAndSortTags.md) sequencing and PCR errors _inside_ barcode sequences. This step is essential to correct artificial diversity caused by errors in barcodes.

```shell
> mixcr correctAndSortTags \
    --report FebControl1.report \
    --json-report FebControl1.report.json \
    FebControl1.vdjca \
    FebControl1.corrected.vdjca
```

#### `assemble`

Assembles alignments into clonotypes and applies several layers of errors correction(ex. quality-awared correction for sequencing errors, clustering to correct for PCR errors). Check [`mixcr assemble`](../reference/mixcr-assemble.md) for more information.

```shell
# assemble CDR3 clonotypes
> mixcr assemble \
    -OseparateByV=true \
    -OseparateByJ=true \
    -OseparateByC=true \
    -OassemblingFeatures={FR1Begin:FR4End} \
    --report FebControl1.corrected.report \
    FebControl1.corrected.vdjca \
    FebControl1.clns
```

Since no V primers are present and isotype specific C primers were used, we can separate clones by V, J and C segments even if they have the same `CDR3`. This is important especially for BCR data due to hypermutations and in order to identify isotypes.

#### `export`

Exports clonotypes from `.clns` file into human-readable tables.
```shell
# export to tsv
> mixcr exportClones \
    -p full \
    FebControl1.clns \
    FebControl1.tsv
```
Here `-p full` defines the full preset of common export columns. Check [`mixcr export`](../reference/mixcr-export.md) for more information.

## Quality control

Now when we have all files processed lets perform Quality Control. That can be easily done using [`mixcr exportQc`](../reference/mixcr-exportQc.md)
function.

```shell
# obtain alignment quality control
> mixcr exportQc align \
    results/*.vdjca \
    alignQc.pdf
```

![align QC](takara-hsa-bcr/figs/20-alignQc.svg)

The plot above demonstrates a high quality alignment rate. Now Lets look at the chain distribution in every sample.

```shell
# obtain chain usage plot
> mixcr exportQc chainUsage \
    results/*.vdjca \
    usageQc.pdf
```

![chain usage QC](takara-hsa-bcr/figs/30-chainUsageQc.svg)

We see that in most sample number of light chains significantly dominate over IGH. Since libraries for all chains were generated in a separate PCR reactions according to the protocol, we might suggest that this bias arise from unequal mixing of cDNA libraries prior sequencing.
