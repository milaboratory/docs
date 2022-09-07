# Barcode pattern syntax

Barcode patterns are used to extract various barcodes (sample barcodes, UMIs, cell barcodes) from raw sequences, trim sequencing reads or filter some sequences out. MiXCR/MiTool provides a powerful pattern-matching regex-like language to specify almost arbitrary barcodes structure. In MiXCR one can specify pattern directly at [`align` step](mixcr-align.md) or [`analyze`](mixcr-analyze.md#generic-targeted-amplicon-libraries) using `--tag-pattern` option. In MiTool patten must be provided for [`parse`](mitool-parse.md) step. 

Example:
```shell
> mixcr align -s mmu \
    --tag-pattern "^(UMI:N{12})attgcccgAAA(R1:*)\(R2:*)" \
    input_R1.fastq input_R2.fastq output.vdjca
```

## Basic Syntax Elements

### Uppercase/lowercase letters

Uppercase and lowercase letters are used to specify the sequence that must be matched.
Capital letters imply perfect match. Lowercase letters allow fuzzy match, where max total mismatches is determined by --tag-max-error-budget (indels are not supported). The ` --tag-max-error-budget ` value (default `10`) is defined as a total penalty score in bits:
- one mismatch with normal nucleotide (a,t,g,c) costs 2 bits, 
- one mismatch with IUPAC wildcards ((N, w, s, m, etc)) costs 1 bit.

Each pattern has to start with `^` which defines the read beginning.

Examples:
```
"^ATGCсtaggcTTCGA"

matches:
ATGCCTAGGCTTCGA....
ATGCGTAGGCTTCGA....
ATGCCAACGCTTCGA....
```

### Backslash `\` 

Backslash symbol `\` is a mate-pair separator. The patter to the left side of the separator will be matched against the first file provided in input (usually `R1`), the pattern to the right side will be matched against the second input file (usually `R2`). In case of single-read input file, `\` character should be omitted. By default, during barcode extraction MiTool will check input reads in the order in which they are specified in --input argument. If `--tag-parse-unstranded` argument is specified, it will also try to match pattern in the other read file. Examples:
```
"^ATTAGACA \ ^CACATATA"

By default matches:
R1: ATTAGACA.......
R2: CACATATA.......

but not:
R2: ATTAGACA......
R1: CACATATA......

With --tag-parse-unstranded the last match is also allowed.
```

### Wildcard `*`

Asterisk symbol `*` means any nucleotide any number of times. Examples:
```
"^* \ ^CACATATA"

matches:
R1 : TGGATTCAGCGC...
R2: CACATATA...
```

### Repeat `{<X>}`

`{<X>}` - repeats the last symbol X number of times. Examples:

```
"^G{4}*"
matches:
GGGGTCCACAT

"^A{1:3}*"
matches:
ATGGGCAT
AATGGGCAT
AAATGGGCAT

"^A{:3}*"
matches:
ATGGGCAT
AATGGGCAT
AAATGGGCAT

"^A{3:}*"
matches:
AAATGGGCAT
AAAATGGGCAT
AAAAATGGGCAT

```
Note: `*` matches the same pattern as `N{:}`

### Trimming 

`<{<X>}` and `>{<X>}` allows to trim 0 to X number of nucleotides from left 
or right side of the pattern respectively. Examples:

```
"^<{3}ATTAGACA"
equals:
^<<<ATTAGACA

Matches:
ATTAGACAATTAGACAATTAGACA...
TTAGACAATTAGACAATTAGACA...
TAGACAATTAGACAATTAGACA...
AGACAATTAGACAATTAGACA...

"ATTAGACA>{3}(R1:*)"
Matches:
GATGTATTAGACAGACGAGTCATGCGTATT...
     ========[------R1-----------
GATGTATTAGACGACGAGTCATGCGTATT....
     =======[-------R1-----------
GATGTATTAGAGACGAGTCATGCGTATT.....
     ======[-------R1------------
GATGTATTAGGACGAGTCATGCGTATT......
     =====[--------R1------------
```

### Capture groups
MiTool allows to extract multiple number of groups and assigns them to the read (or alignment in case of MiXCR). Typical groups are different types of barcodes: molecular barcode, sample barcode, cell barcode etc. 

Group is defined inside round brackets `()` in the following manner:

```
(GROUM_NAME:pattern)

examples:
(UMI:NNNNANNNNNANNNN)
(SMPL:NNNN)
(CELL:atgcTTGANNNNNNNNTGAATCCNN)
(R1:*)
(SMPL:NNNN)(UMI:N{12}(R1:*)
```

Some rules apply to group names:
- Everything that starts with `CELL` is treated as a cell barcode
- Everything that starts with `UMI` or `MI` (ex. `MIG`) is used as a molecular barcode
- Everything that starts with `S` is a sample barcode.
- `R1`, `R2` etc. groups define the payload read sequence.
- Groups with names that don't fall under the rules above will be ignored

**Important:** sequences outside `R1`, `R2`, etc. groups will be ignored and will not be used in analysis.

Examples:

```
"^(CELL:N{4})(UMI:N{5})\^(R2:*)"

matches:
R1: ATGCGGGTGACCTTGAGGTGGACC...
R2: TGGGGTAGCCTACCGTGGACACTG...
```
In the example above only two groups from the first read will be extracted and rest of the sequence will be ignored:\
CELL:ATGC \
UMI:GGGTG

The whole sequence of the read from the second file will be extracted with R2 tag and will be used in the downstream analysis. This pattern is commonly used when only one read has CDR3 sequence in it (`R2` in this case) and the other one is used for extracting molecular and/or cell barcode.

### Logical OR

There are two levels at which logical "OR" can be applied:

`|` - single read level "or" \
`||` - whole pattern level "or"

Constrains:
- There must be the same set of matching groups on both sides of "|" and "||"
- There must be the same number of sub-read patterns on both sides of "||"

Examples:
```
"^ATTAGACA(UMI:NNNN)(R1:*) | ^TGCTTGCA(UMI:NNNN)(R1:*) \ ^(R2:*)"

matches:

R1: ATTAGACATTGCCCTGGGATCCG...
R2: TGCCGTGATTATGCCGTGATTGT...
and
R1: TGCTTGCATTGCCCTGGGATCCG...
R2: TGCCGTGATTATGCCGTGATTGT...

"^ATTAGACA(UMI:NNNN) | ^AGGACACA(UMI:NNNN) \ ^GATACGA || ^GATAGAC \ ^TAGCA(UMI:NNNNNNN)"

matches:

R1: ATTAGACAtgctaagc....
R2: GATACgtacgttgtta....

R1: AGGACACAgctaagct....
R2: GATACgtacgttgtta....

R1: GATAGACtgctaagc....
R2: TAGCAgtacgttgtt....
```

The following patterns will result in an **error** due to violation of the constraints mentioned above:

```
^ATTAGACA(UMI:NNNN) | ^ATTACACA \ ^GATACGA || ^GATAGAC \ ^TAGCA(UMI:NNNNNNN)
^ATTAGACA(UMI:NNNN) | ^ATTACACA(UMI:NNNNNNN) \ ^GATACGA || ^GATAGAC(UMI1:NNNNNNN) \ ^TAGCA(UMI:NNNNNNN)
^ATTAGACA(UMI:NNNN) | ^ATTACACA(UMI:NNNNNNN) \ ^GATACGA || ^GATAGAC \ ^TAGCA
^ATTAGACA | ^ATTACACA \ ^GATACGA || ^GATAGAC
```
