---
toc_depth: 3
---

# Built-in presets

MiXCR provides a comprehensive list of built-in presets for many of available commercial kits, data types and library preparation protocols.

Preset can be used to run the whole upstream analysis pipeline with [`analyze`](mixcr-analyze.md) command. For example:
```shell
mixcr analyze <preset-name> \
      sample_R1.fastq.gz \
      sample_R2.fastq.gz \
      sample_result
```

Command [`exportPreset`](mixcr-exportPreset.md) can help to understand structure of preset.

Bellow you one can find a variety of presets for different types of input data and commercially available kits. Most of these presets do not require any additional arguments.


## Kits

--8<-- "reference/presets/_milaboratories.md_"
--8<-- "reference/presets/_10x.md_"
--8<-- "reference/presets/_neb.md_"
--8<-- "reference/presets/_cellecta.md_"
--8<-- "reference/presets/_illumina.md_"
--8<-- "reference/presets/_qiagen.md_"
--8<-- "reference/presets/_abhelix.md_"
--8<-- "reference/presets/_irepertoire.md_"
--8<-- "reference/presets/_thermofisher.md_"
--8<-- "reference/presets/_invivoscribe.md_"
--8<-- "reference/presets/_takara.md_"
--8<-- "reference/presets/_idt.md_"
--8<-- "reference/presets/_bd.md_"
--8<-- "reference/presets/_nanopore.md_"
--8<-- "reference/presets/_pacbio.md_"
--8<-- "reference/presets/_parsebio.md_"
--8<-- "reference/presets/_singleron.md_"

## Public protocols

--8<-- "reference/presets/_biomed2.md_"
--8<-- "reference/presets/_smartseq.md_"
--8<-- "reference/presets/_splitseq.md_"
--8<-- "reference/presets/_flairrseq.md_"
--8<-- "reference/presets/_seqwell.md_"
--8<-- "reference/presets/_mikelov.md_"
--8<-- "reference/presets/_vergani.md_"
--8<-- "reference/presets/_han.md_"

## Generic data
--8<-- "reference/presets/_rnaseq.md_"
--8<-- "reference/presets/_exomeseq.md_"
--8<-- "reference/presets/_generic-amplicon.md_"
--8<-- "reference/presets/_generic-single-cell.md_"








