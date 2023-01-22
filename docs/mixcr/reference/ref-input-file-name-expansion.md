# Input file name expansion

MiXCR provides a powerful functionality to take and process a batch of raw sequencing files at once and optionally assign molecular, cell and sample barcodes extracted from the file names. This may be used for various purposes:

 - a single sample separated across multiple lanes;
 - a single cell sample with TCR-α and TCR-β or IG-heavy and IG-light sequenced separately;
 - a single cell sample with different cells sequenced separately (e.g. plate-based single cell with one patient on several plates);
 - multiple patient samples.

Basic example to join sequencing files from several lanes on the fly:
```shell
mixcr analyze 10x-vdj-tcr \
      --species hsa \
      sample1_R1_L{{n}}.fastq.gz \
      sample1_R2_L{{n}}.fastq.gz \
      output.vdjca
```
or even shorter:
```shell
mixcr analyze 10x-vdj-tcr \
      --species hsa \
      sample1_{{R}}_L{{n}}.fastq.gz \
      output.vdjca
```
Here a special MiXCR `{{ }}` syntax is used to "wildcard" lanes and read mates in the file name. Under the hood MiXCR will concatenate data on fly, without use of additional storage. It ensures exact pairing of R1/R2 files and guarantees consistent ordering of input reads from run to run.

MiXCR recognizes the following substitution elements in the input file names:

- `{{n}}` - matching any number; with or without leading zeros input sequences will be sorted according to the number value
- `{{a}}` - matches any symbol sequence; input sequences will be sorted lexicographically in respect to this matching group
- `{{R}}` - special matching group that matches `R1`/`R2`/`1`/`2`, and matched value will be used to assign files to corresponding mate pairs
- `{{tag:rule}}` - assign `tag` (molecular, cell or sample) to sequencing reads captured from the file name using one of the above `rules` (except read mates `R`). 

??? Note "Wildcards are recognized only in file names, not in paths" 
    Substitution elements are only recognized in the very last part of the path (so in the following pattern  `/some/path/experiment_{{n}}/{{a}}_{{R}}_L{{n}}.fastq.gz`, first `{{n}}` will not be expanded).

When assigning tags using capturing groups, the tag name must starts with one of `UMI`, `CELL` or `SAMPLE`. For example:
```
mixcr analyze rnaseq-cdr3 sample{{SAMPLE0:n}}_{{R}}.fastq.gz
```
will extract sample barcode from the file name and add it to each sequence pair from the corresponding pair of fastq files. 


## Examples

### One sample, multiple lanes 

Assume we have the following set of files:
```
sample1_R1_L001.fastq.gz
sample1_R2_L001.fastq.gz
sample1_R1_L002.fastq.gz
sample1_R2_L002.fastq.gz
```

The following MiXCR command:
```
mixcr analyze <preset> \
      sample1_R1_L{{n}}.fastq.gz \
      sample1_R2_L{{n}}.fastq.gz \
      sample1_result
```
will match files in the following way:
```
R1:                        R2:
sample1_R1_L001.fastq.gz   sample1_R2_L001.fastq.gz
sample1_R1_L002.fastq.gz   sample1_R2_L002.fastq.gz
```

It can be simplified even more: 
```
mixcr analyze <preset> \
      sample1_{{R}}_L{{n}}.fastq.gz \
      sample1_result
```
producing exactly the same result.


### One sample, multiple files

Assume we have the following set of files, all corresponding to a single patient sample:
```
sample1_A_R1_L001.fastq.gz
sample1_A_R2_L001.fastq.gz
sample1_A_R1_L002.fastq.gz
sample1_A_R2_L002.fastq.gz
sample1_B_R1_L001.fastq.gz
sample1_B_R2_L001.fastq.gz
sample1_B_R1_L002.fastq.gz
sample1_B_R2_L002.fastq.gz
```

The following MiXCR command:
```
mixcr analyze <preset> \
      {{a}}_R1_L{{n}}.fastq.gz \
      {{a}}_R2_L{{n}}.fastq.gz \
      sample1_result
```
will match files in the following way:
```
R1:                          R2:
sample1_A_R1_L001.fastq.gz   sample1_A_R2_L001.fastq.gz
sample1_A_R1_L002.fastq.gz   sample1_A_R2_L002.fastq.gz
sample1_B_R1_L001.fastq.gz   sample1_B_R2_L001.fastq.gz
sample1_B_R1_L002.fastq.gz   sample1_B_R2_L002.fastq.gz
```
Data from those files will be merged on the fly during analysis.

It can be simplified even more:
```
mixcr analyze <preset> \
      {{a}}_{{R}}_L{{n}}.fastq.gz \
      sample1_result
```
producing exactly the same result.

### Microplates: one sample, multiple plates

Suppose we have one patient sample prepared using microplates technology: cells were isolated in separate wells, with well barcode having the following pattern:
```shell
^(CELL:N{8})(UMI:N{10})N{12}(R1:*)\^(R2:*)
```
We have the following files:
```shell
sample1_plate1_R1.fastq.gz
sample1_plate1_R2.fastq.gz
sample1_plate2_R1.fastq.gz
sample1_plate2_R2.fastq.gz
sample1_plate3_R1.fastq.gz
sample1_plate3_R2.fastq.gz
```
The following MiXCR command (tag pattern is explicitly specified for clarity):
```
mixcr analyze <preset> \
      --tag-pattern "^(CELL1WELL:N{8})(UMI:N{10})N{12}(R1:*)\^(R2:*)" \
      sample1_{{CELL0PLATE:a}}_{{R}}.fastq.gz \
      sample1_result
```
will match files in the following way:
```
CELL0PLATE:    R1:                           R2:
plate1         sample1_plate1_R1.fastq.gz    sample1_plate1_R2.fastq.gz
plate2         sample1_plate2_R1.fastq.gz    sample1_plate2_R2.fastq.gz
plate3         sample1_plate3_R1.fastq.gz    sample1_plate3_R2.fastq.gz
...            ...                           ...
```
Two cell tags `CELL0PLATE` and `CELL1WELL` will be assigned to sequences: `CELL0PLATE` will be assigned from the corresponding file names while `CELL1WELL` will be extracted from sequences using tag pattern. Importantly, `CELL1WELL` will be processed in barcode error correction at [`refineTagsAndSort`](mixcr-refineTagsAndSort.md) step.

### Microplates: multiple patient samples, multiple plates

Suppose we have several patient sample prepared using microplates technology: cells were isolated in separate wells, with well barcode having the following pattern:
```shell
^(CELL1ROW:N{5})(UMI:N{10})N{12}(R1:*)\^(CELL2COL:N{5})N{12}(R2:*)
```
where `CELL1ROW` correspond to row barcode and `CELL2COL` to column barcode. Different patient samples were prepared on multiple plates, with some patients having cells from different patients.

We have the following files:
```shell
plate1_R1.fastq.gz
plate1_R2.fastq.gz
plate2_R1.fastq.gz
plate2_R2.fastq.gz
plate3_R1.fastq.gz
plate3_R2.fastq.gz
...
```
The following MiXCR command (tag pattern is explicitly specified for clarity):
```
mixcr analyze <preset> \
      --tag-pattern "^(CELL1ROW:N{5})(UMI:N{10})N{12}(R1:*)\^(CELL2COL:N{5})N{12}(R2:*)" \
      --sample-table sample-table.tsv \
      {{CELL0PLATE:a}}_{{R}}.fastq.gz \
      output/
```
accomplished with the following sample table (tag pattern column is empty as we specified one global tag pattern same for all samples):

| Sample   | TagPattern | CELL0PLATE | CELL1ROW | CELL2COL |
|----------|------------|------------|----------|----------|
| patientA |            | plate1     | AAAAA    | AAAAA    |
| patientA |            | plate1     | TTTTT    | TTTTT    |
| patientA |            | plate2     | TGTGT    | TATAT    |
| patientB |            | plate2     | AAAAA    | TTTTT    |
| patientB |            | plate2     | GGCAA    | TTGCT    |
| patientB |            | plate3     | ATTCA    | CTGAC    |
| ...      | ...        | ...        | ...      | ...      |

will match files in the following way:
```
CELL0PLATE:    R1:                   R2:
plate1         plate1_R1.fastq.gz    plate1_R2.fastq.gz
plate2         plate2_R1.fastq.gz    plate2_R2.fastq.gz
plate3         plate3_R1.fastq.gz    plate3_R2.fastq.gz
...            ...                   ...
```
It will:
 - assign `CELL0PLATE` cell barcode based on the file name;
 - assign `CELL1ROW` and `CELL2COL` cell barcodes based on the tag pattern;
 - split analysis into separate patient samples based on the sample table and values of cell barcodes corresponding to different patients.

### Smart-seq2: individual cells in separate files

Assume we have the following set of files, all corresponding to different cells from the same patient obtained with [Smart-seq2](https://www.nature.com/articles/nprot.2014.006) protocol:
```
cell1_R1.fastq.gz
cell1_R2.fastq.gz
cell2_R1.fastq.gz
cell2_R2.fastq.gz
cell3_R1.fastq.gz
cell3_R2.fastq.gz
...
```
The following MiXCR command with [Smart-seq2](overview-built-in-presets.md#smart-seq2) optimized preset:
```
mixcr analyze smart-seq2 \
      {{CELL:a}}_{{R}}.fastq.gz \
      sample1_result
```
will match files in the following way:
```
CELL:        R1:                  R2:
cell1        cell1_R1.fastq.gz    cell1_R2.fastq.gz
cell2        cell2_R1.fastq.gz    cell2_R2.fastq.gz
cell3        cell3_R1.fastq.gz    cell3_R2.fastq.gz
...          ...                  ...
```
The cell tag `CELL` will be assigned to sequences from the corresponding files.


### Single cell sample, individual cells in separate files

??? Warning "We strictly do not recommend to perform any preprocessing before passing the data to MiXCR"
    MiXCR is able to take and process any raw input data with any kind of barcoding techniques used. It provides powerful [tag patterns](ref-tag-pattern.md) and [sample sheets](ref-samples-table.md) to handle all variety of cases. Preprocessing done before MiXCR analysis may damage the quality of the results (e.g. when you analyze different cells from one patient with separate MiXCR runs). We strictly do not recommend to perform any preprocessing before passing the data to MiXCR (except the standard [`bcl2fastq`](https://support.illumina.com/sequencing/sequencing_software/bcl2fastq-conversion-software.html) and e.g. [`trimmomatic`](http://www.usadellab.org/cms/?page=trimmomatic)).

Assume we have the following set of files, all corresponding to a single patient sample:
```
sample1_TAGCA_AAATC_R1.fastq.gz
sample1_TAGCA_AAATC_R2.fastq.gz
sample1_GAGCA_GCCTA_R1.fastq.gz
sample1_GAGCA_GCCTA_R2.fastq.gz
sample1_ACCAC_GTTAG_R1.fastq.gz
sample1_ACCAC_GTTAG_R2.fastq.gz
...
```
The following MiXCR command:
```
mixcr analyze <preset> \
      sample1_{{CELL0ROW:a}}_{{CELL0COL:a}}_{{R}}.fastq.gz \
      sample1_result
```
will match files in the following way:
```
CELL0ROW:    CELL0COL:    R1:                                R2:
TAGCA        AAATC        sample1_TAGCA_AAATC_R1.fastq.gz    sample1_TAGCA_AAATC_R2.fastq.gz
GAGCA        GCCTA        sample1_GAGCA_GCCTA_R1.fastq.gz    sample1_GAGCA_GCCTA_R2.fastq.gz
ACCAC        GTTAG        sample1_ACCAC_GTTAG_R1.fastq.gz    sample1_ACCAC_GTTAG_R2.fastq.gz
...          ...         ...                               ...
```
Two cell tags `CELL0ROW` and `CELL0COL` will be assigned to sequences from the corresponding files.



## Discussion

De-facto industry standard approach to structuring raw sequencing data, has not much to offer in terms of convenience of downstream processing. Additionally, to the fact that mate pair reads are placed into two separate files, in many cases, sequencer machine software is applied in such a way, that it splits sequence from different lanes of a sequencing cell into separate files, even the exactly same library was sequenced on all of them. Another common case where sequences from the same library end up in different files is when initial run turned up to provide insufficient coverage, and decision is made to sequence the library again to get more reads. Still, most of the software tools for sequencing data analysis expect exactly two mate-pair R1 and R2 files. The only solution for this problem was to merge initial files to adapt it for the software. This approach has two significant drawbacks: (1) increased demand for the storage hardware, (2) possibility to corrupt the data by reordering the reads and losing the connection between mate pairs from R1 and R2 files. The second problem is of a very dangerous nature, as no downstream software checks for R1/R2 pairing correctness (because of a lack of the standards for fastq description lines) and the issue may not be recognized, and poor quality of results are blamed on the bed wet-lab library quality or analysis software problems, or even worse, the problem may be ignored completely and results obtained on the corrupted data are used to make biological or clinical conclusions.

