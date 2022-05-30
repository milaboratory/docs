Let's say we have a folder `fastq/` with FASTQ file pairs.

```
ls fastq/

sample11_LN_R1.fastq    sample11_SPL_R1.fastq  sample12_LN_R1.fastq    sample12_SPL_R1.fastq  sample14_LN_R1.fastq    sample14_SPL_R1.fastq  sample15_LN_R1.fastq    sample15_SPL_R1.fastq
sample11_LN_R2.fastq    sample11_SPL_R2.fastq  sample12_LN_R2.fastq    sample12_SPL_R2.fastq  sample14_LN_R2.fastq    sample14_SPL_R2.fastq  sample15_LN_R2.fastq    sample15_SPL_R2.fastq
sample11_PBMC_R1.fastq  sample11_THY_R1.fastq  sample12_PBMC_R1.fastq  sample12_THY_R1.fastq  sample14_PBMC_R1.fastq  sample14_THY_R1.fastq  sample15_PBMC_R1.fastq  sample15_THY_R1.fastq
sample11_PBMC_R2.fastq  sample11_THY_R2.fastq  sample12_PBMC_R2.fastq  sample12_THY_R2.fastq  sample14_PBMC_R2.fastq  sample14_THY_R2.fastq  sample15_PBMC_R2.fastq  sample15_THY_R2.fastq
```

These files contain sequences of TCR-betta chain enriched cDNA libraries of mice. Libraries were obtained from RNA, isolated from various tissues, using 5'RACE method. Sequence specific primer for C-region was used in library preparation protocol.

Our goal is to generate clonotype tables for every sample and plot Diversity indices box-plots comparing TCR diversity between different tissues.

The most straightforward way to get clonotype tables is to use [```mixcr analyze```](../reference/mixcr-analyze.md).

According to the library preparation protocol,the command for a single pair of files should look like that:

```
mixcr analyze amplicon \
    -s mmu \
    --starting-material rna \
    --receptor-type trb \
    --5-end no-v-primers --3-end c-primers \
    --adapters adapters-present \
    fastq/sample11_LN_R1.fastq fastq/sample11_LN_R2.fastq result/sample11_LN
```

- ```-s``` is set to mmu for Mus Musculus
- ```--starting material``` rna
- ```--receptor-type``` is ```trb``` because we know that only this chain should be present in the data.
- ```--5-end no-v-primers``` is set to ```no-v-primers``` since 5'RACE protocol was used in library preparation. For V multiplex that argument should be changed to ```v-primers```. 
- ```--3-end-primers``` is ```c-primers``` since the primer used for library preparation is complimentary to C-region of TCR genes.
- ```--adapers adapters present``` because primer sequence is present in the data and has not been cut prior to.
- finally we specify paths for both input files and a path to output folder with prefix describing the sample

Running the command above will generate the following files:

```
ls result/
sample11_LN.clns  sample11_LN.clonotypes.TRB.txt  sample11_LN.report  sample11_LN.vdjca
```

- ```sample11_LN.vdjca``` is a binary file with alignments 
- ```sample11_LN.clns``` is a binary file with assembled clonotypes
- ```sample11_LN.clonotypes.TRB.txt``` is a human-readable tab-delimited file with clonotype table for this sample. Check reports section of this documentation to find out more about the data stored in it.
- ```sample11_LN.report``` is a report file which contains both reports for alignment and assemble. Please see Reports section of this documentation to learn how to read ```mixcr``` reports.

Next step is to perform that analysis on multiple file pairs. We work on Linux, and let's say we have [GNU parallel installed](https://www.gnu.org/software/parallel/).
Then we can easily run the command above for all files in the folder:

```
ls fastq/*R1.fastq |\
 parallel "mixcr analyze amplicon \
   	-s mmu \
    --starting-material rna \
    --receptor-type trb \
    --5-end no-v-primers --3-end c-primers \
    --adapters adapters-present \
    {} {=s:R1:R2:=} {=s:.*\/:result/:; s:_R.*::=}"
```

This method is described in [Handy bash commands](../tips/usefullBashScripts.md) section of this documentation.

Briefly, we list all R1 filenames and pass that list to parallel. Inside ```mixcr analyze amplicon``` we use ```sed``` to pass input and output files. For R2 filename we have to replace R1 with R2 (```{=s:R1:R2:=}``` ), and for the output we remove the path to the R1 file, replace it with a new one instead and remove filename ending starting with ```_R``` (```{=s:.*\/:result/:; s:_R.*::=}```).

After execution is complete ```result/``` folder has files wor all the samples similar to those mentioned above.

```
ls result

sample11_LN.clns                  sample11_THY.clonotypes.TRB.txt   sample12_SPL.report               sample14_PBMC.vdjca              sample15_PBMC.clns
sample11_LN.clonotypes.TRB.txt    sample11_THY.report               sample12_SPL.vdjca                sample14_SPL.clns                sample15_PBMC.clonotypes.TRB.txt
sample11_LN.report                sample11_THY.vdjca                sample12_THY.clns                 sample14_SPL.clonotypes.TRB.txt  sample15_PBMC.report
sample11_LN.vdjca                 sample12_LN.clns                  sample12_THY.clonotypes.TRB.txt   sample14_SPL.report              sample15_PBMC.vdjca
sample11_PBMC.clns                sample12_LN.clonotypes.TRB.txt    sample12_THY.report               sample14_SPL.vdjca               sample15_SPL.clns
sample11_PBMC.clonotypes.TRB.txt  sample12_LN.report                sample12_THY.vdjca                sample14_THY.clns                sample15_SPL.clonotypes.TRB.txt
sample11_PBMC.report              sample12_LN.vdjca                 sample14_LN.clns                  sample14_THY.clonotypes.TRB.txt  sample15_SPL.report
sample11_PBMC.vdjca               sample12_PBMC.clns                sample14_LN.clonotypes.TRB.txt    sample14_THY.report              sample15_SPL.vdjca
sample11_SPL.clns                 sample12_PBMC.clonotypes.TRB.txt  sample14_LN.report                sample14_THY.vdjca               sample15_THY.clns
sample11_SPL.clonotypes.TRB.txt   sample12_PBMC.report              sample14_LN.vdjca                 sample15_LN.clns                 sample15_THY.clonotypes.TRB.txt
sample11_SPL.report               sample12_PBMC.vdjca               sample14_PBMC.clns                sample15_LN.clonotypes.TRB.txt   sample15_THY.report
sample11_SPL.vdjca                sample12_SPL.clns                 sample14_PBMC.clonotypes.TRB.txt  sample15_LN.report               sample15_THY.vdjca
sample11_THY.clns                 sample12_SPL.clonotypes.TRB.txt   sample14_PBMC.report              sample15_LN.vdjca
```

Now when we have clonsets for all files we can move on to postanalysis.

First we should create a ```metadata.tsv``` file. This is a tab-delimited file, which contains ```sample``` column with sample names, origin tissue data and animal number.


| sample                    | sample_id      | animal | tissue |
|---------------------------|----------------|--------|--------|
| result/sample11_LN.clns   | sample11_LN    | 11     | LN     |
| result/sample11_PBMC.clns | sample11_PBMC  | 11     | PBMC   |
| result/sample11_SPL.clns  | sample11_SPL   | 11     | SPL    |
| result/sample11_THY.clns  | sample11_THY   | 11     | THY    |
| result/sample12_LN.clns   | sample12_LN    | 12     | LN     |
| result/sample12_PBMC.clns | sample12_PBMC  | 12     | PBMC   |
| result/sample12_SPL.clns  | sample12_SPL   | 12     | SPL    |
| result/sample12_THY.clns  | sample12_THY   | 12     | THY    |
| result/sample14_LN.clns   | sample14_LN    | 14     | LN     |
| result/sample14_PBMC.clns | sample14_PBMC  | 14     | PBMC   |
| result/sample14_SPL.clns  | sample14_SPL   | 14     | SPL    |
| result/sample14_THY.clns  | sample14_THY   | 14     | THY    |
| result/sample15_LN.clns   | sample15_LN    | 15     | LN     |
| result/sample15_PBMC.clns | sample15_PBMC  | 15     | PBMC   |
| result/sample15_SPL.clns  | sample15_SPL   | 15     | SPL    |
| result/sample15_THY.clns  | sample15_THY   | 15     | THY    |

Now we can proceed to postanalysis.

Diversity indices are a part of [```mixcr postanalysis individual```](../reference/mixcr-postanalysis.md).

```
postanalysis individual \
    --only-productive \
    --default-downsampling umi-count-auto \
    --metadata result/metadata.tsv \
    --group tissue \
    --tables postanalysis/postanalysis-output.tsv \
    --preproc-tables postanalysis/preproc.tsv \
    --chains TRB \
    result/*.clns \
    postanalysis/individual-postanalysis-output.json
```

The command above will execute individual postanalysis block. All non-functional clone sequences will be dropped (```--only-productive```). Because it is better to compare diversity indices on normalized data, we are using ```--default-downsampling umi-count-auto```. This type of downsample automatically determines the threshold. ```--group tissue``` means that samples will be joined in groups by tissue of origin (according to the metadata provided).

Finally, we want to create box-plots with diversity.

```
mixcr exportPlots diversity \
    --metadata result/metadata.tsv \
    --chains TRB \
    --plot-type boxplot \
    --p-adjust-method none \
    --primary-group tissue \
    postanalysis/individual-postanalysis-output.json plots/diversity.pdf
```





    