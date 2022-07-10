# 10xGenomics Single Cell V(D)J kit

Here we will discuss how to process cDNA libraries obtained with 10x Genomics V(D)J kit.

### Alignment
Let's say we have a folder `fastq/` with FASTQ file pairs.

??? note "Show files"
    ```
    ls fastq/
    
    lc-p10_scCD4_VDJ_E1_1_R1_001.fastq.gz  lc-p10_scCD4_VDJ_E2_2_R1_001.fastq.gz  lc-p17_scCD4_VDJ_E1_3_R1_001.fastq.gz  lc-p17_scCD4_VDJ_E2_4_R1_001.fastq.gz  lc-p20_scCD4_VDJ_E2_1_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_1_R2_001.fastq.gz  lc-p10_scCD4_VDJ_E2_2_R2_001.fastq.gz  lc-p17_scCD4_VDJ_E1_3_R2_001.fastq.gz  lc-p17_scCD4_VDJ_E2_4_R2_001.fastq.gz  lc-p20_scCD4_VDJ_E2_1_R2_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_2_R1_001.fastq.gz  lc-p10_scCD4_VDJ_E2_3_R1_001.fastq.gz  lc-p17_scCD4_VDJ_E1_4_R1_001.fastq.gz  lc-p20_scCD4_VDJ_E1_1_R1_001.fastq.gz  lc-p20_scCD4_VDJ_E2_2_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_2_R2_001.fastq.gz  lc-p10_scCD4_VDJ_E2_3_R2_001.fastq.gz  lc-p17_scCD4_VDJ_E1_4_R2_001.fastq.gz  lc-p20_scCD4_VDJ_E1_1_R2_001.fastq.gz  lc-p20_scCD4_VDJ_E2_2_R2_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_3_R1_001.fastq.gz  lc-p10_scCD4_VDJ_E2_4_R1_001.fastq.gz  lc-p17_scCD4_VDJ_E2_1_R1_001.fastq.gz  lc-p20_scCD4_VDJ_E1_2_R1_001.fastq.gz  lc-p20_scCD4_VDJ_E2_3_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_3_R2_001.fastq.gz  lc-p10_scCD4_VDJ_E2_4_R2_001.fastq.gz  lc-p17_scCD4_VDJ_E2_1_R2_001.fastq.gz  lc-p20_scCD4_VDJ_E1_2_R2_001.fastq.gz  lc-p20_scCD4_VDJ_E2_3_R2_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_4_R1_001.fastq.gz  lc-p17_scCD4_VDJ_E1_1_R1_001.fastq.gz  lc-p17_scCD4_VDJ_E2_2_R1_001.fastq.gz  lc-p20_scCD4_VDJ_E1_3_R1_001.fastq.gz  lc-p20_scCD4_VDJ_E2_4_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_4_R2_001.fastq.gz  lc-p17_scCD4_VDJ_E1_1_R2_001.fastq.gz  lc-p17_scCD4_VDJ_E2_2_R2_001.fastq.gz  lc-p20_scCD4_VDJ_E1_3_R2_001.fastq.gz  lc-p20_scCD4_VDJ_E2_4_R2_001.fastq.gz
    lc-p10_scCD4_VDJ_E2_1_R1_001.fastq.gz  lc-p17_scCD4_VDJ_E1_2_R1_001.fastq.gz  lc-p17_scCD4_VDJ_E2_3_R1_001.fastq.gz  lc-p20_scCD4_VDJ_E1_4_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E2_1_R2_001.fastq.gz  lc-p17_scCD4_VDJ_E1_2_R2_001.fastq.gz  lc-p17_scCD4_VDJ_E2_3_R2_001.fastq.gz  lc-p20_scCD4_VDJ_E1_4_R2_001.fastq.gz
    ```
File name explained:

`lc-p10_scCD4_VDJ_E1_1_R1_001.fastq.gz`

- `lc-p10` is a patient ID.
- `E1` is a replica number. There are two replicas for every patient.
- `1` is the number of 10x primer. According to 10x protocol it is common that every sample results in 4
raw FASTQ file pairs.
- `R1` is a read number

First thing we want to do is to align reads against reference sequence and extract CELL and UMI barcodes
sequences.

!!! note "How to deal with 4 FASTQ file pairs per sample"
    Usually it is necessary to concatenate 4 pairs into a single pair of files prior to analysis. But 
    MiXCR allows a very convenient way to pass all files to the align command simultaneously.
    Instead of passing the exact file names we will use `{{n}}` wildcard to describe all samples.

??? hint "example"
    ```
    lc-p10_scCD4_VDJ_E1_1_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_1_R2_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_2_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_2_R2_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_3_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_3_R2_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_4_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_4_R2_001.fastq.gz
    ```
    To pass all files above we use the following syntax:
    ```
    lc-p10_scCD4_VDJ_E1_{{n}}_R1_001.fastq.gz
    lc-p10_scCD4_VDJ_E1_{{n}}_R2_001.fastq.gz
    ```

According to the library preparation protocol, `mixcr` command should look like this:
=== "Single pair of files"
    ```
    mixcr align \
        --species HomoSapiens \
        --tag-pattern-name 10x \
        -OvParameters.geneFeatureToAlign=VTranscript \
        -OvParameters.parameters.floatingLeftBound=false \
        -OjParameters.parameters.floatingRightBound=false \
        -OcParameters.parameters.floatingRightBound=false \
        -OallowPartialAlignments=true \
        -OallowNoCDR3PartAlignments=true \
        -r lc-p20_E2_alignReport.txt \
        /fastq/lc-p20_scCD4_VDJ_E2_{{n}}_R1_001.fastq.gz \
        /fastq//lc-p20_scCD4_VDJ_E2_{{n}}_R2_001.fastq.gz \
        lc-p20_E2.vdjca
    ```
=== "Multiple files"
    ```
    ls /fastq/*_R1* | \
    sed 's:_[0-9]_R:_\{\{n\}\}_R:g' | uniq | \
    nice -n 19 parallel -j2  \
    'mixcr align \
         --species HomoSapiens \
         --tag-pattern-name 10x \
         -OvParameters.geneFeatureToAlign=VTranscript \
         -OvParameters.parameters.floatingLeftBound=false \
         -OjParameters.parameters.floatingRightBound=false \
         -OcParameters.parameters.floatingRightBound=false \
         -OallowPartialAlignments=true \
         -OallowNoCDR3PartAlignments=true \
         -r {=s:.*/:clones/:; s:_E([0-9]).*_R1.*:_E$1_alignReport.txt:;s:_scCD4_VDJ_:_:=} \
         -f \
         {} \
         {=s:_R1_:_R2_:=} \
         {=s:.*/:clones/:; s:_E([0-9]).*_R1.*:_E$1.vdjca:;s:_scCD4_VDJ_:_:=}'
    ```

- `--species HomoSapiens` sets the reference to Human
- `--tag-pattern-name 10x` MiXCR has a builtin 10xGenomics barcode so there is no need to set it 
manually, so we only use a name for it.
- `-OvParameters.geneFeatureToAlign=VTranscript` Feature to align is set to `VTranscript` because
    sequences randomly cover the whole transcript starting from 5'UTR.

The following set of parameters is needed because reads lack adaptor or primer sequences thus we can be sure that 
on both ends we have an actual с,lne sequence that should be preserved for assembling step:

- `-OvParameters.parameters.floatingLeftBound=false`
- `-OjParameters.parameters.floatingRightBound=false`
- `-OcParameters.parameters.floatingRightBound=false` 

Running the command above will generate a binary `.vdjca` alignment file.
??? note "What's inside?"
    We can dig into the alignments by means of `mixcr exportAlignmentsPretty` command:

    ```
    > mixcr exportAlignmentsPretty lc-p20_E2.vdjca

    >>> Read ids: 0
    
    
                                        FR1><CDR1     CDR1><FR2
                     I  M  L  E  C  S  Q  T  K  G  H  D  R  M  Y  W  Y  R  Q  D  P  G  L  G  L  R  L
        Quality     67675777777777777777777577677677777677777777777777777777777777777777777777777777
        Target0   0 ATTATGCTGGAATGTTCTCAGACTAAGGGTCATGATAGAATGTACTGGTATCGACAAGACCCAGGACTGGGCCTACGGTT 79   Score
    TRBV24-1*00 211 attatgctggaatgttctcagactaagggtcatgatagaatgtactggtatcgacaagacccaggactgggcctacggtt 290  595
    
                          FR2><CDR2        CDR2><FR3
                      I  Y  Y  S  F  D  V  K  D  I  N  K  G _
        Quality     77777777777777777777777777777470777766600
        Target0  80 GATCTATTACTCCTTTGATGTCAAAGATATAAACAAAGGGC 120  Score
    TRBV24-1*00 291 gatctattactcctttgatgtcaaagatataaacaaagg   329  595
    
    >>> Read ids: 1
    
    
                   <J        CDR3><FR4                    FR4><C
                  _ T  E  A  F  F  G  Q  G  T  R  L  T  V  V  E  D  L  N  K  V  F  P  P  E  V  A
    Quality    00666777777777777777777777777777777777777777777777777777777777777767777777777777
    Target0  0 AACTGAAGCTTTCTTTGGACAAGGCACCAGACTCACAGTTGTAGAGGACCTGAACAAGGTGTTCCCACCCGAGGTCGCTG 79  Score
    TRBJ1-1*00 25  actgaagctttctttggacaaggcaccagactcacagttgtag                                     67  215
    TRBC1*00  0                                             aggacctgaacaaggtgttcccacccgaggtcgctg 35  169
    
    
                V  F  E  P  S  E  I  G  R  A  S  C  R  E
    Quality    77777767777776767777777772777777777226776
    Target0 80 TGTTTGAGCCATCAGAGATCGGAAGAGCGTCGTGTAGGGAA 120  Score
    TRBC1*00 36 tgtttgagccatcaga-aGcAg-agaTcTCcCACACCCAaa 74   169
    
    >>> Read ids: 2
    
    
                                                        FR1><CDR1     CDR1><FR2
                   _  E  K  G  K  D  V  E  L  R  C  D  P  I  S  G  H  T  A  L  Y  W  Y  R  Q  S  L
    Quality     77677777226775777677777767777267275777776277227776772776742247567777777777777775
    Target0   0 CAGAGAAGGGAAAGGATGTAGAGCTCAGGTGTGATCCAATTTCAGGTCATACTGCCCTATACTGGTACCGACAGAGCCTG 79   Score
    TRBV7-2*00 194 cagagaagggaaaggatgtagagctcaggtgtgatccaatttcaggtcatactgccctTtactggtaccgacagagcctg 273  591
    
                                          FR2><CDR2
                    G  Q  G  L  E  F  L  I  Y  F  Q  G  N _
    Quality     27775777777777767762776776726777777766600
    Target0  80 GGGCAGGGCCTGGAGTTTTTAATTTACTTCCAAGGCAACAG 120  Score
    TRBV7-2*00 274 gggcagggcctggagtttttaatttacttccaaggcaacag 314  591
    ```
### Barcode error correction

Just as in any other sequences' error might occur inside UMI or CELL barcodes itself. This may lead to a false diversity
increase. MiXCR allows to correct erroneous barcodes.

=== "Single file"
    ```
    mixcr correctAndSortTags \
     -f \
     --report lc-p20_E2_correctionReport.txt \
    lc-p20_E2.vdjca lc-p20_E2_corrected.vdjca
    ```
=== "Multiple files"
    ```
    ls *.vdjca | parallel -j2 \
    'mixcr correctAndSortTags \
    -f \
    --report {=s:\.vdjca:_correctionReport.txt:=} \
    {} {=s:\.vdjca:_corrected.vdjca:=}'
    ```


### Assemble

Assemble PArtial 

=== "Single file"
    ```
    mixcr assemblePartial \
    -f \
    --report lc-p20_E2_assemblePartialReport.txt \
    lc-p20_E2_corrected.vdjca lc-p20_E2_partialAssemble.vdjca
    ```
=== "Multiple files"
    ```
    ls clones/*_corrected.vdjca | parallel -j2 \
    'mixcr assemblePartial \
    -f \
    --report {=s:_corrected.vdjca:_assemblePartialReport.txt:=} \
    {} {=s:_corrected.vdjca:_partialAssemble.vdjca:=}'
    ```


Assemble

=== "Single file"
    ```
    mixcr assemble \
    -f \
    --report lc-p20_E2_assembleReport.txt \
    lc-p20_E2_partialAssemble.vdjca lc-p20_E2.clna
    ```
=== "Multiple files"
    ```
    ls clones/*_partialAssemble.vdjca | parallel -j2 \
    'mixcr assemble \
    -r {=s:_partialAssemble.vdjca:_assembleReport.txt:=} \
    -f \
    -a \
    {} {=s:_partialAssemble.vdjca:.clna:=}'
    ```

Assemble Contigs

=== "Single file"
    ```
    mixcr assembleContigs \
    -f \
    --report lc-p20_E2_assembleContigsReport.txt \
    lc-p20_E2.clna lc-p20_E2.clns
    ```
=== "Multiple files"
    ```
    ls clones/*.clna | parallel -j2 \
    'mixcr assembleContigs \
    -r {=s:\.clna:_assembleContigsReport.txt:=} \
    -f \
    {} {=s:\.clna:.clns:=}'
    ```