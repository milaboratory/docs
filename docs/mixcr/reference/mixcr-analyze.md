# `mixcr analyze`

A single command to execute a complete upstream analysis pipeline from the raw fastq files to clonotype tables. 

![](pics/analyze-light.svg#only-light)
![](pics/analyze-dark.svg#only-dark)

The `analyze` command takes a [preset name](overview-presets.md) as a required argument and runs a sequence of analysis steps defined by the preset. It sets meaningful names for the intermediate and resulting files and saves all the reports along the pipeline in both `txt` and `json` formats (if not set otherwise by command line options). Preset defines specifically optimized parameters for the particular data type for each of the execution analysis steps. A powerful [file name expansion](ref-input-file-name-expansion.md) functionality allows to take and process a batch of raw sequencing files at once on the fly and optionally assign molecular, cell and sample barcodes extracted from the file names. [Sample tables](ref-samples-table.md) allow to analyze several patient samples at once using sample barcodes that may be picked up from all possible sources. MiXCR supports paired-end and single-end [`.fastq`](https://en.wikipedia.org/wiki/FASTQ_format), [`.fasta`](https://en.wikipedia.org/wiki/FASTA_format), [`.bam` and `.sam`](https://en.wikipedia.org/wiki/Binary_Alignment_Map) formats.

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
    
    # mix-ins

    [--add-step <step>] 
    [--remove-step <step>] 
    [--limit-input <n>]
    [--species <species>] 
    [--library <library>] 
    [--split-by-sample]
    [--dont-split-by-sample]
    [--sample-table sample_table.tsv]
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
    [--add-export-clone-table-splitting <(geneLabel|tag):key>]
    [--reset-export-clone-table-splitting] 
    [--add-export-clone-grouping <(geneLabel|tag):key>]
    [--reset-export-clone-grouping]
    [-M <key=value>]...      
    
    # inputs and outputs
    
    <preset_name> 
	([I1.fastq[.gz] [I2.fastq[.gz]]] R1.fastq[.gz] [R2.fastq[.gz]] 
	 | file.(fasta|bam|sam))  
    output_prefix
```

To take and process a batch of input sequencing files at once and optionally assign molecular, cell and sample barcodes extracted from the file names one can use a powerful [file name expansion](ref-input-file-name-expansion.md) functionality. [Sample tables](ref-samples-table.md) allow to analyze several patient samples at once using sample barcodes that may be picked up from all possible sources.

### Analyze-specific command line options:

`<preset_name>`
: Name of the analysis preset (see [complete list of available presets](overview-built-in-presets.md)). This is the only required option to run the analysis.

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


In addition to these parameters, any of the [available mix-in options](overview-mixins-list.md) may be additionally specify at `analyze`.
