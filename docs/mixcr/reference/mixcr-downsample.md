# `mixcr downsample`

Downsample clonesets.

[//]: # (copy of mixcr-postanalysis.md#downsampling)
<figure markdown>
![downsampling](./pics/downsampling.svg)
</figure>

There are three types of downsampling each of which may be applied on a one of three tag levels: `read`, `umi` or `cell`:

`count-<tag>-(auto|min|fixed)[-<number>]`

:   normalizes datasets to the same _tag number_ (either reads, UMIs or cells). The exact downsampling value may be either

    - computed automatically (`auto`)
    - chosen as a value in the smallest sample (`min`)
    - specified explicitly (`fixed`)

    For automatic downsampling MiXCR calculates 20-th quantile across all clonesets _Q20_, and takes the minimal sample which is above _0.5*Q20_.
    
    For memory efficiency, MiXCR uses random multivariate hypergeometric marginals algorithm for downsampling to the same number of reads.
     
    For downsampling to the same number of UMIs or cells, MiXCR uses random uniform sampling of the whole tag list. 

`top-<tag>-<number>`

:   normalizes datasets to the same number of clonotypes. It takes top `<number>` of clonotypes by corresponding `tag` (i.e. top by number of reads, or by number of UMIs or by number of cells)

`cumtop-<tag>-<percent>`

:   normalizes datasets to the same cloneset abundance. It takes top clonotypes by corresponding `tag` (i.e. top by number of reads, or by number of UMIs or by number of cells) so that the top contains the specified `<percent>` of the cloneset abundance (again computed by corresponding `tag`)


## Command line options

```
mixcr downsample 
    --chains <chains>
    --downsampling <type> 
    [--only-productive] 
    [--suffix <s>] 
    [--out <path_prefix>] 
    [--summary <path>] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help]
    cloneset.{clns|clna}...
```

The command returns a highly-compressed, memory- and CPU-efficient binary `.clns` (clones) or `.clna` (clones & alignments) file that holds exhaustive information about clonotypes. Clonotype tables can be further extracted in tabular form using [`exportClones`](./mixcr-export.md#clonotype-tables) or in human-readable form using [`exportClonesPretty`](./mixcr-exportPretty.md#clonotypes).

Basic command line options are:

`cloneset.{clns|clna}...`
: Paths to input files.

`-c, --chains <chains>`
: Specify chains

`--only-productive`
: Filter out-of-frame sequences and sequences with stop-codons.

`--downsampling <type>`
: Choose downsampling. Possible values: `count-[reads|TAG]-[auto|min|fixed][-<number>]`, `top-[reads|TAG]-[<number>]`, `cumtop-[reads|TAG]-[percent]`

`--suffix <s>`
: Suffix to add to output clns file. Default: downsampled

`--out <path_prefix>`
: Output path prefix.

`--summary <path>`
: Write downsampling summary tsv/csv table.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.
