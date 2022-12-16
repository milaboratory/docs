# `mixcr analyze`

A single command to execute a complete upstream analysis pipeline from the raw fastq files to clonotype tables. 

![](pics/analyze-light.svg#only-light)
![](pics/analyze-dark.svg#only-dark)

The `analyze` command takes a [preset name](overview-presets.md) as a required argument and runs a sequence of analysis steps defined by the preset. It sets meaningful names for the intermediate and resulting files and saves all the reports along the pipeline in both `txt` and `json` formats (if not set otherwise by command line options). Preset defines specifically optimized parameters for the particular data type for each of the execution analysis steps.

MiXCR provides a [comprehensive list](overview-built-in-presets.md) of built-in preset for many of commercially available kits and public protocols.

## Command line options

```
mixcr analyze [--help]

    # analyze-specific options
    
    [--not-aligned-I1 <path.fastq[.gz]>] 
    [--not-aligned-I2 <path.fastq[.gz]>] 
    [--not-aligned-R1 <path.fastq[.gz]>] 
    [--not-aligned-R2 <path.fastq[.gz]>] 
    [--not-parsed-I1 <path.fastq[.gz]>] 
    [--not-parsed-I2 <path.fastq[.gz]>] 
    [--not-parsed-R1 <path.fastq[.gz]>] 
    [--not-parsed-R2 <path.fastq[.gz]>] 
    [--no-reports] 
    [--no-json-reports]  
    [--use-local-temp]
    [--threads <n>] 
    [--force-overwrite]
    [--add-step <step>] 
    [--remove-step <step>] 

    # mix-ins

    [--limit-input <n>]
    [--species <species>] 
    [--library <library>] 
    [--split-by-sample]
    [--dont-split-by-sample]
    [--dna] [--rna] 
    [--floating-left-alignment-boundary [<anchor_point>]]
    [--rigid-left-alignment-boundary [<anchor_point>]]
    [--floating-right-alignment-boundary (<gene_type>|<anchor_point>)] 
    [--rigid-right-alignment-boundary [(<gene_type>|<anchor_point>)]] 
    [--tag-pattern <pattern>] 
    [--keep-non-CDR3-alignments] [--drop-non-CDR3-alignments] 
    [--assemble-clonotypes-by <gene_features>]
    [--split-clones-by <gene_type>]... [--dont-split-clones-by <gene_type>]...  
    [--assemble-contigs-by <gene_features>] 
    [--impute-germline-on-export]
    [--dont-impute-germline-on-export]
    [--prepend-export-clones-field <field> [<param>...]]...
    [--append-export-clones-field <field> [<param>...]]...
    [--prepend-export-alignments-field <field> [<param>...]]...
    [--append-export-alignments-field <field> [<param>...]]... 
    [-M <key=value>]...      
    
    # inputs and outputs
    
    <preset_name> 
    ([file_I1.fastq[.gz] [file_I2.fastq[.gz]]] file_R1.fastq[.gz] [file_R2.fastq[.gz]]|file_RN.(fasta|bam|sam)) 
    output_prefix
```

### Analyze-specific command line options:

`<preset_name>`
: Name of the analysis preset (see [complete list of available presets](overview-built-in-presets.md)). This is the only required option to run the analysis.

`([file_I1.fastq[.gz] [file_I2.fastq[.gz]]] file_R1.fastq[.gz] [file_R2.fastq[.gz]]|file_RN.(fasta|bam|sam))`
: Paths of input files with sequencing data. File name pattern [expansion](./ref-input-file-name-expansion.md) can be used here to merge sequences from multiple sequences or just for convenience.

`output_prefix`
: Path prefix telling mixcr where to put all output files, individual intermediate and resulting files will have suffixes according to the steps they were produced with. If argument ends with file separator, then outputs will be written in specified directory.

`--not-aligned-I1 <path.fastq[.gz]>`
: Pipe not aligned I1 reads into separate file.

`--not-aligned-I2 <path.fastq[.gz]>`
: Pipe not aligned I2 reads into separate file.

`--not-aligned-R1 <path.fastq[.gz]>`
: Pipe not aligned R1 reads into separate file.

`--not-parsed-I1 <path.fastq[.gz]>`
: Pipe not parsed I1 reads into separate file.

`--not-parsed-I2 <path.fastq[.gz]>`
: Pipe not parsed I2 reads into separate file.

`--not-aligned-R2 <path.fastq[.gz]>`
: Pipe not aligned R2 reads into separate file.

`--not-parsed-R1 <path.fastq[.gz]>`
: Pipe not parsed R1 reads into separate file.

`--not-parsed-R2 <path.fastq[.gz]>`
: Pipe not parsed R2 reads into separate file.

`--no-reports`
: Don't output `txt` report files for each of the steps

`--no-json-reports`
: Don't output `json` report files for each of the steps

`--use-local-temp`
: Put temporary files in the same folder as the output files.

`-t, --threads <n>`
: Processing threads

`-f, --force-overwrite`
: Force overwrite of output file(s). Beware, no "smart resume / reanalysis" feature is yet implemented for the new incarnation of `analyze`, with this option `analyze` will just remove all output files and start analysis from scratch.  

`-h, --help`
: Show the help message and exit.

### Params to change pipeline steps:

`--add-step <step>`
: Add a step to pipeline (i.e. `--add-step assembleContigs`)

`--remove-step <step>`
: Remove a step from pipeline (i.e. `--add-step assemblePartial`)


## Concatenating across multiple files

Sometimes it is required to concatenate several fastq files and analyse it as a single sample. This is a common practise when files are separated across sequencing lanes.

MiXCR uses `{{n}}` syntax as a placeholder for any number. Meaning MiXCR will concatenate all files that match the pattern regardless of digits in the place of  `{{n}}`

Bellow you can see an example of how to pass 8 fastq files (four per each paired read) to `mixcr align`:

Example:
```shell
> ls fastq/
    sample1_L001_S25_R1.fastq.gz    sample1_L001_S25_R2.fastq.gz 
    sample1_L002_S25_R1.fastq.gz    sample1_L002_S25_R2.fastq.gz
    sample1_L003_S25_R1.fastq.gz    sample1_L003_S25_R2.fastq.gz
    sample1_L004_S25_R1.fastq.gz    sample1_L004_S25_R2.fastq.gz

> mixcr align -s hsa \
    fastq/sample1_L{{n}}_S25_R1.fastq.gz \
    fastq/sample1_L{{n}}_S25_R2.fastq.gz \
    results/sample1
```

MiXCR uses `{{a}}` syntax which works just like {{n}} but works with any pattern, not just numbers.

Example:

```shell
> ls fastq/
    sample1_nameA1_S25_R1.fastq.gz    sample1_nameA1_S25_R2.fastq.gz
    sample1_nameA_S25_R1.fastq.gz     sample1_nameA_S25_R2.fastq.gz
    sample1_nameC3_S25_R1.fastq.gz    sample1_nameC3_S25_R2.fastq.gz
    sample1_fileD_S25_R1.fastq.gz     sample1_fileD_S25_R2.fastq.gz

> mixcr align -s hsa \
    fastq/sample1_{{n}}_S25_R1.fastq.gz \
    fastq/sample1_{{n}}_S25_R2.fastq.gz \
    results/sample1
```

Finally, MiXCR uses `{{R}}` syntax that marks the reads' number, so you don't have to submit the second read filename.

Bellow is the example of how you can combine multiple MiXCR wildcards and concatenate 16 pairs of files using one pattern.

Example:
```shell
> ls fastq/
    sampleA_primer1_L001_R1.fastq.gz       sampleA_primer1_L001_R2.fastq.gz    
    sampleA_primer1_L002_R1.fastq.gz       sampleA_primer1_L002_R2.fastq.gz    
    sampleA_primer1_L003_R1.fastq.gz       sampleA_primer1_L003_R2.fastq.gz    
    sampleA_primer1_L004_R1.fastq.gz       sampleA_primer1_L004_R2.fastq.gz    
    sampleA_primer2_L001_R1.fastq.gz       sampleA_primer2_L001_R2.fastq.gz
    sampleA_primer2_L002_R1.fastq.gz       sampleA_primer2_L002_R2.fastq.gz
    sampleA_primer2_L003_R1.fastq.gz       sampleA_primer2_L003_R2.fastq.gz
    sampleA_primer2_L004_R1.fastq.gz       sampleA_primer2_L004_R2.fastq.gz
    sampleA_primer3_L001_R1.fastq.gz       sampleA_primer3_L001_R2.fastq.gz
    sampleA_primer3_L002_R1.fastq.gz       sampleA_primer3_L002_R2.fastq.gz
    sampleA_primer3_L003_R1.fastq.gz       sampleA_primer3_L003_R2.fastq.gz
    sampleA_primer3_L004_R1.fastq.gz       sampleA_primer3_L004_R2.fastq.gz
    sampleA_primer4_L001_R1.fastq.gz       sampleA_primer4_L001_R2.fastq.gz
    sampleA_primer4_L002_R1.fastq.gz       sampleA_primer4_L002_R2.fastq.gz
    sampleA_primer4_L003_R1.fastq.gz       sampleA_primer4_L003_R2.fastq.gz
    sampleA_primer4_L004_R1.fastq.gz       sampleA_primer4_L004_R2.fastq.gz
    
> mixcr align -s hsa \
    fastq/sampleA_{{a}}_L{{n}}_{{R}}.fastq.gz
    results/sampleA
```

For details see [this section](/mixcr/reference/ref-input-file-name-expansion).
