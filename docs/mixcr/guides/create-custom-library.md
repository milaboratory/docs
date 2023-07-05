# Custom library

MiXCR uses a special JSON structured format to store reference library of V/D/J/C gene segment sequences and markup. It provides a convenient [`buildLibrary`](../reference/mixcr-buildLibrary.md) command allowing to assemble custom libraries for new species or chimeric model animals.


## De-novo libraries

!!! Note "This method can be used to build library for homologous species. To create a library based on completely artificial or non homologous gene sequences, one need to manually create [library JSON](#library-structure)." 

Suppose we have a bunch of de-novo discovered V,D, J and C gene sequences for _Phocoena sinus_. To build a custom library one need to place those sequences in [fasta](https://en.wikipedia.org/wiki/FASTA_format) files with sequence headers corresponding to gene name. 

For example, assume file `v-genes.IGH.fasta` contains [`VRegion`](../reference/ref-gene-features.md) IGH sequences, i.e. from the FR1 begin to the last nucleotide right before RSS, normally somewhere after conserved cysteine:
```fasta
>IGHV12-348
GATGCTGGAGTTATCCAGTCACCCCGCCATGAGGTGACAGAGATGGGACAAGAAGTGACTCTGAGATGTAAACCA
ATTTCAGGCCACAACTCCCTTTTCTGGTACAGACAGACCATGATGCGGGGACTGGAGTTGCTCATTTACTTTAAC
AACAACGTTCCGATAGATGATTCAGGGATGCCCGAGGATCGATTCTCAGCTAAGATGCCTAATGCATCATTCTCC
ACTCTGAAGATCCAGCCCTCAGAACCCAGGGACTCAGCTGTGTACTTCTGTGCCAGCAGTTTAGC
```

And file `j-genes.IGH.fasta` contains [`JRegion`](../reference/ref-gene-features.md) IGH sequences, i.e. from first J gene nucleotide, right after RSS, until FR4 end:
```fasta
>IGHJJ1-528
TAACAACCAGGCCCAGTATTTTGGAGAAGGGACTCGGCTCTCTGTTCTAG
```

To assemble a custom IGH library one can run:
```
mixcr buildLibrary --debug \
  --v-genes-from-fasta v-genes.IGH.fasta \
  --v-gene-feature VRegion \
  --j-genes-from-fasta j-genes.IGH.fasta \
  --d-genes-from-fasta d-genes.IGH.fasta \ # optional
  --c-genes-from-fasta c-genes.IGH.fasta \ # optional
  --chain IGH \
  --species phocoena \
  phocoena-IGH.json.gz
```

Here we precisely specified mandatory option `--v-gene-feature` to specify the exact [feature](../reference/ref-gene-features.md) for V genes (for other gene types MiXCR by default will use `JRegion`, `DRegion` and `CExon1` respectively). Here we also specified `--debug` option to check whether there are any problems with the resulting library (see [debugging section](#debugging)). 

To use this library with MiXCR one can just put it in the same directory from which you run MiXCR or under the library search path which can be found by running `mixcr -v`. Example usage:
```
mixcr analyze generic-amplicon \
    --library phocoena-IGH \
    --species phocoena \
    --rna \
    --rigid-left-alignment-boundary \
    --floating-right-alignment-boundary C \
    input_R1.fastq.gz \
    input_R2.fastq.gz \
    output
```

For multiple immunological chains, one need to repeat above for each chain and then merge resulting libraries into one library file using [`mergeLibrary`](../reference/mixcr-mergeLibrary.md) command:
```
mixcr mergeLibrary \
    phocoena-IGH.json.gz \
    phocoena-IGK.json.gz \
    phocoena-IGL.json.gz \
    phocoena-TRA.json.gz \
    phocoena-TRB.json.gz \
    phocoena.json.gz \
```

### Debugging

Under the hood of this procedure, MiXCR infers genes markup, i.e. positions of [reference points](../reference/ref-gene-features.md) in gene sequence, based on the alignments with homologous genes from the internal built-in library. If genes sequences are not sufficiently homologous, MiXCR may not be able to infer / or infer with inaccuracy positions of some reference points.

To check whether there are some problems one can use the `debugLibrary` command. For example:
```
mixcr debugLibrary phocoena-IGH.json.gz
```

May output something like:
```
=========

IGHV1-5*00 (F) IGH : 0

WARNINGS:
Expected VIntron sequence to end with AG, was: TC
FR3 contains a stop codon
VRegion contains a stop codon
VTranscriptWithout5UTR contains a stop codon

...
=========

IGHV4-3*00 (F) IGH : 0

WARNINGS:
L1 contains a stop codon
L contains a stop codon
VTranscriptWithout5UTR contains a stop codon

=========

IGHV4-99*00 (F) IGH : 0

WARNINGS:
Unable to find CDR3 end

...
```

To resolve those problems one need to manually [modify the JSON library](#library-structure) file and fix the markup.


## Chimeric model animals

One can also easily build a library for chimeric model animals. For example, to build IGH library with human V,D,J and mouse C genes one can run:
```
mixcr buildLibrary \
  --chain IGH \
  --v-genes-from-species human \
  --d-genes-from-species human \
  --j-genes-from-species human \
  --c-genes-from-species mouse \
  --species humouse \
  humouse-IGH.json
```

Also, we can take some genes from fasta in the same way as for [de-novo libraries](#de-novo-libraries). For example, the following command will take V and J genes from human, D genes from a custom fasta file, and C genes from mouse:
```
mixcr buildLibrary \
  --chain IGH \
  --v-genes-from-species human \
  --d-genes-from-fasta d-genes.fasta \
  --j-genes-from-species human \
  --c-genes-from-species mouse \
  --species humouse \
  humouse-IGH.json
```

To use this library with MiXCR one can just put it in the same directory from which you run MiXCR or under the library search path which can be found by running `mixcr -v`. Example usage:
```
mixcr analyze generic-amplicon \
    --library humouse-IGH \
    --species humouse \
    --rna \
    --rigid-left-alignment-boundary \
    --floating-right-alignment-boundary C \
    input_R1.fastq.gz \
    input_R2.fastq.gz \
    output
```

For multiple immunological chains, one need to repeat above for each chain and then merge resulting libraries into one library file using [`mergeLibrary`](../reference/mixcr-mergeLibrary.md) command:
```
mixcr mergeLibrary \
    humouse-IGH.json.gz \
    humouse-IGK.json.gz \
    humouse-IGL.json.gz \
    humouse-TRA.json.gz \
    humouse-TRB.json.gz \
    humouse.json.gz \
```

## Artificial libraries / non homologous genes

Currently, to build a custom reference library from completely artificial genes, one need to manually create corresponding library JSON-structured file (see [library structure](#library-structure)).

## Library structure

The output JSON file with the library will contain library with inferred [reference points](../reference/ref-gene-features.md):
```json
[ {
  "taxonId": 0,
  "speciesNames": [ "phocoena" ],
  "genes": [ {
    "baseSequence": "file://v-genes.TRB.fasta#TRBV12-348*00",
    "name": "TRBV12-38*00",
    "geneType": "V",
    "isFunctional": true,
    "chains": [ "TRB" ],
    "anchorPoints": {
      "FR1Begin": 0,
      "CDR1Begin": 78,
      "FR2Begin": 93,
      "CDR2Begin": 144,
      "FR3Begin": 162,
      "CDR3Begin": 273,
      "VEnd": 290
    }
  }, {
    "baseSequence": "file://j-genes.TRB.fasta#TRBJ1-528*00",
    "name": "TRBJ1-528*00",
    "geneType": "J",
    "isFunctional": true,
    "chains": [ "TRB" ],
    "anchorPoints": {
      "JBegin": 0,
      "FR4Begin": 22,
      "FR4End": 50
    }
  } ],
  "sequenceFragments" : [ {
    "uri" : "file://v-genes.TRB.fasta#TRBV12-348*00",
    "range" : {
      "from" : 0,
      "to" : 290
    },
    "sequence" : "CTGGGCTCACAGTGACTTCCCCTCACTGTGTCTGTTGCACAGTAATAAACGGCCGTGTCCTCAGGTTTCAGGCTGTTCATTTGCAGATACAGCGTGTTCTTGGCGTTGTCTCTGGAGATGGTGAACCGGCCCTACACGGAGTCTGCATAGTATGTGCTACCACCACCACTATTAATATCTGAGACCCACTCGAGCCCCTTTCCTGGAGCCTGGCGGACCCAGCTCATGGCATAGCTACTGAAGGTGAATCCAGAGGCTGCACAGGAGAGTCTCAGAGACCCCCCAGGCTG"
    }, {
    "uri" : "file://j-genes.TRB.fasta#TRBJ1-528*00",
    "range" : {
      "from" : 0,
      "to" : 50
    },
    "sequence" : "AAGCCACCCGGCCCTGGCCCTGCAGCTCTGGGAGAGGAGCCCCAGTCCGG"
  }]
} ]
```

Each gene is defined by:

`name`
: the name of the gene

`geneType`
: gene type (V, D, J or C)

`isFunctional`
: whether it is functional or not

`chains`
: immunological receptor chains it can form (there may be multiple values, e.g. some V genes from TRA/TRD can form alpha or delta T-cell receptor chain depending on the cell lineage)

`baseSequence`
: URL-like address of the original sequence for this gene (in the above example, address points to the specific record embedded in the library file)

`anchorPoints`
: zero-based positions of [anchor points](../reference/ref-gene-features.md) relative to the `baseSequence`

For normal repertoire extraction we, at least, must specify positions of CDR3Begin (in V gene) and CDR3End (in J gene). 
