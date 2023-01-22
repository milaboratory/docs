[//]: # (# Samples table)

[//]: # ()
[//]: # (In many cases it may be useful or even required to analyze samples from different patients at once. MiXCR allows to do this with sample barcodes, that may be picked up from all possible sources:)

[//]: # ()
[//]: # (- from names of input files;)

[//]: # (- from index I1/I2 FASTQ files;)

[//]: # (- from sequence header lines;)

[//]: # (- from inside the [tag pattern]&#40;ref-tag-pattern.md&#41;.)

[//]: # ()
[//]: # (To enable this functionality, one need to pass sample sheet in a `.tsv` format to MiXCR with `--sample-table` option. The structure of the sample sheet is the following:)

[//]: # ()
[//]: # (| Sample | TagPattern | TAG0 | TAG1 | TAG2 | ... |)

[//]: # (|--------|------------|------|------|------|-----|)

[//]: # (| ...    | ...        | ...  | ...  | ...  | ... |)

[//]: # ()
[//]: # (where columns meaning is the following:)

[//]: # ()
[//]: # (`Sample` &#40;required, non-empty&#41;)

[//]: # (: the name of the sample)

[//]: # ()
[//]: # (`TagPattern` &#40;required, may be empty&#41;)

[//]: # (: [tag pattern]&#40;ref-tag-pattern.md&#41; that should be matched for sequences from the corresponding sample; if not empty it overrides the tag pattern specified by the preset or by mix-in option  )

[//]: # ()
[//]: # (`TAG0` &#40;optional&#41;)

[//]: # (: tag value corresponding to the sample  )

[//]: # ()
[//]: # (MiXCR can process multiple samples in twi principal ways: &#40;1&#41; data can be split by samples right at the [`align`]&#40;mixcr-align.md&#41; step and processed separately, or &#40;2&#41; all samples will be processed as a single set of sequences and separated only on the very last [`exportClones`]&#40;mixcr-export.md&#41; step. Both approaches have their pros and cons allowing to use the best strategy given the experimental setup and study goals.)

[//]: # ()
[//]: # ()
[//]: # (## Examples)

[//]: # ()
[//]: # (Below we illustrate usage of sample sheets by various examples.)

[//]: # ()
[//]: # (### Multiple patient samples processed at once)

[//]: # ()
[//]: # (The simples case when we have multiple samples in one directory. Support we have 3 different patient samples prepared with the same kit and having the following file names:)

[//]: # (```shell)

[//]: # (plate1_R1.fastq.gz)

[//]: # (plate1_R2.fastq.gz)

[//]: # (plate2_R1.fastq.gz)

[//]: # (plate2_R2.fastq.gz)

[//]: # (plate3_R1.fastq.gz)

[//]: # (plate3_R2.fastq.gz)

[//]: # (```)

[//]: # ()
[//]: # (The following MiXCR command will process all :)

[//]: # ()
[//]: # (```shell)

[//]: # (mixcr analyze takara-human \)

[//]: # (      --sample-table sample_sheet.tsv \)

[//]: # (      --split-by-sample \)

[//]: # (      {{SAMPLE:a}}_{{R}}.fastq.gz \)

[//]: # (      output_prefix)

[//]: # (```)

[//]: # ()
[//]: # (will match all pairs of FASTQ files in the current directory and use provided sample sheet to assign)