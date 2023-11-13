# DriverMap Adaptive Immune Receptor (AIR) DNA TCR-BCR Profiling

Easy-to-run, single-day assay that uses multiplex PCR-NGS technology to profile T-cell receptor (TCR) or B-cell receptor (BCR) repertoire present in human DNA. The DriverMap AIR DNA assay measures the frequency of CDR3 clonotypes to quantify the clonal frequency of T and B cells.

Bellow you can see the structure of cDNA library.

![](../reference/pics/cellecta-human-dna-xcr-umi-drivermap-air-light.svg#only-light)

![](../reference/pics/cellecta-human-dna-xcr-umi-drivermap-air-dark.svg#only-dark)

The data for this tutorial consists of one sample prepared according to the manufacturer's protocol.

All data may be downloaded using the script bellow.

??? tip "Use [aria2c](https://aria2.github.io) for efficient download of the full dataset with the proper filenames:"
    ```shell title="download.sh"
    --8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/scripts/010-download-aria2c.sh"
    ```
    ```shell title="download-list.txt"
    --8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/scripts/download-list.txt"
    ```
## Upstream analysis

MiXCR has a dedicated preset for this protocol, thus analysing the data is as easy as:

```shell
--8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/scripts/020-upstream-preset.sh"
```

Running the command above will generate the following files:

```shell
> ls result/

# human-readable reports 
Sample1.align.report.txt
Sample1.align.report.json
Sample1.refine.report.txt
Sample1.refine.report.json
Sample1.assemble.report.txt
Sample1.assemle.report.json

# raw alignments (highly compressed binary file)
Sample1.vdjca

#Alignments with corrected barcode after ```mixcr refineTagsAndSort```
Sample1.refined.vdjca

# TCR and BCR CDR3 clonotypes (highly compressed binary file)
Sample1.clns

# TCR and BCR CDR3 clonotypes exported in tab-delimited txt
Sample1.clones_IGH.tsv
Sample1.clones_IGK.tsv
Sample1.clones_IGL.tsv
Sample1.clones_TRAD.tsv
Sample1.clones_TRB.tsv
```

While `.clns` file holds all data and is used for downstream analysis using [`mixcr postanalisis`](../reference/mixcr-postanalysis.md), the output `.txt` clonotype table will contain exhaustive information about each clonotype as well:

??? tip "See Sample1.clones_IGH.tsv clonotype table"
    {{ read_csv('docs/mixcr/guides/cellecta-human-dna-xcr-umi-drivermap-air/figs/Sample1.clones_IGH.tsv', engine='python', sep='\t') }}


## Quality control

Now let's look at the QC plots. That can be easily done using [`mixcr exportQc`](../reference/mixcr-exportQc.md)
function.

First we will look at the alignment report:

```shell
--8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/scripts/070-qc-align.sh"
```

![align QC](cellecta-human-dna-xcr-umi-drivermap-air/figs/alignQc.svg)

From this plot we can tell that all samples have high alignment rate and nearly 90% of all reads from each sample have been successfully aligned to the reference sequences and CDR3 has been established. 

Now we can check chains distribution plot:

```shell
--8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/scripts/080-qc-chainUsage.sh"
```

![chain usage QC](cellecta-human-dna-xcr-umi-drivermap-air/figs/chainUsage.svg)

Finally, we can take a look at the reads per UMI distribution.

```shell
--8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/scripts/090-qc-tags.sh"
```

![tags QC](cellecta-human-dna-xcr-umi-drivermap-air/figs/tags.0.svg)


## Reports
Finally, MiXCR provides a very convenient way to look at the reports generated at ech step. Every `.vdjca`, `.clns` and `.clna` file holds all the reports for every MiXCR function that has been applied to this sample. E.g. in our case `.clns` file contains reports for `mixcr align` and `mixcr assemble`. To output this report use [`mixcr exportReports`](../reference/mixcr-exportReports.md) as shown bellow. Note `--json` parameter will output a JSON-formatted report.

```shell
--8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/scripts/100-qc-exportReports.sh"
```

```shell
--8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/scripts/101-qc-exportReports-json.sh"
```

??? "Show report file"
    === "`.txt`"
        ```shell
        --8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/figs/Sample1.report.txt"
        ```
    === "`.json`"
        ```json
        --8<-- "guides/cellecta-human-dna-xcr-umi-drivermap-air/figs/Sample1.report.json"
        ```