# Immunoglobulin lineage trees reconstruction

MiXCR v4.1 allows V- and J-gene allele inference and somatic hypermutation lineage trees reconstruction. This guide covers these two major advances in BCR repertoire analysis.

In this guide we demonstrate MiXCR pipeline for a full-length 5’RACE-based IGH sequencing libraries processing, utilizing UMIs, as well as downstream applications for IGHV and IGHJ allele inference and clonal lineage trees reconstruction.

## Data

This tutorial uses the data from the publication: Mikelov A, Alekseeva EI, Komech EA, Staroverov DB, Turchaninova MA, Shugay M, Chudakov DM, Bazykin GA, Zvyagin IV. Memory persistence and differentiation into antibody-secreting cells accompanied by positive selection in longitudinal BCR repertoires. Elife. 2022 Sep 15;11:e79254. [doi: 10.7554/eLife.79254](https://doi.org/10.7554/eLife.79254).

The data was collected from 6 patients. PBMC samples were obtained at three time points and memory B-cells, plasmablasts and plasma cells were sorted using FACS. The cDNA IGH libraries were obtained using a custom 5’RACE-based protocol, utilizing UMIs. Sequencing was performed using Illumina HiSeq™ 2000/2500 sequencing machine, 310 bp paired end, which allowed to cover the full-length IGH sequence. 

For the demonstration purpose, let's download only the files belonging to one donor, e.g. donor IM:

??? tip "Use [aria2c](https://aria2.github.io) for efficient download of the dataset with the proper filenames:"
    ```shell title="download.sh"
    --8<-- "guides/ig-trees-mikelov/scripts/010-download-aria2c.sh"
    ```
    ```shell title="download-list.txt"
    --8<-- "guides/ig-trees-mikelov/scripts/download-list.txt"
    ```

## Upstream analysis

### Preset

The first step that we have to do is to obtain `.clns` clonotype files for the samples. Since it's a BCR data with UMI barcodes, the easiest way to obtain clonotype files is to use `mixcr analyze` command with `generic-bcr-umi-amplicon` preset which uses [`kAligner2`](../reference/mixcr-align.md#v-j-and-c-aligners-parameters) - a BCR dedicated aligner.

Bellow you can see an example command for one sample:

```shell
--8<-- "guides/ig-trees-mikelov/scripts/020-upstream-preset.sh"
```

This generic presets requires a few options:

`--species`
: is set for human (_Homo Sapiens_) 

`--tag-pattern "^N{19}(R1:*)\^tggtatcaacgcagagtac(UMI:N{19})tct>{2}(R2:*)"`
: this pattern ensures C-primers sequences trimming and determines the UMI position in the read.

`--rna`
: leads to `-OvParameters.geneFeatureToAlign=VTranscriptWithP` in [`mixcr align`](../reference/mixcr-align.md#gene-features-to-align) step.

`--rigid-left-alignment-boundary`
: configures aligners to use global alignment at reads 5'-end due to the absence of primer sequences in V-region with 5'RACE protocol. This mix-in passes `-OvParameters.parameters.floatingLeftBound=false` to [`mixcr align`](../reference/mixcr-align.md#parameters-for-kaligner2).

`--rigid-right-alignment-boundary C`
: configures aligners to use global alignment at reads 3'-end and include C gene. We use global alignment here because the primer sequences were trimmed with `--tag-pattern`. This mix-in passes `-OjParameters.parameters.floatingRightBound=false -OcParameters.parameters.floatingRightBound=false` to [`mixcr align`](../reference/mixcr-align.md#parameters-for-kaligner2).

`--assemble-clonotypes-by VDJRegion`
: sets the feature by which clonotypes will be assembled by passing `-OassemblingFeatures=VDJRegion` to [`mixcr assemble`](../reference/mixcr-assemble.md#core-assembler-parameters) step.

`--split-clones-by C`
: passes `-OseparateByC=true` to [`mixcr assemble`](../reference/mixcr-assemble.md#pre-clustering-parameters) step. This provides isotype based clone separation.

`--remove-step exportClones`
: initially this preset include `mixcr exportCLones` step, but we will skip it for now, as we need to find new alleles from the `.clns` files firstly.

The command above will generate the following set of output files:

```shell
> ls result/

# human-readable reports for every step in txt and json format
IM_p01_PBL_1.align.report.json
IM_p01_PBL_1.align.report.txt
IM_p01_PBL_1.assemble.report.json
IM_p01_PBL_1.assemble.report.txt
IM_p01_PBL_1.refine.report.json
IM_p01_PBL_1.refine.report.txt

# raw alignments (highly compressed binary file)
IM_p01_PBL_1.vdjca

# alignments with corrected UMI barcode sequences 
IM_p01_PBL_1.refined.vdjca

# IG clonotypes (highly compressed binary file)
IM_p01_PBL_1.clns
```

In order to run the analysis for all samples in the project on Linux we can use [GNU Parallel](https://www.gnu.org/software/parallel/) in the following way:

```shell
--8<-- "guides/ig-trees-mikelov/scripts/030-upstream-preset-parallel.sh"
```
### Under the hood pipeline explained

Under the hood the command above actually executes the following pipeline:

#### `align`
Alignment of raw sequencing reads against reference database of V-, D-, J- and C- gene segments.

```shell
--8<-- "guides/ig-trees-mikelov/scripts/040-upstream-align.sh"
```
`-p bundle-umi-kaligner2-v1-base`
: this preset describes alignment parameters tuned for maximum performance with BCR data, also it provides a set of parameters for subsequent steps including settings for `mixcr assemble` regarding UMI error-correction and filtering.

The rest of parameters are explained above.

#### `refineTagsAndSort`

[Corrects](../reference/mixcr-refineTagsAndSort.md) sequencing and PCR errors _inside_ barcode sequences. This step does extremely important job by correcting artificial diversity caused by errors in barcodes. In the considered example project it corrects only sequences of UMIs.

```shell
--8<-- "guides/ig-trees-mikelov/scripts/050-upstream-refine.sh"
```

#### `assemble`
Assembles alignments into clonotypes and applies several layers of errors correction:

- quality-dependent correction for sequencing errors
- PCR-error correction by clustering
- UMI-based error correction)

Check [`mixcr assemble`](../reference/mixcr-assemble.md) for more information.

```shell
--8<-- "guides/ig-trees-mikelov/scripts/060-upstream-assemble.sh"
```

## Quality control

Before we move on to lineage trees reconstruction, we will look at the basic QC plots.

First, lets generate and investigate alignment rates QC plot.

```shell
--8<-- "guides/ig-trees-mikelov/scripts/070-qc-align.sh"
```

![align QC](ig-trees-mikelov/figs/alignQc.svg)

Most of the samples have a high successful alignment score of >90% successfully aligner reads. A few samples have a height number of non-target reads. These reads can be extracted and manually investigated using `--not-aligned-R1` and `--not-aligned-R2` options with [`mixcr align`](../reference/mixcr-align.md#command-line-options), but for the purpose of this tutorial we are going to continue and look at the chain usage plot:

```shell
--8<-- "guides/ig-trees-mikelov/scripts/080-qc-chain-usage.sh"
```

Here, we see, the samples are almost entirely consist of IGH chains, which is what one should expect when using IGH target sequencing.

![chainUsage.svg](ig-trees-mikelov/figs/chainUsage.svg)

##  Allele inference

The next step, after obtaining clonotypes is to perform allele inference to separate true allelic variants from hypermutations alterations. This is done using `mixcr findAlleles`  commands which works in two steps:

- a new personalized reference gene library is generated based on the provided samples. 

!!! note
    Only samples obtained from a single donor (or genetic mice strain) should be provided for allele inference.

- the newly generated reference is used to realign each clone. New `.clns` files are generated.

```shell
--8<-- "guides/ig-trees-mikelov/scripts/090-find-alleles.sh"
```

`--export-alleles-mutations`
: specifies a path to write the descriptions and stats for all original and new alleles

`--export-library`
: specifies a path where to write the new library with found alleles.

`--output-template {file_dir_path}/{file_name}_.reassigned.clns`
: specifies the output file path. `{file_dir_path}/{file_name}_.reassigned.clns` means that each realigned `.clns` file will be placed in the same folder and will have the same base name as the original `.clns` file.

For more information on how to read the output tables see [`mixcr findAlleles`](../reference/mixcr-findAlleles.md).

## Export clones

Now, when the alleles have been reassigned we can export clonotype tables in a human-readable format.


```shell
--8<-- "guides/ig-trees-mikelov/scripts/100-export-clones.sh"
```
??? note "Show top 500 clones in IM_p01_Bmem_1_IGH.txt"
    {{ read_csv('docs/mixcr/guides/ig-trees-mikelov/figs/IM_p01_Bmem_1_IGH.txt', engine='python', sep='\t') }}


##  Generate lineage trees

Now we can reconstruct clonal lineage trees with [`mixcr findShmTrees`](../reference/mixcr-findShmTrees.md)  command:

```shell
--8<-- "guides/ig-trees-mikelov/scripts/110-find-shm-trees.sh"
```

### Export lineage trees in a tabular format

To export information on lineage trees in human-readable format use [`mixcr exportShmTreesWithNodes`](../reference/mixcr-exportShmTrees.md#shm-trees-with-nodes-tables).

```shell
--8<-- "guides/ig-trees-mikelov/scripts/120-export-shm-trees-with-nodes.sh"
```

??? note "Show top 500 records from in IM_trees.txt"
    {{ read_csv('docs/mixcr/guides/ig-trees-mikelov/figs/IM_trees.txt', engine='python', sep='\t') }}

The trees can also be exported in a standard Newick format with [`mixcr exportShmTreesNewick`](../reference/mixcr-exportShmTrees.md#newick):

```shell
--8<-- "guides/ig-trees-mikelov/scripts/130-export-trees-newick.sh"
```

This command will generate a separate Newick formatted file for every linage tree and put it in a `IM_newick` folder. For this dataset  18916 trees have been generated.

??? note "Show tree with id 4992"
    {{ read_csv('docs/mixcr/guides/ig-trees-mikelov/figs/4992.tree', engine='python', sep='\t') }}

### Export linage trees in a graphical format

It is also possible to plot lineage trees and add metadata values for better visualization.

??? note "Metadata"
    {{ read_csv('docs/mixcr/guides/ig-trees-mikelov/scripts/metadata.tsv', engine='python', sep='\t') }}

```shell
--8<-- "guides/ig-trees-mikelov/scripts/140-plot-shmTrees.sh"
```

`--node-color Timepoint`
: Links the colors of the nodes to the metadata column Timepoint

`--line-color Subset`
: Links the colors of the lines to the metadata column Subset

`--ids 4992,5530,12970`
: tree ids to be plotted

By default node size represents clone fraction.




One can also add an amino acid or nucleotide alignments for a specified gene feature to the plot:

```shell
--8<-- "guides/ig-trees-mikelov/scripts/150-plot-shmTrees-cdr3.sh"
```



