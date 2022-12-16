# `mixcr postanalysis`

Runs basic postanalysis routines for a list of clonesets and writes the results to a compressed json file, which then may be used for tabular export with [`exportTables`](mixcr-exportTables.md) or graphical export with [`exportPlots`](mixcr-exportPlots.md). There are two types of basic postanalysis:

- [Individual](./mixcr-postanalysis.md#individual-postanalysis) - computes different characteristics for each of the passed clonesets individually
- [Overlap](./mixcr-postanalysis.md#overlap-postanalysis) - builds clonesets overlap and computes various metrics on it

In both cases schematically MiXCR works in the following way:

1. Splits each of the passed clonesets into `TRAD`,  `TRB`, `TRG`, `IGH`, `IGK` and `IGL` clonesets (of course if they present in the data)
2. For each immunological chain it optionally filters productive clonotypes if the corresponding flag is specified
3. Applies normalization of samples according to the specified downsampling
4. Finally, it iterates over normalized datasets and computes either
    - (`individual`) all the characteristics for each dataset
    - (`overlap`) overlap of the normalized clonesets and various pairwise metrics on the overlap

## Common

There are several important common aspects of individual and overlap postanalysis.

### Downsampling

Downsampling is a required procedure without which it is not possible to make a statistical comparisons between datasets.

![](./pics/downsampling-light.svg#only-light)
![](./pics/downsampling-dark.svg#only-dark)

There are three types of downsampling each of which may be applied on a one of three tag levels: `read`, `umi` or `cell`:

`count-<tag>-(auto|min|fixed)[-<number>]`

:   normalizes datasets to the same _tag number_ (either reads, UMIs or cells). The exact downsampling value may be either

    - computed automatically (`auto`)
    - chosen as a value in the smallest sample (`min`)
    - specified explicitly (`fixed`)

    For automatic downsampling MiXCR calculates 20-th quantile across all clonesets _Q20_, and takes the minimal sample which is above _0.5*Q20_.
    
    For memory efficiency, MiXCR uses random multivariate hypergeometric marginals algorithm for downsampling to the same number of reads.
     
    For downsampling to the same number of UMIs or cells, MiXCR uses random uniform sampling of the whole tag list. 

`top-<tag>-<number>`

:   normalizes datasets to the same number of clonotypes. It takes top `<number>` of clonotypes by corresponding `tag` (i.e. top by number of reads, or by number of UMIs or by number of cells)

`cumtop-<tag>-<percent>`

:   normalizes datasets to the same cloneset abundance. It takes top clonotypes by corresponding `tag` (i.e. top by number of reads, or by number of UMIs or by number of cells) so that the top contains the specified `<percent>` of the cloneset abundance (again computed by corresponding `tag`) 

`none`

:   no downsampling

### Weight functions

MiXCR requires to select one of the four methods used to calculate weight of each clonotype:

`read`

:   weight by the number of reads

`umi`

:   weight by the number of UMI

`cell`

:   weight by the number of unique cell barcodes corresponding to the clone

`none`

:   for unweighted analysis


### Metadata

Optionally, one can supply a metadata `.tsv` or `.csv` table which may be used further in `exportPlots` command to group samples and apply different statistical tests on a groups of samples. Metadata file must contain `sample` column. Values in this column should allow unambiguously match names of the input files using the longest common substring (LCS) algorithm. For example, suppose the input samples are:

```shell
> ls results/*

results/sample_1_23_p.clns
results/sample_2_54_n.clns
results/sample_3_32_n.clns
results/sample_4_62_p.clns
...
```

where `sample_i` part is unique for each sample. Then the sample metadata may look like:

| sample   | age | condition |
|----------|-----|-----------|
| sample_1 | 23  | p         |
| sample_2 | 54  | n         |
| sample_3 | 32  | n         |
| sample_4 | 62  | p         |
| ...      | ... | ...       |  

Sometimes one project may contain samples corresponding to different immunological chains in separate files. In that case it is necessary to add `chain` column to the metadata file and MiXCR will use it. For example:

```shell
> ls results/*

results/sample_1_23_p_alpha.clns
results/sample_2_54_n_beta.clns
results/sample_3_32_n_alpha.clns
results/sample_4_62_p_beta.clns
...
```

and example metadata:

| sample   | chain | age | condition |
|----------|-------|-----|-----------|
| sample_1 | TRA   | 23  | p         |
| sample_2 | TRB   | 54  | n         |
| sample_3 | TRA   | 32  | n         |
| sample_4 | TRB   | 62  | p         |
| ...      | ...   | ... | ...       |


### Isolation groups 

Sometimes there is no need to apply normalization for _all_ samples. For example, if there are two cell subsets in the data (e.g. CD4 and CD8) and you are interested in overlap postanalysis, then it is totally meaningless to compute overlap between CD4 and CD8 subsets. MiXCR allows to specify metadata column which will be used to separate samples into groups and apply downsampling and postanalysis separately for each group of samples.        
   

## Individual postanalysis

```
mixcr postanalysis individual 
  --default-downsampling (<type>|none) 
  --default-weight-function (<read>|<Tag>|none) 
  [--only-productive] 
  [--drop-outliers] 
  [--chains <chain>[,<chain>...]]... 
  [--metadata <path>] 
  [--group <group>]... 
  [--tables <path.(tsv|csv)>] 
  [--preproc-tables <path.(tsv|csv)>] 
  [-O <key=value>]... 
  [--force-overwrite] 
  [--no-warnings] 
  [--verbose] 
  [--help] 
  (cloneset.(clns|clna)|directory)... result.json[.gz]
```

Calculates 
[CDR3 metrics](./mixcr-postanalysis.md#cdr3-metrics), [Diversity measures](./mixcr-postanalysis.md#diversity-measures) anв [Gene segment usage](./mixcr-postanalysis.md#segment-usage-metrics) for each of the specified samples.


### Command line options

`(cloneset.(clns|clna)|directory)...`
: Paths to input clnx files or to directories with clnx files. Files in directories will not be filtered by extension.

`result.json[.gz]`
: Path where to write postanalysis result.

`--default-downsampling (<type>|none)`
: Default [downsampling](./mixcr-postanalysis.md#downsampling) applied to normalize the clonesets. Possible values: `count-[reads|TAG]-[auto|min|fixed][-<number>]`, `top-[reads|TAG]-[<number>]`, `cumtop-[reads|TAG]-[percent]`, `none`

`--default-weight-function (<read>|<Tag>|none)`
: Default clonotype [weight function](./mixcr-postanalysis.md#weight-functions)

`--only-productive`
: Filter out-of-frame sequences and sequences with stop-codons.

`--drop-outliers`
: Drop samples which are below downsampling value as computed according to specified default downsampling option.

`--chains <chain>[,<chain>...]`
: Limit analysis to specific chains (e.g. TRA or IGH) (fractions will be recalculated). Possible values (multiple values allowed): `TRA`, `TRD`, `TRAD` (for human), `TRG`, `IGH`, `IGK`, `IGL`

`--metadata <path>`
: [Metadata](./mixcr-postanalysis.md#metadata) file in a tab- (`.tsv`) or comma- (`.csv`) separated form. Must contain `sample` column which matches names of input files. Optionally may have `chains` column.

`--group <group>`
: Metadata column used to group samples into [isolation groups](./mixcr-postanalysis.md#isolation-groups); postanalysis will be performed in each of the groups separately. It is possible to specify several isolation groups.

`--tables <path.(tsv|csv)>`
: Results output path. By default, will be `{outputDir}/{outputFileName}.tsv`. For each `chain` and `metric` will be generated file with path `{dir}/{fileName}.{metric}.{chain}.(tsv|csv)`

`--preproc-tables <path.(tsv|csv)>`
: Output path for the [preprocessing summary tables](./mixcr-postanalysis.md#preprocessing-summary-tables) (filtering and downsampling). By default, will be `{outputDir}/{outputFileName}.preproc.tsv`. For each `chain` will be generated file with path `{dir}/{fileName}.{chain}.(tsv|csv)`

`-O  <key=value>`
: Overrides default postanalysis settings

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.


MiXCR allows to override downsampling and filtering parameters for any postanalysis metric using `-Oparameter=value` syntax. Example:

```shell
> mixcr postanalysis individual \
  -OvUsage.weightFunction=read \
  ...
```

The following options may be overridden:

`-O<metric>.downsampling=<downsampling>`

:   override default downsampling

`-O<metric>.dropOutliers=(true|false)`

:   override default setting for dropping outliers

`-O<metric>.weightFunction=<weightFunction>`

:   override default weight function

`-O<metric>.onlyProductive=(true|false)`

:   override default setting for filtering only productive clonotypes

The following `<metric>` values are supported:

- [CDR3 metrics](./mixcr-postanalysis.md#cdr3-metrics): `cdr3metrics.cdr3lenNT`, `cdr3metrics.cdr3lenAA`, `cdr3metrics.ndnLenNT`, `cdr3metrics.addedNNT`, `cdr3metrics.strength`, `cdr3metrics.hydrophobicity`, `cdr3metrics.disorder`, `cdr3metrics.volume`, `cdr3metrics.charge`,
- [Diversity measures](./mixcr-postanalysis.md#diversity-measures): `diversity.observed`, `diversity.shannonWiener`, `diversity.chao1`, `diversity.normalizedShannonWienerIndex`, `diversity.inverseSimpsonIndex`, `diversity.giniIndex`, `diversity.d50`, `diversity.efronThisted`,
- [Segment usage](./mixcr-postanalysis.md#segment-usage-metrics): `vUsage`, `jUsage`, `isotypeUsage`, `vjUsage`

### CDR3 metrics

CDR3 metrics may be separated into two groups. First includes "length" metrics:

`Length of CDR3, aa`
: length of amino acid CDR3 sequence; shorter length may limit CDR3 loop steric flexibility and thereby enhance the specificity of antigen-driven selection ([Sofya A Kasatskaya et al., Elife. 2020](https://pubmed.ncbi.nlm.nih.gov/33289628/)).

`Length of CDR3, nt`
: length of nucleotide CDR3 sequence

`Length of `VJJunction`, nt`
: nucleotide length of N-D-N region

`Added nucleotides`
: number of added `N` nucleotides

The second group includes averaged physicochemical characteristics computed for the five amino acids in the middle of CDR3, to better reflect functional differences in immune repertoires with respect to potential recognition of antigenic epitopes:

`Strength` ( *Value is in range between 1.78 (ex. five Lys) to 5 (ex. five Leu)* )
: Reflects average propensity to form strong interactions, based on Miyazawa-Jernigan potential ([Miyazawa S, Jernigan RL., J Mol Biol. 1996](https://pubmed.ncbi.nlm.nih.gov/8604144/); [Andrej Kosmrlj et al.,Proc Natl Acad Sci U S A. 2008](https://pubmed.ncbi.nlm.nih.gov/18946038/); [Andrej Kosmrlj et al.,Nature. 2010](https://pubmed.ncbi.nlm.nih.gov/20445539/)).  Depends mainly on the prevalence of aromatic (Tyr, Trp, Phe) and hydrophobic (Val, Tyr, Met, Ile, Leu, Trp, Phe) amino acid residues.
Relevant for both for TCR ([Sofya A Kasatskaya et al., Elife. 2020](https://pubmed.ncbi.nlm.nih.gov/33289628/); [Nadezhda N Logunova et al., Proc Natl Acad Sci U S A. 2020](https://pubmed.ncbi.nlm.nih.gov/32482872/)) and BCR/Ig ([Ola Grimsholm et al., Cell Rep. 2020](https://pubmed.ncbi.nlm.nih.gov/32130900/)) repertoires.

`Hydrophobicity` ( *Value is in range between -5,95 (ex. five Arg) to 5 (ex. five Trp)* )
: Reflects hydrophobicity calculated via inverted [Kidera factor 4](https://link.springer.com/article/10.1007/BF01025492). Relevant for both TCR ([Sofya A Kasatskaya et al., Elife. 2020](https://pubmed.ncbi.nlm.nih.gov/33289628/); [Nadezhda N Logunova et al., Proc Natl Acad Sci U S A. 2020](https://pubmed.ncbi.nlm.nih.gov/32482872/)) and BCR/Ig ([Ola Grimsholm et al., Cell Rep. 2020](https://pubmed.ncbi.nlm.nih.gov/32130900/)) repertoires.

    !!! note
        High hydrophobicity and the propensity to form strong interactions are common but not necessarily determinative features of cross-reactive immune receptors ( [Andrej Kosmrlj et al.,Proc Natl Acad Sci U S A. 2008](https://pubmed.ncbi.nlm.nih.gov/18946038/); [Brian D Stadinski et al., Nat Immunol. 2016](https://pubmed.ncbi.nlm.nih.gov/27348411/)). Non-hydrophobic contacts may underpin higher antigen specificity ([Sofya A Kasatskaya et al., Elife. 2020](https://pubmed.ncbi.nlm.nih.gov/33289628/)).

`Volume` ( *Value is in range between 1.47 (ex. five Gly) to 5 (ex. five Trp)* )
: Reflects relative [amino acid volume](http://www.imgt.org/IMGTeducation/Aide-memoire/_UK/aminoacids/IMGTclasses.html). Relevant for both TCR ([Sofya A Kasatskaya et al., Elife. 2020](https://pubmed.ncbi.nlm.nih.gov/33289628/); [Nadezhda N Logunova et al., Proc Natl Acad Sci U S A. 2020](https://pubmed.ncbi.nlm.nih.gov/32482872/)) and BCR/Ig ([Ola Grimsholm et al., Cell Rep. 2020](https://pubmed.ncbi.nlm.nih.gov/32130900/)) repertoires.

`Charge` ( *Value is in range between -5 (ex. five Asp and/or Glu) to 5 (ex. five Arg and/or His and/or Lys)* )
: Reflects relative abundance of positively charged  (Arg, His, Lys), negatively charged (Asp, Glu) and neutral amino acids.

`Disorder`  (*Value is in range between -5 (maximal order) to 5 (maximal disorder)* )
: Reflects relative abundance of structural disorder-promoting, order-promoting and neutral amino acids.

### Diversity measures

Diversity measures reported by MiXCR include:

- Observed diversity — the number of clonotypes ($D$)
- Normalized Shannon-Wiener index — normalized (divided by log of the number of clonotypes) entropy of clonotype frequency distribution:
  $$
  -\frac{1}{\log(D)}\sum f_i \log (f_i)
  $$

- [Shannon-Wiener diversity](http://www.esajournals.org/doi/abs/10.2307/1934352) — the exponent of clonotype frequency distribution entropy:
  $$
  \exp \left(-\sum f_i \log (f_i)\right)
  $$

- Gini index:
  $$
  1 + \sum f_i^2
  $$

- [Inverse Simpson index](http://www.esajournals.org/doi/abs/10.2307/1934352):
  $$
  1 / \sum f_i^2
  $$

- [Chao1 estimate](https://academic.oup.com/jpe/article/5/1/3/1296712) — Chao lower bound diversity estimate

- [Efron-Thisted estimate](http://www.jstor.org/stable/2335721) — lower bound total diversity estimate

- [d50](http://www.google.com/patents/WO2012097374A1?cl=en) — number of clones substituting a half of the sample abundance 

### Segment usage metrics

Variable, Joining segment and Isotype usage vectors, i.e. the frequency of associated reads for each of V/J segments present in sample.

## Overlap postanalysis

```
mixcr postanalysis overlap 
  --default-downsampling (<type>|none) 
  --default-weight-function (<read>|<Tag>|none) 
  [--criteria <s>] 
  [--factor-by <column>[,<column>...]]... 
  [--only-productive] 
  [--drop-outliers] 
  [--chains <chain>[,<chain>...]]... 
  [--metadata <path>] 
  [--group <group>]... 
  [--tables <path.(tsv|csv)>] 
  [--preproc-tables <path.(tsv|csv)>] 
  [-O <key=value>]... 
  [-f] [-nw] [--verbose] [-h] 
  (cloneset.(clns|clna)|directory)... result.json[.gz]
```
Calculates pairwise 
[Distance metrics](./mixcr-postanalysis.md#overlap-metrics).



### Command line options

`(cloneset.(clns|clna)|directory)...`
: Paths to input clnx files or to directories with clnx files. Files in directories will not be filtered by extension.

`result.json[.gz]`
: Path where to write postanalysis result.

`--default-downsampling (<type>|none)`
: Default [downsampling](./mixcr-postanalysis.md#downsampling) applied to normalize the clonesets. Possible values: `count-[reads|TAG]-[auto|min|fixed][-<number>]`, `top-[reads|TAG]-[<number>]`, `cumtop-[reads|TAG]-[percent]`, `none`

`--default-weight-function (<read>|<Tag>|none)`
: Default clonotype [weight function](./mixcr-postanalysis.md#weight-functions)

`--criteria <s>`
: Overlap criteria. Defines the rules to treat clones as equal. It allows to specify gene feature for overlap (nucleotide or amino acid), and optionally use V and J hits. Examples: `CDR3|AA|V|J` (overlap by a.a. CDR3 and V and J), `VDJRegion|AA` (overlap by a.a. `VDJRegion`), `CDR3|NT|V` (overlap by nt CDR3 and V). Default: CDR3|AA|V|J

`--factor-by <meta>[,<meta>...]`
: Pools samples with the same values of specified metadata columns and performs overlap between such pooled samples

`--only-productive`
: Filter out-of-frame sequences and sequences with stop-codons.

`--drop-outliers`
: Drop samples which are below downsampling value as computed according to specified default downsampling option.

`--chains <chain>[,<chain>...]`
: Limit analysis to specific chains (e.g. TRA or IGH) (fractions will be recalculated). Possible values (multiple values allowed): `TRA`, `TRD`, `TRAD` (for human), `TRG`, `IGH`, `IGK`, `IGL`

`--metadata <path>`
: [Metadata](./mixcr-postanalysis.md#metadata) file in a tab- (`.tsv`) or comma- (`.csv`) separated form. Must contain `sample` column which matches names of input files. Optionally may have `chains` column.

`--group <group>`
: Metadata column used to group samples into [isolation groups](./mixcr-postanalysis.md#isolation-groups); postanalysis will be performed in each of the groups separately. It is possible to specify several isolation groups.

`--tables <path.(tsv|csv)>`
: Results output path. By default, will be `{outputDir}/{outputFileName}.tsv`. For each `chain` and `metric` will be generated file with path `{dir}/{fileName}.{metric}.{chain}.(tsv|csv)`

`--preproc-tables <path.(tsv|csv)>`
: Output path for the [preprocessing summary tables](./mixcr-postanalysis.md#preprocessing-summary-tables) (filtering and downsampling). By default, will be `{outputDir}/{outputFileName}.preproc.tsv`. For each `chain` will be generated file with path `{dir}/{fileName}.{chain}.(tsv|csv)`

`-O  <key=value>`
: Overrides default postanalysis settings

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.

MiXCR allows to override downsampling and filtering parameters for any postanalysis metric using `-Oparameter=value` syntax. Example:

```shell
> mixcr postanalysis overlap \
  -OvUsage.weightFunction=read \
  ...
```

The following options may be overridden:

`-O<metric>.downsampling=<downsampling>`

:   override default downsampling

`-O<metric>.dropOutliers=(true|false)`

:   override default setting for dropping outliers

`-O<metric>.weightFunction=<weightFunction>`

:   override default weight function

`-O<metric>.onlyProductive=(true|false)`

:   override default setting for filtering only productive clonotypes

The following `<metric>` values are supported : `sharedClonotypes`, `f1Index`, `f2Index`, `jaccardIndex`, `pearson`, `pearsonAll`.

### Pairwise distance metrics

Repertoire similarity measures include:

- Shared clonotypes — number of shared clonotypes

- Relative diversity — overlap diversity, computed with the following normalization:
  $$
  D_{ij} = \frac{d_{ij}}{d_{i}d_{j}}
  $$
  where $d_{ij}$ is the number of clonotypes present in both samples and $d_{i}$ is the diversity of sample $i$. See [this paper](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3872297/) for the rationale behind normalization.

- Pearson — Pearson's correlation of clonotype frequencies, restricted only to the overlapping clonotypes:
  $$
  R_{ij} = \frac{\sum^N_{k=1} \left(\phi_{ik} - \bar{\phi_{i}} \right) \left(\phi_{jk} - \bar{\phi_{j}} \right)}{\sqrt{\sum^N_{k=1} \left(\phi_{ik} - \bar{\phi_{i}} \right)^2 \sum^N_{k=1}  \left(\phi_{jk} - \bar{\phi_{j}} \right)^2}}
  $$
  where $k=1 \to N$ are the indices of overlapping clonotypes, $\phi_{ik}$ is the frequency of clonotype $k$ in sample $i$ and $\bar{\phi_{i}}$ is the average frequency of overlapping clonotypes in sample $i$.

- Pearson (all) — Pearson's correlation of clonotype frequencies, restricted only to the overlapping clonotypes

- F1 index — geometric mean of relative overlap frequencies:
  $$
  F_{ij} = \sqrt{f_{ij}f_{ji}}
  $$
  where $f_{ij}=\sum^N_{k=1}\phi_{ik}$ is the total frequency of clonotypes that overlap between samples $i$ and $j$ in sample $i$.

- F2 index — clonotype-wise sum of geometric mean frequencies:
  $$
  F2_{ij} = \sum^N_{k=1}\sqrt{\phi_{ik}\phi_{jk}}
  $$
  Note that this measure performs similar to $F$ and provides slightly more robust results in case cross-sample contamination is present.

- [Jaccard index](http://en.wikipedia.org/wiki/Jaccard_index).

[//]: # (- [Jensen-Shannon divergence]&#40;https://www.cise.ufl.edu/~anand/sp06/jensen-shannon.pdf&#41; between Variable segment usage profiles)

[//]: # ()
[//]: # (- `Morisita-Horm index <http://en.wikipedia.org/wiki/Morisita's_overlap_index>`__.)



### Preprocessing summary tables

MiXCR provides detailed reports on preprocessing steps (filtering clonotypes and downsampling) applied for each of the computed postanalysis metrics. The typical report table looks like:

| characteristic | sample            | preprocessor                                                                            | nElementsBefore | sumWeightBefore | nElementsAfter | sumWeightAfter | preprocessor#1        | nElementsBefore#1 | sumWeightBefore#1 | nElementsAfter#1 | sumWeightAfter#1 | preprocessor#2                    | nElementsBefore#2 | sumWeightBefore#2 | nElementsAfter#2 | sumWeightAfter#2 | preprocessor#3              | nElementsBefore#3 | sumWeightBefore#3 | nElementsAfter#3 | sumWeightAfter#3 | 
|----------------|-------------------|-----------------------------------------------------------------------------------------|-----------------|-----------------|----------------|----------------|-----------------------|-------------------|-------------------|------------------|------------------|-----------------------------------|-------------------|-------------------|------------------|------------------|-----------------------------|-------------------|-------------------|------------------|------------------|
| VSegmentUsage  | P21-M1-PD1.clns   | Filter TRA,TRD chains & Filter stops in CDR3, OOF in CDR3 & Downsample by umi automatic | 309             | 2141.0          | 110            | 796.0          | Filter TRA,TRD chains | 309               | 2141.0            | 162              | 1186.0           | Filter stops in CDR3, OOF in CDR3 | 162               | 1186.0            | 139              | 1143.0           | Downsample by umi automatic | 139               | 1143.0            | 110              | 796.0            |  
| Added N, nt    | P14-T0-TIGIT.clns | Filter TRA,TRD chains & Filter stops in CDR3, OOF in CDR3 & Downsample by umi automatic | 863             | 8478.0          | 189            | 796.0          | Filter TRA,TRD chains | 863               | 8478.0            | 412              | 3688.0           | Filter stops in CDR3, OOF in CDR3 | 412               | 3688.0            | 311              | 3071.0           | Downsample by umi automatic | 311               | 3071.0            | 189              | 796.0            | 
| ...            | ...               | ...                                                                                     | ...             | ...             | ...            | ...            | ...                   | ...               | ...               | ...              | ...              | ...                               | ...               | ...               | ...              | ...              | ...                         | ...               | ...               | ...              | ...              | 

The meaning of the columns is the following:

`characteristic`

:   name for a group of metrics for which the same downsampling was applied

`preprocessor`

:   the name of the _overall_ preprocessing chain applied to the dataset

`nElementsBefore`

:   number of clonotypes before any preprocessing applied (that is in the initial dataset)

`sumWeightBefore`

:   total [weight](./mixcr-postanalysis.md#downsampling) of all clonotypes before any preprocessing applied

`nElementsAfter`

:   number of clonotypes in the dataset after all preprocessing applied

`sumWeightBefore`

:   total weight of all clonotypes after all preprocessing applied.

`preprocessor#i` and following columns

:   report columns for i-th step in the preprocessing chain
