# Analysis overview

MiXCR analysis in a typical study consists of two parts:

- upstream analysis of raw sequencing data;
- downstream analysis of repertoire tables.

The exact steps and parameters of the analysis workflow are largely dependent on the data type and wet lab library preparation protocol used. In addition, downstream analysis steps may vary depending on the objectives of the particular study and available metadata.

To systematize the approach of running workflows for a wide diversity of protocols and study designs, MiXCR provides a powerful concept of [presets](intro-presets.md) which allows to execute specifically optimized pre-configured analysis pipelines for a variety of widely adopted data types and library preparation protocols. And this can be run using a one-line  [`analyze`](mixcr-analyze.md) command or in a step by step mode for better hardware utilization.

Below we give a high-level overview of MiXCR actions which make up different types of analysis pipelines.

## Upstream analysis steps

Upstream analysis basically includes alignment of raw sequencing data against reference V-, D-, J- and C- gene segment database and assembling of clonotypes based on different criteria. There are plenty of peculiarities caused by different data types and library preparation protocols. Below is the list of key upstream analysis steps.

**1. Alignment:** [`align`](mixcr-align.md)
: The initial step of the analysis is alignment of raw sequencing data against reference V-, D-, J- and C- gene segment database.
    
    ![](./pics/align.svg)
    
    MiXCR implements a family of highly efficient alignment algorithms, which may be tuned depending on the particular library type. At a top level it uses fast [k-mer seed-and-vote approach](http://nar.oxfordjournals.org/content/41/10/e108) and switches to different variations of classical [Needleman–Wunsch](https://en.wikipedia.org/wiki/Needleman–Wunsch_algorithm) and [Smith–Waterman](https://en.wikipedia.org/wiki/Smith–Waterman_algorithm) algoritms to find optimal alignments. It may use either [global, local or glocal](https://en.wikipedia.org/wiki/Sequence_alignment#Global_and_local_alignments) alignments at 5'- and 3'- ends of raw reads depending on the presense of absence of primers and adapters. 
     
    Tag pattern
    
    By default it uses its own accurate reference library database with different species available. It also allows to use external libraries such  

**2. Barcode correction:** [`correctAndRefineTags`](mixcr-correctAndSortTags.md)
: When asdasd dsf 
    
    ![](pics/correctAndSortTags.svg)

**3. Partial assembly:** [`assemblePartial`](mixcr-assemblePartial.md)
: When asdasd dsf
    
    ![](pics/assemblePartial.svg)


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

