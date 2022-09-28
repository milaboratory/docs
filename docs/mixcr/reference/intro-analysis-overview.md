# Analysis overview

MiXCR analysis in a typical study consists of two parts:

- upstream analysis of raw sequencing data;
- downstream analysis of repertoire tables.

The exact steps and parameters of the analysis workflow are largely dependent on the data type and wet lab library preparation protocol used. In addition, downstream analysis steps may vary depending on the objectives of the particular study and available metadata.

To systematize the approach of running workflows for a wide diversity of protocols and study designs, MiXCR provides a powerful concept of [presets](intro-presets.md) which allows to execute specifically optimized pre-configured analysis pipelines for a variety of widely adopted data types and library preparation protocols. The whole pipeline can be run using a convenient one-line [`analyze`](mixcr-analyze.md) command or in a step by step mode for better hardware utilization.

Below we give a high-level overview of MiXCR actions which consitute most of the data analysis pipelines.

## Upstream analysis steps

Upstream analysis basically includes alignment of raw sequencing data against reference V-, D-, J- and C- gene segment database and assembling of clonotypes based on different criteria. There are plenty of peculiarities caused by different data types and library preparation protocols. Below is the list of key upstream analysis steps.

**1. Alignment:** [`align`](mixcr-align.md)
: The initial step of the analysis is alignment of raw sequencing data against reference V-, D-, J- and C- gene segment database.
    
    ![](./pics/align.svg)
    
    MiXCR implements a family of highly efficient alignment algorithms, which may be tuned depending on the particular library architecture. At a top level it uses fast [k-mer seed-and-vote approach](http://nar.oxfordjournals.org/content/41/10/e108) and implements two aligners: the first one with [linear scoring](mixcr-align.md#parameters-for-kaligner) is better designed for T-cells and the second one with [affine scoring](mixcr-align.md#parameters-for-kaligner2) better supports long indels which are more typical for B-cells. In the depths it switches to different variations of more expensive classical [Needleman–Wunsch](https://en.wikipedia.org/wiki/Needleman–Wunsch_algorithm) and [Smith–Waterman](https://en.wikipedia.org/wiki/Smith–Waterman_algorithm) algoritms to find optimal alignments. It may use either [global, local or glocal](https://en.wikipedia.org/wiki/Sequence_alignment#Global_and_local_alignments) alignments at 5'- and 3'- ends of raw reads depending on the presense of absence of primers and adapters. 
     
    In case of paired-end data, MiXCR [merges](mixcr-align.md#merging-algorithm-parameters) overlapping mate pairs using either subsequence match (if overlap is long enough) or alignment aided overlap. In the latter case it is able to overlap mate pairs even if there is only a single overlapping nucleotide. Optionally, MiXCR can trimm low quality nucleotides at read edges.  
    
    Also at the alignment step MiXCR performs barcodes sequences extraction for barcoded data. There is a powerfull [regex-like](ref-tag-pattern.md) pattern-matching language allowing to use almost arbitrary barcode design.  
    
    The built-in reference [gene library](http://github.com/repseqio/library) of V-, D-, J- and C- segments is thoroughly compiled for every available species using the data specifically obtained from multiple dedicated sequencing runs as well as from hundreds of other experiments. At the same time MiXCR supports using of [external libraries](../guides/external-libraries.md) or even to assemble a [custom library](../guides/create-custom-library.md) from scratch.     

**2. Barcode correction:** [`correctAndRefineTags`](mixcr-correctAndSortTags.md)
: For barcoded data, corrects errors _inside_ barcode sequences and filters out spurious barcodes.
    
    ![](pics/correctAndSortTags.svg)
    
    There are multiple sources of erroneous and spurious barcodes and this step is crucial to eliminate artificial diversity caused by them.
    
    Errors inside barcode sequences are generated either during PCR or sequencig steps. MiXCR correction algorithm uses prefix trees and different clustering strategies to identify and correct those errors _inside_ barcode sequences.
    
    Spurious barcodes arise from multiple sources. For UMIs this is oftenly a recombination and formation of chimeric molecules. For many of droplet-based single cell technologies, spruious barcodes come from exploded cells and/or empty droplets. MiXCR has a powerful and highly tunebale filtering strategies able to identify and filter out clusters of such spurious barcodes. Importantly, fraction of spurious barcodes in some protocols may be as high as 90% which makes this filtering extremely important.


**3. Partial assembly:** [`assemblePartial`](mixcr-assemblePartial.md)
: For fragmented or shotgun data, rescues alignments that partially cover CDR3 region.
    
    ![](pics/assemblePartial.svg)
    
    Typically this step is applied for non-targeted RNA-Seq data or in case of a fragmented data when target molecule is randomly shredded (e.g. 10x chemistry). In such cases there may be a fraction of alignmets that do not cover whole CDR3 region. MiXCR implements a [powerful algorithm](https://www.nature.com/articles/nbt.3979) to identify groups of such alignments coming from the same molecule and merge them in order to reconstruct CDR3 region and prevent this information from losing. The algorithm applies multiple criteria to identify such groups and utilizes barcodes if they are present in the data.
     
    This procedure is [throughly optimized](https://www.nature.com/articles/nbt.3979) both on thouthands of real RNA-Seq datasets as well on a simulated data using various multiobjective optimization strategies, as result showing highest possible recall rate keeping at the same time zero rate of false-positives.     



**4. CDR3 extension:** [`extend`](mixcr-extend.md)
: When asdasd dsf

    ![](pics/extend.svg)

**5. Clonotype assembly:** [`assemble`](mixcr-assemble.md)
: AS

    ![](pics/assemble.svg)

**6. Contig assembly:** [`assembleContigs`](mixcr-assembleContigs.md)
: AS

    ![](pics/assembleContigs.svg)

**7. Export:** [`export`](mixcr-export.md)
: AS

