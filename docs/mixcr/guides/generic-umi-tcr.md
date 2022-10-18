# Analysis of TCR amplicon libraries with UMIs

## Data libraries

This tutorial uses the data from the publication: Simon S, Voillet V, Vignard V, et al, _PD-1 and TIGIT coexpression identifies a circulating CD8 T cell subset predictive of response to anti-PD-1 therapy_, Journal for ImmunoTherapy of Cancer 2020;8:e001631. [doi: 10.1136/jitc-2020-001631](https://jitc.bmj.com/content/8/2/e001631)

The data was collected from 12 patients. PBMC samples were obtained at three time points for each patient. The libraries were generated using _Human TCR Panel QIAseq Immune Repertoire RNA Library Kit (QIAGEN&trade;)_. Sequencing was performed using Illumina NextSeq&trade; sequencing machine. Each samples contain sequences of TCRα and TCRβ chains enriched cDNA libraries of human. 261bp Read 1 holds CDR3 region and 41bp Read 2 with UMI (first 12bp):

![](../reference/pics/QIAseq-immune-tcr-kit-light.svg#only-light)
![](../reference/pics/QIAseq-immune-tcr-kit-dark.svg#only-dark)

All data may be downloaded directly from SRA using e.g. [SRA Explorer](https://sra-explorer.info).
??? tip "Use [aria2c](https://aria2.github.io) for efficient download of the full dataset with the proper filenames:"
    ```shell title="download.sh"
    --8<-- "generic-umi-tcr/scripts/010-download-aria2c.sh"
    ```
    ```shell title="download-list.txt"
    --8<-- "generic-umi-tcr/scripts/download-list.txt"
    ```


The project contains 544 paired fastq files, separated in multiple lanes and biosample ids:

```shell
> ls raw/

SRR10545725_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_1.fastq.gz
SRR10545725_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_2.fastq.gz
SRR10545726_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_1.fastq.gz
SRR10545726_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_2.fastq.gz
SRR10545727_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_1.fastq.gz
SRR10545727_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_2.fastq.gz
SRR10545728_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_1.fastq.gz
SRR10545728_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_2.fastq.gz
...
```

Each file name encodes the information about lane, biosample id, metadata, R1 or R2. For example for the first file from above listing: 

- `SRR10545497` - lane
- `GSM4195404` - biosample id
- `P5` - patient id
- `T0` - time point
- `DPOS` - double positive
- `OTHER_1` - first mate of paired-end data.

## Upstream analysis

The most straightforward way to get clonotype tables is to use a
universal [`mixcr analyze`](../reference/mixcr-analyze.md) command.

According to the library preparation protocol, the library has V primers on 5'-end and C primers on 3', so the command for a single sample is the following:

```shell
--8<-- "generic-umi-tcr/scripts/020-upstream-example.sh"
```

The meaning of these options is the following.

`--species`
: is set to `hsa` for _Homo Sapience_

`--starting-material`
: RNA or DNA. It affects the choice of V gene region which will be used as target in [`align`](../reference/mixcr-align.md) step (`vParameters.geneFeatureToAlign`, see [`align` documentation](../reference/mixcr-align.md)): `rna` corresponds to the `VTranscriptWithout5UTRWithP` and `dna` to `VGeneWithP` (see [Gene features and anchor points](../reference/ref-gene-features.md) for details)

`--receptor-type`
: TCR or BCR. It affects the choice of underlying alignment algorithms: MiXCR uses fundamentally different algorithms for TCRs and BCRs because BCRs have somatic hypermutations and long indels.

`--5-end`
: may be `no-v-primers` or `v-primers`. For this library structure we use `no-v-primers` while e.g. Depending on the presence of primers or adapters at 5'-end MiXCR uses either global or local alignment algorithm to align the left bound of V.

`--3-end-primers`
: may be `j-primers`, `j-c-intron-primers` or `c-primers`. Here we use `c-primers` since the primer used for library preparation is complimentary to C-region of TCR genes. Depending on the presence of primers or adapters at 3'-end MiXCR uses either global or local alignment algorithms to align the right bound of J and C gene segments.

`--adapers`
: may be `adapters-present` or `no-adapters`. We use `adapters-present` because primer sequence is present in the data and has not been cut prior to. Presence or absence of adapter sequences results in the choice between local and global alignment algorithms on the edges of the target sequence.

`--umi-pattern`
: is used to specify UMI pattern for the library. MiXCR provides a powerful regex-like [language](../reference/ref-tag-pattern.md) allowing to specify almost arbitrary barcode structure. Here we use `^(R1:*)\^(UMI:N{12})` pattern to specify that R1 should be used as is, UMI spans the first 12 letters of R2 and the rest of R2 is ignored.

Finally, we specify paths for both input files and a path to output folder with prefix describing the sample. Note that `{{n}}` syntax is similar to Linux wildcard behaviour: it will concatenate all fastq files matching this pattern into one sample. This is very useful when you have for example multiple lanes.

Running the command above will generate the following files:

```shell
> ls results/

# human-readable reports 
P15-T0-TIGIT.report
# raw alignments (highly compressed binary file)
P15-T0-TIGIT.vdjca
# alignments with corrected UMI barcode sequences 
P15-T0-TIGIT.refined.vdjca
# TCRα & TCRβ CDR3 clonotypes (highly compressed binary file)
P15-T0-TIGIT.clns
# TCRα & TCRβ CDR3 clonotypes exported in tab-delimited txt
P15-T0-TIGIT.clonotypes.TRA.tsv
P15-T0-TIGIT.clonotypes.TRB.tsv  
```

Clonotype tables is the main result of the upstream analysis. They are stored in a highly compressed and efficient binary `.clns` file and can be exported in many ways: detailed [tab-delimited format](../reference/mixcr-export.md) with dozens of customizable columns, [human readable](../reference/mixcr-exportPretty.md) for manual inspection, and [AIRR format](../reference/mixcr-exportAirr.md) suitable for many scientific downstream analysis tools. By default, MiXCR exports clonotypes in a tab-delimited format separately for each immunological chain.

In order to run the analysis for all samples in the project on Linux we can for example use [GNU Parallel](https://www.gnu.org/software/parallel/) in the following way:

```shell
--8<-- "generic-umi-tcr/scripts/030-upstream-parallel.sh"
```

Briefly, we list all R1 files in the fastq directory, replace lane specifications with MiXCR `{{n}}` wildcard, pipe the list to parallel, then run `mixcr analyze` for each pair, again using sed to obtain R2 filename from R1 and the name of output.

### Details and fine-tuning

Under the hood, `mixcr analyze amplicon` executes the following pipeline of MiXCR actions:

![pipeline](generic-umi-tcr/figs/mixcr_pipeline.svg)

Each step in this pipeline is executed with a specific options inherited from the options supplied to `mixcr analyze amplicon`. Instead of running `analyze` one can run the whole pipeline step by step and additionally fine tune the analysis parameters at each step. Another reason why sometimes it is better to execute the pipeline step by step is the ability to better manage hardware resources allocated to each step, because some steps are memory intensive and less CPU intensive, while others are vice a versa.

Let's go throw each step executed in the considered case.

#### `align`

[Performs](../reference/mixcr-align.md):

- alignment of raw sequencing reads against reference database of V-, D-, J- and C- gene segments
- pattern matching of tag pattern sequence and extraction of barcodes

```shell
--8<-- "generic-umi-tcr/scripts/040-upstream-align.sh"
```

Options `--report` and `--json-report` are specified here explicitly. Since we start from RNA data we use `VTranscriptWithout5UTRWithP` for the alignment of V segments (see [Gene features and anchor points](../reference/ref-gene-features.md). Because we have primers on V segment, we use local alignment on the left bound of V and since we have primers on C segment, we use global alignment for J and local on the right bound of C.

This step utilizes all available CPUs and scales perfectly. When there are a lot of CPUs, the only limiting factor is the speed of disk I/O. To limit the number of used CPUs one can pass `--threads N` option.

#### `correctAndSortTags`

[Corrects](../reference/mixcr-refineTagsAndSort.md) sequencing and PCR errors _inside_ barcode sequences. This step does extremely important job by correcting artificial diversity caused by errors in barcodes. In the considered example project it corrects only sequences of UMIs.

```shell
--8<-- "generic-umi-tcr/scripts/050-upstream-correctAndSortTags.sh"
```

Options `--report` and `--json-report` are specified here explicitly so that the report files will be appended with the barcode correction report.

#### `assemble`

[Assembles](../reference/mixcr-assemble.md) clonotypes and applies several layers of errors correction. In the current example project we consider TCRα & TCRβ separately and clonotype by its CDR3 sequence. The layers of correction applied in this example are:

- assembly consensus CDR3 sequence for each UMI
- quality-awared correction for sequencing errors
- clustering to correct for PCR errors, which still may present even in the case of UMI data, since a error may be introduced e.g. on the first reverse-transcription cycle

```shell
--8<-- "generic-umi-tcr/scripts/060-upstream-assemble.sh"
```

Options `--report` and `--json-report` are specified here explicitly so that the report files will be appended with assembly report.

Assembly step may be quite memory consuming for very big datasets. MiXCR offloads memory intensive computations to disk and does it in a highly efficient and parallelized way, fully utilizing all hardware facilities. For such big samples it may be worth to control the amount of RAM provided to MiXCR using `-Xmx` JVM option (the more RAM supplied the faster execution):

```shell
> mixcr -Xmx16g assemble ...
```

#### `exportClones`

Finally, to [export](../reference/mixcr-export.md#clonotype-tables) clonotype tables in tabular form `exportClones` is used:

```shell
--8<-- "generic-umi-tcr/scripts/070-upstream-exportClones.sh"
```

Here `-p full` is a shorthand for the full preset of common export columns and `-uniqueTagCount UMI` adds a column with the UMI count for each clone.

The resulting clonotype table will contain exhaustive information about each clonotype:

{{ read_table('docs/mixcr/guides/generic-umi-tcr/figs/P15-T0-TIGIT.TRA.tsv', engine='python', sep='\t', nrows=3) }}

??? tip "See full clonotype table for P15-T0-TIGIT:"
    {{ read_csv('docs/mixcr/guides/generic-umi-tcr/figs/P15-T0-TIGIT.TRA.tsv', engine='python', sep='\t') }}


## Quality controls

MiXCR generates comprehensive reports for each step of the pipeline, containing exhaustive information about quality of the library and performance of the algorithms. These reports are a primary source of the feedback to the wet lab, and also may be used to tune the parameters of the pipeline.

The very basic overview of the library performance may be generated in a graphical form using `mixcr exportQc align` command:

```shell
--8<-- "generic-umi-tcr/scripts/080-qc-align.sh"
```
![alignQc.svg](generic-umi-tcr/figs/alignQc.svg)

This plot shows the fraction of raw reads that were successfully aligned against reference V/D/J/C-gene segment library. Rate of successful alignments is expected to be higher than 90% for a high quality targeted TCR library. So in the considered example something went not as expected.

In most cases when we observe low alignment rate for amplicon library, the reason lies either in a wrong understanding of the library architecture or some sample preparation artefacts. From the plot we see two primary reasons for failed alignments:

- Alignment failed, no any hits (not TCR/IG) - read was not covered by any part of V/D/J/C-gene segments, which is probably due to a contamination in the lab
- Alignments failed because of absence of J hits - read was covered by V segment, but not by J

To dig deeper one can re-align one problematic sample with the options to preserve partial alignments and save not-aligned reads:

```shell
--8<-- "generic-umi-tcr/scripts/090-qc-debug-align.sh"
```

Additional options are:

`-OallowNoCDR3PartAlignments`
: preserve alignments that do not fully cover CDR3 region in the output

`-OallowPartialAlignments`
:  preserve alignments that lack either V or J hit in the output

`--not-aligned-R1`
: save all not aligned reads to `na.fastq`

Now one can check how reads cover V-D-J region using `exportQc coverage` command:

```shell
--8<-- "generic-umi-tcr/scripts/100-qc-coverage.sh"
```
![coverage](generic-umi-tcr/figs/P23-T0-DPOS_debug.coverage_R0.svg)

From this plot it is seen that there are nearly 50% of not-spliced reads in the data, which is a clear signal of some library preparation artefacts.

To dig even deeper one can also export raw alignments in a human-readable way for further manual inspection:

```shell
--8<-- "generic-umi-tcr/scripts/110-qc-exportAlignmentsPretty.sh"
```

Some examples from the output illustrating wet lab artefacts:

```
>>> Read ids: 1

   Quality    22222224225262622222222727222
   Target0  0 CATAAAATCATCGTGTCAGAGAAGGGAAA 28   Score
TRBV7-2*00 94                 cagagaagggaaa 106  65
TRBV7-3*00 94                 cagagaagggaaa 106  65


          _ T  P  H  P  P  P  H  P  A  A  P  D  P  P  P  P  T  P  P  L  H  P  P  P  P  P
Quality   26222554266244522552226622622255252424222424522222224572655225265422265622726222
Target1 0 CACACCCCACCCCCCCCCCCACCCCGCCGCCCCCGACCCCCCTCCCCCGACCCCCCCCCTCCACCCCCCCCCCCCCCCCC 79  Score

                                                                                     <J     CD
              P  H  P  P  P  P  P  P  H  A  P  P  P  P  P  P  P  P  P  R  A  G  R  H  T  Q  Y
   Quality    56264672227222227277727225222242256272762722222226222262222222222222222767777752
   Target1 80 CCCACCCCCCCCCCCCCCCCCCCCACGCGCCCCCCCCCCCCCCCCCCCCCCCCCCCCGCGCCGGCCGCCACACCCAGTAC 159  Score
TRBJ2-5*00 28                                                                        acccagtac 36   186

               R3><FR4                    FR4><C
                F  G  P  G  T  R  L  L  V  L  E  D  L  K  N  V  F  P  P  E  V  A  V  F  E  P  S
   Quality     77462776776777222727275627625777775676777777767777772727666777767577676777777777
   Target1 160 TTCGGGCCAGGCACGCGGCTACTGGTGCTCGAGGACCTGAAAAACGTGTTCCCACCCGAGGTCGCTGTGTTTGAGCCATC 239  Score
TRBJ2-5*00  37 ttcgggccaggcacgcggctCctggtgctcg                                                  67   186
  TRBC2*00   0                                aggacctgaaaaacgtgttcccacccgaggtcgctgtgtttgagccatc 48   330
  TRBC1*00   0                                aggacctgaaCaaGgtgttcccacccgaggtcgctgtgtttgagccatc 48   302
  
  
>>> Read ids: 17

Quality   22222222222777777727776774777
Target0 0 ACTAGAGGTGGTCTTAATAACATCAGGGA 28  Score


             _ E  S  I  I  R  Q  L  Y  S  L  L  I  T  S  G  K  S  L  K  F  I  L  E  N  L  I
 Quality     24624425222562545262542222265255252255252252467657526665566526226544775226266625
 Target1   0 TGAGAGCATAATTAGACAATTGTATTCCTTATTAATAACATCAGGGAAAAGCCTTAAATTTATACTGGAAAATCTAATTG 79   Score
TRGV8*00 274                                          cagggaaGagccttaaatttatactggaaaatctaattg 312  356

                                 FR3><CDR3     V>         <J               CDR3><FR4
              E  R  D  S  G  V  Y  Y  C  A  T  W  I  Q  G _ T  G  W  F  K  I  F  A  E  G  T  K
  Quality     66446666665444255226265657272527756756665255757525576277277777766767777777677777
  Target1  80 AACGTGACTCTGGGGTCTATTACTGTGCCACCTGGATTCAGGGGCACTGGTTGGTTCAAGATATTTGCTGAAGGGACTAA 159  Score
 TRGV8*00 313 aacgtgactctggggtctattactgtgccacctgg                                              347  356
TRGJP1*00  24                                             cactggttggttcaagatatttgctgaagggactaa 59   280

                              FR4><C
                L  I  V  T  S  P  D  K  Q  L  D  A  D  V  S  P  K  P  T  I  F  L  P  S  I  A
  Quality     77777777777577776777777777777776767777776677777677777777777777777777767777777777
  Target1 160 GCTCATAGTAACTTCACCTGATAAACAACTTGATGCAGATGTTTCCCCCAAGCCCACTATTTTTCTTCCTTCAATTGCTG 239  Score
TRGJP1*00  60 gctcatagtaacttcacctg                                                             79   280
 TRGC1*00   0                     ataaacaacttgatgcagatgtttcccccaagcccactatttttcttccttcaattgctg 59   391
 TRGC2*00   0                     ataaacaacttgatgcagatgtttcccccaagcccactatttttcttccttcaattgctg 59   377

```

Finally, one can use `na.fastq` to blast not aligned sequences and precisely determine the source of not aligned reads: contamination, artefacts in the library preparation etc.

Another useful report is a chain usage report:

```shell
--8<-- "generic-umi-tcr/scripts/120-qc-chainUsage.sh"
```
![chainUsage.svg](generic-umi-tcr/figs/chainUsage.svg)

Here we see a small fraction of TRG sequences, which are not supposed to be present in the library, thus the initial cell selection probably was not ideal.

Individual reports generated at each step of MiXCR pipeline can be exported either in JSON or text form using [`exportReports`](../reference/mixcr-exportReports.md) command:

```shell
--8<-- "generic-umi-tcr/scripts/125-qc-exportReports.sh"
```

Detailed description of each report can be found in [reports section](../reference/report-align.md) of reference.

## Downstream analysis

There are two types of basic downstream analysis: _individual_ and _overlap_. Individual computes CDR3 metrics, diversity and gene usage metrics for each dataset. Overlap computes statistical metrics of repertoire overlap. In both cases MiXCR applies appropriate sample normalization.

To run postanalysis routines we need to prepare a metadata file in a .tsv or .csv form. Table must contain `sample` column which will be used to match metadata with cloneset files. For our project metadata table looks like:

{{ read_csv('docs/mixcr/guides/generic-umi-tcr/scripts/metadata.tsv', engine='python', sep='\t', nrows=3) }}


??? tip "See full metadata:"
    {{ read_csv('docs/mixcr/guides/generic-umi-tcr/scripts/metadata.tsv', engine='python', sep='\t') }}

### Individual metrics

To compute individual metrics of datasets we run

```shell
--8<-- "generic-umi-tcr/scripts/130-pa-individual.sh"
```

The meaning of specified options is the following:

`--metadata`
: specified metadata file to use

`--default-downsampling`
: downsampling applied to normalize the clonesets. Without appropriate normalization it is not possible to make a statistical comparisons between datasets. In the considered case we normalize data to the same number of UMIs, and this number is computed automatically based on the number of unique UMIs in each clone in each dataset. For all downsampling options see [TODO]. Default downsampling may be overridden for individual metrics.

`--default-weight-function`
: defines weight of each clonotype. May be `read`, `umi` or `cell`

`--only-productive`
: drop clonotypes with out-of-frame CDR3 sequences or containing stop codons

`--tables`
: path for postanalysis metrics in a tabular form

`--preproc-tables`
: path for tabular summary of the applied downsampling and other samples preprocessing (for example filtering productive clonotypes)

After execution, we will have the following files:

```shell
> ls pa/

# gzipped JSON with all results 
i.json.gz

# summary of applied downsampling
i.preproc.TRA.tsv
i.preproc.TRB.tsv
# diversity tables
i.diversity.TRA.tsv
i.diversity.TRB.tsv
# CDR3 metrics tables & CDR3 properties
i.cdr3metrics.TRA.tsv
i.cdr3metrics.TRB.tsv
# V-gene usage
i.vUsage.TRA.tsv
i.vUsage.TRB.tsv

...
```

MiXCR runs postanalysis for each chain individually, so we have result per each chain in the output. One can specify `--chains` option to select specific chains for the analysis. Also in case if you have separate .fastq files for separate chains, it is possible to specify `chains` metadata column.

Preprocessing summary tables (e.g. `i.preproc.TRA.tsv`) contain detailed information on how downsampling was applied for each metric:

{{ read_csv('docs/mixcr/guides/generic-umi-tcr/figs/i.preproc.TRA.tsv',  engine='python', sep='\t', nrows=3) }}

??? tip "See full preprocessing summary:"
    {{ read_csv('docs/mixcr/guides/generic-umi-tcr/figs/i.preproc.TRA.tsv', engine='python', sep='\t') }}


The meaning of the columns is the following:

`characteristic`
: name for a set of metrics

`preprocessor`
: the name of the _overall_ preprocessor chain applied to the dataset

`nElementsBefore`
: number of clonotypes before any preprocessing applied (that is in the initial dataset)

`sumWeightBefore`
: total weight of all clonotypes before any preprocessing applied. The weight may be either number of reads or UMIs or cells, depending on the selected downsampling.

`nElementsAfter`
: number of clonotypes in the dataset after all preprocessing applied

`sumWeightBefore`
: total weight of all clonotypes after all preprocessing applied.

`preprocessor#i`
: i-th part of the preprocessing chain

Finally, tabular results for postanalysis metrics contain information about each metric computed for each sample. For example, for diversity metrics:

{{ read_csv('docs/mixcr/guides/generic-umi-tcr/figs/i.diversity.TRA.tsv',  engine='python', sep='\t', nrows=3) }}

??? tip "See full diversity results for TRA chain:"
    {{ read_csv('docs/mixcr/guides/generic-umi-tcr/figs/i.diversity.TRA.tsv', engine='python', sep='\t') }}



#### Graphical output

MiXCR allows to export graphical results in PDF, EPS, PNG and SVG formats using `exportPlots` command.

For diversity metrics and CDR3 properties MiXCR allows to group data in a different ways and apply various statistical tests.

For example, if one interested in how diversity metrics are changed between time points for different markers we can use a combination of primary grouping and faceting:

```shell
--8<-- "generic-umi-tcr/scripts/140-pa-diversity-facets.sh"
```
![diversity facets](generic-umi-tcr/figs/diversity-facets.TRA.svg)

Or using secondary grouping:

```shell
--8<-- "generic-umi-tcr/scripts/150-pa-diversity-secondary-grouping.sh"
```
![secondary grouping](generic-umi-tcr/figs/diversity-grouped.TRA.svg)

For further details see [exportPlots reference](../reference/mixcr-exportPlots.md).

Gene usage plots may be exported as heatmaps:

```shell
--8<-- "generic-umi-tcr/scripts/160-pa-vUsage.sh"
```
![vUsage.TRA.svg](generic-umi-tcr/figs/vUsage.TRA.svg)

For further details see [gene usage plots reference](../reference/mixcr-exportPlots.md).

### Overlap metrics 

To compute samples pairwise overlap metrics we run

```shell
--8<-- "generic-umi-tcr/scripts/170-pa-overlap.sh"
```

Then we can export graphical heatmap using `exportPlots` command: 

```shell    
--8<-- "generic-umi-tcr/scripts/180-pa-overlap-export.sh"
```

![overlap](generic-umi-tcr/figs/overlap.TRA.svg)


However, when there are many samples such representation may be not very informative. In this case it may be worth to factor data by specific columns. For example, in the considered project we might be interested in the overlap between different groups of samples (`Time`, `Marker`):

```shell
--8<-- "generic-umi-tcr/scripts/190-pa-overlap-factor-by.sh"
```

This way MiXCR will perform pairwise overlap comparison between groups of samples with different `Time` and `Marker` values. 

The tabular output for example for F1 metric will look like:

{{ read_csv('docs/mixcr/guides/generic-umi-tcr/figs/o.tm.F1Index.TRA.tsv',  engine='python', sep='\t') }} |

The graphical output will be more informative as well:

```shell
--8<-- "generic-umi-tcr/scripts/200-pa-overlap-factor-by-export.sh"
```
![overlap.tm](generic-umi-tcr/figs/overlap.tm.TRA.svg)

For further details see [overlap postanalysis reference](../reference/mixcr-exportPlots.md).
