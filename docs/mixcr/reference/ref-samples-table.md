# Samples table

In many cases it may be useful or even required to analyze samples from different patients at once. MiXCR allows to do this with sample barcodes that may be picked up from all possible sources:

- from names of input files;
- from index I1/I2 FASTQ files;
- from sequence header lines;
- from inside the [tag pattern](ref-tag-pattern.md).

To enable this functionality, one need to pass sample table in a `.tsv` format to MiXCR with `--sample-table` option. The structure of the sample table is the following:

| Sample | TagPattern | TAG0 | TAG1 | TAG2 | ... |
|--------|------------|------|------|------|-----|
| ...    | ...        | ...  | ...  | ...  | ... |

where columns meaning is the following:

`Sample` (required, non-empty)
: the name of the sample

`TagPattern` (required, may be empty)
: [tag pattern](ref-tag-pattern.md) that should be matched for sequences from the corresponding sample; if not empty it overrides the tag pattern specified by the preset or by mix-in option  

`TAG0` (optional)
: tag value corresponding to the sample  

MiXCR can process multiple samples in two principal ways: (1) data can be split by samples right at the [`align`](mixcr-align.md) step and processed separately, or (2) all samples will be processed as a single set of sequences and separated only on the very last [`exportClones`](mixcr-export.md) step. Both approaches have their pros and cons allowing to use the best strategy given the experimental setup and study goals.


## Examples

Below we illustrate usage of sample sheets by various examples.

### Sample barcodes from index files

Suppose index barcodes from I1/I2 `.fastq` files are used to identify different samples from the same run. We can use the following MiXCR command to infer sample barcodes from index files:
```shell
mixcr analuze <preset-name> \
      --sample-table sample_table.tsv \
      --tag-pattern "(R1:*)\(R2:*)\(SAMPLE0I1:*)\(SAMPLE1I2:*)" \
      input_R1.fastq.gz \
      input_R2.fastq.gz \
      input_I1.fastq.gz \
      input_I2.fastq.gz \
      output
```

The tag pattern just takes R1 and R2 as is, and treats sequences from I1 and I2 as `SAMPLE0I1` and `SAMPLE1I2` sample barcodes respectively. Of course, if there are other barcodes in R1/R2, the [tag pattern](ref-tag-pattern.md) might be more complicated than in the above example. 

The `sample_table.tsv` may looks like:

| Sample  | TagPattern | SAMPLE0I1 | SAMPLE0I2 |
|---------|------------|-----------|-----------|
| Sample1 |            | CAGCCCAC  | ACATTACT  |
| Sample2 |            | GGCAATGG  | ACATTACT  |
| ...     |            | ...       | ...       |

Note that `TagPattern` column is empty since the pattern is specified globally for all samples.

### Sample barcodes from file names

Suppose we want to analyze multiple patient samples prepared with Takara Human BCR kit at once. We have the following files:
```shell
plate1_R1.fastq.gz
plate1_R2.fastq.gz
plate2_R1.fastq.gz
plate2_R2.fastq.gz
plate3_R1.fastq.gz
plate3_R2.fastq.gz
```

We can use the following MiXCR command to process all samples at once:
```shell
mixcr analyze takara-human-bcr-full-length \
      --infer-sample-table \
      {{SAMPLE:a}}_{{R}}.fastq.gz \
      output_prefix
```
Here we assign sample barcode using [file name expansion](ref-input-file-name-expansion.md). The command will match all pairs of FASTQ files in the current directory and automatically generate sample table based on the extracted sample barcodes.

### Sample barcodes from tag patterns

Suppose we have a custom library containing sample barcodes as first 6 letters of R1. We have the following files:
```shell
run01_R1.fastq.gz
run02_R2.fastq.gz
run03_R1.fastq.gz
run04_R2.fastq.gz
run05_R1.fastq.gz
run06_R2.fastq.gz
```

We can use the following MiXCR command to process all files at once:
```shell
mixcr analyze generic-bcr-amplicon-umi \
    --species hsa \
    --rna \
    --sample-table sample_table.tsv \
    --tag-pattern "^(SMPL:N{6})(R1:*) \ ^(UMI:N{12})GTAC(R2:*)" \
    --rigid-left-alignment-boundary \
    --floating-right-alignment-boundary C \
      {{a}}_{{R}}.fastq.gz \
      result
```

The `sample_table.tsv` may looks like:

| Sample  | TagPattern | SMPL   |
|---------|------------|--------|
| Sample1 |            | CAGCCC |
| Sample2 |            | GGCAAT |
| ...     |            | ...    |

### Sample barcodes from cell tags

See [this example](ref-input-file-name-expansion.md#microplates--multiple-patient-samples-multiple-plates).

