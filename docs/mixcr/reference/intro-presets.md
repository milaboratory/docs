# Conducting analysis

MiXCR analysis of a typical study consists of two parts:

 - upstream analysis of raw sequencing data;
 - downstream analysis of repertoire tables.

Upstream analysis basically includes alignment of raw sequencing data against reference V-, D-, J- and C- gene segment database and assembling of clonotypes based on different criteria. The efficiency of upstream analysis is determined by two metrics: recall rate and rate of false-positives. Recall rate simply measures how many sequences from the raw data are identified as productive (the more the better). Rate of false-positives measures how many of reported sequences are actually misidentified (the more the worse).

To run a qualified upstream analysis one need to basically understand the wet lab protocol used and architecture of the libraries. Additionally, the list of steps in the analysis pipeline may be different for different types of the data.  For example, depending on the presence or absence of primer sequences or adapters one should use either [global, local or glocal](https://en.wikipedia.org/wiki/Sequence_alignment#Global_and_local_alignments) alignment algorithms at 5'- and 3'-ends; for B-cell data it is better to use [affine](https://en.wikipedia.org/wiki/Gap_penalty#Affine) scoring supporting long indels while for T-cell [linear](https://en.wikipedia.org/wiki/Gap_penalty#Linear); in case of barcoded data there are additional pipeline steps for more precise [error-correction](https://pubmed.ncbi.nlm.nih.gov/24793455/); single-cell data requires steps with sophisticated filtering and decontamination; non-enriched data like RNA-seq requires [specific tuning](https://www.nature.com/articles/nbt.3979) to avoid false-positives; and there are a plenty of other examples. 


MiXCR implements a large variety of algorithms and dozens of parameters allowing to adapt its workflows for every particular library preparation protocol and achieve the best possible recall at a nearly zero rate of false-positives. Hopefully, MiXCR provides a convenient and powerful high-level mechanism to enable scientists conduct most effective analysis   





### Species

Yaml:
```yaml
mixins:
  - type: SetSpecies
    species: hs
```

Command line:
```sh
mixcr align +species hs ...
```

### Library

Yaml:
```yaml
mixins:
  - type: SetLibrary
    species: imgt
```

Command line:
```sh
mixcr align +library imgt ...
```

### Starting material type


Yaml:
```yaml
mixins:
  - type: MaterialTypeDNA
```

```yaml
mixins:
  - type: MaterialTypeRNA
```

Command line:
```sh
mixcr align +dna ...
```

```sh
mixcr align +rna ...
```


### No CDR3 

YAML:
```yaml
mixins:
  - type: KeepNonCDR3Alignments
```

Command line:
```shell
mixcr align +keepNonCDR3Alignments ...
```


YAML:
```yaml
mixins:
  - type: DropNonCDR3Alignments
```

Command line:
```shell
mixcr align +dropNonCDR3Alignments ...
```

### Input limit


YAML:
```yaml
mixins:
  - type: LimitInput
    number: 100000
```

Command line:
```shell
mixcr align +limitInput 100000 ...
```

### Alignment boundaries

Yaml:
```yaml
mixins:
   - type: LeftAlignmentBoundaryNoPoint
     

```


Command line:
```shell
+floatingLeftAlignmentBoundary
+rigidLeftAlignmentBoundary

+floatingRightAlignmentBoundary
+rigidRightAlignmentBoundary
```