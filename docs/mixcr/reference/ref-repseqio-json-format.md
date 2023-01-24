# Repseq.IO JSON library format

Format supports:

 - references to external sequences (from separate file, HTTP link, NCBI sequence accession, etc.)
 - as well sequence information may be embedded inside library file, for convenient distribution (`repseqio` util has special action to convert library with external sequence links into a single self-contained file, see `repseqio compile`)

library with embedded sequences is not intended for manual editing or submission into version control system like `git`.

## Complete library example

`my_genes.v.fasta` (contain VRegion, i.e. from the FR1 begin to the last nucleotide before RSS normally after conserved cysteine)
```fasta
>TRBV12-348*00|F
GATGCTGGAGTTATCCAGTCACCCCGCCATGAGGTGACAGAGATGGGACAAGAAGTGACTCTGAGATGTAAACCA
ATTTCAGGCCACAACTCCCTTTTCTGGTACAGACAGACCATGATGCGGGGACTGGAGTTGCTCATTTACTTTAAC
AACAACGTTCCGATAGATGATTCAGGGATGCCCGAGGATCGATTCTCAGCTAAGATGCCTAATGCATCATTCTCC
ACTCTGAAGATCCAGCCCTCAGAACCCAGGGACTCAGCTGTGTACTTCTGTGCCAGCAGTTTAGC
```

`my_genes.j.fasta` (contains JRegion, i.e. from first J gene nucleotide, right after RSS, until FR4 end)
```fasta
>TRBJ1-528*00|F
TAACAACCAGGCCCAGTATTTTGGAGAAGGGACTCGGCTCTCTGTTCTAG
```

`library.json`
```json
[ {
  "taxonId": 9606,
  "speciesNames": [ "homosapiens", "homsap", "hs", "hsa", "human" ],
  "genes": [ {
    "baseSequence": "file://my_genes.v.fasta#TRBV12-348*00",
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
    "baseSequence": "file://my_genes.j.fasta#TRBJ1-528*00",
    "name": "TRBJ1-528*00",
    "geneType": "J",
    "isFunctional": true,
    "chains": [ "TRB" ],
    "anchorPoints": {
      "JBegin": 0,
      "FR4Begin": 22,
      "FR4End": 50
    }
  } ]
} ]
```

positions are 0-based.

All files must be in the same folder.

Gene libraries in `repseqio` are addressed by NCBI's taxon id of the species and library's file name. You can also specify short species names, to be automatically resolved to taxon id in commands like `mixcr align -s homsap ...` (`speciesNames` field). You also can have several libraries for several species in a single file (e.g. `[{...library1...},{...library2...}]`)

Each gene is defined by its
* `name`
* `geneType`
* wether it `isFunctional` or not
* immunological receptor `chains` it can form (may be multiple values, e.g. some `V` genes from `TRA`/`TRD` can form alpha or delta T-cell receptor chain depending on the cell lineage)
* `baseSequence` - URL-like address of the original sequence for this gene. In the above example, address points to the specific record in the local `fasta` file. The value after hash symbol points to the target sequence name from multi-sequence `fasta` file (sequence identifiers are separated by `|` symbol in original file, any identifier unique inside the file can be used)
* zero-based positions of `anchorPoints` relative to the `baseSequence`

See [main repseqio library](https://github.com/repseqio/library) for real example.

## Basic manipulations with the library:

Extracting particular gene feature sequence:
```shell
repseqio fasta -gene-feature FR1 my_library.json
```

Embedding all sequencing information:
```shell
repseqio compile my_library.json my_library.compiled.json
```
`my_library.compiled.json` will contain all sequence information required for library usage

So now having only `my_library.compiled.json` one can perform the same library manipulations
```shell
repseqio fasta -gene-feature FR1 my_library.compiled.json
```

