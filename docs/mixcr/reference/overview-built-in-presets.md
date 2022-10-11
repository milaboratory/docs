# Built-in presets

MiXCR provides a comprehensive list of built-in presets for many of available commercial kits, data types and library preparation protocols.

Example command:

```shell
mixcr analyze milab-tcr-rna-multiplex \
      sample_R1.fastq.gz \
      sample_R2.fastq.gz \
      sample_result
```

## Protocols

## Kits

### MiLaboratories

#### [HUMAN IG RNA MULTIPLEX](https://milaboratories.com/human-ig-rna-multiplex-kit)

![](pics/milab-multiplex-bcr.svg)

Preset name: **`milab-human-bcr-multiplex-cdr3`**

- discriminates all IGH isotypes including IgM, IgD, IgG3, IgG1, IgA1, IgG2, IgG4, IgE, and IgA2
- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction
- separate clones by isotype  (C-gene) by default. To change this behavior use `+dontSeparateBy C` mix-in.

Preset name: **`milab-human-bcr-multiplex-full-length`**

- discriminates all IGH isotypes including IgM, IgD, IgG3, IgG1, IgA1, IgG2, IgG4, IgE, and IgA2
- assemble clonotypes by `VDJ` region.
- UMI-depended error-correction
- separate clones by isotype (C-gene) by default. To change this behavior use `+dontSeparateBy C` mix-in.

#### [HUMAN TCR RNA MULTIPLEX KIT](https://milaboratories.com/human-tcr-rna-multiplex-kit)

![](pics/milab-multiplex-tcr.svg)

This kit allows to obtain human TCR alpha and beta repertoires for different types of available RNA material, with high sensitivity and UMI-based accuracy.

Preset name: **`milab-human-tcr-rna-multiplex-cdr3`**
- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction

See [this tutorial](../guides/milaboratories-human-tcr-rna-multi.md) for the under-the-hood details.

#### [HUMAN TCR RNA KIT](https://milaboratories.com/human-tcr-rna-kit)

![](pics/milab-race-tcr.svg)


Preset name: **`milab-human-tcr-rna-race-cdr3`**
- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction

Preset name: **`milab-human-tcr-rna-race-full-length`**
- assemble clonotypes by `VDJ` region
- UMI-depended error-correction


#### [HUMAN TCR DNA MULTIPLEX KIT](https://milaboratories.com/human-tcr-dna-multiplex-kit)

Preset name: **`milab-human-tcr-dna-multiplex-cdr3`**
- assemble clonotypes by `CDR3` sequence

### Takara Bio

#### [SMART-Seq Human BCR (with UMIs)](https://www.takarabio.com/products/next-generation-sequencing/immune-profiling/human-repertoire/smart-seq-human-bcr-(with-umis)) & [SMARTer Human BCR IgG IgM H/K/L Profiling Kit](https://www.takarabio.com/products/next-generation-sequencing/immune-profiling/human-repertoire/human-bcr-profiling-kit-for-illumina-sequencing)

![](pics/SMARTer-Human-BCR-IgG-IgM-H-K-L.svg)

Preset name: **`takara-human-bcr-cdr3`**

- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction
- separate clones by isotype (C-gene) by default. To change this behavior use `+dontSeparateBy C` mix-in.

Preset name: **`takara-human-bcr-full-length`**

- assemble clonotypes by `VDJ` region.
- UMI-depended error-correction
- separate clones by isotype (IgG, IgM) (C-gene) by default. To change this behavior use `+dontSeparateBy C` mix-in.

#### [SMARTer Human TCR a/b Profiling Kit v2](https://www.takarabio.com/products/next-generation-sequencing/immune-profiling/human-repertoire/human-tcrv2-profiling-kit-for-illumina-sequencing)

![](pics/SMARTer-Human-TCRv2.svg)

Preset name: **`takara-human-tcr-V2-cdr3`**

- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction
- separate clones by isotype (C-gene) by default. To change this behavior use `+dontSeparateBy C` mix-in.

Preset name: **`takara-human-tcr-V2-full-length`**

- assemble clonotypes by `VDJ` region.
- UMI-depended error-correction
- separate clones by isotype (C-gene) by default. To change this behavior use `+dontSeparateBy C` mix-in.

#### [SMARTer Human TCR a/b Profiling Kit](https://www.takarabio.com/products/next-generation-sequencing/immune-profiling/human-repertoire/human-tcr-profiling-kit-for-illumina-sequencing)

![](pics/SMARTer-Human-TCRv1.svg)

Preset name: **`takara-human-tcr-V1-cdr3`**

- assemble clonotypes by `CDR3` sequence

Preset name: **`takara-human-tcr-V1-full-length`**

- assemble clonotypes by `VDJ` region.

#### [SMARTer Mouse BCR IgG H/K/L Profiling Kit](https://www.takarabio.com/products/next-generation-sequencing/immune-profiling/mouse-repertoire/mouse-bcr-profiling-kit-for-illumina-sequencing)

![](pics/SMARTer-Mouse-BCR.svg)

Preset name: **`takara-mouse-bcr-cdr3`**

- assemble clonotypes by `CDR3` sequence

Preset name: **`takara-mouse-bcr-full-length`**

- assemble clonotypes by `VDJ` region.

#### [SMARTer Mouse TCR a/b Profiling Kit](https://www.takarabio.com/products/next-generation-sequencing/immune-profiling/mouse-repertoire/mouse-tcr-profiling-kit-for-illumina-sequencing)

![](pics/SMARTer-Mouse-TCR.svg)

Preset name: **`takara-mouse-tcr-cdr3`**

- assemble clonotypes by `CDR3` sequence

Preset name: **`takara-mouse-tcr-full-length`**

- assemble clonotypes by `VDJ` region.

### New England BioLabs

#### [NEBNext® Immune Sequencing Kit (Human) BCR & TCR](https://www.neb.com/products/e6320-nebnext-immune-sequencing-kit-human#Product%20Information)

![](pics/NEBNext-human-bcr-kit.svg)

Preset name: **`nebnext-human-bcr-cdr3`**

- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction
- separate clones by isotype (IgG, IgA, IgE, IgM, IgD) by default. To change this behavior use `+dontSeparateBy C` mix-in.

Preset name: **`nebnext-human-bcr-full-length`**

- assemble clonotypes by `VDJ` sequence
- UMI-depended error-correction
- separate clones by isotype (IgG, IgA, IgE, IgM, IgD) by default. To change this behavior use `+dontSeparateBy C` mix-in.

![](pics/NEBNext-human-tcr-kit.svg)

Preset name: **`nebnext-human-tcr-cdr3`**

- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction

Preset name: **`nebnext-human-tcr-full-length`**

- assemble clonotypes by `VDJ` sequence
- UMI-depended error-correction

#### [NEBNext® Immune Sequencing Kit (Mouse) BCR & TCR](https://www.neb.com/products/e6330-nebnext-immune-sequencing-kit-mouse#Product%20Information)

![](pics/NEBNext-mouse-bcr-kit.svg)

Preset name: **`nebnext-mouse-bcr-cdr3`**

- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction
- separate clones by isotype (IgG, IgA, IgE, IgM, IgD) by default. To change this behavior use `+dontSeparateBy C` mix-in.

Preset name: **`nebnext-mouse-bcr-full-length`**

- assemble clonotypes by `VDJ` sequence
- UMI-depended error-correction
- separate clones by isotype (IgG, IgA, IgE, IgM, IgD) by default. To change this behavior use `+dontSeparateBy C` mix-in.

![](pics/NEBNext-mouse-tcr-kit.svg)

Preset name: **`nebnext-mouse-tcr-cdr3`**

- assemble clonotypes by `CDR3` sequence
- TCRα, TCRβ, TCRγ and TCRδ chains
- UMI-depended error-correction

Preset name: **`nebnext-mouse-tcr-full-length`**

- assemble clonotypes by `VDJ` sequence
- TCRα, TCRβ, TCRγ and TCRδ chains
- UMI-depended error-correction

### [AbHelix](https://abhelix.com/)

#### BCR

![](pics/ABHelix-bcr-kit.svg)

This kit allows identification of IgG1,IgG1,IgG1,IgG1,IgGM,IgA isotypes. Apparently isotypes are separated prior to the final PCR reaction, in a way that resulting sequences don't cover C region enough. Thus this preset does not separate clones by C-gene, implying that different isotypes have been already separated into different samples.

Preset name: **`abhelix-human-bcr-cdr3`**

- assemble clonotypes by `CDR3` sequence

Preset name: **`abhelix-human-bcr-full-length`**

- assemble clonotypes by `VDJ` sequence

#### TCR

![](pics/ABHelix-tcr-kit.svg)

Preset name: **`abhelix-human-tcr-cdr3`**

- assemble clonotypes by `CDR3` sequence

Preset name: **`abhelix-human-tcr-full-length`**

- assemble clonotypes by `VDJ` sequence

### Biomed2

#### FR1-FR4 Human Multiplex BCR Primer set

![](pics/biomed2-human-bcr-kit.svg)

Preset name: **`biomed2-human-bcr-cdr3`**

- assemble clonotypes by `CDR3` sequence


Preset name: **`biomed2-human-bcr-full-length`**

- assemble clonotypes by `VDJ` region

### Qiagen

#### [QIAseq™ Human TCR Panel Immune Repertoire RNA Library Kit](https://geneglobe.qiagen.com/us/product-groups/qiaseq-immune-repertoire-rna-library-kits)

![](pics/QIAseq-immune-tcr-kit.svg)

Preset name: **`qiaseq-human-tcr-cdr3`**

- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction

Preset name: **`qiaseq-human-tcr-full-length`**

- assemble clonotypes by `VDJ` sequence
- UMI-depended error-correction

#### [QIAseq™ Mouse TCR Panel Immune Repertoire RNA Library Kit](https://geneglobe.qiagen.com/us/product-groups/qiaseq-immune-repertoire-rna-library-kits)

![](pics/QIAseq-immune-tcr-kit.svg)

Preset name: **`qiaseq-mouse-tcr-cdr3`**

- assemble clonotypes by `CDR3` sequence
- UMI-depended error-correction

Preset name: **`qiaseq-mouse-tcr-full-length`**

- assemble clonotypes by `VDJ` sequence
- UMI-depended error-correction

### Illumina

#### [AmpliSeq for Illumina Immune Repertoire Plus, TCR beta Panel](https://www.illumina.com/products/by-type/sequencing-kits/library-prep-kits/ampliseq-immune-repertoire-panel.html)

![](pics/ampliseq-oncomine-lr.svg)

Preset name: **`ampliseq-tcrb-plus-cdr3`**

- assemble clonotypes by `CDR3` sequence

Preset name: **`ampliseq-tcrb-plus-full-length`**

- assemble clonotypes by the region starting from `CDR1` till the end of `FR4`

#### [AmpliSeq™ for Illumina® TCR beta-SR Panel](https://www.illumina.com/products/by-type/sequencing-kits/library-prep-kits/ampliseq-immune-repertoire-panel.html)

![](pics/ampliseq-lr.svg)

Preset name: **`ampliseq-tcrb-plus-cdr3`**

- assemble clonotypes by `CDR3` sequence


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
