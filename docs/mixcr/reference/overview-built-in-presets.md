---
toc_depth: 3
---

# Built-in presets

MiXCR provides a comprehensive list of built-in presets for many of available commercial kits, data types and library preparation protocols.

Preset can be used to run the whole upstream analysis pipeline with [`analyze`](mixcr-analyze.md) command. For example:
```shell
mixcr analyze milab-human-bcr-multiplex-cdr3 \
    --dont-split-clones-by C \
      sample_R1.fastq.gz \
      sample_R2.fastq.gz \
      sample_result
```
runs upstream analysis for samples obtained using Milaboratories Human BCR kit with additional optional config `--dont-split-clones-by C`.

Command [`exportPreset`](mixcr-exportPreset.md) can help to understand structure of preset.

Bellow you one can find a variety of presets for different types of input data and commercially available kits. Most of these presets do not require any additional arguments.


## Kits

--8<-- "reference/presets/_milaboratories.md_"
--8<-- "reference/presets/_takara.md_"
--8<-- "reference/presets/_10x.md_"
--8<-- "reference/presets/_illumina.md_"
--8<-- "reference/presets/_qiagen.md_"
--8<-- "reference/presets/_cellecta.md_"
--8<-- "reference/presets/_irepertoire.md_"
--8<-- "reference/presets/_thermofisher.md_"
--8<-- "reference/presets/_abhelix.md_"
--8<-- "reference/presets/_bd.md_"
--8<-- "reference/presets/_nanopore.md_"
--8<-- "reference/presets/_parsebio.md_"
--8<-- "reference/presets/_singleron.md_"
--8<-- "reference/presets/_neb.md_"

## Public protocols

--8<-- "reference/presets/_biomed2.md_"
--8<-- "reference/presets/_smartseq.md_"

### SPLiT-seq
==`split-seq-vdj-3gex`==
·
[:octicons-link-16: Publication](https://www.science.org/doi/10.1126/science.aam8999)
·
[:octicons-mark-github-16: Code](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/mixcr_presets/protocols/parsebio.yaml)

The SPLiT-seq uses the combinatorial indexing to identify single cells without single cell isolation. Multi-level indexing can be performed by ligation. Please note that as a 3'end RNA-seq based protocol it was not originally optimized for immune repertoire analysis, thus tcr/bcr yield might be low.

![](pics/split-seq-light.svg#only-light)
![](pics/split-seq-dark.svg#only-dark)

Example:
```shell
mixcr analyze split-seq-3gex-vdj \
      input_R1.fastq.gz \
      input_R2.fastq.gz \
      result
```

### Mikelov et al, 2021
==`mikelov-et-al-2021`==
·
[:octicons-link-16: Publication](https://www.biorxiv.org/content/10.1101/2021.12.30.474135v2)
·
[:octicons-mark-github-16: Code](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/mixcr_presets/protocols/custom.yaml)



### Vergani et al, 2017
==`vergani-et-al-2017-cdr3`==
·
==`vergani-et-al-2017-full-length`==
·
[:octicons-link-16: Publication](https://www.frontiersin.org/articles/10.3389/fimmu.2017.01157/full)
·
[:octicons-mark-github-16: Code](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/mixcr_presets/protocols/custom.yaml)


Example:
```shell
mixcr analyze vergani-et-al-2017-full-length \
      input_R1.fastq.gz \
      input_R2.fastq.gz \
      result
```


### Han et al, 2014

==`han-et-al-2014-tcr`==
·
==`han-et-al-2014-bcr`==
·
[:octicons-link-16: Publication](https://www.nature.com/articles/nbt.2938)
·
[:octicons-mark-github-16: Code](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/mixcr_presets/protocols/custom.yaml#L46)

These presets are optimized for a single-cell use of the protocol when each plate well contains a single cell.

![](pics/han-et-al-2014-light.svg#only-light)
![](pics/han-et-al-2014-dark.svg#only-dark)

Example:
```shell
mixcr analyze han-et-al-2014-bcr \
      --species hsa \
      input_R1.fastq.gz \
      input_R2.fastq.gz \
      result
```


## Generic data


### RNA-Seq data
==`rnaseq-cdr3`==
·
==`rnaseq-full-length`==
·
[:octicons-link-16: Publication](https://www.nature.com/articles/nbt.3979)
·
[:octicons-mark-github-16: Code](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/mixcr_presets/protocols/rnaseq.yaml)

Non-enriched fragmented (shotgun) RNA-Seq data. Preset `rnaseq-cdr3` is used to assemble CDR3 clonotypes, while `rnaseq-full-length` additionally runs [consensus contig assembly](mixcr-assembleContigs.md) to reconstruct all available parts of V-D-J-C receptor rearrangement sequence.

![](pics/rnaseq-structure-light.svg#only-light)
![](pics/rnaseq-structure-dark.svg#only-dark)

The `--species` option is required.

Example:
```shell
mixcr analyze rnaseq-full-length \
    --species hsa \
      input_R1.fastq.gz \
      input_R2.fastq.gz \
      result
```


### Exome data
==`exome-cdr3`==
·
==`exome-full-length`==
·
[:octicons-mark-github-16: Code](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/mixcr_presets/protocols/exom.yaml)

Non-enriched fragmented (shotgun) Exome-Seq data. Preset `exome-cdr3` is used to assemble CDR3 clonotypes, while `exome-full-length` additionally runs [consensus contig assembly](mixcr-assembleContigs.md) to reconstruct all available parts of V-D-J receptor rearrangement sequence.

The `--species` option is required.

Example:
```shell
mixcr analyze exome-full-length \
    --species hsa \
      input_R1.fastq.gz \
      input_R2.fastq.gz \
      result
```

### Generic TCR amplicon
==`generic-tcr-amplicon`==
·
==`generic-tcr-amplicon-umi`==
·
[:octicons-mark-github-16: Code](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/mixcr_presets/protocols/general-amplicon.yaml)
·
[:octicons-mortar-board-16: Tutorial](../guides/generic-umi-tcr.md)


Generic TCR amplicon library with (`-umi`) or without UMIs. Required configs that must be specified with corresponding [mix-in options](overview-mixins-list.md):


: :fontawesome-solid-puzzle-piece: Species;
: :fontawesome-solid-puzzle-piece: Material type;
: :fontawesome-solid-puzzle-piece: Tag pattern (for `generic-tcr-amplicon-umi`);
: :fontawesome-solid-puzzle-piece: Left alignment boundary (5'-end);
: :fontawesome-solid-puzzle-piece: Right alignment boundary (3'-end).

The following example runs upstream analysis for some bulk mouse 5'RACE TCR RNA library with 3'-end primers located on C-gene:
```shell
mixcr analyze generic-tcr-amplicon \
    --species mmu \
    --rna \
    --rigid-left-alignment-boundary \
    --floating-right-alignment-boundary C \
      input_R1.fastq.gz \
      input_R2.fastq.gz \
      result
```
The following [mix-in options](overview-mixins-list.md) are used:

`--species mmu`
: specify _Mus Musculus_ species

`--rna`
: set RNA as starting material (exon regions only will be used for alignments)

`--rigid-left-alignment-boundary`
: use global _left alignment boundary_ (5'RACE)

`--floating-right-alignment-boundary C`
: use local _right alignment boundary_ on C-segment as C-primers are used


### Generic BCR amplicon
==`generic-bcr-amplicon`==
·
==`generic-bcr-amplicon-umi`==
·
[:octicons-mark-github-16: Code](https://github.com/milaboratory/mixcr/blob/develop/src/main/resources/mixcr_presets/protocols/generic-amplicon.yaml)
·
[:octicons-mortar-board-16: Tutorial](../guides/generic-umi-bcr.md)
·
[:octicons-mortar-board-16: Tutorial](../guides/generic-multiplex-bcr.md)


Generic BCR amplicon library with (`-umi`) or without UMIs. Required configs that must be specified with corresponding [mix-in options](overview-mixins-list.md):


: :fontawesome-solid-puzzle-piece: Species;
: :fontawesome-solid-puzzle-piece: Material type;
: :fontawesome-solid-puzzle-piece: Tag pattern (for `generic-bcr-amplicon-umi`);
: :fontawesome-solid-puzzle-piece: Left alignment boundary (5'-end);
: :fontawesome-solid-puzzle-piece: Right alignment boundary (3'-end).

The following example runs upstream analysis for some full-length human BCR RNA multiplex library with 3'-end primers located on C-gene and UMIs spanning first 12 letters of 5'-end, followed by 4 letters of a fixed linker sequence:
```shell
mixcr analyze generic-bcr-amplicon-umi \
    --species hsa \
    --rna \
    --tag-pattern "^(R1:*) \ ^(UMI:N{12})GTAC(R2:*)" \
    --rigid-left-alignment-boundary \
    --floating-right-alignment-boundary C \
      input_R1.fastq.gz \
      input_R2.fastq.gz \
      result
```
The following [mix-in options](overview-mixins-list.md) are used:

`--species hsa`
: specify _Homo Sapiens_ species

`--rna`
: set RNA as starting material (exon regions only will be used for alignments)

`--tag-pattern "^(R1:*) \ ^(UMI:N{12})GTAC(R2:*)"`
: UMI [barcode pattern](ref-tag-pattern.md)

`--rigid-left-alignment-boundary`
: use global _left alignment boundary_ as our tag pattern removes UMIs and linked sequensed from 5'-end of reads

`--floating-right-alignment-boundary C`
: use local _right alignment boundary_ on C-segment as C-primers are used
