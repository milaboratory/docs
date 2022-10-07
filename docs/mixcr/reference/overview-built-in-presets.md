# Built-in presets

MiXCR provides a comprehensive list of built-in presets for many of available commercial kits, data types and library preparation protocols.

## Protocols

## Kits

### [MiLaboratories Human TCR RNA Multiplex kit](https://milaboratories.com/human-tcr-rna-multiplex-kit)
![](pics/badge-farac.svg)

Preset name: **`milab-tcr-rna-multiplex`**

This kit allows to obtain human TCR alpha and beta repertoires for different types of available RNA material, with high sensitivity and UMI-based accuracy.

![](../guides/milaboratories-human-tcr-rna-multi/MiLabMultiTCR.svg)

There are no required mixins. Example command:

```shell
mixcr analyze milab-tcr-rna-multiplex \
      sample_R1.fastq.gz \
      sample_R2.fastq.gz \
      sample_result
```

See [this tutorial](../guides/milaboratories-human-tcr-rna-multi.md) for the under-the-hood details.



### [10x Genomics single cell VDJ](https://milaboratories.com/human-tcr-rna-multiplex-kit)
![](pics/badge-faraaagc.svg)

Preset names:

- **`10x-vdj-tcr`** for human or mouse TCR profiling 
- **`10x-vdj-bcr`** for human or mouse BCR profiling

This kit allows to obtain TCR alpha and beta repertoires for different types of available RNA material, with high sensitivity and UMI-based accuracy.

![](../guides/rnaseq/figs/library-structure.svg)

There only required mixin is `species`. Example command:

```shell
mixcr analyze 10x-vdj-bcr \
     +species hsa \
      sample_R1.fastq.gz \
      sample_R2.fastq.gz \
      sample_result
```

See [this tutorial](../guides/milaboratories-human-tcr-rna-multi.md) for the under-the-hood details.
