# SMARTer Mouse TCR a/b Profiling Kit
Here we will discuss how to process TCR cDNA libraries obtained with SMARTer Mouse TCR a/b Profiling Kit.

## Data libraries

This tutorial uses the data from the following publication: *A T cell repertoire timestamp is at the core of responsiveness to CTLA-4 blockade* Hagit Philip et al., , iScience, 2021 Feb;
[doi: 10.1016/j.isci.2021.102100](https://doi.org/10.1016/j.isci.2021.102100)

Samples were collected from 20 mice implanted with MC38 adenocarcinoma cells. The experiment contained 2 groups, of which the first group (5 animals with ids A - E) was dosed with 10 ml/kg/day of vehicle on day 1, 3 and 6 of the experiment. The second group (15 animals with ids F - T) was dosed with the investigational antibody anti-mCTLA4 (5/2.5 mg/kg/day at 1/3, 6). After treatment with the immune checkpoint inhibitor antibody anti-mCTLA4 blood samples for the preparation of PBMCs were taken at days 0,7,14 and 21. Tumors (where still visible) and spleens were collected immediately after euthanasia, and directly transferred to liquid nitrogen (snap-frozen samples). Total RNA was isolated from every sample and cDNA libraries were prepared using SMARTer Mouse TCR a/b Profiling Kit. TCR sequencing was performed on an Illumina Miseq sequencer using the 600-cycle Miseq reagent kit v3(Illumina) with pair-end, 2x300 base pair reads.

The data for this tutorial can be downloaded using the script bellow.

```shell
#!/usr/bin/env bash
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/021/SRR12487521/SRR12487521_1.fastq.gz -o S_s_R1.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/022/SRR12487522/SRR12487522_1.fastq.gz -o S_7_R1.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/023/SRR12487523/SRR12487523_1.fastq.gz -o S_21_R1.fastq.gz
```

??? note "See full script"
    ```shell
    #!/usr/bin/env bash
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/021/SRR12487521/SRR12487521_1.fastq.gz -o S_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/022/SRR12487522/SRR12487522_1.fastq.gz -o S_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/023/SRR12487523/SRR12487523_1.fastq.gz -o S_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/024/SRR12487524/SRR12487524_1.fastq.gz -o S_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/025/SRR12487525/SRR12487525_1.fastq.gz -o S_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/026/SRR12487526/SRR12487526_1.fastq.gz -o I_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/027/SRR12487527/SRR12487527_1.fastq.gz -o I_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/028/SRR12487528/SRR12487528_1.fastq.gz -o I_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/029/SRR12487529/SRR12487529_1.fastq.gz -o I_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/030/SRR12487530/SRR12487530_1.fastq.gz -o I_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/031/SRR12487531/SRR12487531_1.fastq.gz -o T_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/032/SRR12487532/SRR12487532_1.fastq.gz -o J_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/033/SRR12487533/SRR12487533_1.fastq.gz -o J_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/034/SRR12487534/SRR12487534_1.fastq.gz -o J_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/035/SRR12487535/SRR12487535_1.fastq.gz -o J_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/036/SRR12487536/SRR12487536_1.fastq.gz -o J_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/037/SRR12487537/SRR12487537_1.fastq.gz -o A_t_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/038/SRR12487538/SRR12487538_1.fastq.gz -o A_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/039/SRR12487539/SRR12487539_1.fastq.gz -o A_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/040/SRR12487540/SRR12487540_1.fastq.gz -o A_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/041/SRR12487541/SRR12487541_1.fastq.gz -o M_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/042/SRR12487542/SRR12487542_1.fastq.gz -o T_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/043/SRR12487543/SRR12487543_1.fastq.gz -o M_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/044/SRR12487544/SRR12487544_1.fastq.gz -o M_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/045/SRR12487545/SRR12487545_1.fastq.gz -o M_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/046/SRR12487546/SRR12487546_1.fastq.gz -o M_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/047/SRR12487547/SRR12487547_1.fastq.gz -o G_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/048/SRR12487548/SRR12487548_1.fastq.gz -o G_t_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/049/SRR12487549/SRR12487549_1.fastq.gz -o G_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/050/SRR12487550/SRR12487550_1.fastq.gz -o G_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/051/SRR12487551/SRR12487551_1.fastq.gz -o G_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/052/SRR12487552/SRR12487552_1.fastq.gz -o G_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/053/SRR12487553/SRR12487553_1.fastq.gz -o T_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/054/SRR12487554/SRR12487554_1.fastq.gz -o O_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/055/SRR12487555/SRR12487555_1.fastq.gz -o O_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/056/SRR12487556/SRR12487556_1.fastq.gz -o O_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/057/SRR12487557/SRR12487557_1.fastq.gz -o O_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/058/SRR12487558/SRR12487558_1.fastq.gz -o O_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/059/SRR12487559/SRR12487559_1.fastq.gz -o R_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/060/SRR12487560/SRR12487560_1.fastq.gz -o R_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/061/SRR12487561/SRR12487561_1.fastq.gz -o R_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/062/SRR12487562/SRR12487562_1.fastq.gz -o R_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/063/SRR12487563/SRR12487563_1.fastq.gz -o R_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/064/SRR12487564/SRR12487564_1.fastq.gz -o T_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/065/SRR12487565/SRR12487565_1.fastq.gz -o H_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/066/SRR12487566/SRR12487566_1.fastq.gz -o H_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/067/SRR12487567/SRR12487567_1.fastq.gz -o H_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/068/SRR12487568/SRR12487568_1.fastq.gz -o H_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/069/SRR12487569/SRR12487569_1.fastq.gz -o H_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/070/SRR12487570/SRR12487570_1.fastq.gz -o P_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/071/SRR12487571/SRR12487571_1.fastq.gz -o P_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/072/SRR12487572/SRR12487572_1.fastq.gz -o P_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/073/SRR12487573/SRR12487573_1.fastq.gz -o P_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/074/SRR12487574/SRR12487574_1.fastq.gz -o P_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/075/SRR12487575/SRR12487575_1.fastq.gz -o T_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/076/SRR12487576/SRR12487576_1.fastq.gz -o E_t_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/077/SRR12487577/SRR12487577_1.fastq.gz -o E_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/078/SRR12487578/SRR12487578_1.fastq.gz -o E_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/079/SRR12487579/SRR12487579_1.fastq.gz -o E_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/080/SRR12487580/SRR12487580_1.fastq.gz -o E_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/081/SRR12487581/SRR12487581_1.fastq.gz -o E_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/082/SRR12487582/SRR12487582_1.fastq.gz -o D_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/083/SRR12487583/SRR12487583_1.fastq.gz -o D_t_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/084/SRR12487584/SRR12487584_1.fastq.gz -o D_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/085/SRR12487585/SRR12487585_1.fastq.gz -o D_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/086/SRR12487586/SRR12487586_1.fastq.gz -o Q_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/087/SRR12487587/SRR12487587_1.fastq.gz -o D_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/088/SRR12487588/SRR12487588_1.fastq.gz -o D_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/089/SRR12487589/SRR12487589_1.fastq.gz -o K_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/090/SRR12487590/SRR12487590_1.fastq.gz -o K_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/091/SRR12487591/SRR12487591_1.fastq.gz -o K_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/092/SRR12487592/SRR12487592_1.fastq.gz -o K_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/093/SRR12487593/SRR12487593_1.fastq.gz -o L_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/094/SRR12487594/SRR12487594_1.fastq.gz -o L_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/095/SRR12487595/SRR12487595_1.fastq.gz -o L_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/096/SRR12487596/SRR12487596_1.fastq.gz -o L_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/097/SRR12487597/SRR12487597_1.fastq.gz -o Q_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/098/SRR12487598/SRR12487598_1.fastq.gz -o L_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/099/SRR12487599/SRR12487599_1.fastq.gz -o F_t_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/000/SRR12487600/SRR12487600_1.fastq.gz -o F_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/001/SRR12487601/SRR12487601_1.fastq.gz -o F_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/002/SRR12487602/SRR12487602_1.fastq.gz -o F_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/003/SRR12487603/SRR12487603_1.fastq.gz -o F_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/004/SRR12487604/SRR12487604_1.fastq.gz -o F_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/005/SRR12487605/SRR12487605_1.fastq.gz -o N_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/006/SRR12487606/SRR12487606_1.fastq.gz -o N_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/007/SRR12487607/SRR12487607_1.fastq.gz -o N_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/008/SRR12487608/SRR12487608_1.fastq.gz -o Q_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/009/SRR12487609/SRR12487609_1.fastq.gz -o N_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/010/SRR12487610/SRR12487610_1.fastq.gz -o N_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/011/SRR12487611/SRR12487611_1.fastq.gz -o C_s_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/012/SRR12487612/SRR12487612_1.fastq.gz -o C_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/013/SRR12487613/SRR12487613_1.fastq.gz -o C_21_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/014/SRR12487614/SRR12487614_1.fastq.gz -o C_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/015/SRR12487615/SRR12487615_1.fastq.gz -o C_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/016/SRR12487616/SRR12487616_1.fastq.gz -o B_7_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/017/SRR12487617/SRR12487617_1.fastq.gz -o B_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/018/SRR12487618/SRR12487618_1.fastq.gz -o B_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/019/SRR12487619/SRR12487619_1.fastq.gz -o Q_14_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/020/SRR12487620/SRR12487620_1.fastq.gz -o Q_0_R1.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/021/SRR12487521/SRR12487521_2.fastq.gz -o S_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/022/SRR12487522/SRR12487522_2.fastq.gz -o S_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/023/SRR12487523/SRR12487523_2.fastq.gz -o S_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/024/SRR12487524/SRR12487524_2.fastq.gz -o S_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/025/SRR12487525/SRR12487525_2.fastq.gz -o S_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/026/SRR12487526/SRR12487526_2.fastq.gz -o I_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/027/SRR12487527/SRR12487527_2.fastq.gz -o I_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/028/SRR12487528/SRR12487528_2.fastq.gz -o I_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/029/SRR12487529/SRR12487529_2.fastq.gz -o I_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/030/SRR12487530/SRR12487530_2.fastq.gz -o I_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/031/SRR12487531/SRR12487531_2.fastq.gz -o T_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/032/SRR12487532/SRR12487532_2.fastq.gz -o J_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/033/SRR12487533/SRR12487533_2.fastq.gz -o J_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/034/SRR12487534/SRR12487534_2.fastq.gz -o J_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/035/SRR12487535/SRR12487535_2.fastq.gz -o J_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/036/SRR12487536/SRR12487536_2.fastq.gz -o J_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/037/SRR12487537/SRR12487537_2.fastq.gz -o A_t_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/038/SRR12487538/SRR12487538_2.fastq.gz -o A_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/039/SRR12487539/SRR12487539_2.fastq.gz -o A_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/040/SRR12487540/SRR12487540_2.fastq.gz -o A_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/041/SRR12487541/SRR12487541_2.fastq.gz -o M_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/042/SRR12487542/SRR12487542_2.fastq.gz -o T_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/043/SRR12487543/SRR12487543_2.fastq.gz -o M_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/044/SRR12487544/SRR12487544_2.fastq.gz -o M_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/045/SRR12487545/SRR12487545_2.fastq.gz -o M_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/046/SRR12487546/SRR12487546_2.fastq.gz -o M_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/047/SRR12487547/SRR12487547_2.fastq.gz -o G_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/048/SRR12487548/SRR12487548_2.fastq.gz -o G_t_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/049/SRR12487549/SRR12487549_2.fastq.gz -o G_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/050/SRR12487550/SRR12487550_2.fastq.gz -o G_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/051/SRR12487551/SRR12487551_2.fastq.gz -o G_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/052/SRR12487552/SRR12487552_2.fastq.gz -o G_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/053/SRR12487553/SRR12487553_2.fastq.gz -o T_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/054/SRR12487554/SRR12487554_2.fastq.gz -o O_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/055/SRR12487555/SRR12487555_2.fastq.gz -o O_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/056/SRR12487556/SRR12487556_2.fastq.gz -o O_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/057/SRR12487557/SRR12487557_2.fastq.gz -o O_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/058/SRR12487558/SRR12487558_2.fastq.gz -o O_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/059/SRR12487559/SRR12487559_2.fastq.gz -o R_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/060/SRR12487560/SRR12487560_2.fastq.gz -o R_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/061/SRR12487561/SRR12487561_2.fastq.gz -o R_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/062/SRR12487562/SRR12487562_2.fastq.gz -o R_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/063/SRR12487563/SRR12487563_2.fastq.gz -o R_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/064/SRR12487564/SRR12487564_2.fastq.gz -o T_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/065/SRR12487565/SRR12487565_2.fastq.gz -o H_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/066/SRR12487566/SRR12487566_2.fastq.gz -o H_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/067/SRR12487567/SRR12487567_2.fastq.gz -o H_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/068/SRR12487568/SRR12487568_2.fastq.gz -o H_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/069/SRR12487569/SRR12487569_2.fastq.gz -o H_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/070/SRR12487570/SRR12487570_2.fastq.gz -o P_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/071/SRR12487571/SRR12487571_2.fastq.gz -o P_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/072/SRR12487572/SRR12487572_2.fastq.gz -o P_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/073/SRR12487573/SRR12487573_2.fastq.gz -o P_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/074/SRR12487574/SRR12487574_2.fastq.gz -o P_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/075/SRR12487575/SRR12487575_2.fastq.gz -o T_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/076/SRR12487576/SRR12487576_2.fastq.gz -o E_t_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/077/SRR12487577/SRR12487577_2.fastq.gz -o E_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/078/SRR12487578/SRR12487578_2.fastq.gz -o E_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/079/SRR12487579/SRR12487579_2.fastq.gz -o E_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/080/SRR12487580/SRR12487580_2.fastq.gz -o E_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/081/SRR12487581/SRR12487581_2.fastq.gz -o E_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/082/SRR12487582/SRR12487582_2.fastq.gz -o D_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/083/SRR12487583/SRR12487583_2.fastq.gz -o D_t_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/084/SRR12487584/SRR12487584_2.fastq.gz -o D_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/085/SRR12487585/SRR12487585_2.fastq.gz -o D_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/086/SRR12487586/SRR12487586_2.fastq.gz -o Q_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/087/SRR12487587/SRR12487587_2.fastq.gz -o D_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/088/SRR12487588/SRR12487588_2.fastq.gz -o D_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/089/SRR12487589/SRR12487589_2.fastq.gz -o K_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/090/SRR12487590/SRR12487590_2.fastq.gz -o K_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/091/SRR12487591/SRR12487591_2.fastq.gz -o K_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/092/SRR12487592/SRR12487592_2.fastq.gz -o K_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/093/SRR12487593/SRR12487593_2.fastq.gz -o L_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/094/SRR12487594/SRR12487594_2.fastq.gz -o L_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/095/SRR12487595/SRR12487595_2.fastq.gz -o L_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/096/SRR12487596/SRR12487596_2.fastq.gz -o L_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/097/SRR12487597/SRR12487597_2.fastq.gz -o Q_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/098/SRR12487598/SRR12487598_2.fastq.gz -o L_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/099/SRR12487599/SRR12487599_2.fastq.gz -o F_t_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/000/SRR12487600/SRR12487600_2.fastq.gz -o F_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/001/SRR12487601/SRR12487601_2.fastq.gz -o F_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/002/SRR12487602/SRR12487602_2.fastq.gz -o F_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/003/SRR12487603/SRR12487603_2.fastq.gz -o F_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/004/SRR12487604/SRR12487604_2.fastq.gz -o F_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/005/SRR12487605/SRR12487605_2.fastq.gz -o N_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/006/SRR12487606/SRR12487606_2.fastq.gz -o N_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/007/SRR12487607/SRR12487607_2.fastq.gz -o N_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/008/SRR12487608/SRR12487608_2.fastq.gz -o Q_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/009/SRR12487609/SRR12487609_2.fastq.gz -o N_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/010/SRR12487610/SRR12487610_2.fastq.gz -o N_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/011/SRR12487611/SRR12487611_2.fastq.gz -o C_s_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/012/SRR12487612/SRR12487612_2.fastq.gz -o C_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/013/SRR12487613/SRR12487613_2.fastq.gz -o C_21_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/014/SRR12487614/SRR12487614_2.fastq.gz -o C_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/015/SRR12487615/SRR12487615_2.fastq.gz -o C_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/016/SRR12487616/SRR12487616_2.fastq.gz -o B_7_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/017/SRR12487617/SRR12487617_2.fastq.gz -o B_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/018/SRR12487618/SRR12487618_2.fastq.gz -o B_0_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/019/SRR12487619/SRR12487619_2.fastq.gz -o Q_14_R2.fastq.gz
    curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR124/020/SRR12487620/SRR12487620_2.fastq.gz -o Q_0_R2.fastq.gz
    ```

The project contains 100 FASTQ file pairs. For the purpose of this tutorial we assume that all fastq files are stored in `fastq/` folder. Each file name encodes the information about mouse id and PMBC sample time-point (0,7,14,21 days) or tissue (s - spleen, t -tumor)
- `S` - mouce id, experiment group
- `s` - spleen tissue

The structure of sequences is shown on the image bellow.

![Takara_SMARTer_Mouse_TCR.svg](takara-mmu-tcr/Takara_SMARTer_Mouse_TCR.svg)

## Upstream analysis

The easiest way to obtain results from this type of data is to use `mixcr analyze amplicon` command in the following manner:

```shell
> mixcr analyze amplicon \ 
  --species mmu \
  --starting-material rna \
  --receptor-type tcr \
  --5-end no-v-primers \
  --3-end c-primers \
  --adapters adapters-present \
  fastq/S_s_R1.fastq.gz fastq/S_s_R2.fastq.gz\
  result/S_s
```
Arguments explained:

`--species`
: is set to `hsa` for _Mus Musculus_

`--starting-material`
: `rna` It affects the choice of V gene region which will be used as target in [`align`](../reference/mixcr-align.md) step (`vParameters.geneFeatureToAlign`, see [`align` documentation](../reference/mixcr-align.md)). By specifying `rna` as starting material, `VTranscriptWithout5UTRWithP` will be used as `geneFeatureToAlign` for V segment.

`--receptor-type`
: `tcr`. It affects the choice of underlying alignment algorithms. 

`--5-end`
: is set to `no-v-primers` because samples were prepared using 5'RACE protocol. This leads to a global alignment on the left bound of V gene.

`--3-end`
: is set to `c-primers`. 

`--adapers`
: is set to `adapters-present` because primers sequences are present in the data and has not been cut prior to.

Under the hood the command above actually executes the following pipeline:
        
```shell
# align raw reads
mixcr align -s mmu \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=true \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    fastq/S_s_R1.fastq.gz fastq/S_s_R2.fastq.gz \
    result/S_s_R1.vdjca
  
# assemble clonotypes
mixcr assemble result/S_s_R1.vdjca result/S_s_R1.clns

# export to tsv
mixcr exportClones result/S_s_R1.clns result/S_s_R1.txt
```

One may use the script bellow to process all samples together (see [GNU Parallel](https://www.gnu.org/software/parallel/)):

```shell
ls fastq/*R1* | parallel -j 4 \
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

After executing the command above for every sample we will have a following set of output files:
```shell
# human-readable reports 
S_s_R1.report
# raw alignments (highly compressed binary file)
S_s_R1.vdjca
# TCRα & TCRβ CDR3 clonotypes (highly compressed binary file)
S_s_R1.clns
# TCRα & TCRβ CDR3 clonotypes exported in tab-delimited txt
S_s_R1.TRB.txt
S_s_R1.TRB.txt
```

## Quality control

Now when we have processed all samples, we can proceed to quality control. First thing that we want to look at is the alignment quality. This can be easily done with the following command:

```shell
mixcr exportQc align result/*.vdjca alignQc.pdf
```

![alignQC.svg](takara-mmu-tcr/alignQC.svg)

From the plot above we see, that only about 50% of reads from every sample have been successfully aligned. The major reason why the alignment failed is that a lot of reads lack TCR sequences. In that case, if we want to dig a bit deeper into the issue we can realign one of the samples and save not-aligned reads into separate files for manual inspection. Let's pick one of the samples, ex. S_7, and realign it.

```shell
mixcr align \
    --species mmu \
    --report result/S_7.debug.report \
    -OvParameters.geneFeatureToAlign=VTranscriptWithP \
    -OvParameters.parameters.floatingLeftBound=true \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    --not-aligned-R1 S_7_notAligned_R1.fastq \
    --not-aligned-R2 S_7_notAligned_R2.fastq \
    fastq/S_7_R1.fastq.gz fastq/S_7_R2.fastq.gz \
    S_7.debug.vdjca
```

Now one can use BLAST to determine the origin of the reads in  `S_7_notAligned_R1.fastq` and `S_7_notAligned_R2.fastq`

Finally, we can look at the chain distribution among all clones. 

```shell
mixcr exportQc chainUsage test_run/*.vdjca chainUsage.pdf
```

On the plot bellow we see, despite some TRB dominance, both (TCR alpha and TCR beta) chains equally present in each sample.

![chainUsage.svg](takara-mmu-tcr/chainUsage.svg)



