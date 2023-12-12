# Presets

To run a qualified upstream analysis one need to understand the wet lab protocol used and the architecture of the cDNA/DNA libraries. The list of steps in the analysis pipeline may also differ depending on the data type. MiXCR is like a "swiss knife" that provides full flexibility to optimize a workflow for every particular type of data and achieve the highest possible analysis performance. MiXCR _presets_ is a convenient and intuitive interface allowing users to run complicated pipelines easily.


A _preset_ is a list of pre-configured MiXCR steps needed to run an analysis for a particular data type, bundled under a certain name and defined in a YAML format. Preset determines the list of MiXCR analysis steps, their parameter values and additional required parameters needed to be specified by the user. There is a [comprehensive list](overview-built-in-presets.md) of built-in presets for many of commercialy available kits, known library preparation protocols and sequencing data types.

Presets can be used with [`mixcr analyze`](mixcr-analyze.md) command. For example, to run the analysis of 10x Genomics single cell human VDJ data for B-cells we can use `10x-vdj-bcr` preset:
```shell
mixcr analyze 10x-vdj-bcr \
    --species hsa \
      sample1_R1.fastq.gz \
      sample1_R2.fastq.gz \
      sample1_result 
```
The only required option we had to specify here is species. Under the hood MiXCR will run pre-configured steps for this 10x preset, including [alignment](mixcr-align.md), [barcode correction](mixcr-refineTagsAndSort.md), [partial assembly](mixcr-assemblePartial.md), [clonotype assembly](mixcr-assemble.md), [full-length contig assembly](mixcr-assembleContigs.md) and [export](mixcr-export.md).

For every step, a preset [contains](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/presets/protocols/10x.yaml) many pre-configured parameters optimized specifically for this protocol e.g. the type of alignment algorithms, scoring matrices and other aligner parameters, barcode filters, different threshold values, etc.  

The same pipeline can be also executed step by step. In this case the preset must be specified for the first step only (`mixcr align`) and it will be automatically used by all subsequent steps :
```shell
mixcr align \
    --preset 10x-vdj-bcr \
    --species hsa \
      sample1_R1.fastq.gz \
      sample1_R2.fastq.gz \
      sample1_result.vdjca 
      
mixcr refineTagsAndSort \
      sample1_result.vdjca \
      sample1_result.refined.vdjca 

mixcr assemblePartial \
      sample1_result.refined.vdjca \
      sample1_result.par.vdjca
      
mixcr assemble \
      sample1_result.par.vdjca \
      sample1_result.clna
      
mixcr assembleContigs \
      sample1_result.clna \
      sample1_result.clns 
      
mixcr exportClones \
      sample1_result.clns \
      sample1_result.tsv 
```

If there is no built-in preset for some specific protocol, one can use one of the universal presets and additionally configure them using mixins.  

## Mix-in options

While preset already determines the whole analysis pipeline, one can add additional configs using _mix-in_ options. Such options "mix in" additional configs or modifies the pre-configured ones for a given preset. There is a [list](overview-mixins-list.md) of built-in mixins allowing to conveniently adjust any pipeline for certain needs.

Some presets have required mixins (_flags_) to be specified by the user (like species in the above case). For example, let's consider a universal preset `tcr-amplicon`, used for analysis of generic TCR amplicon library. It requires to specify species, type of starting material (DNA or RNA), 3'- and 5'- library structure (primers/adapters on V, J or C genes):
```shell
mixcr analyze generic-amplicon \
    --species hsa \
    --rna \
    --floating-left-alignment-boundary \
    --floating-right-alignment-boundary C \
      sample_R1.fastq.gz \
      sample_R2.fastq.gz \
      sample_result
```
Here the following mixins are used:

`--species hsa`
: mixin to set species

`--rna`
: starting material mixin which sets [gene feature to align](mixcr-align.md#gene-features-to-align) for V and C genes: `rna` corresponds to  `VTranscriptWithout5UTRWithP` on V and `CExon1` on C and `dna` to `VGeneWithP` on V and `CRegion` on C; see [this ref](ref-gene-features.md) for details;
 
`--floating-left-alignment-boundary`
: 5'-end alignment type mixin: here semi-local alignment should be used because of the presence of V-gene primers;
 
`--floating-right-alignment-boundary C`
: 3'-end alignment type mixin: here semi-local alignment should be used at the 3'-end of C-gene, since C-gene primers are used, while for J-gene the global alignment will be used.

For the following reading see [list of available mixins](overview-mixins-list.md).
