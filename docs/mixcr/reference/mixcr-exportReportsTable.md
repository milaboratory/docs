# `mixcr exportReportsTable`

Export all reports from any MiXCR binary file (`.vdjca`, `.clns`, `.clna` and `.shmt`) in tabular form.

```
mixcr exportReportsTable 
    [--with-upstreams] 
    [--preset <preset>] 
    [--preset-file <presetFile>] 
    [--no-header] 
    [<exportField>]...
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    (data.(vdjca|clns|clna|shmt)|directory)... [report.tsv]
```

Command line options:

`(data.(vdjca|clns|clna|shmt)|directory)...`
: Path to input files or directories.  In case of directory no filter by file type will be applied.

`[report.tsv]`
: Path where to write reports. Print in stdout if omitted.

`--with-upstreams`
: Export upstream reports for sources of steps with several inputs, like `findShmTrees`.

`-p, --preset <preset>`
: Specify preset of export fields. Possible values: min, full. By default `full`

`-pf, --preset-file <presetFile>`
: Specify preset file of export fields

`--no-header`
: Don't print first header line, print only data

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.


## Export fields

`-fileName`
: File name as it was specified in command `exportReportsTable`.

`-MiXCRVersion`
: Version of MiXCR.

`-inputFilesAlign`
: Input files on `align` command.

`-totalReads`
: Count of reads in original data.

`-patternMatchedReads`
: Percentage of reads that match pattern.

`-overlapped`
: Percentage of overlapped reads.

`-overlappedAndAligned`
: Percentage of overlapped and aligned reads.

`-alignmentsFailed`
: Percentage of reads that not aligned because of different reasons (columns for each reason).

`-successAligned`
: Percentage of aligned reads.

`-readsWithChain`
: Percentage of reads aligned on specific chain. Will be exported all found chains.

`-inputFileAssemble`
: Input files on `assemble` command.

`-readsClusteredInCorrection`
: Reads pre-clustered due to the similar VJC-lists, percent of used.

`-droppedNoClonalSeq`
: Reads dropped due to the lack of a clone sequence, percent of total.

`-droppedShortSeq`
: Reads dropped due to a too short clonal sequence, percent of total.

`-droppedLowQual`
: Reads dropped due to low quality, percent of total.

`-droppedFailedMapping`
: Reads dropped due to failed mapping, percent of total

`-inputFileAssembleContigs`
: Input files on `assembleContigs` command.

`-totalClonotypes`
: Total clonotypes after `assembleContigs` command if it was run, `assemble` otherwise.

`-readsUsedInClonotypes`
: Reads used in clonotypes after `assembleContigs` command if it was run, `assemble` otherwise.

`-clonesWithChain`
: Percentage of clones aligned on specific chain (`assemble` command). Will be exported all found chains.

`-foundAllelesCount`
: Count of found alleles.

`-foundTreesCount`
: Count of found trees.

`-cloneInTreesCount`
: Count of uniq clones that was included in trees.
