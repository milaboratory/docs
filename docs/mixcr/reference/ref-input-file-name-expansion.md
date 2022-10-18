# Input file name expansion rules

## Preface

De-facto industry standard approach to structuring raw sequencing data, has not much to offer in terms of convenience of downstream processing. Additionally to the fact that mate pair reads are placed into two separate files, in many cases, sequencer machine software is applied in such a way, that it splits sequence from different lanes of a sequencing cell into separate files, even the exactly same library was sequenced on all of them. Another common case where sequences from the same library end up in different files is when initial run turned up to provide insufficient coverage, and decision is made to sequence the library again to get more reads. Still, most of the software tools for sequencing data analysis expect exactly two mate-pair R1 and R2 files. The only solution for this problem was to merge initial files to adapt it for the software. This approach has two significant drawbacks: (1) increased demand for the storage hardware, (2) possibility to corrupt the data by reordering the reads and losing the connection between mate pairs from R1 and R2 files. The second problem is of a very dangerous nature, as no downstream software checks for R1/R2 pairing correctness (because of a lack of the standards for fastq description lines) and the issue may not be recognized, and poor quality of results are blamed on the bed wet-lab library quality or analysis software problems, or even worse, the problem may be ignored completely and results obtained on the corrupted data are used to make biological or clinical conclusions.

## Feature description

To overcome the problems described above MiXCR offers a mechanism to merge sequencing reads from separate files on the fly. The mechanism require no additional storage, ensures exact pairing of R1/R2 files and guarantees consistent ordering of input reads from run to run.

This feature is supported in both by [`analyze`](./mixcr-analyze.md) and [`align`](./mixcr-align.md) sub commands.

MiXCR recognize the following substitution elements in the input file names:

  - `{{n}}` - matching any number; with or without leading zeros input sequences will be sorted according to the number value
  - `{{a}}` - matches any symbol sequence; input sequences will be sorted lexicographically in respect to this matching group
  - `{{R}}` - special matching group that matches `R1`/`R2`/`1`/`2`, and matched value will be used to assign files to corresponding mate pairs

Substitution elements are only recognized in the very last part of the path (so in the following pattern  `/some/path/experiment_{{n}}/{{a}}_{{R}}_L{{n}}.fastq.gz`, first `{{n}}` will not be expanded).  

## Examples

Please see the following examples to have a better grasp on how the feature works. Let's assume we have the following set of files:

```
sample1_R1_L001.fastq.gz
sample1_R2_L001.fastq.gz
sample1_R1_L002.fastq.gz
sample1_R2_L002.fastq.gz
sample2_R1_L001.fastq.gz
sample2_R2_L001.fastq.gz
sample2_R1_L002.fastq.gz
sample2_R2_L002.fastq.gz
```

then:

  - `mixcr align ... sample1_R1_L{{n}}.fastq.gz sample1_R2_L{{n}}.fastq.gz output.vdjca` will match files in the following way:
      
    ```
    R1:                        R2:
    sample1_R1_L001.fastq.gz   sample1_R2_L001.fastq.gz
    sample1_R1_L002.fastq.gz   sample1_R2_L002.fastq.gz
    ```

  - the above command can be simplified even more: `mixcr align ... sample1_{{R}}_L{{n}}.fastq.gz output.vdjca` producing exactly the same result:
      
    ```
    R1:                        R2:
    sample1_R1_L001.fastq.gz   sample1_R2_L001.fastq.gz
    sample1_R1_L002.fastq.gz   sample1_R2_L002.fastq.gz
    ```

  - and this is how the whole set of sequences can be merged as if it is a single dataset: `mixcr align ... {{a}}_{{R}}_L{{n}}.fastq.gz output.vdjca`, which will be interpreted in the following way: 

    ```
    R1:                        R2:
    sample1_R1_L001.fastq.gz   sample1_R2_L001.fastq.gz
    sample1_R1_L002.fastq.gz   sample1_R2_L002.fastq.gz
    sample2_R1_L001.fastq.gz   sample2_R2_L001.fastq.gz
    sample2_R1_L002.fastq.gz   sample2_R2_L002.fastq.gz
    ```

