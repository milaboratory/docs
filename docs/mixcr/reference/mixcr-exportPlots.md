# `mixcr exportPlots`

A set of routines for graphical export of [postanalysis](./mixcr-postanalysis.md) results. MiXCR supports graphical export in PDF, SVG, EPS, PNG and JPEG formats.

## Diversity and CDR3 metrics

```
mixcr exportPlots (diversity|cdr3metrics) 
    [--chains <chain>]... 
    [--width <n>] 
    [--height <n>] 
    [--filter <meta(|>|>=|=|<=|<)value>[,<meta(|>|>=|=|<=|<)value>...]]... 
    [--metadata <path>] 
    [--plot-type <plotType>] 
    [--primary-group <meta>] 
    [--primary-group-values <value>[,<value>...]]... 
    [--secondary-group <meta>] 
    [--secondary-group-values <value>[,<value>...]]... 
    [--facet-by <meta>] 
    [--hide-overall-p-value] 
    [--pairwise-comparisons] 
    [--ref-group <refGroup>] 
    [--hide-non-significant] 
    [--paired] 
    [--method <method>] 
    [--method-multiple-groups <method>] 
    [--p-adjust-method <method>] 
    [--show-significance] 
    [--metric <metric>[,<metric>...]]... 
    [--no-warnings] 
    [--verbose] 
    [--help]
    pa.json[.gz] output.(pdf|eps|png|jpeg)
```
Exports [diversity](./mixcr-postanalysis.md#diversity-measures) or [CDR3 metrics](./mixcr-postanalysis.md#cdr3-metrics) visualization plots from the [individual](./mixcr-postanalysis.md#individual-postanalysis) postanalysis results. When exporting in PDF format the resulting file will contain multiple pages: one page per metric. For exaporint in other formats one need to specify `--metrics <metric>` option to export one particular metric.

Basic command line options are:

`pa.json[.gz]`
: Input file with postanalysis results.

`output.(pdf|eps|png|jpeg)`
: Output PDF/EPS/PNG/JPEG file name.

`--chains <chain>`
: Export only for specified immunological chains.

`--width <n>`
: Plot width.

`--height <n>`
: Plot height.

`--filter <filter>[,<filter>...]`
: Filter samples to put on a plot by their metadata values. Filter allows equality (`species=cat`) or arithmetic comparison (`age>=10`) etc.

`--metadata <path>`
: [Metadata](./mixcr-postanalysis.md#metadata) file in a tab- (`.tsv`) or comma- (`.csv`) separated form. Must contain `sample` column which matches names of input files.

`--plot-type <plotType>`
: Plot type. Possible values: `boxplot`, `boxplot-bindot`, `boxplot-jitter`, `violin`, `violin-bindot`, `barplot`, `barplot-stacked`, `lineplot`, `lineplot-jitter`, `lineplot-bindot`, `scatter`

`-p, --primary-group <meta>`
: Specify metadata column used to group datasets.

`-pv, --primary-group-values <value>[,<value>...]`
: List of comma separated primary group values.

`-s, --secondary-group <meta>`
: Secondary group.

`-sv, --secondary-group-values <value>[,<value>...]`
: List of comma separated secondary group values.

`--facet-by <meta>`
: Facet by.

`--metric <metric>[,<metric>...]`
: Output only specified list of metrics:

    - for [`cdr3metrics`](./mixcr-postanalysis.md#cdr3-metrics) possible values are: `cdr3lenAA`, `cdr3lenNT`, `ndnLenNT`, `addedNNT`, `strength`, `hydrophobicity`, `surface`, `volume`, `charge`
    
    - for [`diversity`](./mixcr-postanalysis.md#diversity-measures) possible values are: `observed`, `shannonWiener`, `chao1`, `normalizedShannonWienerIndex`, `inverseSimpsonIndex`, `giniIndex`, `d50`, `efronThisted`


`--hide-overall-p-value`
: Hide overall p-value.

`--pairwise-comparisons`
: Show pairwise p-value comparisons.

`--ref-group <refGroup>`
: Reference group for compare means statistics. Can be 'all' or some specific value.

`--hide-non-significant`
: Hide non-significant observations.

`--paired`
: Do paired analysis

`--method <method>`
: Statistical test method. Available methods: [`Wilcoxon`](https://en.wikipedia.org/wiki/Mann–Whitney_U_test) (default), [`ANOVA`](https://en.wikipedia.org/wiki/Analysis_of_variance), [`TTest`](https://en.wikipedia.org/wiki/Student%27s_t-test), [`KruskalWallis`](https://en.wikipedia.org/wiki/Kruskal–Wallis_one-way_analysis_of_variance), [`KolmogorovSmirnov`](https://en.wikipedia.org/wiki/Kolmogorov–Smirnov_test)

`--method-multiple-groups <method>`
: Test method for multiple groups comparison. Available methods: [`KruskalWallis`](https://en.wikipedia.org/wiki/Kruskal–Wallis_one-way_analysis_of_variance) (default), [`Wilcoxon`](https://en.wikipedia.org/wiki/Mann–Whitney_U_test), [`ANOVA`](https://en.wikipedia.org/wiki/Analysis_of_variance), [`TTest`](https://en.wikipedia.org/wiki/Student%27s_t-test), [`KolmogorovSmirnov`](https://en.wikipedia.org/wiki/Kolmogorov–Smirnov_test)

`--p-adjust-method <method>`
: Method used to adjust p-values. Available methods: Available methods: [`Holm`](https://www.jstor.org/stable/4615733) (default), [`BenjaminiHochberg`](https://www.jstor.org/stable/2346101), [`BenjaminiYekutieli`](https://www.jstor.org/stable/2674075), [`Bonferroni`](https://en.wikipedia.org/wiki/Holm%E2%80%93Bonferroni_method), [`Hochberg`](https://www.jstor.org/stable/2336325), [`Hommel`](https://www.jstor.org/stable/2336190), `none`

`--show-significance`
: Show significance levels instead of p-values ( `ns` for p-value >= 0.05, `***` for p-value < 0.0001,  `**` for p-value < 0.001, `*` in other case).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

### Examples

Use primary grouping and facets: 

```shell
> mixcr exportPlots diversity -f \
    --plot-type lineplot-bindot \
    --primary-group Time \
    --primary-group-values T0,M1,M2 \
    --facet-by Marker \
    pa/i.json.gz \
    plots/diversity_facets.pdf
```
<figure markdown>
![export-plots-primary-facets.TRAD.svg](pics/export-plots-primary-facets.TRAD.svg)
</figure>


Use secondary grouping:

```shell
> mixcr exportPlots diversity -f \
    --primary-group Marker \
    --secondary-group Time \
    --secondary-group-values T0,M1,M2 \
    pa/i.json.gz \
    plots/pdf
```
<figure markdown>
![export-plots-secondary.TRAD.svg](pics/export-plots-secondary.TRAD.svg)
</figure>

[TODO more examples]


## Gene segment usage

```
mixcr exportPlots (vUsage|jUsage|isotypeUsage|vjUsage) [-f]
    [--chains <chains>]...
    [--metadata <metadata>]
    [--filter <filterByMetadata>]...
    [--color-key <colorKey>]...
    [--no-genes-dendro]
    [--no-samples-dendro]
    [--palette <palette>]
    [--h-labels-size <hLabelsSize>]
    [--v-labels-size <vLabelsSize>]
    [--width <width>]
    [--height <height>]
    individual.pa.json.gz
    plot.(pdf|svg|eps|png|jpg)
```
Exports [gene segment usage](./mixcr-postanalysis.md#segment-usage-metrics) heatmap plots from the [individual](./mixcr-postanalysis.md#individual-postanalysis) postanalysis results.

`--chains <chains>`

:   export only for specified immunological chains

`--metadata <file>`

:   supply additional [metadata](./mixcr-postanalysis.md#metadata) `.tsv` or `.csv` table

`--filter <meta(|>|>=|=|<=|<)value>...`

:   filter samples to put on a plot by their metadata values. Filter allows equality (`species=cat`) or arithmetic comparison (`age>=10`) etc.

`--color-key <meta>`

:   add color key layer to the heatmap

`--no-genes-dendro`

:   do not plot genes dendrogram

`--no-samples-dendro`

:   do not plot samples dendrogram

`palette <palette>`

:   specify color palette to be used: `density` (default), `diverging`, `viridis2magma`, `lime2rose`, `blue2red`, `teal2red`, `softSpectral`, `sequential`, `viridis`, `magma`, `sunset`, `rainbow`, `salinity` 

`--h-labels-size`

:   size of horizontal labels in tile units

`--v-labels-size`

:   size of vertical labels in tile units

`--width <width>`

:   width of a plot

`--height <height>`

:   height of a plot

### Examples

Export Variable gene segment usage plot and add color key:
```shell
mixcr exportPlots vUsage -f \
    --color-key Patient \
    pa/i.json.gz \
    plots/vUsage.svg
```
<figure markdown>
![vUsage.TRAD.svg](pics/export-plots-vUsage.TRAD.svg)
</figure>

Export Joining gene segment usage plot and specify another palette:
```shell
mixcr exportPlots jUsage -f \
    --palette magma \
    --color-key Marker \
    pa/i.json.gz \
    plots/jUsage.svg
```
<figure markdown>
![vUsage.TRB.svg](pics/export-plots-jUsage.TRB.svg)
</figure>

## Overlap
```
mixcr exportPlots overlap [-f]
    [--chains <chains>]...
    [--metadata <metadata>]
    [--filter <filterByMetadata>]...
    [--color-key <colorKey>]...
    [--no-dendro]
    [--fill-diagonal]
    [--palette <palette>]
    [--h-labels-size <hLabelsSize>]
    [--v-labels-size <vLabelsSize>]
    [--width <width>]
    [--height <height>]
    individual.pa.json.gz
    plot.(pdf|svg|eps|png|jpg)
```
Exports [pairwise distance metrics](./mixcr-postanalysis.md#segment-usage-metrics) heatmap plots from the [overlap](./mixcr-postanalysis.md#overlap-postanalysis) postanalysis results.

`--chains <chains>`

:   export only for specified immunological chains

`--metadata <file>`

:   supply additional [metadata](./mixcr-postanalysis.md#metadata) `.tsv` or `.csv` table

`--filter <meta(|>|>=|=|<=|<)value>...`

:   filter samples to put on a plot by their metadata values. Filter allows equality (`species=cat`) or arithmetic comparison (`age>=10`) etc.

`--color-key <meta>`

:   add color key layer to the heatmap. One may write `--color-key x_meta` to draw color key horizontally (default) or `--color-key y_meta` to draw vertically.

`--metric <metric>`
: The following <metric> values are supported : sharedClonotypes, f1Index, f2Index, jaccardIndex, pearson, pearsonAll

`--no-dendro`

:   do not plot dendrogram

`--fill-diagonal`

:   fill diagonal values

`palette <palette>`

:   specify color palette to be used: `density` (default), `diverging`, `viridis2magma`, `lime2rose`, `blue2red`, `teal2red`, `softSpectral`, `sequential`, `viridis`, `magma`, `sunset`, `rainbow`, `salinity`

`--h-labels-size`

:   size of horizontal labels in tile units

`--v-labels-size`

:   size of vertical labels in tile units

`--width <width>`

:   width of a plot

`--height <height>`

:   height of a plot

### Examples

Export overlap with color key:

```
> mixcr exportPlots overlap \
    --metric pearsonAll \
    --color-key Patient \
    pa/o.json.gz \
    plots/overlap.pdf
```
<figure markdown>
![overlap](pics/export-plots-overlap.TRAD.svg)
</figure>

## SHM trees
```
mixcr exportPlots shmTrees [-f] 
    [--alignment-no-fill] 
    [-nw] 
    [--verbose] 
    [--alignment-aa <alignmentGeneFeatureAa>] 
    [--alignment-nt <alignmentGeneFeatureNt>] 
    [--filter-aa-pattern <patternSeqAa>] 
    [--filter-in-feature <patternInFeature>] 
    [--filter-min-height <minHeight>] 
    [--filter-min-nodes <minNodes>] 
    [--filter-nt-pattern <patternSeqNt>] 
    [--limit <limit>] 
    [--line-color <lineColor>] 
    [-m <metadata>] 
    [--node-color <nodeColor>] 
    [--node-label <nodeLabel>]
    [--node-size <nodeSize>] 
    [--pattern-max-errors <patternMaxErrors>] 
    [--ids <treeIds>[,<treeIds>...]]... 
    trees.shmt 
    plots.pdf
```
Visualize SHM tree and save in PDF format

`trees.shmt`
: Input file produced by findShmTrees.

`plots.pdf`
: Output file with plots

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-m, --metadata <metadata>`
: Path to metadata file

`--filter-min-nodes <minNodes>`
: Minimal number of nodes in tree

`--filter-min-height <minHeight>`
: Minimal height of the tree

`--ids <treeIds>[,<treeIds>...]`
: Filter specific trees by id

`--filter-aa-pattern <patternSeqAa>`
: Filter specific trees by aa pattern

`--filter-nt-pattern <patternSeqNt>`
: Filter specific trees by nt pattern

`--filter-in-feature <patternInFeature>`
: Match pattern inside specified gene feature

`--pattern-max-errors <patternMaxErrors>`
: Max allowed subs & indels

`--limit <limit>`
: Take first N trees (for debug purposes)

`--node-color <nodeColor>`
: Color nodes with given metadata column

`--line-color <lineColor>`
: Color lines with given metadata column

`--node-size <nodeSize>`
: Size nodes with given metadata column. Predefined columns: "Abundance".

`--node-label <nodeLabel>`
: Label nodes with given metadata column. Predefined columns: "Isotype"

`--alignment-nt <alignmentGeneFeatureNt>`
: Show tree nucleotide alignments using specified gene feature

`--alignment-aa <alignmentGeneFeatureAa>`
: Show tree amino acid alignments using specified gene feature

`--alignment-no-fill`
: Do not highlight alignments with color
