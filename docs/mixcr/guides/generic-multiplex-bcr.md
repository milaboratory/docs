# Multiplex BCR cDNA libraries

For this tutorial we will use the data published in the following article:

Aizik L, Dror Y, Taussig D, Barzel A, Carmi Y, Wine Y. Antibody *Repertoire Analysis of Tumor-Infiltrating B Cells Reveals Distinct Signatures and Distributions Across Tissues.* Front Immunol. 2021 Jul 19;12:705381. [doi: 10.3389/fimmu.2021.705381](https://doi.org/10.3389%2Ffimmu.2021.705381). PMID: 34349765; PMCID: PMC8327180.

## Experiment setting

BALB/C mice were injected subcutaneously into mammary fat-pad number five with 2×105 4T1 cells suspended in 30 µl of DMEM (Gibco, Thermo Fisher Scientific). The induced tumors were monitored by measuring their size twice a week using calipers. After 23 days, mice were sacrificed, and B cells were isolated from four tissue types, namely, bone marrow, blood, DLNs, and tumors. For the control mice, three tissue types were collected - bone marrow, blood, and lymph nodes. Lymphocytes were isolated from every sample. For all tissues, cells were then incubated with a mixture of anti-IgG, anti-IgM, anti-CD138 magnetic beads. Later, total RNA was isolated following by first-strand cDNA synthesis using SuperScript™ III First-Strand Synthesis System with 200 ng RNA as the template and Oligo (dT) primers. After cDNA synthesis, PCR amplification of the variable heavy Ig genes was performed using a set of 19 forward primers with the gene-specific regions annealing to framework 1 of the VDJ-region and two reverse primers with the gene-specific region binding to the IgG and IgM constant regions. Recovered DNA products from the first PCR was applied to a second PCR amplification to attach Illumina adaptors to the amplified VH genes using the primer extension method.
Technical replicates (two per sample) of BCR-Seq libraries were prepared based on cDNA from each mouse/tissue. cDNA was split, and library preparation was performed in parallel with different Illumina indices as described above.
cDNA libraries were subjected to NGS on the MiSeq platform with the reagent kit V3 2 × 300 bp paired-end (Illumina).

<figure markdown>
![PRJNA699402-library-structure.svg](generic-multiplex-bcr/PRJNA699402-library-structure.svg)

</figure>

??? note "Show primers"
    ```shell
    # PCR1 Forward primers
    # Primers inglude step-out(glue) sequence and gene specific region
    
    m-VH-glue-Fw1   CCCTCCTTTAATTCCCGAKGTRMAGCTTCAGGAGTC
    m-VH-glue-Fw2   CCCTCCTTTAATTCCCGAGGTBCAGCTBCAGCAGTC
    m-VH-glue-Fw3   CCCTCCTTTAATTCCCCAGGTGCAGCTGAAGSASTC
    m-VH-glue-Fw4   CCCTCCTTTAATTCCCGAGGTCCARCTGCAACARTC
    m-VH-glue-Fw5   CCCTCCTTTAATTCCCCAGGTYCAGCTBCAGCARTC
    m-VH-glue-Fw6   CCCTCCTTTAATTCCCCAGGTYCARCTGCAGCAGTC
    m-VH-glue-Fw7   CCCTCCTTTAATTCCCCAGGTCCACGTGAAGCAGTC
    m-VH-glue-Fw8   CCCTCCTTTAATTCCCGAGGTGAASSTGGTGGAATC
    m-VH-glue-Fw9   CCCTCCTTTAATTCCCGAVGTGAWGYTGGTGGAGTC
    m-VH-glue-Fw10  CCCTCCTTTAATTCCCGAGGTGCAGSKGGTGGAGTC
    m-VH-glue-Fw11  CCCTCCTTTAATTCCCGAKGTGCAMCTGGTGGAGTC
    m-VH-glue-Fw12  CCCTCCTTTAATTCCCGAGGTGAAGCTGATGGARTC
    m-VH-glue-Fw13  CCCTCCTTTAATTCCCGAGGTGCARCTTGTTGAGTC
    m-VH-glue-Fw14  CCCTCCTTTAATTCCCGARGTRAAGCTTCTCGAGTC
    m-VH-glue-Fw15  CCCTCCTTTAATTCCCGAAGTGAARSTTGAGGAGTC
    m-VH-glue-Fw16  CCCTCCTTTAATTCCCCAGGTTACTCTRAAAGWGTSTG
    m-VH-glue-Fw17  CCCTCCTTTAATTCCCCAGGTCCAACTVCAGCARCC
    m-VH-glue-Fw18  CCCTCCTTTAATTCCCGATGTGAACTTGGAAGTGTC
    m-VH-glue-Fw19  CCCTCCTTTAATTCCCGAGGTGAAGGTCATCGAGTC
    
    # PCR1 Reverse primers
    # Primers inglude step-out(glue) sequence and gene specific region
    
    m-IgMC-BC-glue-REV      GAGGAGAGAGAGAGAGCGAGGGGGAAGACATTTGGG
    m-IgGall-BC-glue-REV    GAGGAGAGAGAGAGAGCCARKGGATAGACHGATGGG
    
    # PCR2 Forward primer
    # Primer ingludes Universal trueSeq Illumina adaptor and glue sequence from PCR1 forward primers
    
    PE-IgALL-Univ-FW    AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCTNNNNCCCTCCTTTAATTCCC
    
    # PCR2 Reverse primer
    # Primer ingludes Universal trueSeq Illumina adaptor and glue sequence from PCR1 reverse primers
    
    YW23X_PE-Idx-REV    CAAGCAGAAGACGGCATACGAGATNNNNNNGTGACTGGAGTTCAGACGTGTGCTCTTCCGATCTNNNNGAGGAGAGAGAGAGAG
    ```

Data for this project is available under PRJNA699402 BioProject id.   

## One command Solution

The easiest way to obtain clonotype tables for this type of data is to use a universal [`mixcr analyze`](../reference/mixcr-analyze.md) command.

The exact command for a single sample you can see bellow:

```shell
'> mixcr analyze amplicon \
    --species mmu \
    --starting-material rna \
    --receptor-type bcr \
    --align "-OvParameters.geneFeatureToAlign={CDR1Begin:VEnd}+{VEnd:VEnd(-20)}" \
    --5-end no-v-primers \
    --3-end c-primers \
    --adapters adapters-present \
    --assemble "-OassemblingFeatures={CDR1Begin:FR4End} -OseparateByC=true" \
    M1_4T1_Blood_S2_L001_R1_001_B3.1.fastq.gz \
    M1_4T1_Blood_S2_L001_R1_001_B3.1.fastq.gz \
    M1_4T1_Blood_S2
```

The meaning of these options is the following.

`--species`
:   is set to `mmu` for _Mus Musculus_

`--starting-material`
:   is set to `rna` and corresponds to `VTranscriptWithout5UTRWithP` alignment feature for V-gene (see [Gene features and anchor points](../reference/geneFeatures.md) for details)

`--receptor-type`
:  `bcr`. It affects the choice of alignment algorithms. MiXCR uses a specific set of algorithms for BCR data.

`--align`
: `"-OvParameters.geneFeatureToAlign={CDR1Begin:VEnd}+{VEnd:VEnd(-20)}"` Here we pass an extra argument for [`mixcr align`](../reference/mixcr-align.md) step of the pipeline. From the library structure we see, that all V-gene specific primers are located inside `FR1` region, thus we crop the alignment region to start from beginning of `CDR1`. Thus, we can trust our alignment, knowing that there are no nucleotides that could have come from the primer sequence. Ideologically this equals to primer trimming. 

`--5-end`
:   is set to `no-v-primers` because we have cropped `-OvParameters.geneFeatureToAlign` in a way that it does not cover the region where primers are located. This leads to a global alignment algorithms to align the left bound of V gene.

`--3-end-primers`
:  is set to `c-primers`. Here, C primers were used in cDNA synthesis. We did not adjust this with alignment feature for C gene, because these primers are isotype specific, and we do need these sequences for correct isotype determination. If we had shrunk `-OcParameters.geneFeatureToAlign`, trimming the C-primer region, there would be too few nucleotides left from C gene for correct isotype identification. This choice leads to a global alignment algorithms to align the right bound of J gene and a local alignment algorithm for the left bound of C-gene.

`--adapers`
:   `adapters-present` because we still have C-primer sequences in our data.

`--assemble`
:  `"-OassemblingFeatures={CDR1Begin:FR4End} -OseparateByC=true"`. Here we pass two extra arguments for [`mixcr assemble`](../reference/mixcr-assemble.md) step of the pipeline. First we extend the assembling feature to start from `CDR1`. That is because this is BCR data, where hypermutations occur throughout V gene, and we want to capture as much as we can. Second, we use `-OseparateByC=true` option to separate clones with the same assembling feature sequence but different C genes, which is essential for isotype identification.

`M1_4T1_Blood_S2_L001_R1_001_B3.1.fastq.gz M1_4T1_Blood_S2_L001_R1_001_B3.1.fastq.gz M1_4T1_Blood_S2`
: Finally, we provide the names of input files and an output prefix:


Now, since we have multiple files ist easier to process them all together instead of running the same command multiple times. One of the ways to achieve it is to use [GNU Parallel](https://www.gnu.org/software/parallel/): 

```shell
> fastq/*R1* | 
  parallel -j2 \
   '~/mixcr-private/mixcr analyze amplicon \
        --species mmu \
        --starting-material rna \
        --receptor-type bcr \
        --5-end no-v-primers \
        --3-end c-primers \
        --adapters adapters-present \
        --align "-OvParameters.geneFeatureToAlign={CDR1Begin:VEnd}+{VEnd:VEnd(-20)}" \
        --assemble "-OassemblingFeatures={CDR1Begin:FR4End} -OseparateByC=true" \
        {} \
        {=s:R1:R2:=} \
        {=s:.*/:results/:;s:_L001.*::=}'
```

## Under the hood of `mixcr analyze` pipeline

Under the hood, `mixcr analyze amplicon` command that we use above actually executes the following pipeline of MiXCR actions:

#### `align`

[Performs](../reference/mixcr-align.md):

- alignment of raw sequencing reads against reference database of V-, D-, J- and C- gene segments
- pattern matching of tag pattern sequence and extraction of barcodes

```shell
 > mixcr align \
    --species mmu \
    --report result/Multi_TRA_10ng_3.report \
    --json-report result/Multi_TRA_10ng_3.report.json \
    -OvParameters.geneFeatureToAlign={CDR1Begin:VEnd}+{VEnd:VEnd(-20)} \
    -OvParameters.parameters.floatingLeftBound=false \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    fastq/M1_4T1_Blood_S2_L001_R1_001_B3.1.fastq.gz \
    fastq/M1_4T1_Blood_S2_L001_R2_001_B3.1.fastq.gz \
    results/M1_4T1_Blood_S2.vdjca
```

Options `--report` and `--json-report` are specified here explicitly. Since we start from RNA data we use `VTranscriptWithout5UTRWithP` for the alignment of V segments (see [Gene features and anchor points](../reference/geneFeatures.md).

 `-OvParameters.parameters.floatingLeftBound=false -OjParameters.parameters floatingRightBound=false -OcParameters.parameters.floatingRightBound=true`
: These option determine global vs local alignment algorithm on the bounds of gene segments. As have been mentioned above we will use global alignment on the left bound of V gene and right bound of J gene. The alignment on the right bound of C gene will be local due to the presence of primer sequence.

This step utilizes all available CPUs and scales perfectly. When there are a lot of CPUs, the only limiting factor is the speed of disk I/O. To limit the number of used CPUs one can pass `--threads N` option.

#### `assemble`

[Assembles](../reference/mixcr-assemble.md) clonotypes and applies several layers of errors correction:

- assembly consensus CDR3 sequence
- quality-awared correction for sequencing errors
- clustering to correct for PCR errors

```shell
> mixcr assemble \
    --report results/Multi_TRA_10ng_3.report \
    --json-report results/Multi_TRA_10ng_3.report.json \
    -OassemblingFeatures={CDR1Begin:FR4End} \
    -OseparateByC=true \
    M1_4T1_Blood_S2.vdjca \
    M1_4T1_Blood_S2.clns
```

Options `--report` and `--json-report` are specified here explicitly so that the report files will be appended with assembly report.

#### `exportClones`

Finally, to [export](../reference/mixcr-export.md#clonotype-tables) clonotype tables in tabular form `exportClones` is used:

```shell
> mixcr exportClones \
    -p full \
    M1_4T1_Blood_S2.clns \
    M1_4T1_Blood_S2.tsv
```

Here `-p full` is a shorthand for the full preset of common export columns.

## Quality control

Now when the upstream analysis is finished we can move on to quality control. First lets look at the alignment report plot.

```shell
# obtain alignment quality control
> mixcr exportQc align \
    result/*.vdjca \
    alignQc.pdf
```
<figure markdown>
![alignQc.svg](generic-multiplex-bcr/alignQc.svg)
</figure>

We see that all samples have a very high score of successfully aligned reads. No signficat issues present.

Next, lets examine chane usage distribution 

<figure markdown>
![chainUsage.svg](generic-multiplex-bcr/chainUsage.svg)
</figure>

We don't see any contamination from other Ig chains. As expected, all samples consist only of IGH chains.

## Downstream analysis

There are two types of basic downstream analysis: _individual_ and _overlap_. Individual computes CDR3 metrics, diversity  and gene usage metrics for each dataset. Overlap computes statistical metrics of repertoire overlap. In both cases MiXCR applies appropriate sample normalization.

To run postanalysis routines we need to prepare a metadata file in a .tsv or .csv form. Metadata must contain a `sample` column which will be used to match metadata with cloneset files. Bellow you can find a metadata table for our samples.

??? note "Metadata"

    | sample              | mice_id  | condition | tissue  | replica |
    |---------------------|----------|-----------|---------|---------|
    | M1_4T1_Blood_S2     | M1       | 4T1       | Blood   | 1       |
    | M1_4T1_Blood_S6     | M1       | 4T1       | Blood   | 2       |
    | M1_4T1_BM_S4        | M1       | 4T1       | BM      | 1       |
    | M1_4T1_BM_S8        | M1       | 4T1       | BM      | 2       |
    | M1_4T1_DLN_S3       | M1       | 4T1       | DLN     | 1       |
    | M1_4T1_DLN_S7       | M1       | 4T1       | DLN     | 2       |
    | M1_4T1_Tumor_S5     | M1       | 4T1       | Tumor   | 1       |
    | M1_4T1_Tumor_S1     | M1       | 4T1       | Tumor   | 2       |
    | M2_4T1_Blood_S2     | M2       | 4T1       | Blood   | 1       |
    | M2_4T1_Blood_S6     | M2       | 4T1       | Blood   | 2       |
    | M2_4T1_BM_S4        | M2       | 4T1       | BM      | 1       |
    | M2_4T1_BM_S8        | M2       | 4T1       | BM      | 2       |
    | M2_4T1_DLN_S3       | M2       | 4T1       | DLN     | 1       |
    | M2_4T1_DLN_S7       | M2       | 4T1       | DLN     | 2       |
    | M2_4T1_Tumor_S1     | M2       | 4T1       | Tumor   | 1       |
    | M2_4T1_Tumor_S5     | M2       | 4T1       | Tumor   | 2       |
    | M3_4T1_Blood_S10    | M3       | 4T1       | Blood   | 1       |
    | M3_4T1_Blood_S9     | M3       | 4T1       | Blood   | 2       |
    | M3_4T1_BM_S7        | M3       | 4T1       | BM      | 1       |
    | M3_4T1_BM_S8        | M3       | 4T1       | BM      | 2       |
    | M3_4T1_DLN_S11      | M3       | 4T1       | DLN     | 1       |
    | M3_4T1_DLN_S12      | M3       | 4T1       | DLN     | 2       |
    | M3_4T1_Tumor_S13    | M3       | 4T1       | Tumor   | 1       |
    | M3_4T1_Tumor_S14    | M3       | 4T1       | Tumor   | 2       |
    | M4_4T1_Blood_S2     | M4       | 4T1       | Blood   | 1       |
    | M4_4T1_Blood_S7     | M4       | 4T1       | Blood   | 2       |
    | M4_4T1_BM_S10       | M4       | 4T1       | BM      | 1       |
    | M4_4T1_BM_S5        | M4       | 4T1       | BM      | 2       |
    | M4_4T1_DLN_S4       | M4       | 4T1       | DLN     | 1       |
    | M4_4T1_DLN_S9       | M4       | 4T1       | DLN     | 2       |
    | M4_4T1_Tumor_S1     | M4       | 4T1       | Tumor   | 1       |
    | M4_4T1_Tumor_S6     | M4       | 4T1       | Tumor   | 2       |
    | N1_control_Blood_S5 | N1       | control   | Blood   | 1       |
    | N1_control_Blood_S6 | N1       | control   | Blood   | 2       |
    | N1_control_BM_S1    | N1       | control   | BM      | 1       |
    | N1_control_BM_S2    | N1       | control   | BM      | 2       |
    | N1_control_LN_S3    | N1       | control   | LN      | 1       |
    | N1_control_LN_S4    | N1       | control   | LN      | 2       |
    | N2_control_Blood_S5 | N2       | control   | Blood   | 1       |
    | N2_control_Blood_S6 | N2       | control   | Blood   | 2       |
    | N2_control_BM_S1    | N2       | control   | BM      | 1       |
    | N2_control_BM_S2    | N2       | control   | BM      | 2       |
    | N2_control_LN_S3    | N2       | control   | LN      | 1       |
    | N2_control_LN_S4    | N2       | control   | LN      | 2       |

### Individual postanalysis

To compute a set of individual metrics we run the following command:

```shell
> mixcr postanalysis individual \
    --metadata metadata.tsv \
    --default-downsampling count-reads-auto \
    --default-weight-function read \
    --only-productive \
    --chains IGH \
    --tables postanalysis/pa.i.tsv \
    --preproc-tables postanalysis/preproc.i.tsv \
    results/*.clns \
    postanalysis/individual.json.gz
```

The meaning of specified options is the following:

`--metadata`
:   specified metadata file to use

`--default-downsampling`
:   downsampling applied to normalize the clonesets. Without appropriate normalization it is not possible to make a  statistical comparisons between datasets. In the considered case we normalize data to the same number of reads, and this  number is computed automatically based on the number of unique reads in each clone in each dataset. See [reference](../reference/mixcr-postanalysis.md#downsampling) for all downsampling options. Default downsampling may be overridden for individual metrics.

`--default-weight-function`
:   defines weight of each clonotype. Set `read` beacause there are no barcodes in the data.

`--only-productive`
:   drop clonotypes with out-of-frame CDR3 sequences or containing stop codons

`--tables`
:   path for postanalysis metrics in a tabular form

`--preproc-tables`
:   path for tabular summary of the applied downsampling and other samples preprocessing (for example filtering productive clonotypes)

`--chains`
: Since only `IGH` chain is present in the samples we can specify it directly.

After execution, we will have the following files:

```shell
> ls postanalysis/

# gzipped JSON with all results 
individual.json.gz

# summary of applied preprocessors
preproc.i.IGH.tsv

# diversity tables
pa.i.diversity.IGH.tsv

# CDR3 metrics tables & CDR3 properties
pa.i.cdr3metrics.IGH.tsv

# V- / J- / VJ- usage tables
pa.i.vUsage.IGH.tsv
pa.i.JUsage.IGH.tsv
pa.i.VJUsage.IGH.tsv

# Isotype usage table
pa.i.IsotypeUsage.IGH.tsv

#V Spectratype tables
pa.i.VSpectratype.IGH.tsv
pa.i.VSpectratypeMean.IGH.tsv
```

Preprocessing summary tables (e.g. `preproc.i.IGH.tsv`) contain detailed information on how downsampling was applied for each metric:

|characteristic|sample|preprocessor|nElementsBefore|sumWeightBefore|nElementsAfter|sumWeightAfter|preprocessor#1|nElementsBefore#1|sumWeightBefore#1|nElementsAfter#1|sumWeightAfter#1|preprocessor#2|nElementsBefore#2|sumWeightBefore#2|nElementsAfter#2|sumWeightAfter#2|preprocessor#3|nElementsBefore#3|sumWeightBefore#3|nElementsAfter#3|sumWeightAfter#3|
|--------------|---------------------|------------------------------------------------------------------------------|-----------------------------------|---------------------|--------------|-----------------|-----------------|-----------------|-----------------|----------------|-----------------|---------------------------------|-----------------|---------------------------------|----------------|-----------------|--------------------|-----------------|--------------------|----------------|----------------|
|IsotypeUsage|M2_4T1_BM_S8.clns|FilterIGHchains\|FilterstopsinCDR3,OOFinCDR3\|Downsampleautomatic|72121|1120769.0|30741|125550.0|FilterIGHchains|72121|1120769.0|72121|1120769.0|FilterstopsinCDR3,OOFinCDR3|72121|1120769.0|64734|1024106.0|Downsampleautomatic|64734|1024106.0|30741|125550|
|IsotypeUsage|M2_4T1_DLN_S7.clns|FilterIGHchains\|FilterstopsinCDR3,OOFinCDR3\|Downsampleautomatic|95523|648857.0|45810|125550.0|FilterIGHchains|95523|648857.0|95523|648857.0|FilterstopsinCDR3,OOFinCDR3|95523|648857.0|86623|601517.0|Downsampleautomatic|86623|601517.0|45810|125550|
|IsotypeUsage|N1_control_BM_S1.clns|FilterIGHchains\|FilterstopsinCDR3,OOFinCDR3\|Downsampleautomatic|92761|1111263.0|33352|125550.0|FilterIGHchains|92761|1111263.0|92761|1111263.0|FilterstopsinCDR3,OOFinCDR3|92761|1111263.0|83364|1019615.0|Downsampleautomatic|83364|1019615.0|33352|125550|
|IsotypeUsage|M1_4T1_Tumor_S1.clns|FilterIGHchains\|FilterstopsinCDR3,OOFinCDR3\|Downsampleautomatic|1910|1542543.0|653|125550.0|FilterIGHchains|1910|1542543.0|1910|1542543.0|FilterstopsinCDR3,OOFinCDR3|1910|1542543.0|1771|1320389.0|Downsampleautomatic|1771|1320389.0|653|125550|
|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|


Columns explained:

`characteristic`
:   metrics name (ex.`IsotypeUsage`)

`sample`
: name of the `.clns` file (ex. `M2_4T1_BM_S8.clns`)

`preprocessor`
:   the name of the _overall_ preprocessors chain applied to the dataset. `FilterIGHchains|FilterstopsinCDR3,OOFinCDR3|Downsampleautomatic` means the data has been subjected to three consecutive preprocessors:

    - Only IGH chains were filtered
    - Non-functional clonotypes containing stop-codons and OOF clones were filltered out and only functional were left
    - Automatic Downsampling function has been applied to normalize sample sizes

`nElementsBefore`
:   number of clonotypes before any preprocessing applied (that is in the initial dataset) (ex. `72121` clones)

`sumWeightBefore`
:   total weight of all clonotypes before any preprocessing applied. The weight may be either number of reads, UMIs or cells, depending on the selected downsampling. In this case it represents the total number of reads that contribute to clonotypes (ex.`1120769` reads)

`nElementsAfter`
:   number of clonotypes in the dataset after all preprocessors have been applied (ex.`30741` clones)

`sumWeightBefore`
:   total weight of all clonotypes after all preprocessors have been applied (ex. `125550`). Note that all samples will have the same value for `sumWeightBefore` in this case, because downsampling was applied, thus all samples have been normalized to the same weight.

`preprocessor#i`
:   i-th part of the preprocessing chain (ex. `preprocessor#1`: `Filter IGH chains`)

`nElementsBefore#i`
:   number of clonotypes before i-th preprocessor has been applied (ex. `nElementsBefore#1`: `72121`)

`sumWeightBefore#i`
:   total weight of all clonotypes before i-th preprocessor has been applied (ex. `sumWeightBefore#1`: `1120769`)

`nElementsAfter#i`
:   number of clonotypes after i-th preprocessor has been applied (ex. `nElementsAfter#1`: `30741`)

`sumWeightAfter#i`
:   total weight of all clonotypes after i-th preprocessor has been applied (ex. `sumWeightAfter#1`: `125550`)

.
.
.

Various postanalysis tables contain information about each metric computed for each sample. For
example, let's have a look inside `pa.i.JUsage.IGH.tsv`. This table contains frequencies for each J segment present in the sample :

| sample               | IGHJ3*00            | IGHJ2*00           | IGHJ1*00            | IGHJ4*00            |
|----------------------|---------------------|--------------------|---------------------|---------------------|
| M1_4T1_Blood_S2.clns | 0.24678614097968937 | 0.356726403823178  | 0.12035045798486659 | 0.27613699721226603 |
| M1_4T1_Blood_S6.clns | 0.2431620868180008  | 0.37610513739546   | 0.1291358024691358  | 0.25159697331740344 |
| M1_4T1_BM_S4.clns    | 0.24498606133014736 | 0.2887216248506571 | 0.13416168857029073 | 0.3321306252489048  |
| M1_4T1_BM_S8.clns    | 0.24844285145360415 | 0.2861091198725607 | 0.13389088012743927 | 0.33155714854639584 |
| M1_4T1_DLN_S3.clns   | 0.24744723217841497 | 0.2569573874950219 | 0.06846674631620868 | 0.42712863401035445 |
| ...                  | ...                 | ...                | ...                 | ...                 |


#### Graphical output

MiXCR allows to export graphical results in PDF, EPS, PNG and SVG formats using `exportPlots` command.

For diversity metrics and CDR3 properties MiXCR allows to group data in different ways according to the submitted `metadata.tsv` and apply various statistical tests for group comparison.

##### Diversity
Let's reconstruct one of the figures from the paper. Let's say we want to look at the Normalized ShannonWiener diversity index. We will group samples by tissues and use separate facets for contol and experiment group. That can be easily done with a single command:

```shell
> mixcr exportPlots diversity \
    --metadata metadata.tsv \
    --plot-type boxplot \
    --metric normalizedShannonWienerIndex \ 
    --primary-group tissue \
    --facet-by condition \
    --primary-group-values Tumor,LN,DLN,Blood,BM \
    postanalysis/individual.json.gz \
    normalizedShannonWienerIndex.pdf
```
<figure markdown>
![normalizedShannonWienerIndex.IGH.svg](generic-multiplex-bcr/normalizedShannonWienerIndex.IGH.svg)
</figure>

Arguments explained:

`--metadata`
: `metadata.tsv` is the name of metadata file.

`--plot-type`
: `boxplot` is the type of plot to generate. See [`mixcr exportPlots`](../reference/mixcr-exportPlots.md) for other options.

`--metric`:
: `normalizedShannonWienerIndex` is the name of the metric to visualize. See [`diversity metrics`](../reference/mixcr-exportPlots.md#diversity-and-cdr3-metrics) for other options. If not specified multiple plots will be generated for each available diversity metric.

`--primary-group`
: `tissue` is name of the column with metadata values from `metadata.tsv` to group samples by.

`--primary-group-values`
: `Tumor,LN,DLN,Blood,BM` represents the order of `--primary-group` values on the plot (`tissue` in this case)

`--facet-by`
: `condition` is name of the column with metadata values from `metadata.tsv` to group samples and represent on separate facets for each group.

`postanalysis/individual.json.gz`
: the name of gzipped JSON file with all postanalysis results generated by [`mixcr postanalysis individual](../reference/mixcr-postanalysis.md#individual-postanalysis)

`normalizedShannonWienerIndex.pdf`
: the name of output file. Also specifies the extension of the output file. One can use one of the following graphical out formats: `.pdf`, `.eps`, `.png` and `.svg`.

##### V usage

Now lets look at the J gene distribution among all samples.

```shell
> mixcr exportPlots jUsage \
    --metadata metadata.tsv \
    --chains IGH \
    --palette sequential \
    --color-key tissue \
    postanalysis/individual.json.gz \
    jUsage.pdf  
```

`--palette`
: `sequential`. Determines color palette to be used for the heatmap. See [gene segment usage plots](../reference/mixcr-exportPlots.md#gene-segment-usage) for other options.

`--color-key`
: `tissue`. Metadata column name.

<figure markdown>
![jUsage.IGH.svg](generic-multiplex-bcr/jUsage.IGH.svg)
</figure>

### Overlap postanalysis

#### Two samples overlap

Since our samples were prepared in replicas, it is often usefully to check if clone frequencies correlate between replicas. Let's take two replicas of one biological sample and overlap two repertoires. We will use [`mixcr overlapScatterPlot` function](../reference/mixcr-overlapScatterPlot.md):

```shell
> mixcr overlapScatterPlot \
    --downsampling none \
    --chains IGH \
    results/M1_4T1_Blood_S2.clns results/M1_4T1_Blood_S6.clns \
    M1_4T1_Blood.overlap.pdf
```
<figure markdown>
![M1_4T1_Blood.overlap.png](M1_4T1_Blood.overlap.png)
</figure>

#### All-vs-All overlap

MiXCR also allows performing an overall overlap analysis using [`mixcr postanalysis overlap`](../reference/mixcr-postanalysis.md#overlap-postanalysis). But here, since there are a lot of samples we want to actually overlap groups of samples. Running the following command will perform pairwise overlap comparison between groups of samples with different `tissue` and `condition` values.

```shell
> mixcr postanalysis overlap -f \
   --factor-by tissue,condition \
   --metadata metadata.tsv \
   --default-downsampling count-reads-auto \
   --default-weight-function read \
   --only-productive \
   --tables postanalysis/postanalysis.overlap.tsv \
   --preproc-tables postanalysis/preproc.overlap.tsv \
   results/*.clns \
   postanalysisls /overlap.tissue_condition.json.gz
```

`--factor-by`
: `tissue,condition` defines the set of metadata columns for which a list of unique intersections will be created and used for group comparison

Other arguments are same as for individual postanalysis mentioned above.

This command will generate a set of files:

```shell
#Tsv files for every metric
postanalysis.overlap.F1Index.IGH.tsv
postanalysis.overlap.F2Index.IGH.tsv
postanalysis.overlap.JaccardIndex.IGH.tsv
postanalysis.overlap.PearsonAll.IGH.tsv
postanalysis.overlap.Pearson.IGH.tsv
postanalysis.overlap.RelativeDiversity.IGH.tsv
postanalysis.overlap.SharedClonotypes.IGH.tsv

# summary of applied preprocessors
preproc.overlap.IGH.tsv

# gzipped JSON with all results 
overlap.tissue_condition.json.gz
```

The tabular output for example for F2 metric will look like:

||LN,control|BM,4T1|BM,control|DLN,4T1|Blood,4T1|Blood,control|Tumor,4T1|
|-|----------|------|----------|-------|---------|-------------|---------|
|**LN,control**|1.0|0.013774364765374518|0.04650437588957222|0.014099278585204775|0.031036354127937787|0.027203139358090662|0.010163687504766344|
|**BM,4T1**|0.013774364765374518|1.0|0.05529474567524548|0.04405383350942532|0.10645680248929848|0.07417602888238424|0.09466939004888049|
|**BM,control**|0.04650437588957222|0.05529474567524548|1.0|0.03286381709464843|0.233349361966603|0.11870207376989239|0.06314011150401469|
|**DLN,4T1**|0.014099278585204775|0.04405383350942532|0.03286381709464843|1.0|0.1768279650269904|0.0188038306990065|0.10982393111366022|
|**Blood,4T1**|0.031036354127937787|0.10645680248929848|0.233349361966603|0.1768279650269904|1.0|0.0634481121480744|0.13415831269714423|
|**Blood,control**|0.027203139358090662|0.07417602888238424|0.11870207376989239|0.0188038306990065|0.0634481121480744|1.0|0.03867881035646659|
|**Tumor,4T1**|0.010163687504766344|0.09466939004888049|0.06314011150401469|0.10982393111366022|0.13415831269714423|0.03867881035646659|1.0|

Every overlap metric is also possible to present in a graphical format:

```shell
> mixcr exportPlots overlap \
    --chains IGH \
    --palette density \
    --metric f2Index \
    postanalysis/overlap.tissue_condition.json.gz \
    overlap.time_marker.pdf
```

For list of available metrics see [`mixcr exportPlots overlap`](../reference/mixcr-exportPlots.md#overlap)

<figure markdown>
![overlap.tissue_condition.IGH.svg](generic-multiplex-bcr/overlap.tissue_condition.IGH.svg)
</figure>

For further details see [overlap postanalysis reference](../reference/mixcr-exportPlots.md).



