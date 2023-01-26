# First run

The easiest way to run even a sophisticated upstream analysis pipeline is by a single MiXCR [`analyze`](../reference/mixcr-analyze.md) command:
```shell
mixcr analyze \
      takara-human-bcr-full-length \
      sample_R1_L{{n}}.fastq.gz \
      sample_R2_L{{n}}.fastq.gz \
      result
```
This example runs an optimized analysis pipeline for the full-length human BCR molecular-barcoded data, obtained with SMART-Seq Human BCR kit. Option `takara-human-bcr-full-length` corresponds to MiXCR [preset](../reference/overview-presets.md) for this particular wet lab protocol and `{{n}}` syntax is used to concatenate samples across multiple lanes. 

MiXCR provides a [comprehensive list](../reference/overview-built-in-presets.md) of available presets for plenty of protocols, data types and commercially available kits. One can find optimized analysis workflows for the following suppliers:

| Supplier                                                                   | Species                         | Data types |
|----------------------------------------------------------------------------|---------------------------------|--|
| [MiLaboratories](../reference/overview-built-in-presets.md#milaboratories) | _Homo Sapience_, _Mus Musculus_, _Monkey_ | amplicon BCR, TCR |
| [Takara Bio](../reference/overview-built-in-presets.md#takara-bio) | _Homo Sapience_, _Mus Musculus_ | amplicon BCR, TCR |
| [10x Genomics](../reference/overview-built-in-presets.md#10xgenomics) | _any_ | single-cell VDJ, 5' GEX |
| [Illumina](../reference/overview-built-in-presets.md#illumina) | _Homo Sapience_ | amplicon TCR |
| [Qiagen](../reference/overview-built-in-presets.md#qiagen) | _Homo Sapience_, _Mus Musculus_ | amplicon TCR |
| [iRepertoire](../reference/overview-built-in-presets.md#irepertoire) | _Homo Sapience_, _Mus Musculus_ | amplicon BCR, TCR |
| [Thermo Fisher](../reference/overview-built-in-presets.md#thermo-fisher) | _Homo Sapience_ | amplicon BCR, TCR |
| [AbHelix](../reference/overview-built-in-presets.md#abhelix) | _Homo Sapience_ | amplicon TCR, BCR |
| [BD](../reference/overview-built-in-presets.md#bd-rhapsody) | _Homo Sapience_, _Mus Musculus_ | single-cell VDJ |
| [Oxford Nanopore](../reference/overview-built-in-presets.md#oxford-nanopore-technologies) | _any_ | long-read VDJ |
| [ParseBio](../reference/overview-built-in-presets.md#parse-biosciences) | _any_ | single-cell 3' GEX |
| [NEB](../reference/overview-built-in-presets.md#new-england-biolabs) | _Homo Sapience_, _Mus Musculus_ | amplicon TCR, BCR |


Also, there are dedicated presets for generic data types and open-source protocols, including:

 - [Non-targeted RNA-Seq (or shotgun DNA) data](../reference/overview-built-in-presets.md#rna-seq-data)
 - [Generic amplicon libraries (no UMIs)](../reference/overview-built-in-presets.md#generic-data)
 - [Generic amplicon libraries (with UMIs)](../reference/overview-built-in-presets.md#generic-data)
 - [Biomed2](../reference/overview-built-in-presets.md#biomed2)

The further details can be found in the following materials:

 - [Overview of MiXCR features and analysis pipelines](../reference/overview-analysis-overview.md)
 - [Full list of available presets](../reference/overview-built-in-presets.md)
 - [Tutorial guides for special analysis cases](../guides/generic-umi-tcr.md)


