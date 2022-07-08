# Data libraries

This tutorial uses the data from the publication:

Memory persistence and differentiation into antibody-secreting cells accompanied by positive selection in longitudinal 
BCR repertoires Artem I. Mikelov, Evgeniia I. Alekseeva, Ekaterina A. Komech, Dmitriy B. Staroverov, Maria A. Turchaninova,
Mikhail Shugay, Dmitriy M. Chudakov, Georgii A. Bazykin, Ivan V. Zvyagin bioRxiv 2021.12.30.474135; 
[doi: https://doi.org/10.1101/2021.12.30.474135](https://www.biorxiv.org/content/10.1101/2021.12.30.474135v2)

??? note "Sample preparation"
    Blood samples from six young and middle-aged donors were collected at three time-points (T1 - 0, T2 - 1 month, 
    T3 - 12 months). PBMC were isolated, stained and then sorted using FACS into the following populations: memory B cells, 
    plasmablasts and plasma cells. 
    IGH cDNA libraries were prepared using RACE approach as described previously 
    [Turchaninova et al. 2016](https://www.nature.com/articles/nprot.2016.093). Adaptors contained both unique molecular identifiers
    (UMIs), and sample barcodes we introduced.  Multiplexed C-segment-specific primers for each isotype were used for RT and PCR.
    Prepared libraries were then sequenced with an Illumina HiSeq 2000/2500, (paired-end, 2 × 310 bp).

!!! note "Barcodes"
    Tag pattern for this data is build into MiXCR under the name "mikelov_et_al_2021". 

??? note "Take a look at the barcodes"
    Bellow you can see the actual tag-pattern that will be used.
    The first read contains one of four isotype specific primers. The second read contains one of 22 SampleBarcodes and 
    a UMI sequence. The tag-pattern implies that all adaptor and primer sequences will not be passed to the downstream 
    analysis after alignment.
    ```
    ^(R1F:N{0:2}(C:gggggaaaagggttg)(R1:*)) |
    ^(R1F:N{0:2}(C:rggggaagacsgatg)(R1:*)) |
    ^(R1F:N{0:2}(C:agcgggaagaccttg)(R1:*)) |
    ^(R1F:N{0:2}(C:tatgatggggaacac)(R1:*)) \
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNNTACCTGTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNNTATGCATNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNNTCACCATNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNNTCAGATTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNNTCCTGTTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNNTTGAAATNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNNTTGTTATNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNTNACGATNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNTNATTCGNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNTNCCGTCNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNTNGATACNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNNTNTACGTNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNCACTGNNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNCCATGNNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNCTAGTNNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNGCAAANNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNGCTGCNNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNGGATANNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNTAACCNNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNTCGACNNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNTTATGNNTNNNNNN)tct>{2}(R2:*)) |
    ^(R2F:tggtatcaacgcagagtac(UMI:NNNNTNNTTGCGNNTNNNNNN)tct>{2}(R2:*))
    ```
The project contains 158 paired fastq files.

??? note "List files"

    ```shell
    >ls fastq/
    
    AT_p01_Bmem_1_GTAGAGGA-AGAGTAGA_L00M_R1_001.fastq.gz
    AT_p01_Bmem_1_GTAGAGGA-AGAGTAGA_L00M_R2_001.fastq.gz
    AT_p01_PBL_1_GCTACGCT-CTAAGCCT_L00M_R1_001.fastq.gz
    AT_p01_PBL_1_GCTACGCT-CTAAGCCT_L00M_R2_001.fastq.gz
    AT_p01_PL_1_TCCTGAGC-TATCCTCT_L00M_R1_001.fastq.gz
    AT_p01_PL_1_TCCTGAGC-TATCCTCT_L00M_R2_001.fastq.gz
    AT_p02_Bmem_1_TAAGGCGA-AAGGAGTA_L00M_R1_001.fastq.gz
    AT_p02_Bmem_1_TAAGGCGA-AAGGAGTA_L00M_R2_001.fastq.gz
    AT_p02_Bmem_2_TAAGGCGA-CTAAGCCT_L00M_R1_001.fastq.gz
    AT_p02_Bmem_2_TAAGGCGA-CTAAGCCT_L00M_R2_001.fastq.gz
    AT_p02_PBL_1_GCTACGCT-TAGATCGC_L00M_R1_001.fastq.gz
    AT_p02_PBL_1_GCTACGCT-TAGATCGC_L00M_R2_001.fastq.gz
    AT_p02_PL_1_TAAGGCGA-TAGATCGC_L00M_R1_001.fastq.gz
    AT_p02_PL_1_TAAGGCGA-TAGATCGC_L00M_R2_001.fastq.gz
    AT_p03_Bmem_1_TAAGGCGA-AGAGTAGA_L00M_R1_001.fastq.gz
    AT_p03_Bmem_1_TAAGGCGA-AGAGTAGA_L00M_R2_001.fastq.gz
    AT_p03_Bmem_2_CGTACTAG-AGAGTAGA_L00M_R1_001.fastq.gz
    AT_p03_Bmem_2_CGTACTAG-AGAGTAGA_L00M_R2_001.fastq.gz
    AT_p03_PBL_1_TAAGGCGA-ACTGCATA_L00M_R1_001.fastq.gz
    AT_p03_PBL_1_TAAGGCGA-ACTGCATA_L00M_R2_001.fastq.gz
    AT_p03_PBL_2_CGTACTAG-ACTGCATA_L00M_R1_001.fastq.gz
    AT_p03_PBL_2_CGTACTAG-ACTGCATA_L00M_R2_001.fastq.gz
    AT_p03_PL_1_AGGCAGAA-CTCTCTAT_L00M_R1_001.fastq.gz
    AT_p03_PL_1_AGGCAGAA-CTCTCTAT_L00M_R2_001.fastq.gz
    ...
    ```
Each file name encodes the information about patient, time-point, cell subset and replica number. For example for the first file 
from above listing: AT - patient, p01 - time-point, Bmem - memory B cells, 1 - first replica. 

# Upstream analysis

### `align`

Performs:

- alignment of raw sequencing reads against reference database of V-, D-, J- and C- gene segments
- pattern matching of tag pattern sequence and extraction of barcodes



=== "Single pair of files"
    ```shell
    > mixcr align \
        --species HomoSapiens \
        -p kAligner2 \
        -OvParameters.geneFeatureToAlign=VTranscript \
        --tag-pattern-name mikelov_et_al_2021 \
        -r MT_p03_PL_1_alignReport.txt \
        --json-report MT_p03_PL_1_alignReport.json \
        fastq/MT_p03_PL_1_GTAGAGGA-CTCTCTAT_L00M_R1_001.fastq.gz fastq/MT_p03_PL_1_GTAGAGGA-CTCTCTAT_L00M_R2_001.fastq.gz \
        MT_p03_PL_1.vdjca
    ```
=== "Multiple files"
    ```shell
    > ls fastq/*R1* | \
      nice -n 19 parallel -j2  \
      'mixcr align \
           --species HomoSapiens \
           -p kAligner2 \
           -OvParameters.geneFeatureToAlign=VTranscript \
           --tag-pattern-name mikelov_et_al_2021 \
           -r {=s:.*/:clones/:; s:(_[ATGC]{8}).*_R1.*:_alignReport.txt:=} \
           -f \
           {} \
           {=s:_R1_:_R2_:=} \
           {=s:.*/:clones/:; s:(_[ATGC]{8}).*_R1.*:.vdjca:=}'
    ```

Options `--report` and `--json-report` are specified here explicitly. Since we start from RNA data and we want to assemble
a full-length receptor sequence we want to use `VTranscript` for the alignment of V segments (see [Gene features and anchor points](../reference/geneFeatures.md)).
Because its Ig sequences we use `kAligner2` aligner algorithm as the best option for this type of data. As has been 
mentioned above we use a build-in tag-pattern `mikelov_et_al_2021`. For a real data please provide a pattern with 
`--tag-pattern` option (see [Tag pattern](../reference/tag-pattern.md))

This step utilizes all available CPUs and scales perfectly. When there are a lot of CPUs, the only limiting factor is 
the speed of disk I/O. To limit the number of used CPUs one can pass `--threads N` option.

### `correctAndSortTags`

Corrects sequencing and PCR errors _inside_ barcode sequences. This step does extremely important job by correcting 
artificial diversity caused by errors in barcodes. In the considered example project it corrects only sequences of UMIs.

=== "Single file"
    ```shell
    > mixcr correctAndSortTags \
        --report MT_p03_PL_1_correctionReport.txt \
        MT_p03_PL_1.vdjca \
        MT_p03_PL_1_corrected.vdjca
    ```
=== "Multiple files"
    ```shell
    > ls *.vdjca | parallel -j2 \
      'mixcr correctAndSortTags \
          --report {=s:\.vdjca:_correctionReport.txt:=} \
          {} \
          {=s:\.vdjca:_corrected.vdjca:=}'
    ```

### `assemble`

Assembles clonotypes and applies several layers of errors correction. The layers of correction applied in this example are:

- assembly consensus CDR3 sequence for each UMI
- quality-aware correction for sequencing errors
- clustering to correct for PCR errors, which still may present even in the case of UMI data, since an error may be 
introduced e.g. on the first reverse-transcription cycle

=== "Single file"
    ```shell
    > mixcr assemble \
          -OassemblingFeatures=VDJRegion \
          -OseparateByC=true \
          -r MT_p03_PL_1_assembleReport.txt \
           MT_p03_PL_1_corrected.vdjca \
           MT_p03_PL_1.clns
    ```
=== "Multiple files"
    ```shell
    > ls *_corrected.vdjca | parallel -j2 \
      'mixcr assemble \
          -OassemblingFeatures=VDJRegion \
          -OseparateByC=true \
          -r {=s:_corrected.vdjca:_assembleReport.txt:=} \
          {} \
          {=s:_corrected.vdjca:.clns:=}'
    ```

In order to assemble a full-length Ig sequence we specify `VDJRegion` as the assembling feature. And since our C-gene 
primers were created in a way that we can distinguish different isotypes, we set `-OseparateByC=true` option, so the clones
with the same `VDJRegion` will be seperated by C-gene sequence.

Assembly step may be quite memory consuming for very big datasets. MiXCR offloads memory intensive computations to 
disk and does it in a highly efficient and parallelized way, fully utilizing all hardware facilities. For such big 
samples it may be worth to control the amount of RAM provided to MiXCR using `-Xmx` JVM option (the more RAM supplied 
the faster execution):
```shell
> mixcr -Xmx16g assemble ...
```

### exportClones

Finally, to export clonotype tables in tabular form `exportClones` is used:

=== "Single File"
    ```shell
    > mixcr exportClones \
        -p full \
        -uniqueTagCount UMI \
        MT_p03_PL_1.clns \
        MT_p03_PL_1.tsv
    ```
=== "Multiple files"
    ```shell
    > ls *.clns | parallel -j2 \
    'mixcr exportClones \
        -p full \
        -uniqueTagCount UMI \
        {} \
        {=s:.clns:.tsv:=}'
    ```

Here `-p full` is a shorthand for the full preset of common export columns and `-uniqueTagCount UMI` adds a column 
with the UMI count for each clone.  

