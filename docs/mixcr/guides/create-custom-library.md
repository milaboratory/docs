# Creating RepSeq.io formatted JSON library

Suppose we have a bunch of de-novo discovered V/D/J/C sequences in fasta files with the following content:

`my_genes.v.fasta`*` (contain VRegion, i.e. from the FR1 begin to the last nucleotide right before RSS, normally somewhere after conserved cysteine)
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

To use these sequences in MiXCR or any other `repseqio`-based software, we have to create JSON library file for them (see format description [here](../reference/repseqio-json-format.md)).

There are two main options of creating library file:
- create repseqio-JSON formatted library using two automated steps and then, if required, fill in information that was not automatically detected
- from scratch, manually provide JSON file with meta information and positions of `CDR`s (complementarity determining regions) and `FR`s (framework regions) along with positions of other important gene features required for downstream software (see list of available anchor points [here](../reference/ref-gene-features.md)).

Here we will cover automatic import procedure. Please see [library format description](../reference/repseqio-json-format.md) for more details.

## Automatically create boilerplate library

We can do this using [`fromFasta`](../reference/repseqio-fromFasta.md) action:

```shell
> repseqio fromFasta --taxon-id 9606 \
    --species-name hs --species-name homsap \
    --chain TRB --name-index 0 \
    --gene-type V --gene-feature VRegion \
    my_genes.v.fasta my_library.v.json

> repseqio fromFasta --taxon-id 9606 \
    --species-name hs --species-name homsap \
    --chain TRB --name-index 0 \
    --gene-type D --gene-feature DRegion \
    my_genes.d.fasta my_library.d.json

> repseqio fromFasta --taxon-id 9606 \
    --species-name hs --species-name homsap \
    --chain TRB --name-index 0 \
    --gene-type J --gene-feature JRegion \
    my_genes.j.fasta my_library.j.json

repseqio merge my_library.v.json my_library.d.json my_library.j.json my_library.json

rm my_library.v.json my_library.d.json my_library.j.json
```

To check the library file, we have so far, we can run [`debug`](../reference/repseqio-debug.md) command:

```shell
> repseqio debug my_library.json
```

this will print the following (supposing we used files mentioned above):

```
TRBV12-38*00 (F) TRB

WARNINGS:
Unable to find CDR3 start


V5UTRGermline
N:   Not Available
AA:  Not Available

...

GermlineVCDR3Part
N:   Not Available
AA:  Not Available

VRegion
N:   GATGCTGGAGTTATCCAGTCACCCCGCCATGAGGTGACAGAGATGGGACAAGAAGTGACTCTGAGATGTAAACCAATTTCAGGCCACAACTCCCTTTTCTGGTACAGACAGACCATGATGCGGGGACTGGAGTTGCTCATTTACTTTAACAACAACGTTCCGATAGATGATTCAGGGATGCCCGAGGATCGATTCTCAGCTAAGATGCCTAATGCATCATTCTCCACTCTGAAGATCCAGCCCTCAGAACCCAGGGACTCAGCTGTGTACTTCTGTGCCAGCAGTTTAGC
AA:  DAGVIQSPRHEVTEMGQEVTLRCKPISGHNSLFWYRQTMMRGLELLIYFNNNVPIDDSGMPEDRFSAKMPNASFSTLKIQPSEPRDSAVYFCASSL_

...

=========

TRBJ1-528*00 (F) TRB

WARNINGS:
Unable to find CDR3 end


JRegion
N:   TAACAACCAGGCCCAGTATTTTGGAGAAGGGACTCGGCTCTCTGTTCTAG
AA:  Not Available

...

FR4
N:   Not Available
AA:  Not Available
=========
```

basically this shows us how `repseqio` see the library content. After [`fromFasta`](../reference/repseqio-fromFasta.md) action library contains information only on begin and end positions of genes (strictly speaking begin and end positions of gene feature we specified using `--gene-feature` option), so the only regions it can extract are `VRegion` for `V` gene and `JRegion` for `J` (see illustration [here](../reference/ref-gene-features.md)). For normal repertoire extraction we, at least, must specify positions of `CDR3Begin` (in V gene) and `CDR3End` (in J gene), and probably also need `FR`s, if we plan to extract corresponding regions from repertoire data. Here we again have two options:

* manually specify corresponding positions by adding new items to the `anchorPoints` field (see [library format description](../reference/repseqio-json-format.md))
* let repseqio find sequence with known anchor points homologous to our sequences from other library (built-in library in this case) and infer missing anchor point from them.

The first option may be the only way if target 'V'/'J' segments are not homologous to any sequences from available library.

For the second approach we can use `inferPoint` action from `repseqio` utility and `built-in` repseqio library as a reference (used by default) (see library repo [here](https://github.com/repseqio/library)):
```
repseqio inferPoints -g VRegion -g JRegion -f my_library.json my_library.json
```

here we inferred points for `V` genes based on alignment of `VRegion` with `V` genes from built-in repseqio library, and for `J` genes base on alignment of `JRegion`. `my_library.json` specified both as input and output file, with `-f` option, so it will be in-place overwritten with the result (*!!* don't use such execution pattern for libraries containing any manual edits or other hands-on time investments, this command may delete or corrupt the file). **!!** The output (alignments) of this commands should be carefully analysed to detect possible inconsistencies this automated procedure may introduce, or to spot genes for that repseqio failed to find homologous genes.

The output file (`my_library2.json`) will contain library with inferred points:

```json
[ {
  "taxonId": 9606,
  "speciesNames": [ "homosapiens", "homsap", "hs", "hsa", "human" ],
  "genes": [ {
    "baseSequence": "file://my_genes.fasta#TRBV12-348*00",
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
    "baseSequence": "file://my_genes.fasta#TRBJ1-528*00",
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

After final library is built, consider running `repseqio debug -p my_library.json`. This will check the library and print information on the problems it detected in the library.

To simplify further distribution of the library one may want to compile library into a single file, containing all required sequence information, see `repseqio compile` docs.

## Creating library from `IMGT`-style padded `fasta` file

**(please notice)** You can download already converted IMGT library [here](https://github.com/repseqio/library-imgt/releases).

`repseqio` util contain special action [`fromPaddedFasta`](../reference/repseqio-fromPaddedFasta.md) to convert `IMGT`-style libraries to `json` format.

Example input file with `V` genes (say `imgt_lib_v.fasta`):

```fasta
>AE000659|TRAV12-3*01|Homo sapiens|F|V-REGION|221187..221463|277 nt|1| | | | |277+45=322| | |
cagaaggaggtggagcaggatcctggaccactcagtgttccagagggagccattgtttct
ctcaactgcacttacagcaacagtgct..................tttcaatacttcatg
tggtacagacagtattccagaaaaggccctgagttgctgatgtacacatactcc......
......agtggtaacaaagaagat...............ggaaggtttacagcacaggtc
gataaatccagcaagtatatctccttgttcatcagagactcacagcccagtgattcagcc
acctacctctgtgcaatgagcg
>M17656|TRAV12-3*02|Homo sapiens|(F)|V-REGION|67..343|277 nt|1| | | | |277+45=322| | |
cagaaggaggtggagcaggatcctggaccactcagtgttccagagggagccattgtttct
ctcaactgcacttacagcaacagtgct..................tttcaatacttcatg
tggtacagacagtattccagaataggccctgagttgctgatgtacacatactcc......
......agtggtaacaaagaagat...............ggaaggtttacagcacaggtc
gataaatccagcaagtatatctccttgttcatcagagactcacagcccagtgattcagcc
acctacctctgtgcaatgagcg
```

Example input file with `J` genes (say `imgt_lib_j.fasta`):
```fasta
>X02885|TRAJ12*01|Homo sapiens|F|J-REGION|53..112|60 nt|3| | | | |60+0=60| | |
ggatggatagcagctataaattgatcttcgggagtgggaccagactgctggtcaggcctg
>M94081|TRAJ13*01|Homo sapiens|F|J-REGION|71280..71342|63 nt|3| | | | |63+0=63| | |
tgaattctgggggttaccagaaagttacctttggaattggaacaaagctccaagtcatcc
caa
>AC023226|TRAJ13*02|Homo sapiens|F|J-REGION|51292..51354|63 nt|3| | | | |63+0=63| |rev-compl|
tgaattctgggggttaccagaaagttacctttggaactggaacaaagctccaagtcatcc
caa
```

To use [`fromPaddedFasta`](../reference/repseqio-fromPaddedFasta.md) action, you should specify positions of anchor points (see [here](../reference/ref-gene-features.md)) in padded file. Here is the most common options for `V` genes in `IMGT`:
```
-PFR1Begin=0 -PCDR1Begin=78 -PFR2Begin=114 -PCDR2Begin=165 -PFR3Begin=195 -PCDR3Begin=309 -PVEnd=-1
```
and `J` genes
```
-PJBegin=0 -PFR4Begin=-31 -LFR4Begin='[WF](G.G)' -PFR4End=-1
```

Here are example commands for input files provided above:
```shell
> repseqio fromPaddedFasta -t 9606 -c TRA -j 3 -n 1 -g V -PFR1Begin=0 -PCDR1Begin=78 -PFR2Begin=114 -PCDR2Begin=165 -PFR3Begin=195 -PCDR3Begin=309 -PVEnd=-1 imgt_lib_v.fasta imgt_lib_v.json.fasta imgt_lib_v.json

> repseqio fromPaddedFasta -t 9606 -c TRA -j 3 -n 1 -g J -PJBegin=0 -PFR4Begin=-31 -LFR4Begin='[WF](G.G)' -PFR4End=-1 imgt_lib_j.fasta imgt_lib_j.json.fasta imgt_lib_j.json
```
this will create library files `imgt_lib_j.json` and `imgt_lib_v.json`, along with un-padded `imgt_lib_j.json.fasta` and `imgt_lib_v.json.fasta` that libraries refers to (see section above for more information on json library format).

## Using the library

To use your library with MiXCR, just copy `json` file and all referenced `fasta` files to `~/.mixcr/libraries` folder (example for files form "Creating library from scratch, based on `fasta` file"):

```shell
> mkdir -p ~/.mixcr/libraries
> cp my_library2.json ~/.mixcr/libraries/my_library.json
```

run `mixcr` as follows:
```shell
> mixcr align --library my_library -s homsap ...
```

To simplify library distribution, library can be packed into a single file along with all sequence information (notice, this procedure will incorporate only regions of the sequences that are used inside the library, so it will not pack the whole chromosome sequence, but only parts referenced in the library):

```shell
> repseqio compile my_library2.json my_library.compiled.json.gz
```
(repseqio also supports direct reading from gzipped files)

Now just single file must be copied to the library folder

```shell
> cp my_library2.json ~/.mixcr/libraries/my_library.compiled.json.gz
```
