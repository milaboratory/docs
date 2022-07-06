# Data libraries

This tutorial uses the data from the publication:

Memory persistence and differentiation into antibody-secreting cells accompanied by positive selection in longitudinal 
BCR repertoires Artem I. Mikelov, Evgeniia I. Alekseeva, Ekaterina A. Komech, Dmitriy B. Staroverov, Maria A. Turchaninova,
Mikhail Shugay, Dmitriy M. Chudakov, Georgii A. Bazykin, Ivan V. Zvyagin bioRxiv 2021.12.30.474135; 
[doi: https://doi.org/10.1101/2021.12.30.474135](https://www.biorxiv.org/content/10.1101/2021.12.30.474135v2)

Blood samples from six young and middle-aged donors were collected at three time-points (T1 - 0, T2 - 1 month, 
T3 - 12 months). PBMC were isolated, stained and then sorted using FACS into the following populations: memory B cells, 
plasmablasts and plasma cells. IGH cDNA libraries were prepared using RACE approach as described previously 
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


