# NEBNext® Immune Sequencing

Here we will discuss how to process BCR cDNA libraries obtained with NEBNext® Immune Sequencing Kit.

## Data libraries

This tutorial uses the data from the following publication: *Germinal centre-driven maturation of B cell response to mRNA vaccination* Wooseob, et al, Nature volume 604, pages141–145 (2022)
[doi:10.1038/s41586-022-04527-1](https://doi.org/10.1038/s41586-022-04527-1)

The data includes samples taken from 8 patients before and several time points after receiving SARS-CoV-2 mRNA vaccine. Samples include: germinal center B cells from lymph node, plasmablasts from lymph node, plasma cells from bone marrow and memory B cells from blood. Sorted GC B cells and LNPCs from FNA, enriched BMPCs from bone marrow or enriched MBCs from PBMCs from blood were used for library preparation for bulk BCR sequecning. Circulating MBCs were magnetically isolated by first staining with IgD-PE and MojoSort anti-PE Nanobeads (BioLegend), and then processing with the EasySep Human B Cell Isolation Kit (StemCell Technologies) to negatively enrich IgDlo B cells. RNA was prepared from each sample using the RNeasy Plus Micro kit (Qiagen). Libraries were prepared using the NEBNext Immune Sequencing Kit for Human (New England Biolabs) according to the manufacturer’s instructions without modifications. Only heavy chain primers were used. High-throughput paired-end sequencing was performed on the Illumina MiSeq platform, 325 cycles for read 1 and 275 cycles for read 2.

On the scheme bellow you can see structure of cDNA library. UMI is located in the first 17 bp of R2, followed by 7 to 10 bp occurred in the process of template switching (TS).

??? "The set of primers used in NEBNext® Immune Sequencing Kit"
    === "Human"
        ```shell
        >Human-IGHM
        GAATTCTCACAGGAGACGAGG
        >Human-IGHD
        TGTCTGCACCCTGATATGATGG
        >Human-IGHA
        GGGTGCTGYMGAGGCTCAG
        >Human-IGHE
        TTGCAGCAGCGGGTCAAGG
        >Human-IGHG
        CCAGGGGGAAGACSGATG
        >Human-IGK
        GACAGATGGTGCAGCCACAG
        >Human-IGL
        AGGGYGGGAACAGAGTGAC
        >Human-TRA
        CACGGCAGGGTCAGGGTTC
        >Human-TRB
        CGACCTCGGGTGGGAACAC
        ```
    === "Mouse"
        ```shell
        >Mus-p5-IgGb
        CCAGGGACCAAGGGATAGAC
        >Mus-p5-IgGa
        CCAGTGGATAGACHGATGGGG
        >Mus-p5-IgE
        GCTTTAAGGGGTAGAGCTGAG
        >Mus-p5-IgD
        CTCTGAGAGGAGGAACATGTCA
        >Mus-p5-IgM
        GGGAAGACATTTGGGAAGGAC
        >Mus-p5-IgA
        GAATCAGGCAGCCGATTATCAC
        >Mus-p5-IgK
        AGATGGATGCAGTTGGTGCA
        >Mus-p5-IgL
        TCCTCAGAGGAAGGTGGAAAC
        >Mus-p5-TRAC
        ATCTTTTAACTGGTACACAGCAGG
        >Mus-p5-TRBC
        CAAGGAGACCTTGGGTGGAG
        >Mus-p5-TRGC
        AAGGAAGAAAAATAGTGGGCTTGG
        >Mus-p5-TRDC
        CATGATGAAAACAGATGGTTTGGC        
        ```
<figure markdown>
![NEBNext.svg](nebnext-bcr/NEBNext.svg)
</figure>

All data may be downloaded directly from SRA using e.g. [SRA Explorer](https://sra-explorer.info):
??? tip "Use this script to download the full data set with the proper filenames for the tutorial:"
    ```shell
    #!/usr/bin/env bash
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/032/SRR17709532/SRR17709532_1.fastq.gz -o 13_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/032/SRR17709532/SRR17709532_2.fastq.gz -o 13_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/033/SRR17709533/SRR17709533_1.fastq.gz -o 07_d110_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/033/SRR17709533/SRR17709533_2.fastq.gz -o 07_d110_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/034/SRR17709534/SRR17709534_1.fastq.gz -o 07_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/034/SRR17709534/SRR17709534_2.fastq.gz -o 07_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/036/SRR17709536/SRR17709536_1.fastq.gz -o 01a_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/036/SRR17709536/SRR17709536_2.fastq.gz -o 01a_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/031/SRR17709531/SRR17709531_1.fastq.gz -o 13_d110_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/031/SRR17709531/SRR17709531_2.fastq.gz -o 13_d110_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/035/SRR17709535/SRR17709535_1.fastq.gz -o 01a_d110_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/035/SRR17709535/SRR17709535_2.fastq.gz -o 01a_d110_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/030/SRR17709530/SRR17709530_1.fastq.gz -o 13_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/030/SRR17709530/SRR17709530_2.fastq.gz -o 13_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/029/SRR17709529/SRR17709529_1.fastq.gz -o 13_d110_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/029/SRR17709529/SRR17709529_2.fastq.gz -o 13_d110_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/027/SRR17709527/SRR17709527_1.fastq.gz -o 22_d110_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/027/SRR17709527/SRR17709527_2.fastq.gz -o 22_d110_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/028/SRR17709528/SRR17709528_1.fastq.gz -o 22_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/028/SRR17709528/SRR17709528_2.fastq.gz -o 22_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/026/SRR17709526/SRR17709526_1.fastq.gz -o 22_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/026/SRR17709526/SRR17709526_2.fastq.gz -o 22_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/025/SRR17709525/SRR17709525_1.fastq.gz -o 22_d110_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/025/SRR17709525/SRR17709525_2.fastq.gz -o 22_d110_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/024/SRR17709524/SRR17709524_1.fastq.gz -o 01a_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/024/SRR17709524/SRR17709524_2.fastq.gz -o 01a_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/022/SRR17709522/SRR17709522_1.fastq.gz -o 20_d110_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/022/SRR17709522/SRR17709522_2.fastq.gz -o 20_d110_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/023/SRR17709523/SRR17709523_1.fastq.gz -o 20_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/023/SRR17709523/SRR17709523_2.fastq.gz -o 20_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/021/SRR17709521/SRR17709521_1.fastq.gz -o 20_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/021/SRR17709521/SRR17709521_2.fastq.gz -o 20_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/020/SRR17709520/SRR17709520_1.fastq.gz -o 20_d110_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/020/SRR17709520/SRR17709520_2.fastq.gz -o 20_d110_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/019/SRR17709519/SRR17709519_1.fastq.gz -o 02a_d35_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/019/SRR17709519/SRR17709519_2.fastq.gz -o 02a_d35_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/018/SRR17709518/SRR17709518_1.fastq.gz -o 02a_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/018/SRR17709518/SRR17709518_2.fastq.gz -o 02a_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/017/SRR17709517/SRR17709517_1.fastq.gz -o 02a_d35_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/017/SRR17709517/SRR17709517_2.fastq.gz -o 02a_d35_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/015/SRR17709515/SRR17709515_1.fastq.gz -o 02a_d35_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/015/SRR17709515/SRR17709515_2.fastq.gz -o 02a_d35_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/016/SRR17709516/SRR17709516_1.fastq.gz -o 02a_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/016/SRR17709516/SRR17709516_2.fastq.gz -o 02a_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/014/SRR17709514/SRR17709514_1.fastq.gz -o 02a_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/014/SRR17709514/SRR17709514_2.fastq.gz -o 02a_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/013/SRR17709513/SRR17709513_1.fastq.gz -o 01a_d110_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/013/SRR17709513/SRR17709513_2.fastq.gz -o 01a_d110_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/012/SRR17709512/SRR17709512_1.fastq.gz -o 02a_d35_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/012/SRR17709512/SRR17709512_2.fastq.gz -o 02a_d35_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/011/SRR17709511/SRR17709511_1.fastq.gz -o 02a_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/011/SRR17709511/SRR17709511_2.fastq.gz -o 02a_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/009/SRR17709509/SRR17709509_1.fastq.gz -o 10_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/009/SRR17709509/SRR17709509_2.fastq.gz -o 10_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/010/SRR17709510/SRR17709510_1.fastq.gz -o 10_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/010/SRR17709510/SRR17709510_2.fastq.gz -o 10_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/008/SRR17709508/SRR17709508_1.fastq.gz -o 10_d110_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/008/SRR17709508/SRR17709508_2.fastq.gz -o 10_d110_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/007/SRR17709507/SRR17709507_1.fastq.gz -o 10_d110_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/007/SRR17709507/SRR17709507_2.fastq.gz -o 10_d110_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/006/SRR17709506/SRR17709506_1.fastq.gz -o 10_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/006/SRR17709506/SRR17709506_2.fastq.gz -o 10_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/005/SRR17709505/SRR17709505_1.fastq.gz -o 10_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/005/SRR17709505/SRR17709505_2.fastq.gz -o 10_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/003/SRR17709503/SRR17709503_1.fastq.gz -o 10_d110_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/003/SRR17709503/SRR17709503_2.fastq.gz -o 10_d110_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/004/SRR17709504/SRR17709504_1.fastq.gz -o 10_d110_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/004/SRR17709504/SRR17709504_2.fastq.gz -o 10_d110_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/002/SRR17709502/SRR17709502_1.fastq.gz -o 04_d28_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/002/SRR17709502/SRR17709502_2.fastq.gz -o 04_d28_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/001/SRR17709501/SRR17709501_1.fastq.gz -o 01a_d201_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/001/SRR17709501/SRR17709501_2.fastq.gz -o 01a_d201_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/000/SRR17709500/SRR17709500_1.fastq.gz -o 01a_d201_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/000/SRR17709500/SRR17709500_2.fastq.gz -o 01a_d201_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/099/SRR17709499/SRR17709499_1.fastq.gz -o 02a_d201_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/099/SRR17709499/SRR17709499_2.fastq.gz -o 02a_d201_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/098/SRR17709498/SRR17709498_1.fastq.gz -o 04_d201_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/098/SRR17709498/SRR17709498_2.fastq.gz -o 04_d201_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/096/SRR17709496/SRR17709496_1.fastq.gz -o 13_d201_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/096/SRR17709496/SRR17709496_2.fastq.gz -o 13_d201_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/097/SRR17709497/SRR17709497_1.fastq.gz -o 07_d201_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/097/SRR17709497/SRR17709497_2.fastq.gz -o 07_d201_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/095/SRR17709495/SRR17709495_1.fastq.gz -o 20_d201_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/095/SRR17709495/SRR17709495_2.fastq.gz -o 20_d201_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/094/SRR17709494/SRR17709494_1.fastq.gz -o 22_d201_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/094/SRR17709494/SRR17709494_2.fastq.gz -o 22_d201_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/092/SRR17709492/SRR17709492_1.fastq.gz -o 04_d201_d208_blood_memory_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/092/SRR17709492/SRR17709492_2.fastq.gz -o 04_d201_d208_blood_memory_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/093/SRR17709493/SRR17709493_1.fastq.gz -o 02a_d201_blood_memory_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/093/SRR17709493/SRR17709493_2.fastq.gz -o 02a_d201_blood_memory_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/091/SRR17709491/SRR17709491_1.fastq.gz -o 04_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/091/SRR17709491/SRR17709491_2.fastq.gz -o 04_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/089/SRR17709489/SRR17709489_1.fastq.gz -o 10_d201_blood_memory_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/089/SRR17709489/SRR17709489_2.fastq.gz -o 10_d201_blood_memory_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/090/SRR17709490/SRR17709490_1.fastq.gz -o 07_d201_blood_memory_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/090/SRR17709490/SRR17709490_2.fastq.gz -o 07_d201_blood_memory_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/088/SRR17709488/SRR17709488_1.fastq.gz -o 13_d201_blood_memory_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/088/SRR17709488/SRR17709488_2.fastq.gz -o 13_d201_blood_memory_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/086/SRR17709486/SRR17709486_1.fastq.gz -o 22_d201_blood_memory_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/086/SRR17709486/SRR17709486_2.fastq.gz -o 22_d201_blood_memory_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/087/SRR17709487/SRR17709487_1.fastq.gz -o 20_d201_blood_memory_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/087/SRR17709487/SRR17709487_2.fastq.gz -o 20_d201_blood_memory_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/085/SRR17709485/SRR17709485_1.fastq.gz -o 10_d280_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/085/SRR17709485/SRR17709485_2.fastq.gz -o 10_d280_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/084/SRR17709484/SRR17709484_1.fastq.gz -o 20_d280_bone_marrow_bone_marrow_plasma_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/084/SRR17709484/SRR17709484_2.fastq.gz -o 20_d280_bone_marrow_bone_marrow_plasma_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/083/SRR17709483/SRR17709483_1.fastq.gz -o 04_d28_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/083/SRR17709483/SRR17709483_2.fastq.gz -o 04_d28_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/082/SRR17709482/SRR17709482_1.fastq.gz -o 04_d60_lymph_node_plasmablast_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/082/SRR17709482/SRR17709482_2.fastq.gz -o 04_d60_lymph_node_plasmablast_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/080/SRR17709480/SRR17709480_1.fastq.gz -o 07_d110_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/080/SRR17709480/SRR17709480_2.fastq.gz -o 07_d110_lymph_node_germinal_center_B_cell_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/081/SRR17709481/SRR17709481_1.fastq.gz -o 07_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR177/081/SRR17709481/SRR17709481_2.fastq.gz -o 07_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz
    ```

The project contains 57 paired FASTQ files. Each file name encodes the information about donor, time-point relative to vaccination, tissue of origin and cell population. For example for the first file from the above listing:

13_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz
- 13 - donor id
- d60 - 60 days after vaccination
- lymph node - tissue
- germinal centerB cell - cell population

## Upstream analysis

The most straightforward way to get clonotype tables is to use a universal [`mixcr analyze`](../reference/mixcr-analyze.md) command.

According to the library preparation protocol, the library does not have any V primers on 5'-end and has C primers on 3', so the command for a single sample is the following:

```shell
> mixcr analyze amplicon \
    --species hsa \
    --starting-material rna \
    --receptor-type bcr \
    --5-end no-v-primers \
    --3-end c-primers \
    --adapters adapters-present \
    --umi-pattern '^(R1:*)\^(UMI:N{17})(R2:N{*})' \
    fastq/13_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz \
    fastq/13_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz \
    results/13_d60_lymph_node_germinal_center_B_cell
```

The meaning of these options is the following.

`--species`
:   is set to `hsa` for _Homo Sapience_

`--starting-material`
:   RNA or DNA. It affects the choice of V gene region which will be used as target in [`align`](../reference/mixcr-align.md) step (`vParameters.geneFeatureToAlign`, see [`align` documentation](../reference/mixcr-align.md)): `rna` corresponds to the `VTranscriptWithout5UTRWithP` and `dna` to `VGeneWithP` (see [Gene features and anchor points](../reference/ref-gene-features.md) for details)

`--receptor-type`
:   TCR or BCR. It affects the choice of underlying alignment algorithms: MiXCR uses fundamentally different algorithms for TCRs and BCRs because BCRs have somatic hypermutations and long indels.

`--5-end`
: is set to `no-v-primers`, because the library was obtained using 5'RACE. This leads to a global alignment algorithm on the left bound of V gene.

`--3-end-primers`
:  is set `c-primers` according to the cDNA library preparation protocol. This leads to a global alignment algorithm to align the right bound of C gene segment.

`--adapers`
:  is set to `adapters-present` because primer sequence is present in the data and has not been cut prior to. Presence or absence of adapter sequences results in the choice between local and global alignment algorithms on the edges of the target sequence.

`--umi-pattern`
:   is used to specify UMI pattern for the library. MiXCR provides a powerful regex-like [language](../reference/ref-tag-pattern.md) allowing to specify almost arbitrary barcode structure. Here we
use `^(R1:*)\^(UMI:N{17})(R2:N{*})` pattern to specify that R1 should be used as is, UMI spans the first 17 letters of R2 and the rest of R2 is used as a paired read.

Running the command above will generate the following files:

```shell
> ls result/

# human-readable reports 
13_d60_lymph_node_germinal_center_B_cell.report
# raw alignments (highly compressed binary file)
13_d60_lymph_node_germinal_center_B_cell.vdjca
# alignments with corrected UMI barcode sequences 
13_d60_lymph_node_germinal_center_B_cell.corrected.vdjca
# IGH, IGK and IGL CDR3 clonotypes (highly compressed binary file)
13_d60_lymph_node_germinal_center_B_cell.clns
# IGH, IGK and IGL CDR3 clonotypes exported in tab-delimited txt
13_d60_lymph_node_germinal_center_B_cell.clonotypes.IGH.tsv
13_d60_lymph_node_germinal_center_B_cell.clonotypes.IGK.tsv
13_d60_lymph_node_germinal_center_B_cell.clonotypes.IGL.tsv  

```

Obtained `*.tsv` files can be used for manual examination. `*.clns` files can be used for downstream analysis using [`mixcr postanalisis`](../reference/mixcr-postanalysis.md). By default, MiXCR exports clonotypes in a tab-delimited format separately for each immunological chain.

In order to run the analysis for all samples in the project on Linux we can use [GNU Parallel](https://www.gnu.org/software/parallel/) in the following way:

```shell
> ls /fastq/*_R1* | \
  parallel -j2 \
  'mixcr analyze amplicon \
    --species hsa \
    --starting-material rna \
    --receptor-type bcr \
    --5-end no-v-primers \
    --3-end c-primers \
    --adapters adapters-present \
    --umi-pattern "^(R1:*)\^(UMI:N{"17"})(R2:*)" \
    {} \
    {=s:R1:R2:=} \
    {=s:.*/:results:;s:_R1.*::=}'
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
    -OcParameters.parameters.floatingRightBound=true \
    --report results/13_d60_lymph_node_germinal_center_B_cell.report \
    --tag-pattern '^(R1:N{*})\^(UMI:N{17})(R2:N{*})' \
    fastq/13_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz \
    fastq/13_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz \
    13_d60_lymph_node_germinal_center_B_cell.vdjca
```
Option `--report` is specified here explicitly.
- `-p kAligner2` specifies an BCR aligner. 
- `-OvParameters.parameters.floatingLeftBound=false -OjParameters.parameters.floatingRightBound=false` are set to `false` because no V or J primers were used in cDNA library preparation. This results in a global aligning algorithm (instead of a local one) on the left bound of V gene and right bound of J gene.
- `-OcParameters.parameters.floatingRightBound=true` is set to `true` because C primers sequence is present on the 3'end of the cDNA library. Thus, local alignment algorithm will be used on the right bound of C gene. 

#### `correctAndSortTags`

[Corrects](../reference/mixcr-refineTagsAndSort.md) sequencing and PCR errors _inside_ barcode sequences. This step is essential to correct artificial diversity caused by errors in barcodes. 

```shell
> mixcr correctAndSortTags \
    --report 13_d60_lymph_node_germinal_center_B_cell.report \
    --json-report 13_d60_lymph_node_germinal_center_B_cell.report.json \
    13_d60_lymph_node_germinal_center_B_cell.vdjca \
    13_d60_lymph_node_germinal_center_B_cell.corrected.vdjca
```

#### `assemble`

Assembles alignments into clonotypes and applies several layers of errors correction(ex. quality-awared correction for sequencing errors, clustering to correct for PCR errors). Check [`mixcr assemble`](../reference/mixcr-assemble.md) for more information.

```shell
# assemble CDR3 clonotypes
> mixcr assemble \
    -OseparateByV=true \
    -OseparateByJ=true \
    --report 13_d60_lymph_node_germinal_center_B_cell.corrected.report \
    13_d60_lymph_node_germinal_center_B_cell.corrected.vdjca \
    13_d60_lymph_node_germinal_center_B_cell.corrected.clns
```

#### `export`

Exports clonotypes from `.clns` file into human-readable tables.
```shell
# export to tsv
> mixcr exportClones \
    -p full \
    13_d60_lymph_node_germinal_center_B_cell.corrected.clns \
    13_d60_lymph_node_germinal_center_B_cell.corrected.tsv
```
Here `-p full` defines the full preset of common export columns. Check [`mixcr export`](../reference/mixcr-export.md) for more information.

## Quality control

Now when we have all files processed lets perform Quality Control. That can be easily done using [`mixcr exportQc`](../reference/mixcr-exportQc.md)
function.

```shell
# obtain alignment quality control
> mixcr exportQc align \
    result/*.vdjca \
    alignQc.pdf

# obtain chain usage plot
> mixcr exportQc chainUsage \
    result/*.vdjca \
    usageQc.pdf
```

First let's examine the alignment quality control plot.

<figure markdown>
![alignQc.svg](nebnext-bcr/alignQc.svg)
</figure>

Most of the samples have a height successful alignment score. But samples that come from blood memory B cells clearly have a lower percentage of aligned reads, and the major reason for that is the lack of immune receptor sequences. That might be due to some issues during sample preparation of this particular kind. It is recommended to realign one of these samples and save not aligned reads into separate file for manual inspection. That can be done with the following command:

```shell
mixcr align \
    -p kAligner2 \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=false \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    --report 22_d201_blood_memory_B_cell.debug.report \
    --tag-pattern '^(R1:N{*})\^(UMI:N{17})(R2:N{*})' \
    -OvParameters.geneFeatureToAlign=VTranscriptWithP \
    -OvParameters.parameters.floatingLeftBound=true \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    --not-aligned-R1 22_d201_blood_memory_B_cell_R1.fastq \
    --not-aligned-R2 22_d201_blood_memory_B_cell.fastq \
    fastq/22_d201_blood_memory_B_cell_R1.fastq.gz fastq/22_d201_blood_memory_B_cell_R2.fastq.gz \
    22_d201_blood_memory_B_cell.debug.vdjca
```

If we look at the chain usage plot, we see, as expected, that the samples are almost entirely consist of IGH chains, since only heavy BCR chains we sequenced.

<figure markdown>
![chainUsage.svg](nebnext-bcr/chainUsage.svg)
</figure>


## Advanced parameters tuning

In the example above, we have assembled clones by a default `CDR3` feature. But NEBNext® Immune Sequencing Kit, as we can tell from the library structure scheme covers the whole sequence of V and J genes, because it is a 5'RACE based protocol. And not only that, but it also uses a set of primers which allows isotype differentiation. To reveal the full potential of this kit (separate clones by hypermutations and isotypes) we will modify the feature used to assemble clones, and we will also use C gene to separate clones by isotypes.

That can be done by modifying `mixcr analyze amplicon` parameters:

```shell
> mixcr analyze amplicon \
    --species hsa \
    --starting-material rna \
    --receptor-type bcr \
    --5-end no-v-primers \
    --3-end c-primers \
    --adapters adapters-present \
    --umi-pattern '^(R1:*)\^(UMI:N{17})(R2:N{*})' \
    --assemble "-OassemblingFeatures={FR1Begin:FR4End} -OseparateByC=true" \
    fastq/13_d60_lymph_node_germinal_center_B_cell_R1.fastq.gz \
    fastq/13_d60_lymph_node_germinal_center_B_cell_R2.fastq.gz \
    results/13_d60_lymph_node_germinal_center_B_cell
```

Under the hood this adjustment will pass extra arguments (`-OassemblingFeatures={FR1Begin:FR4End}`, `-OseparateByC=true`) to [`mixcr assemle`](../reference/mixcr-assemble.md) step.
