# iRepertoure TCR

Here we will discuss how to process the data obtained using iRepertoire TCR LR kit. This is a multiplex protocol designed in such a way that forward primers are located in FR1 region of V gene and reverse primers are complimentary to constant region. Thus, you can use these tutorial for any data obtained by similar protocols, like: 

- Illumina Ampliseq TCR LR
- Thermo Fisher Oncomine™ TCR Beta-LR
    

## Data libraries

This tutorial uses the data from the following publication: *Longitudinal High-Throughput Sequencing of the T-Cell Receptor Repertoire Reveals Dynamic Change and Prognostic Significance of Peripheral Blood TCR Diversity in Metastatic Colorectal Cancer During Chemotherapy* Yi-Tung Chen et al., Front. Immunol., 2022 Jan;12:743448 [doi: 10.3389/fimmu.2021.743448](https://doi.org/10.3389/fimmu.2021.743448)

A total of 36 subjects, including 20 healthy controls and 16 metastatic CRC patients, were enrolled in this study.Peripheral blood samples were obtained from 20 age-matched healthy controls (62.6 ± 10.48 years old) and 16 CRC patients (62.38 ± 12.62 years old) before therapy. Among the 16 CRC patients, 67 peripheral blood samples were collected from 13 patients with follow-up every two months for approximately 98 to 452 days. 103 samples in total. Peripheral blood mononuclear cells (PBMCs) were isolated following the standard procedure, and total RNA from PBMCs was extracted using TRIzol reagent (Invitrogen, Carlsbad, CA) according to the manufacturer’s protocol. A multiplex PCR amplification reaction was used to amplify the TCR immune repertoire. Human TCRα and TCRβ libraries were prepared using the HTAI-M and HTBI-M Kits (iRepertoire, Inc.) according to the manufacturer’s instructions and 2 × 250 bp paired-end sequenced was performed on the Illumina MiSeq platfor.

The data for this tutorial can be downloaded using the script bellow:


??? note "Show script"
    ```
    #!/usr/bin/env bash
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/064/SRR15440664/SRR15440664_1.fastq.gz -o CRC01601_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/064/SRR15440664/SRR15440664_2.fastq.gz -o CRC01601_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/065/SRR15440665/SRR15440665_1.fastq.gz -o CRC01602_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/065/SRR15440665/SRR15440665_2.fastq.gz -o CRC01602_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/062/SRR15440662/SRR15440662_1.fastq.gz -o CRC01508_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/062/SRR15440662/SRR15440662_2.fastq.gz -o CRC01508_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/067/SRR15440667/SRR15440667_1.fastq.gz -o CRC01604_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/067/SRR15440667/SRR15440667_2.fastq.gz -o CRC01604_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/066/SRR15440666/SRR15440666_1.fastq.gz -o CRC01603_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/066/SRR15440666/SRR15440666_2.fastq.gz -o CRC01603_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/061/SRR15440661/SRR15440661_1.fastq.gz -o CRC01507_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/061/SRR15440661/SRR15440661_2.fastq.gz -o CRC01507_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/063/SRR15440663/SRR15440663_1.fastq.gz -o CRC01509_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/063/SRR15440663/SRR15440663_2.fastq.gz -o CRC01509_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/069/SRR15440669/SRR15440669_1.fastq.gz -o CRC01606_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/069/SRR15440669/SRR15440669_2.fastq.gz -o CRC01606_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/068/SRR15440668/SRR15440668_1.fastq.gz -o CRC01605_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/068/SRR15440668/SRR15440668_2.fastq.gz -o CRC01605_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/070/SRR15440670/SRR15440670_1.fastq.gz -o CRC01607_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/070/SRR15440670/SRR15440670_2.fastq.gz -o CRC01607_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/071/SRR15440671/SRR15440671_1.fastq.gz -o CRC01608_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/071/SRR15440671/SRR15440671_2.fastq.gz -o CRC01608_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/072/SRR15440672/SRR15440672_1.fastq.gz -o CRC01701_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/072/SRR15440672/SRR15440672_2.fastq.gz -o CRC01701_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/073/SRR15440673/SRR15440673_1.fastq.gz -o CRC01702_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/073/SRR15440673/SRR15440673_2.fastq.gz -o CRC01702_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/074/SRR15440674/SRR15440674_1.fastq.gz -o CRC01703_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/074/SRR15440674/SRR15440674_2.fastq.gz -o CRC01703_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/075/SRR15440675/SRR15440675_1.fastq.gz -o CRC01704_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/075/SRR15440675/SRR15440675_2.fastq.gz -o CRC01704_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/076/SRR15440676/SRR15440676_1.fastq.gz -o CRC01705_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/076/SRR15440676/SRR15440676_2.fastq.gz -o CRC01705_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/077/SRR15440677/SRR15440677_1.fastq.gz -o CRC01706_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/077/SRR15440677/SRR15440677_2.fastq.gz -o CRC01706_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/078/SRR15440678/SRR15440678_1.fastq.gz -o NGSA16_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/078/SRR15440678/SRR15440678_2.fastq.gz -o NGSA16_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/079/SRR15440679/SRR15440679_1.fastq.gz -o NGSA31_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/079/SRR15440679/SRR15440679_2.fastq.gz -o NGSA31_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/080/SRR15440680/SRR15440680_1.fastq.gz -o NGSA37_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/080/SRR15440680/SRR15440680_2.fastq.gz -o NGSA37_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/084/SRR15440684/SRR15440684_1.fastq.gz -o NGSA57_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/084/SRR15440684/SRR15440684_2.fastq.gz -o NGSA57_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/081/SRR15440681/SRR15440681_1.fastq.gz -o NGSA46_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/081/SRR15440681/SRR15440681_2.fastq.gz -o NGSA46_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/082/SRR15440682/SRR15440682_1.fastq.gz -o NGSA49_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/082/SRR15440682/SRR15440682_2.fastq.gz -o NGSA49_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/083/SRR15440683/SRR15440683_1.fastq.gz -o NGSA51_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/083/SRR15440683/SRR15440683_2.fastq.gz -o NGSA51_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/085/SRR15440685/SRR15440685_1.fastq.gz -o NGSA68_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/085/SRR15440685/SRR15440685_2.fastq.gz -o NGSA68_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/087/SRR15440687/SRR15440687_1.fastq.gz -o NGSA81_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/087/SRR15440687/SRR15440687_2.fastq.gz -o NGSA81_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/086/SRR15440686/SRR15440686_1.fastq.gz -o NGSA74_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/086/SRR15440686/SRR15440686_2.fastq.gz -o NGSA74_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/089/SRR15440689/SRR15440689_1.fastq.gz -o NGSB41_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/089/SRR15440689/SRR15440689_2.fastq.gz -o NGSB41_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/088/SRR15440688/SRR15440688_1.fastq.gz -o NGSB32_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/088/SRR15440688/SRR15440688_2.fastq.gz -o NGSB32_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/090/SRR15440690/SRR15440690_1.fastq.gz -o NGSB46_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/090/SRR15440690/SRR15440690_2.fastq.gz -o NGSB46_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/091/SRR15440691/SRR15440691_1.fastq.gz -o NGSB52_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/091/SRR15440691/SRR15440691_2.fastq.gz -o NGSB52_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/092/SRR15440692/SRR15440692_1.fastq.gz -o NGSB62_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/092/SRR15440692/SRR15440692_2.fastq.gz -o NGSB62_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/094/SRR15440694/SRR15440694_1.fastq.gz -o NGSB67_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/094/SRR15440694/SRR15440694_2.fastq.gz -o NGSB67_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/093/SRR15440693/SRR15440693_1.fastq.gz -o NGSB66_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/093/SRR15440693/SRR15440693_2.fastq.gz -o NGSB66_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/095/SRR15440695/SRR15440695_1.fastq.gz -o NGSB68_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/095/SRR15440695/SRR15440695_2.fastq.gz -o NGSB68_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/096/SRR15440696/SRR15440696_1.fastq.gz -o NGSB69_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/096/SRR15440696/SRR15440696_2.fastq.gz -o NGSB69_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/097/SRR15440697/SRR15440697_1.fastq.gz -o NGSB71_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/097/SRR15440697/SRR15440697_2.fastq.gz -o NGSB71_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/095/SRR15440595/SRR15440595_1.fastq.gz -o CRC00101_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/095/SRR15440595/SRR15440595_2.fastq.gz -o CRC00101_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/097/SRR15440597/SRR15440597_1.fastq.gz -o CRC00103_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/097/SRR15440597/SRR15440597_2.fastq.gz -o CRC00103_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/099/SRR15440599/SRR15440599_1.fastq.gz -o CRC00105_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/099/SRR15440599/SRR15440599_2.fastq.gz -o CRC00105_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/098/SRR15440598/SRR15440598_1.fastq.gz -o CRC00104_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/098/SRR15440598/SRR15440598_2.fastq.gz -o CRC00104_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/096/SRR15440596/SRR15440596_1.fastq.gz -o CRC00102_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/096/SRR15440596/SRR15440596_2.fastq.gz -o CRC00102_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/000/SRR15440600/SRR15440600_1.fastq.gz -o CRC00106_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/000/SRR15440600/SRR15440600_2.fastq.gz -o CRC00106_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/001/SRR15440601/SRR15440601_1.fastq.gz -o CRC00107_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/001/SRR15440601/SRR15440601_2.fastq.gz -o CRC00107_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/002/SRR15440602/SRR15440602_1.fastq.gz -o CRC00201_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/002/SRR15440602/SRR15440602_2.fastq.gz -o CRC00201_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/004/SRR15440604/SRR15440604_1.fastq.gz -o CRC00203_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/004/SRR15440604/SRR15440604_2.fastq.gz -o CRC00203_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/003/SRR15440603/SRR15440603_1.fastq.gz -o CRC00202_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/003/SRR15440603/SRR15440603_2.fastq.gz -o CRC00202_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/005/SRR15440605/SRR15440605_1.fastq.gz -o CRC00204_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/005/SRR15440605/SRR15440605_2.fastq.gz -o CRC00204_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/006/SRR15440606/SRR15440606_1.fastq.gz -o CRC00301_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/006/SRR15440606/SRR15440606_2.fastq.gz -o CRC00301_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/007/SRR15440607/SRR15440607_1.fastq.gz -o CRC00302_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/007/SRR15440607/SRR15440607_2.fastq.gz -o CRC00302_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/008/SRR15440608/SRR15440608_1.fastq.gz -o CRC00303_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/008/SRR15440608/SRR15440608_2.fastq.gz -o CRC00303_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/010/SRR15440610/SRR15440610_1.fastq.gz -o CRC00305_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/010/SRR15440610/SRR15440610_2.fastq.gz -o CRC00305_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/009/SRR15440609/SRR15440609_1.fastq.gz -o CRC00304_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/009/SRR15440609/SRR15440609_2.fastq.gz -o CRC00304_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/011/SRR15440611/SRR15440611_1.fastq.gz -o CRC00306_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/011/SRR15440611/SRR15440611_2.fastq.gz -o CRC00306_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/012/SRR15440612/SRR15440612_1.fastq.gz -o CRC00307_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/012/SRR15440612/SRR15440612_2.fastq.gz -o CRC00307_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/013/SRR15440613/SRR15440613_1.fastq.gz -o CRC00308_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/013/SRR15440613/SRR15440613_2.fastq.gz -o CRC00308_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/014/SRR15440614/SRR15440614_1.fastq.gz -o CRC00401_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/014/SRR15440614/SRR15440614_2.fastq.gz -o CRC00401_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/016/SRR15440616/SRR15440616_1.fastq.gz -o CRC00502_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/016/SRR15440616/SRR15440616_2.fastq.gz -o CRC00502_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/015/SRR15440615/SRR15440615_1.fastq.gz -o CRC00501_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/015/SRR15440615/SRR15440615_2.fastq.gz -o CRC00501_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/017/SRR15440617/SRR15440617_1.fastq.gz -o CRC00503_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/017/SRR15440617/SRR15440617_2.fastq.gz -o CRC00503_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/018/SRR15440618/SRR15440618_1.fastq.gz -o CRC00504_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/018/SRR15440618/SRR15440618_2.fastq.gz -o CRC00504_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/019/SRR15440619/SRR15440619_1.fastq.gz -o CRC00505_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/019/SRR15440619/SRR15440619_2.fastq.gz -o CRC00505_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/020/SRR15440620/SRR15440620_1.fastq.gz -o CRC00506_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/020/SRR15440620/SRR15440620_2.fastq.gz -o CRC00506_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/021/SRR15440621/SRR15440621_1.fastq.gz -o CRC00507_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/021/SRR15440621/SRR15440621_2.fastq.gz -o CRC00507_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/022/SRR15440622/SRR15440622_1.fastq.gz -o CRC00601_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/022/SRR15440622/SRR15440622_2.fastq.gz -o CRC00601_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/024/SRR15440624/SRR15440624_1.fastq.gz -o CRC00603_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/024/SRR15440624/SRR15440624_2.fastq.gz -o CRC00603_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/023/SRR15440623/SRR15440623_1.fastq.gz -o CRC00602_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/023/SRR15440623/SRR15440623_2.fastq.gz -o CRC00602_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/025/SRR15440625/SRR15440625_1.fastq.gz -o CRC00604_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/025/SRR15440625/SRR15440625_2.fastq.gz -o CRC00604_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/026/SRR15440626/SRR15440626_1.fastq.gz -o CRC00605_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/026/SRR15440626/SRR15440626_2.fastq.gz -o CRC00605_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/027/SRR15440627/SRR15440627_1.fastq.gz -o CRC00606_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/027/SRR15440627/SRR15440627_2.fastq.gz -o CRC00606_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/028/SRR15440628/SRR15440628_1.fastq.gz -o CRC00607_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/028/SRR15440628/SRR15440628_2.fastq.gz -o CRC00607_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/029/SRR15440629/SRR15440629_1.fastq.gz -o CRC00701_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/029/SRR15440629/SRR15440629_2.fastq.gz -o CRC00701_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/030/SRR15440630/SRR15440630_1.fastq.gz -o CRC00702_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/030/SRR15440630/SRR15440630_2.fastq.gz -o CRC00702_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/032/SRR15440632/SRR15440632_1.fastq.gz -o CRC00704_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/032/SRR15440632/SRR15440632_2.fastq.gz -o CRC00704_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/033/SRR15440633/SRR15440633_1.fastq.gz -o CRC00705_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/033/SRR15440633/SRR15440633_2.fastq.gz -o CRC00705_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/031/SRR15440631/SRR15440631_1.fastq.gz -o CRC00703_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/031/SRR15440631/SRR15440631_2.fastq.gz -o CRC00703_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/034/SRR15440634/SRR15440634_1.fastq.gz -o CRC00801_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/034/SRR15440634/SRR15440634_2.fastq.gz -o CRC00801_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/036/SRR15440636/SRR15440636_1.fastq.gz -o CRC01001_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/036/SRR15440636/SRR15440636_2.fastq.gz -o CRC01001_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/035/SRR15440635/SRR15440635_1.fastq.gz -o CRC00901_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/035/SRR15440635/SRR15440635_2.fastq.gz -o CRC00901_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/038/SRR15440638/SRR15440638_1.fastq.gz -o CRC01003_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/038/SRR15440638/SRR15440638_2.fastq.gz -o CRC01003_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/039/SRR15440639/SRR15440639_1.fastq.gz -o CRC01101_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/039/SRR15440639/SRR15440639_2.fastq.gz -o CRC01101_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/041/SRR15440641/SRR15440641_1.fastq.gz -o CRC01103_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/041/SRR15440641/SRR15440641_2.fastq.gz -o CRC01103_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/042/SRR15440642/SRR15440642_1.fastq.gz -o CRC01104_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/042/SRR15440642/SRR15440642_2.fastq.gz -o CRC01104_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/040/SRR15440640/SRR15440640_1.fastq.gz -o CRC01102_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/040/SRR15440640/SRR15440640_2.fastq.gz -o CRC01102_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/037/SRR15440637/SRR15440637_1.fastq.gz -o CRC01002_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/037/SRR15440637/SRR15440637_2.fastq.gz -o CRC01002_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/043/SRR15440643/SRR15440643_1.fastq.gz -o CRC01105_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/043/SRR15440643/SRR15440643_2.fastq.gz -o CRC01105_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/045/SRR15440645/SRR15440645_1.fastq.gz -o CRC01107_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/045/SRR15440645/SRR15440645_2.fastq.gz -o CRC01107_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/044/SRR15440644/SRR15440644_1.fastq.gz -o CRC01106_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/044/SRR15440644/SRR15440644_2.fastq.gz -o CRC01106_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/046/SRR15440646/SRR15440646_1.fastq.gz -o CRC01201_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/046/SRR15440646/SRR15440646_2.fastq.gz -o CRC01201_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/047/SRR15440647/SRR15440647_1.fastq.gz -o CRC01202_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/047/SRR15440647/SRR15440647_2.fastq.gz -o CRC01202_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/048/SRR15440648/SRR15440648_1.fastq.gz -o CRC01203_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/048/SRR15440648/SRR15440648_2.fastq.gz -o CRC01203_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/049/SRR15440649/SRR15440649_1.fastq.gz -o CRC01204_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/049/SRR15440649/SRR15440649_2.fastq.gz -o CRC01204_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/050/SRR15440650/SRR15440650_1.fastq.gz -o CRC01301_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/050/SRR15440650/SRR15440650_2.fastq.gz -o CRC01301_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/051/SRR15440651/SRR15440651_1.fastq.gz -o CRC01302_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/051/SRR15440651/SRR15440651_2.fastq.gz -o CRC01302_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/052/SRR15440652/SRR15440652_1.fastq.gz -o CRC01303_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/052/SRR15440652/SRR15440652_2.fastq.gz -o CRC01303_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/053/SRR15440653/SRR15440653_1.fastq.gz -o CRC01304_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/053/SRR15440653/SRR15440653_2.fastq.gz -o CRC01304_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/054/SRR15440654/SRR15440654_1.fastq.gz -o CRC01305_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/054/SRR15440654/SRR15440654_2.fastq.gz -o CRC01305_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/055/SRR15440655/SRR15440655_1.fastq.gz -o CRC01501_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/055/SRR15440655/SRR15440655_2.fastq.gz -o CRC01501_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/056/SRR15440656/SRR15440656_1.fastq.gz -o CRC01502_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/056/SRR15440656/SRR15440656_2.fastq.gz -o CRC01502_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/057/SRR15440657/SRR15440657_1.fastq.gz -o CRC01503_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/057/SRR15440657/SRR15440657_2.fastq.gz -o CRC01503_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/058/SRR15440658/SRR15440658_1.fastq.gz -o CRC01504_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/058/SRR15440658/SRR15440658_2.fastq.gz -o CRC01504_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/059/SRR15440659/SRR15440659_1.fastq.gz -o CRC01505_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/059/SRR15440659/SRR15440659_2.fastq.gz -o CRC01505_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/060/SRR15440660/SRR15440660_1.fastq.gz -o CRC01506_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR154/060/SRR15440660/SRR15440660_2.fastq.gz -o CRC01506_R2.fastq.gz
    ```
The project contains 103 FASTQ file pairs. For the purpose of this tutorial we assume that all fastq files are stored  in `fastq/` folder. The structure of sequences is shown on the picture bellow. The data was obtained using multiplex primers for V and J genes. Below you can see the structure of cDNA library.

<figure markdown>
![iRepertoire.svg](irepertoire-tcr-lr/iRepertoire.svg)
</figure>


## Upstream analysis

The easiest way to obtain results from this type of data is to use [`mixcr analyze amplicon`](../reference/mixcr-analyze.md#generic-targeted-amplicon-libraries) command in the following manner:

```shell
> mixcr analyze amplicon \ 
    --species hsa \
    --starting-material rna \
    --receptor-type tcr \
    --5-end v-primers \
    --3-end c-primers \
    --adapters adapters-present \
    --assemble "-OassemblingFeatures={CDR1Begin:FR4End}" \
    fastq/CRC01601_R1.fastq.gz CRC01601_R2.fastq.gz \
    result/CRC01601
```
Arguments explained:

`--species`
: is set to `hsa` for _Homo Sapience_

`--starting-material`
: affects the choice of V gene region which will be used as target in [`align`](../reference/mixcr-align.md) step (`vParameters.geneFeatureToAlign`, see [`align` documentation](../reference/mixcr-align.md)). By specifying `rna` as starting material, `VTranscriptWithout5UTRWithP` will be used as `geneFeatureToAlign` for V segment.

`--receptor-type`
: `tct` affects the choice of underlying alignment algorithms. 

`--5-end`
: is set to `v-primers` because samples were prepared using multiplex V-primers. This leads to a local alignment on the left bound of V gene (if `adapters-present` is specified).

`--3-end`
: is set to `c-primers`, since C primers were used for library preparation. This leads to a local alignment on the right bound of C gene (if `adapters-present` is specified).

`--adapers`
: is set to `adapters-present` because primer sequences are present in the data and has not been cut prior to. Together with `--5-end v-primers` and `--3-end c-primers` it leads to a local alignment on the left bound of V gene and right bound of C gene.

`--assemble`
: `"-OassemblingFeatures={CDR1Begin:FR4End}"`. We pass an extra parameter to `mixcr assemble` step of the pipeline. By default, clones are assembled by `CDR3` sequence, but in this case V primers are located in `FR1` region and reverse primer is in C region. Thus we should use the sequence starting from the beginning of `CDR1` all the way till the end of `FR4`, because we are sure that there were no primers used within that region.

A common practice to process all samples at once is to use [GNU Parallel](https://www.gnu.org/software/parallel/):

```shell
ls fastq/*R1* | parallel -j4 \
'mixcr analyze amplicon \
    --species hsa \
    --starting-material rna \
    --receptor-type tcr \
    --5-end v-primers \
    --3-end c-primers \
    --adapters adapters-present \
    --assemble "-OassemblingFeatures={CDR1Begin:FR4End}" \
  {} {=s:R1:R2:=} \
  {=s:.*\/:result/:;s:_R.*::=}'
```

where `-j 4` means that 4 samples will be analyzed at a time. Pay attention to available computing resources.

### Under the hood pipeline:

Under the hood the command above actually executes the following pipeline:

#### `align`
Alignment of raw sequencing reads against reference database of V-, D-, J- and C- gene segments.

```shell
# align raw reads
> mixcr align \
    -s hsa \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=true \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    --report result/CRC01601.report \
     fastq/CRC01601_R1.fastq.gz fastq/CRC01601_R2.fastq.gz \
     result/CRC01601.vdjca
```

Option `--report` is specified here explicitly.

`-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP"`
: Sets a V gene feature to align. Check [gene features](../reference/ref-gene-features.md) for more info.

`-OvParameters.parameters.floatingLeftBound=true`
: Results in a local alignment algorithm for V gene left bound.

`-OjParameters.parameters.floatingRightBound=false`
: Results in a global alignment algorithm for J gene right bound.

`-OcParameters.parameters.floatingRightBound=false`
: Results in a local alignment algorithm for C gene right bound.

#### `assemble`
Assembles alignments into clonotypes and applies several layers of errors correction(ex. quality-awared correction for sequencing errors, clustering to correct for PCR errors). Check [`mixcr assemble`](../reference/mixcr-assemble.md) for more information.

```shell
# assemble clonotypes
> mixcr assemble \
    -OassemblingFeatures={CDR1Begin:FR4End} \
    result/CRC01601.vdjca \
    result/CRC01601.clns
```

`-OassemblingFeatures={CDR1Begin:FR4End}`
: Sets the feature that defines to different clones. Default value is `CDR3`. Here we extend this feature knowing primer locations.

#### `export`
Exports clonotypes from .clns file into human-readable tables.

```shell
# export to tsv
> mixcr exportClones \
    -p full \
    -c TRA
    result/CRC01601.clns \
    result/CRC01601.clonotypes.TRA.txt
    
> mixcr exportClones \
    -p full \
    -c TRB
    result/CRC01601.clns \
    result/CRC01601.clonotypes.TRA.txt
```

Here `-p full` defines the full preset of common export columns. Check [`mixcr export`](../reference/mixcr-export.md) for more information.

`-с <chain>`
: defines a specific chain to be exported. By default `mixcr analyze` exports all chains in separate files.

After execution is complete the following list of files is generated for every sample:

```shell
# human-readable reports 
CRC01601.report
# raw alignments (highly compressed binary file)
CRC01601.vdjca
# TRA and TRB clonotypes (highly compressed binary file)
CRC01601.clns
# TRA and TRB clonotypes exported in tab-delimited txt
CRC01601.clonotypes.TRA.tsv
CRC01601.clonotypes.TRA.tsv  
```

Obtained `*.tsv` files can be used for manual examination. `*.clns` files can be used for downstream analysis using [`mixcr postanalisis`](../reference/mixcr-postanalysis.md).

## Quality control

Now when we have all files processed lets perform Quality Control. That can be easily done using [`mixcr exportQc`](../reference/mixcr-exportQc.md) function.

First let's examine the alignment quality control plot.

```shell
# obtain alignment quality control
mixcr exportQc align \
  result/*.vdjca \
  alignQc.pdf
```

<figure markdown>
![alignQc.svg](irepertoire-tcr-lr/alignQc.svg)
</figure>


From this plot we can clearly see some issues with the libraries. Most of the samples have a relatively big fraction of not aligned reads primarily due to the absence of J hits. 

MiXCR is a powerful tool that allows us to investigate further. Let's pick one of the samples where the issue is most obvious. (ex. CRC00308 ). To look at the reads' alignments for that sample we first will run [`mixcr align`](../reference/mixcr-align.md) command for that sample once again, but this time we will specify additional options - `-OallowPartialAlignments=true -OallowNoCDR3PartAlignments=true`, that will preserve partially aligned reads (ex. reads that may lack J gene) and reads that lack `CDR3` sequence.

```shell
> mixcr align \
    -s hsa \
    -p kAligner2 \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=true \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    -OallowPartialAlignments=true \
    -OallowNoCDR3PartAlignments=true \
    fastq/CRC00308_R1.fastq.gz fastq/CRC00308_R2.fastq.gz \
    CRC00308_debug.vdjca
```

Now we can look at raw alignments itself using [`mixcr exportAlignmentsPretty`](../reference/mixcr-exportPretty.md#raw-alignments).

The function bellow will generate a `.txt` human-readable file with alignments. We use parameter `--skip 1000` to skip first 1000 reads, as first reads usually have bad quality, and `--limit 100` will export only 100 alignments as we usually don't need to examine every alignment to see the issue.

```shell
> mixcr exportAlignmentsPretty \
    --skip 1000 \
    --limit 100 \
    CRC00308_debug.vdjca \
    CRC00308_debug.alignments.txt
```

Bellow you can see a few alignments from the generated file. The first one is an example of well aligned reads.

```shell
>>> Read ids: 1113


                                            FR1><CDR1     CDR1><FR2
              _ E  K  P  V  T  L  S  C  S  Q  T  L  N  H  N  V  M  Y  W  Y  Q  Q  K  S  S  Q
  Quality     66666767777777777777777777777777777777777777777777777777777777777777777777777777
  Target0   0 AGAAAAGCCAGTGACCCTGAGTTGTTCTCAGACTTTGAACCATAACGTCATGTACTGGTACCAGCAGAAGTCAAGTCAGG 79   Score
TRBV15*00 104    aaagccagtgaccctgagttgttctcagactttgaaccataacgtcatgtactggtaccagcagaagtcaagtcagg 180  1148

                              FR2><CDR2        CDR2><FR3
              A  P  K  L  L  F  H  Y  Y  D  K  D  F  N  N  E  A  D  T  P  D  N  F  Q  S  R  R
  Quality     77777777777777777777777777777777777777777777777777777777777777777777777777777777
  Target0  80 CCCCAAAGCTGCTGTTCCACTACTATGACAAAGATTTTAACAATGAAGCAGACACCCCTGATAACTTCCAATCCAGGAGG 159  Score
TRBV15*00 181 ccccaaagctgctgttccactactatgacaaagattttaacaatgaagcagacacccctgataacttccaatccaggagg 260  1148

                                                                            FR3><CDR3        V
               P  N  I  S  F  C  F  L  D  I  R  S  P  G  L  G  D  A  A  M  Y  L  C  A  T  S  G
  Quality     77777777777777777777777777777777777777777777777777777777777777777777777777777777
  Target0 160 CCGAACATTTCTTTCTGCTTTCTTGACATCCGCTCACCAGGCCTGGGGGACGCAGCCATGTACCTGTGTGCCACCAGCGG 239  Score
TRBV15*00 261 ccgaacaCttctttctgctttcttgacatccgctcaccaggcctgggggacAcagccatgtacctgtgtgccaccagcAg 340  1148

               >      <J        CDR3><FR4                    FR4><C
                 L  G  D  T  Q  Y  F  G  P  G  T  R  L  T  V  L  E  D  L  K  N  V  F  P  P  E
   Quality     77777777777777777777777777777777777777777777777777777777777777777777777777777777
   Target0 240 ACTAGGGGATACGCAGTATTTTGGCCCAGGCACCCGGCTGACAGTGCTCGAGGACCTGAAAAACGTGTTCCCACCCGAGG 319  Score
 TRBV15*00 341 a                                                                                341  1148
TRBJ2-3*00  26        gatacgcagtattttggcccaggcacccggctgacagtgctcg                               68   215
  TRBC2*00   0                                                   aggacctgaaaaacgtgttcccacccgagg 29   260


             V  A  V  F  E  P  S  D  S  Q _
 Quality     7777777777777777777777777766666
 Target0 320 TCGCTGTGTTTGAGCCATCAGATAGTCAATG 350  Score
TRBC2*00  30 tcgctgtgtttgagccatcaga          51   260
```

Now, the following pair of reads failed to align.

```shell
>>> Read ids: 1115



          _  N  P  V  G  L  R  C  Y  P  T  S  V  F  F  C  V  Y  L  Y  Q  Q  K  P  F  P  C
Quality   33553553353536366363363333633322336733363663633333633633733363222632222333655322
Target0 0 CAAACCCCGTGGGGCTGAGGTGCTACCCAACCTCTGTCTTTTTCTGTGTGTACTTGTACCAACAAAAACCCTTCCCCTGC 79  Score


            P  G  S  P  S  K  N  Y  Q  A  E  G  G  G  D  G  E  G  E  E  G  V  S  G  G  R  R
Quality    62222252552522333333633336333225522622222222252522525222222222222233522525222522
Target0 80 CCCGGGTCCCCCAGTAAGAATTATCAGGCCGAAGGGGGAGGAGACGGGGAGGGGGAAGAAGGAGTATCCGGGGGGCGGCG 159  Score

                                                                         FR3><CDR3
               V  V  L  K  K  K  L  N  L  S  S  L  E  L  V  D  S  A  L  Y  F  C  A  S  V  G
 Quality     22242225222672224452252522242225242626256626244262222424525222625452225222252225
 Target0 160 CGTTGTCTTAAAAAAAAAACTAAACCTGAGCTCTCTGGAGCTGGTGGACTCAGCTTTGTATTTCTGTGCCAGCGTCGGGT 239  Score
TRBV9*00 280                  aactaaacctgagctctctggagctggGggactcagctttgtatttctgtgccagc--AgCgt 340  200

             V><VP     VP>
             S   H   H  I
 Quality     242 22 252224
 Target0 240 CGC-AC-CACATA 250  Score
TRBV9*00 341 AgcTacGcTGCtG 353  200

             <CDR2        CDR2><FR3
              Y  H  K  G  E  E  R  A  K  G  N  I  L  E  R  F  S  A  Q  Q  F  P  D  F  L  F  F
 Quality     22224664272772777762664467626552222267767777765422666277777777766636665226665653
 Target1   0 TATCATAAAGGAGAAGAGAGAGCAAAAGGAAACATTCTTGAACGATTCTCCGCACAACAGTTCCCTGACTTTCTTTTTTT 79   Score
TRBV9*00 201 tatTataaTggagaagagagagcaaaaggaaacattcttgaacgattctccgcacaacagttccctgactt          271  327


             Q  A  E  D  G  I  R  H  R  S  R  H  S  C  *  T  A  L  P  I  *  T  P  V  E  L
Quality    27773753566265533552552226776565636377677777752777762626237777377772777667667733
Target1 80 TCAAGCAGAAGACGGCATACGACATCGGTCTCGGCATTCCTGCTGAACCGCTCTTCCGATTTGAACCCCTGTGGAGCTGA 159  Score


            R  C  N  Y  S  S  S  V  S  V  Y  L  F  *  Y  P  E  P  *  P  C  R  V  P  A  E  R
Quality     67777776777762277637766776776776667776676776636666776636366767337776636766636367
Target1 160 GGTGCAACTACTCATCGTCTGTTTCAGTGTATCTCTTCTGATATCCAGAACCCTGACCCTGCCGTGTACCAGCTGAGAGA 239  Score


             L  S  Q _
Quality     66776666366
Target1 240 CTTAGTCAGCC 250  Score
```

One can use BLAST and search for the not aligned parts of sequence in order to find out its origin.

Another quality report we should investigate is a chain abundance plot.

```shell
> mixcr exportQc chainUsage \
    result/*.vdjca \
    chainUsage.pdf
```

<figure markdown>
![chainUsage.svg](irepertoire-tcr-lr/chainUsage.svg)
</figure>

Most of the samples are more or less equally consist of TRA and TRB chains. Although we can alse see a few samples (ex. CRC01302) with no TRA chain wich might indicate some cDNA library reparation issues and needs further investigation.

