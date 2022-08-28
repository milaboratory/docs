# ABHelix
Here we will discuss how to process BCR cDNA libraries obtained with ABHelix kit.

## Data libraries

This tutorial uses the data from the following publication: *High frequency of shared clonotypes in human B cell receptor repertoires.* Soto C et al., , Nature, 2019 Feb;566(7744):398-402
[doi: 10.1038/s41586-019-0934-8](https://doi.org/10.1038/s41586-019-0934-8)

Peripheral blood samples were collected from three donors : HIP1 (female, 47 y.o.), HIP2 (male, 22 y.o.) and HIP3(male, 29 y.o.). Samples were collected in multiple replicas. Total RNA was extracted from PBMCs and multiple reactions of reverse transcription were combined and purified using magnetic beads. The purified RT products were divided evenly for the first round of PCR amplification specific to human IgG, IgL IgK, IgM, or IgA. The 5' multiplex PCR primers were designed within the leader sequences of each productive V gene and the 3' primers within the constant regions, but in close approximation to the J gene/constant region junctions. Second PCR was performed using leader and V-C junction primers. Subsequent amplicon libraries were sequenced using next-generation sequencing. Paired end sequencing was performed on Illumina HiSeq 2500, R1 and R2 are 250bp long.

The data for this tutorial can be downloaded using the script bellow.

```shell
#!/usr/bin/env bash
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365277/SRR8365277_1.fastq.gz -o SRR8365277_HIP1_female_IgG1_R1.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365278/SRR8365278_1.fastq.gz -o SRR8365278_HIP1_female_IgG2_R1.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365279/SRR8365279_1.fastq.gz -o SRR8365279_HIP1_female_IgG3_R1.fastq.gz
```

??? note "See full script"
    ```shell
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365277/SRR8365277_1.fastq.gz -o SRR8365277_HIP1_female_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365278/SRR8365278_1.fastq.gz -o SRR8365278_HIP1_female_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365279/SRR8365279_1.fastq.gz -o SRR8365279_HIP1_female_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365280/SRR8365280_1.fastq.gz -o SRR8365280_HIP1_female_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365281/SRR8365281_1.fastq.gz -o SRR8365281_HIP1_female_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365282/SRR8365282_1.fastq.gz -o SRR8365282_HIP1_female_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365283/SRR8365283_1.fastq.gz -o SRR8365283_HIP1_female_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365284/SRR8365284_1.fastq.gz -o SRR8365284_HIP1_female_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365285/SRR8365285_1.fastq.gz -o SRR8365285_HIP2_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365286/SRR8365286_1.fastq.gz -o SRR8365286_HIP2_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365287/SRR8365287_1.fastq.gz -o SRR8365287_HIP2_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365288/SRR8365288_1.fastq.gz -o SRR8365288_HIP2_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365289/SRR8365289_1.fastq.gz -o SRR8365289_HIP2_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365290/SRR8365290_1.fastq.gz -o SRR8365290_HIP2_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365291/SRR8365291_1.fastq.gz -o SRR8365291_HIP2_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365292/SRR8365292_1.fastq.gz -o SRR8365292_HIP2_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365293/SRR8365293_1.fastq.gz -o SRR8365293_HIP3_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365294/SRR8365294_1.fastq.gz -o SRR8365294_HIP3_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365295/SRR8365295_1.fastq.gz -o SRR8365295_HIP3_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365296/SRR8365296_1.fastq.gz -o SRR8365296_HIP3_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365297/SRR8365297_1.fastq.gz -o SRR8365297_HIP2_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365298/SRR8365298_1.fastq.gz -o SRR8365298_HIP2_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365299/SRR8365299_1.fastq.gz -o SRR8365299_HIP3_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365300/SRR8365300_1.fastq.gz -o SRR8365300_HIP3_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365311/SRR8365311_1.fastq.gz -o SRR8365311_HIP1_female_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365312/SRR8365312_1.fastq.gz -o SRR8365312_HIP1_female_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365313/SRR8365313_1.fastq.gz -o SRR8365313_HIP1_female_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365314/SRR8365314_1.fastq.gz -o SRR8365314_HIP1_female_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365315/SRR8365315_1.fastq.gz -o SRR8365315_HIP1_female_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365316/SRR8365316_1.fastq.gz -o SRR8365316_HIP1_female_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365317/SRR8365317_1.fastq.gz -o SRR8365317_HIP1_female_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365318/SRR8365318_1.fastq.gz -o SRR8365318_HIP1_female_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365319/SRR8365319_1.fastq.gz -o SRR8365319_HIP1_female_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365320/SRR8365320_1.fastq.gz -o SRR8365320_HIP1_female_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365323/SRR8365323_1.fastq.gz -o SRR8365323_HIP3_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365332/SRR8365332_1.fastq.gz -o SRR8365332_HIP2_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365333/SRR8365333_1.fastq.gz -o SRR8365333_HIP2_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365334/SRR8365334_1.fastq.gz -o SRR8365334_HIP2_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365335/SRR8365335_1.fastq.gz -o SRR8365335_HIP2_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365336/SRR8365336_1.fastq.gz -o SRR8365336_HIP2_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365337/SRR8365337_1.fastq.gz -o SRR8365337_HIP2_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365338/SRR8365338_1.fastq.gz -o SRR8365338_HIP2_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365339/SRR8365339_1.fastq.gz -o SRR8365339_HIP2_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365340/SRR8365340_1.fastq.gz -o SRR8365340_HIP3_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365341/SRR8365341_1.fastq.gz -o SRR8365341_HIP3_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365342/SRR8365342_1.fastq.gz -o SRR8365342_HIP2_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365343/SRR8365343_1.fastq.gz -o SRR8365343_HIP2_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365344/SRR8365344_1.fastq.gz -o SRR8365344_HIP3_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365345/SRR8365345_1.fastq.gz -o SRR8365345_HIP3_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365346/SRR8365346_1.fastq.gz -o SRR8365346_HIP3_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365347/SRR8365347_1.fastq.gz -o SRR8365347_HIP3_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365349/SRR8365349_1.fastq.gz -o SRR8365349_HIP2_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365350/SRR8365350_1.fastq.gz -o SRR8365350_HIP2_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365351/SRR8365351_1.fastq.gz -o SRR8365351_HIP2_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365352/SRR8365352_1.fastq.gz -o SRR8365352_HIP2_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365353/SRR8365353_1.fastq.gz -o SRR8365353_HIP2_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365354/SRR8365354_1.fastq.gz -o SRR8365354_HIP2_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365355/SRR8365355_1.fastq.gz -o SRR8365355_HIP2_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365356/SRR8365356_1.fastq.gz -o SRR8365356_HIP2_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365357/SRR8365357_1.fastq.gz -o SRR8365357_HIP2_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365358/SRR8365358_1.fastq.gz -o SRR8365358_HIP2_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365359/SRR8365359_1.fastq.gz -o SRR8365359_HIP3_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365360/SRR8365360_1.fastq.gz -o SRR8365360_HIP3_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365361/SRR8365361_1.fastq.gz -o SRR8365361_HIP3_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365362/SRR8365362_1.fastq.gz -o SRR8365362_HIP3_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365363/SRR8365363_1.fastq.gz -o SRR8365363_HIP3_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365364/SRR8365364_1.fastq.gz -o SRR8365364_HIP3_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365365/SRR8365365_1.fastq.gz -o SRR8365365_HIP3_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365366/SRR8365366_1.fastq.gz -o SRR8365366_HIP3_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365367/SRR8365367_1.fastq.gz -o SRR8365367_HIP3_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365368/SRR8365368_1.fastq.gz -o SRR8365368_HIP3_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365369/SRR8365369_1.fastq.gz -o SRR8365369_HIP3_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365370/SRR8365370_1.fastq.gz -o SRR8365370_HIP2_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365371/SRR8365371_1.fastq.gz -o SRR8365371_HIP2_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365372/SRR8365372_1.fastq.gz -o SRR8365372_HIP3_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365373/SRR8365373_1.fastq.gz -o SRR8365373_HIP2_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365374/SRR8365374_1.fastq.gz -o SRR8365374_HIP2_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365375/SRR8365375_1.fastq.gz -o SRR8365375_HIP2_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365376/SRR8365376_1.fastq.gz -o SRR8365376_HIP2_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365377/SRR8365377_1.fastq.gz -o SRR8365377_HIP2_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365378/SRR8365378_1.fastq.gz -o SRR8365378_HIP2_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365379/SRR8365379_1.fastq.gz -o SRR8365379_HIP2_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365380/SRR8365380_1.fastq.gz -o SRR8365380_HIP2_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365381/SRR8365381_1.fastq.gz -o SRR8365381_HIP3_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365382/SRR8365382_1.fastq.gz -o SRR8365382_HIP3_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365383/SRR8365383_1.fastq.gz -o SRR8365383_HIP3_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365384/SRR8365384_1.fastq.gz -o SRR8365384_HIP3_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365385/SRR8365385_1.fastq.gz -o SRR8365385_HIP3_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365386/SRR8365386_1.fastq.gz -o SRR8365386_HIP3_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365387/SRR8365387_1.fastq.gz -o SRR8365387_HIP3_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365388/SRR8365388_1.fastq.gz -o SRR8365388_HIP3_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365389/SRR8365389_1.fastq.gz -o SRR8365389_HIP3_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365390/SRR8365390_1.fastq.gz -o SRR8365390_HIP3_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365391/SRR8365391_1.fastq.gz -o SRR8365391_HIP1_female_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365392/SRR8365392_1.fastq.gz -o SRR8365392_HIP1_female_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365393/SRR8365393_1.fastq.gz -o SRR8365393_HIP1_female_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365394/SRR8365394_1.fastq.gz -o SRR8365394_HIP1_female_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365395/SRR8365395_1.fastq.gz -o SRR8365395_HIP1_female_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365396/SRR8365396_1.fastq.gz -o SRR8365396_HIP1_female_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365397/SRR8365397_1.fastq.gz -o SRR8365397_HIP1_female_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365398/SRR8365398_1.fastq.gz -o SRR8365398_HIP1_female_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365399/SRR8365399_1.fastq.gz -o SRR8365399_HIP1_female_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365400/SRR8365400_1.fastq.gz -o SRR8365400_HIP1_female_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365401/SRR8365401_1.fastq.gz -o SRR8365401_HIP3_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365402/SRR8365402_1.fastq.gz -o SRR8365402_HIP3_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365413/SRR8365413_1.fastq.gz -o SRR8365413_HIP3_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365414/SRR8365414_1.fastq.gz -o SRR8365414_HIP3_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365415/SRR8365415_1.fastq.gz -o SRR8365415_HIP3_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365416/SRR8365416_1.fastq.gz -o SRR8365416_HIP3_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365417/SRR8365417_1.fastq.gz -o SRR8365417_HIP3_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365425/SRR8365425_1.fastq.gz -o SRR8365425_HIP3_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365426/SRR8365426_1.fastq.gz -o SRR8365426_HIP3_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365427/SRR8365427_1.fastq.gz -o SRR8365427_HIP3_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365428/SRR8365428_1.fastq.gz -o SRR8365428_HIP1_female_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365429/SRR8365429_1.fastq.gz -o SRR8365429_HIP1_female_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365430/SRR8365430_1.fastq.gz -o SRR8365430_HIP1_female_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365431/SRR8365431_1.fastq.gz -o SRR8365431_HIP1_female_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365432/SRR8365432_1.fastq.gz -o SRR8365432_HIP1_female_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365433/SRR8365433_1.fastq.gz -o SRR8365433_HIP1_female_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365442/SRR8365442_1.fastq.gz -o SRR8365442_HIP3_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365445/SRR8365445_1.fastq.gz -o SRR8365445_HIP3_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365451/SRR8365451_1.fastq.gz -o SRR8365451_HIP2_male_IgG1_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365452/SRR8365452_1.fastq.gz -o SRR8365452_HIP2_male_IgG2_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365453/SRR8365453_1.fastq.gz -o SRR8365453_HIP2_male_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365454/SRR8365454_1.fastq.gz -o SRR8365454_HIP2_male_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365455/SRR8365455_1.fastq.gz -o SRR8365455_HIP2_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365466/SRR8365466_1.fastq.gz -o SRR8365466_HIP3_male_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365472/SRR8365472_1.fastq.gz -o SRR8365472_HIP2_male_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365476/SRR8365476_1.fastq.gz -o SRR8365476_HIP2_male_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365477/SRR8365477_1.fastq.gz -o SRR8365477_HIP2_male_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365478/SRR8365478_1.fastq.gz -o SRR8365478_HIP1_female_IgL_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365479/SRR8365479_1.fastq.gz -o SRR8365479_HIP1_female_IgK_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365480/SRR8365480_1.fastq.gz -o SRR8365480_HIP1_female_IgA_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365481/SRR8365481_1.fastq.gz -o SRR8365481_HIP1_female_IgM_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365486/SRR8365486_1.fastq.gz -o SRR8365486_HIP1_female_IgG4_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365487/SRR8365487_1.fastq.gz -o SRR8365487_HIP1_female_IgG3_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365277/SRR8365277_2.fastq.gz -o SRR8365277_HIP1_female_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365278/SRR8365278_2.fastq.gz -o SRR8365278_HIP1_female_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365279/SRR8365279_2.fastq.gz -o SRR8365279_HIP1_female_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365280/SRR8365280_2.fastq.gz -o SRR8365280_HIP1_female_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365281/SRR8365281_2.fastq.gz -o SRR8365281_HIP1_female_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365282/SRR8365282_2.fastq.gz -o SRR8365282_HIP1_female_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365283/SRR8365283_2.fastq.gz -o SRR8365283_HIP1_female_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365284/SRR8365284_2.fastq.gz -o SRR8365284_HIP1_female_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365285/SRR8365285_2.fastq.gz -o SRR8365285_HIP2_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365286/SRR8365286_2.fastq.gz -o SRR8365286_HIP2_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365287/SRR8365287_2.fastq.gz -o SRR8365287_HIP2_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365288/SRR8365288_2.fastq.gz -o SRR8365288_HIP2_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365289/SRR8365289_2.fastq.gz -o SRR8365289_HIP2_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365290/SRR8365290_2.fastq.gz -o SRR8365290_HIP2_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365291/SRR8365291_2.fastq.gz -o SRR8365291_HIP2_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365292/SRR8365292_2.fastq.gz -o SRR8365292_HIP2_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365293/SRR8365293_2.fastq.gz -o SRR8365293_HIP3_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365294/SRR8365294_2.fastq.gz -o SRR8365294_HIP3_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365295/SRR8365295_2.fastq.gz -o SRR8365295_HIP3_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365296/SRR8365296_2.fastq.gz -o SRR8365296_HIP3_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365297/SRR8365297_2.fastq.gz -o SRR8365297_HIP2_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365298/SRR8365298_2.fastq.gz -o SRR8365298_HIP2_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365299/SRR8365299_2.fastq.gz -o SRR8365299_HIP3_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365300/SRR8365300_2.fastq.gz -o SRR8365300_HIP3_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365311/SRR8365311_2.fastq.gz -o SRR8365311_HIP1_female_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365312/SRR8365312_2.fastq.gz -o SRR8365312_HIP1_female_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365313/SRR8365313_2.fastq.gz -o SRR8365313_HIP1_female_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365314/SRR8365314_2.fastq.gz -o SRR8365314_HIP1_female_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365315/SRR8365315_2.fastq.gz -o SRR8365315_HIP1_female_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365316/SRR8365316_2.fastq.gz -o SRR8365316_HIP1_female_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365317/SRR8365317_2.fastq.gz -o SRR8365317_HIP1_female_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365318/SRR8365318_2.fastq.gz -o SRR8365318_HIP1_female_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365319/SRR8365319_2.fastq.gz -o SRR8365319_HIP1_female_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365320/SRR8365320_2.fastq.gz -o SRR8365320_HIP1_female_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365323/SRR8365323_2.fastq.gz -o SRR8365323_HIP3_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365332/SRR8365332_2.fastq.gz -o SRR8365332_HIP2_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365333/SRR8365333_2.fastq.gz -o SRR8365333_HIP2_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365334/SRR8365334_2.fastq.gz -o SRR8365334_HIP2_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365335/SRR8365335_2.fastq.gz -o SRR8365335_HIP2_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365336/SRR8365336_2.fastq.gz -o SRR8365336_HIP2_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365337/SRR8365337_2.fastq.gz -o SRR8365337_HIP2_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365338/SRR8365338_2.fastq.gz -o SRR8365338_HIP2_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365339/SRR8365339_2.fastq.gz -o SRR8365339_HIP2_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365340/SRR8365340_2.fastq.gz -o SRR8365340_HIP3_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365341/SRR8365341_2.fastq.gz -o SRR8365341_HIP3_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365342/SRR8365342_2.fastq.gz -o SRR8365342_HIP2_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365343/SRR8365343_2.fastq.gz -o SRR8365343_HIP2_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365344/SRR8365344_2.fastq.gz -o SRR8365344_HIP3_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365345/SRR8365345_2.fastq.gz -o SRR8365345_HIP3_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365346/SRR8365346_2.fastq.gz -o SRR8365346_HIP3_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365347/SRR8365347_2.fastq.gz -o SRR8365347_HIP3_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365349/SRR8365349_2.fastq.gz -o SRR8365349_HIP2_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365350/SRR8365350_2.fastq.gz -o SRR8365350_HIP2_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365351/SRR8365351_2.fastq.gz -o SRR8365351_HIP2_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365352/SRR8365352_2.fastq.gz -o SRR8365352_HIP2_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365353/SRR8365353_2.fastq.gz -o SRR8365353_HIP2_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365354/SRR8365354_2.fastq.gz -o SRR8365354_HIP2_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365355/SRR8365355_2.fastq.gz -o SRR8365355_HIP2_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365356/SRR8365356_2.fastq.gz -o SRR8365356_HIP2_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365357/SRR8365357_2.fastq.gz -o SRR8365357_HIP2_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365358/SRR8365358_2.fastq.gz -o SRR8365358_HIP2_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365359/SRR8365359_2.fastq.gz -o SRR8365359_HIP3_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365360/SRR8365360_2.fastq.gz -o SRR8365360_HIP3_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365361/SRR8365361_2.fastq.gz -o SRR8365361_HIP3_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365362/SRR8365362_2.fastq.gz -o SRR8365362_HIP3_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365363/SRR8365363_2.fastq.gz -o SRR8365363_HIP3_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365364/SRR8365364_2.fastq.gz -o SRR8365364_HIP3_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365365/SRR8365365_2.fastq.gz -o SRR8365365_HIP3_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365366/SRR8365366_2.fastq.gz -o SRR8365366_HIP3_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365367/SRR8365367_2.fastq.gz -o SRR8365367_HIP3_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365368/SRR8365368_2.fastq.gz -o SRR8365368_HIP3_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365369/SRR8365369_2.fastq.gz -o SRR8365369_HIP3_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365370/SRR8365370_2.fastq.gz -o SRR8365370_HIP2_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365371/SRR8365371_2.fastq.gz -o SRR8365371_HIP2_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365372/SRR8365372_2.fastq.gz -o SRR8365372_HIP3_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365373/SRR8365373_2.fastq.gz -o SRR8365373_HIP2_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365374/SRR8365374_2.fastq.gz -o SRR8365374_HIP2_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365375/SRR8365375_2.fastq.gz -o SRR8365375_HIP2_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365376/SRR8365376_2.fastq.gz -o SRR8365376_HIP2_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365377/SRR8365377_2.fastq.gz -o SRR8365377_HIP2_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365378/SRR8365378_2.fastq.gz -o SRR8365378_HIP2_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365379/SRR8365379_2.fastq.gz -o SRR8365379_HIP2_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365380/SRR8365380_2.fastq.gz -o SRR8365380_HIP2_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365381/SRR8365381_2.fastq.gz -o SRR8365381_HIP3_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365382/SRR8365382_2.fastq.gz -o SRR8365382_HIP3_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365383/SRR8365383_2.fastq.gz -o SRR8365383_HIP3_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365384/SRR8365384_2.fastq.gz -o SRR8365384_HIP3_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365385/SRR8365385_2.fastq.gz -o SRR8365385_HIP3_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365386/SRR8365386_2.fastq.gz -o SRR8365386_HIP3_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365387/SRR8365387_2.fastq.gz -o SRR8365387_HIP3_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365388/SRR8365388_2.fastq.gz -o SRR8365388_HIP3_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365389/SRR8365389_2.fastq.gz -o SRR8365389_HIP3_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365390/SRR8365390_2.fastq.gz -o SRR8365390_HIP3_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365391/SRR8365391_2.fastq.gz -o SRR8365391_HIP1_female_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365392/SRR8365392_2.fastq.gz -o SRR8365392_HIP1_female_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365393/SRR8365393_2.fastq.gz -o SRR8365393_HIP1_female_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365394/SRR8365394_2.fastq.gz -o SRR8365394_HIP1_female_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365395/SRR8365395_2.fastq.gz -o SRR8365395_HIP1_female_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365396/SRR8365396_2.fastq.gz -o SRR8365396_HIP1_female_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365397/SRR8365397_2.fastq.gz -o SRR8365397_HIP1_female_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365398/SRR8365398_2.fastq.gz -o SRR8365398_HIP1_female_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365399/SRR8365399_2.fastq.gz -o SRR8365399_HIP1_female_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365400/SRR8365400_2.fastq.gz -o SRR8365400_HIP1_female_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365401/SRR8365401_2.fastq.gz -o SRR8365401_HIP3_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365402/SRR8365402_2.fastq.gz -o SRR8365402_HIP3_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365413/SRR8365413_2.fastq.gz -o SRR8365413_HIP3_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365414/SRR8365414_2.fastq.gz -o SRR8365414_HIP3_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365415/SRR8365415_2.fastq.gz -o SRR8365415_HIP3_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365416/SRR8365416_2.fastq.gz -o SRR8365416_HIP3_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365417/SRR8365417_2.fastq.gz -o SRR8365417_HIP3_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365425/SRR8365425_2.fastq.gz -o SRR8365425_HIP3_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365426/SRR8365426_2.fastq.gz -o SRR8365426_HIP3_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365427/SRR8365427_2.fastq.gz -o SRR8365427_HIP3_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365428/SRR8365428_2.fastq.gz -o SRR8365428_HIP1_female_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365429/SRR8365429_2.fastq.gz -o SRR8365429_HIP1_female_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365430/SRR8365430_2.fastq.gz -o SRR8365430_HIP1_female_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365431/SRR8365431_2.fastq.gz -o SRR8365431_HIP1_female_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365432/SRR8365432_2.fastq.gz -o SRR8365432_HIP1_female_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365433/SRR8365433_2.fastq.gz -o SRR8365433_HIP1_female_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365442/SRR8365442_2.fastq.gz -o SRR8365442_HIP3_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365445/SRR8365445_2.fastq.gz -o SRR8365445_HIP3_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365451/SRR8365451_2.fastq.gz -o SRR8365451_HIP2_male_IgG1_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365452/SRR8365452_2.fastq.gz -o SRR8365452_HIP2_male_IgG2_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/003/SRR8365453/SRR8365453_2.fastq.gz -o SRR8365453_HIP2_male_IgG3_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/004/SRR8365454/SRR8365454_2.fastq.gz -o SRR8365454_HIP2_male_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/005/SRR8365455/SRR8365455_2.fastq.gz -o SRR8365455_HIP2_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365466/SRR8365466_2.fastq.gz -o SRR8365466_HIP3_male_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/002/SRR8365472/SRR8365472_2.fastq.gz -o SRR8365472_HIP2_male_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365476/SRR8365476_2.fastq.gz -o SRR8365476_HIP2_male_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365477/SRR8365477_2.fastq.gz -o SRR8365477_HIP2_male_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/008/SRR8365478/SRR8365478_2.fastq.gz -o SRR8365478_HIP1_female_IgL_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/009/SRR8365479/SRR8365479_2.fastq.gz -o SRR8365479_HIP1_female_IgK_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/000/SRR8365480/SRR8365480_2.fastq.gz -o SRR8365480_HIP1_female_IgA_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/001/SRR8365481/SRR8365481_2.fastq.gz -o SRR8365481_HIP1_female_IgM_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/006/SRR8365486/SRR8365486_2.fastq.gz -o SRR8365486_HIP1_female_IgG4_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR836/007/SRR8365487/SRR8365487_2.fastq.gz -o SRR8365487_HIP1_female_IgG3_R2.fastq.gz
    ```

The project contains 136 FASTQ file pairs. For the purpose of this tutorial we assume that all fastq files are stored in `fastq/` folder. Each file name encodes the information about donor, sex and Ig chain and isotype. For example for the first file from above listing: 

- `SRR8365277` - sample id
- `HIP1` - patient id
- `female` - patient sex
- `IgG1` - Ig isotype

The structure of sequences is shown on the picture bellow. 

<figure markdown>
![ABHelix.svg](abhelix-bcr/ABHelix.svg)
</figure>

## Upstream analysis

The easiest way to obtain results from this type of data is to use `mixcr analyze amplicon` command in the following
manner:

```shell
> mixcr analyze amplicon \ 
    --species hsa \
    --starting-material rna \
    --receptor-type bcr \
    --5-end no-v-primers \
    --3-end j-primers \
    --adapters adapters-present \
    fastq/SRR8365277_HIP1_female_IgG1_R1.fastq.gz fastq/SRR8365277_HIP1_female_IgG1_R2.fastq.gz \
    result/SRR8365277_HIP1_female_IgG1_
```
Arguments explained:

`--species`
: is set to `hsa` for _Homo Sapience_

`--starting-material`
: `rna` It affects the choice of V gene region which will be used as target in [`align`](../reference/mixcr-align.md) step (`vParameters.geneFeatureToAlign`, see [`align` documentation](../reference/mixcr-align.md)). By specifying `rna` as starting material, `VTranscriptWithout5UTRWithP` will be used as `geneFeatureToAlign` for V segment.

`--receptor-type`
: `bcr`. It affects the choice of underlying alignment algorithms. Due to somatic hypermutations and long indels MiXCR uses a fundamentally different algorithm for BCRs.

`--5-end`
: is set to `no-v-primers` because samples were prepared using primers located in the leader region. This leads to a global alignment on the left bound of V gene.

`--3-end`
: is set to `j-primers`, since the J multiplex primers were used for library preparation. This choice leads to a local alignment on the right bound of J gene.(`adapters-present` required)

`--adapers`
: is set to `adapters-present` because primers sequences are present in the data and has not been cut prior to. Together with `--3-end j-primers` it leads to a local alignment on the right bound of J gene.

One may use the script bellow to process all samples together (see [GNU Parallel](https://www.gnu.org/software/parallel/)):

```shell
> ls fastq/*R1* | parallel -j 4 \
    'mixcr analyze amplicon \
          --species hsa \
          --starting-material rna \
          --receptor-type bcr \
          --5-end no-v-primers \
          --3-end j-primers \
          --adapters adapters-present \
          {} {=s:R1:R2:=} \
          {=s:.*/:results/:;s:_R.*::=}'
```

### Under the hood pipeline:

Under the hood the command above actually executes the following pipeline:

#### `align`
Alignment of raw sequencing reads against reference database of V-, D-, J- and C- gene segments.

```shell
# align raw reads
> mixcr align \
    -s hsa \
    -p kAligner2 \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=false \
    -OjParameters.parameters.floatingRightBound=true \
    -OcParameters.parameters.floatingRightBound=false \
    --report result/SRR8365277_HIP1_female_IgG1.report \
     fastq/SRR8365277_HIP1_female_IgG1_R1.fastq.gz fastq/SRR8365277_HIP1_female_IgG1_R2.fastq.gz \
     result/SRR8365277_HIP1_female_IgG1.vdjca
```

Option `--report` is specified here explicitly.

`-p`
: `kAligner2` specifies the specific BCR aligner.

`-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP"`
: Sets a V gene feature to align. Check [gene features](../reference/geneFeatures.md) for more info.

`-OvParameters.parameters.floatingLeftBound=false`
: Results in a global alignment algorithm for V gene left bound. 

`-OjParameters.parameters.floatingRightBound=true`
: Results in a local alignment algorithm for J gene right bound.

`-OcParameters.parameters.floatingRightBound=false`
: Results in a global alignment algorithm for C gene right bound.

#### `assemble`
Assembles alignments into clonotypes and applies several layers of errors correction(ex. quality-awared correction for sequencing errors, clustering to correct for PCR errors). Check [`mixcr assemble`](../reference/mixcr-assemble.md) for more information.

```shell
# assemble clonotypes
> mixcr assemble \
    -OseparateByV=true \
    result/SRR8365277_HIP1_female_IgG1.vdjca \
    result/SRR8365277_HIP1_female_IgG1.clns
```

`-OseparateByV=true`
: Separate clones with same `CDR3` sequence but different V-genes. This option is important for BCR data due to hypermutations in V region, but it shouldn't be used unless no V gene primer sequences present in the data.


#### `export`
Exports clonotypes from .clns file into human-readable tables.

```shell
# export to tsv
> mixcr exportClones \
    -p full \
    -c IGH
    result/SRR8365277_HIP1_female_IgG1.clns \
    result/SRR8365277_HIP1_female_IgG1.clonotypes.IGHtxt
    
> mixcr exportClones \
    -p full \
    -c IGK
    result/SRR8365277_HIP1_female_IgG1.clns \
    result/SRR8365277_HIP1_female_IgG1.clonotypes.IGK.txt
    
> mixcr exportClones \
    -p full \
    -c IGL
    result/SRR8365277_HIP1_female_IgG1.clns \
    result/SRR8365277_HIP1_female_IgG1.clonotypes.IGL.txt
```
Here `-p full` defines the full preset of common export columns. Check [`mixcr export`](../reference/mixcr-export.md) for more information.

`-с <chain>`
: defines a specific chain to be exported. By default `mixcr analyze` exports all chains in separate files.

By the end of upstream analysis you should have the following set of output files:

```shell
# human-readable reports 
SRR8365277_HIP1_female_IgG1.report

# raw alignments (highly compressed binary file)
SRR8365277_HIP1_female_IgG1.vdjca

# IGH, IGK and IGL clonotypes (highly compressed binary file)
SRR8365277_HIP1_female_IgG1.clns

# IGH, IGK and IGL clonotypes exported in tab-delimited txt
SRR8365277_HIP1_female_IgG1.clonotypes.IGH.txt
SRR8365277_HIP1_female_IgG1.clonotypes.IGK.txt
SRR8365277_HIP1_female_IgG1.clonotypes.IGL.txt
```

## Quality control

Now when we have processed all samples, we can proceed to quality control. First thing that we want to look at is the 
alignment quality. This can be easily done with the following command:

```shell
> mixcr exportQc align \
    result/*.vdjca \
    alignQc.pdf
```

<figure markdown>
![alignQc.svg](abhelix-bcr/alignQc.svg)
</figure>

From the plot above we see that most samples have high percentage of successfully aligned reads (above 90%). What we can
also tell is that from all the samples those that come from HIP1_female_IgG4 have a lower alignment rate:

- SRR8365486_HIP1_female_IgG4
- SRR8365430_HIP1_female_IgG4
- SRR8365394_HIP1_female_IgG4
- SRR8365317_HIP1_female_IgG4
- SRR8365280_HIP1_female_IgG4

That suggest a potential issue during sample preparation. Note that HIP3_male_IgG4 and HIP3_male_IgG3 sample also tend to
have a lower alignment rate.

Let's look at the same plot, but instead of percentages of reads  we will plot an absolute number of reads.

```shell
> mixcr exportQc align \
    --absolute-values \
    test_run/*.vdjca  \
    alignQcAbsolute.svg
```
<figure markdown>
![alignQcAbsolute.svg](abhelix-bcr/alignQcAbsolute.svg)
</figure>

Now we see, that nearly all bad samples have a significantly lower total reads count. 
Next, lets take a closer look at SRR8365280_HIP1_female_IgG4, because it has a lot of reads compared to other low quality samples but most of them lack Ig sequences. By default, MiXCR removed non target reads during alignment. We will realign this sample using options `-OallowPartialAlignments=true` and `-OallowNoCDR3PartAlignments=true` to preserve partially aligned reads. We will also save not aligned reads (`--not-aligned-R1`, `--not-aligned-R2`) to separate FASTQ files for manual inspection. See [`mixcr align`](../reference/mixcr-align.md) for more details.

Bellow is the complete command:

```shell
> mixcr align \
    -s hsa \
    -p kAligner2 \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=false \
    -OjParameters.parameters.floatingRightBound=true \
    -OcParameters.parameters.floatingRightBound=false \
    -OallowPartialAlignments=true \
    -OallowNoCDR3PartAlignments=true \
    --not-aligned-R1 SRR8365280_HIP1_female_IgG4_notAligned_R1.fastq \
    --not-aligned-R2 SRR8365280_HIP1_female_IgG4_notAligned_R2.fastq \
    -r SRR8365280_HIP1_female_IgG4_debug.report \
     fastq/SRR8365280_HIP1_female_IgG4_R1.fastq.gz fastq/SRR8365280_HIP1_female_IgG4_R2.fastq.gz \
     SRR8365280_HIP1_female_IgG4_debug.vdjca
```

Resulting `SRR8365280_HIP1_female_IgG4_notAligned_R1.fastq` and `SRR8365280_HIP1_female_IgG4_notAligned_R1.fastq` files can be manually expected. A brief [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi) search revealed that a lot of reads align with PhiX, which is regularly used as a DNA sequencing control in Illumina protocol. Bellow you can see a few reads from  `SRR8365280_HIP1_female_IgG4_notAligned_R2.fastq`.

```shell
@SRR8365280.116 GWZHISEQ01:570:HYJYKBCXX:1:1101:12039:44077/2
GAGAGATGAGATTGAGGCTGGGAAAAGTTACTGTAGCCGACGTTTTGGCGGCGCAACCTGTGACGACAAATCTGCTCAAATTTATGCGCGCTTCGATAAAAATGATTGGCGTATCCAACCTGCAGAGTTTTATCGCTTCCATGACGCAGAAGTTAACACTTTCGGATATTTCTGATGAGTCGAAAAATTATCTTGATAAAGCAGGAATTACTACTGCTTGTTTACGAATTAAATCGAAGTGGACTGCTGGC
+
DDBDD<GHHIFHIHIIIEHIGGIIIIIIGHIIIICHIIIIIHEHHHHDHIICHHHIIIIIIIIIIIGDHIIFHIIIIIGIIIIIHIHHIHIIHIIHHIIIIHIIIIIIIIIIIIIGIIIIHIIIIEHHIIHHHGIIIIIIIIIIIIIHIIIHIHHIIIIIIHIIIII=FHHIFHCGHG?HIIIIGIIIIEHCFHHII?GHH.FHEHIIHHHH-BGHHHHGFHIIIHI.5B6-8@F-B@HHHHIIIIGFE?-
@SRR8365280.117 GWZHISEQ01:570:HYJYKBCXX:1:1101:13143:44082/2
ACGATGAGGGACATAAAAAGTAAAAATGTCTACAGTAGAGTCAATAGCAAGGCCACGACGCAATGGAGAAAGACGGAGAGCGCCAACGGCGTCCATCTCGAAGGAGTCGCCAGCGATAACCGGAGTAGTTGAAATGGTAATAAGACGACCAATCTGACCAGCAAGGAAGCCAAGATGGGAAAGGTCATGCGGCATACGCTCGGCGCCAGTTTGAATATTAGACATAATTTATCCTCAAGTAAGGGGCCGAA
+
DDDDBIIIIIHHGHHIHHHIIIFIGIHHIIHHIIIIIHHIHIIIIEHHHGIIIIIIIIIHHIIIIIIHIIIFHIHIIIIIHGHIIIIHIIIIIHIHIIIIIDGHHHHIGIIHIIIIIIIIIGHIHGHHHHHIHIIEHIIII@HHIIIIIIIHIHIIHHIHIHIIIIIHIIII.BEGHGII?FHGHFHHHCDHIIIIHHCEHHIHIGIIIAHGEEEHH?FH?AFFHFHHHHH?FCH--BHHHHHE@,,>??H
@SRR8365280.118 GWZHISEQ01:570:HYJYKBCXX:1:1101:9938:44446/2
AGAAGAAAACGTGCGTCAAAAATTACGTGCAGAAGGAGTGATGTAATGTCTAAAGGTAAAAAACGTTCTGGCGCTCGCCCTGGTCGTCCGCAGCCGTTGCGAGGTACTAAAGGCAAGCGTAAAGGCGCTCGTCTTTGGTATGTAGGTGGTCAACAATTTTAATTGCAGGGGCTTCGGCCCCTTACTTGAGGATAAATTATGTCTAATATTCAAACTGGCGCCGAGCGTATGCCGCATGACCTTTCCCATCT
+
DDDDDIIGIIIIIIHGHHHHHHHIIIIHIF?HHIII?FHIIHIIIEHFHHIIIIIIIIHIIIIIIHIIIHIIIIIIIIIIIIIIIIIGIIIIIIIIHHHIHHHHIIIIHIIIIIIIHIIIHIIHIGIICGHCHHIHHGEEEEHIIIIIIIIIIIGHIIIIIIIIHIIICE<CHIIHHIIHIHIIIIFHIIIIIIHHEGEHHAFEECHIGHIIIIIG?E?EEH?CHGIGHII?GHIDDHHHIIIHEHEFB-A
```

Now lets look inside `SRR8365280_HIP1_female_IgG4_debug.vdjca` file witch now has partially aligned reads in it.
That can be easily achieved using [`mixcr exportAlignmentsPretty`](../reference/mixcr-exportPretty.md#raw-alignments).

The function bellow will generate a `.txt` human-readable file with alignments. We use parameter `--skip 1000` to skip first 1000 reads, as first reads usually have bad quality, and `--limit 100` will export only 100 alignments.

```shell
> mixcr exportAlignmentsPretty \
    --skip 1000 \
    --limit 100 \
    SRR8365280_HIP1_female_IgG4_debug.vdjca \
    SRR8365280_HIP1_female_IgG4_debug.alignments.txt
```

If we look in the file we can spot how some troubled alignments look like. Bellow you can see one alignment from that file. First read aligns with a good score to IGHV1-69D. But its pair consists of low-quality nucleotides and can't be aligned against ahy IGHJ.

Further analysis might help reveal where such low quality reads come from.

```shell
>>> Read ids: 12846


                                                L1><L2     L2><FR1
                _ T  R  F  L  F  V  V  A  A  A  T  G  V  Q  S  Q  V  Q  L  V  Q  S  G  P  E  V
     Quality    76767888777877765777666775777788877737576737677788888767777778357777767777667877
     Target0  0 CACTAGGTTCCTCTTTGTGGTGGCAGCAGCTACAGGTGTCCAGTCCCAGGTGCAGCTGGTGCAGTCTGGGCCTGAGGTGA 79  Score
IGHV1-69D*00 11 cTGGaggttcctctttgtggtggcagcagctacaggtgtccagtcccaggtgcagctggtgcagtctgggGctgaggtga 90  1901

                                                     FR1><CDR1              CDR1><FR2
                K  K  P  G  S  S  V  K  V  S  C  E  A  S  G  G  T  F  S  N  F  A  V  N  W  V  R
     Quality    87888877888677675673763577787777777786767777776667878888888773577677878867775677
     Target0 80 AGAAGCCTGGGTCGTCGGTGAAGGTCTCCTGCGAGGCTTCTGGAGGCACCTTCAGTAACTTTGCTGTCAACTGGGTGCGA 159  Score
IGHV1-69D*00 91 agaagcctgggtcCtcggtgaaggtctcctgcAaggcttctggaggcaccttcagCaGctAtgctAtcaGctgggtgcga 170  1901

                                                 FR2><CDR2              CDR2><FR3
                  Q  A  P  G  Q  G  L  E  W  V  G  G  I  I  P  L  F  N  V  A  K  Y  A  Q  K  F  E
     Quality     77787778865577867376625733535577887777787767786772253677767777677777787777766667
     Target0 160 CAGGCCCCTGGACAAGGGCTTGAGTGGGTGGGAGGGATCATCCCTCTATTTAATGTGGCAAAGTACGCACAGAAGTTCGA 239  Score
IGHV1-69D*00 171 caggcccctggacaagggcttgagtggAtgggagggatcatccctAtCtttGGtACAgcaaaCtacgcacagaagttcCa 250  1901


                   G  R  V _
     Quality     76677566676
     Target0 240 GGGCAGAGTCA 250  Score
IGHV1-69D*00 251 gggcagagtca 261  1901


Quality   26426422222222222562442222424424255222225225222225224226522255252272242277525257
Target1 0 GGTTGGTTGGCGGGCTCATCCCGCTATTTAATGTGGGGATGTACGCACTGAGGTACGTTGGCAGGGTCCCGGTTGTCGCG 79  Score


Quality    72737277523535532353332333335333222235526353536262252522222577533555352225673735
Target1 80 GACGATTCAGTGGGCTGTGCTTACGTAGACATTGCCCGCTTGCGATCTGCCGCCAGCGCCGTGTATTACTGTGCGGCTTC 159  Score


Quality     53333223353333655367555355333325223333535353355335367777733353335333333533533533
Target1 160 AGGTGGCGACGTCCTGTGATATGACTACAAGGCCCCCTAAGGGGATGAACTATGGGGGCAATCGACAATAGTGACCGTCT 239  Score


Quality     33533233333
Target1 240 ACTAAGTTTCG 250  Score
```

Finally, lets check chain usage among all samples.

```shell
> mixcr exportQc chainUsage \
    test_run/*.vdjca \
    chainUsage.pdf
```

Bellow is plot visualizing chain usage distribution among all samples. The plot suggests that this data has a low cross-contamination level, since almost all clones from IgG1, IgG2,IgG3,IgG4,IgM and IgA samples are IGH, and samples with IgK and IgL mostly consist of IGK and IGL clones.

<figure markdown>
![chainUsage.svg](abhelix-bcr/chainUsage.svg)
</figure>

## Advanced settings
By default `mixcr assemble` assembles clones by `CDR3` sequence. But in case of BCR data, due to hypermutations in V region, we usually want to extend that assemble feature so clones with different V gene sequences will be separated regardless of the same V-gene name. This is only possible if ore reads long enough to cover most of the V gene and if we a sure, that primer sequences will not introduce any bias.

ABhelix library preparation protocol is designed in such a way that forward primers are located in the V gene leader sequence. Thus, when we assemble clones we can actually use that part of V gene. The easiest way to utilize that "extra" sequence is to pass an extended [assembling feature](../reference/mixcr-assemble.md) to `mixcr analyze amplicon` command.

```shell
> mixcr analyze amplicon \
    --species hsa \
    --starting-material rna \
    --receptor-type bcr \
    --5-end no-v-primers \
    --3-end j-primers \
    --adapters adapters-present \
    --assemble "-OassemblingFeatures={FR1Begin:CDR3End}"
    fastq/SRR8365277_HIP1_female_IgG1_R1.fastq.gz fastq/SRR8365277_HIP1_female_IgG1_R2.fastq.gz \
    result/SRR8365277_HIP1_female_IgG1_
```

Under the hood `-OassemblingFeatures={FR1Begin:CDR3End}` will be passed to [`mixcr asemble`](../reference/mixcr-assemble.md). 