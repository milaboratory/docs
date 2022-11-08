# `mixcr analyze`

A single command to execute complete MiXCR analysis pipeline, from raw fastq files to resulting clone-sets (in a tabular and binary formats). Each MiXCR preset, among other parameters, defines a sequence of steps required to analyze the target dataset, `analyze` retrieves this information, and executed all the steps for you, setting meaningful names for the intermediate files and saving all the reports along the pipeline in both `txt` and `json` formats (if not set otherwise by command line options).

??? warning "Starting from MiXCR 4.1 logic of this command was changed completely"

    Previous logic with `mixcr analyze amplicon ...` and `mixcr analyze shotgun ...` was removed in MiXCR 4.1 in favour of the new logic centered around the preset

## Command line options

```
mixcr analyze [--help]

    // analyze-specific options
    
    [--not-aligned-R1 <path.fastq[.gz]>] 
    [--not-aligned-R2 <path.fastq[.gz]>] 
    [--not-parsed-R1 <path.fastq[.gz]>] 
    [--not-parsed-R2 <path.fastq[.gz]>] 
    [--no-reports] 
    [--no-json-reports]  
    [--threads <n>] 
    [--force-overwrite]
    [--add-step <step>] 
    [--remove-step <step>] 

    // mix-ins

    [--limit-input <n>]
    [--species <species>] 
    [--library <library>] 
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
    
    // inputs and outputs
    
    <preset_name> (file_R1.fastq[.gz] file_R2.fastq[.gz]|file_RN.(fastq[.gz]|fasta|bam|sam)) output_prefix
```

### Analyze-specific command line options:

`<preset_name>`
: Name of the analysis preset (see [complete list of available presets](overview-built-in-presets.md)). This is the only required option to run the analysis.

`(file_R1.fastq[.gz] file_R2.fastq[.gz]|file_RN.(fastq[.gz]|fasta|bam|sam))`
: Paths of input files with sequencing data. File name pattern [expansion](./ref-input-file-name-expansion.md) can be used here to merge sequences from multiple sequences or just for convenience.

`output_prefix`
: Path prefix telling mixcr where to put all output files, individual intermediate and resulting files will have suffixes according to the steps they were produced with

`--not-aligned-R1 <path.fastq[.gz]>`
: Pipe not aligned R1 reads into separate file.

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
