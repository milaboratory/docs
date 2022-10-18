# `mixcr refineTagsAndSort`

Corrects sequencing and PCR errors _inside_ barcode sequences and sorts resulting file by tags. This step does extremely important job by correcting artificial diversity caused by errors in barcodes.

![](pics/refineAndSortTags-light.svg#only-light)
![](pics/refineAndSortTags-dark.svg#only-dark)

## Command line options

```
mixcr refineTagsAndSort 
    [--dont-correct] 
    [--power <d>] 
    [--substitution-rate <d>] 
    [--indel-rate <d>] 
    [--min-quality <n>] 
    [--max-substitutions <n>] 
    [--max-indels <n>] 
    [--max-errors <n>] 
    [--whitelist <tag=value>]... 
    [--memory-budget <n>] 
    [--report <path>] 
    [--json-report <path>] 
    [--use-local-temp] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help]
    alignments.vdjca alignments.corrected.vdjca
```
Command takes input `.vdjca` file produced at [`align`](./mixcr-align.md) step and writes the resulting `.vdjca` file with corrected barcode sequences. Additionally, it provides a comprehensive [report](./report-refineTagsAndSort.md) with the correction performance.   

Basic command line options are:

`alignments.vdjca`
: Path to input alignments

`alignments.corrected.vdjca`
: Path where to write corrected alignments

`--dont-correct`
: Don't correct barcodes, only sort alignments by tags. Default value determined by the preset.

`-p, --power <d>`
: This parameter determines how thorough the procedure should eliminate variants looking like errors. Smaller value leave less erroneous variants at the cost of accidentally correcting true variants. This value approximates the fraction of erroneous variants the algorithm will miss (type II errors). Default value determined by the preset.

`-s, --substitution-rate <d>`
: Expected background non-sequencing-related substitution rate. Default value determined by the preset.

`-i, --indel-rate <d>`
: Expected background non-sequencing-related indel rate. Default value determined by the preset.

`-q, --min-quality <n>`
: Minimal [Phred33](https://en.wikipedia.org/wiki/Phred_quality_score) quality score for the tag. Tags having positions with lower quality score will be discarded, if not corrected. Default value determined by the preset.

`--max-substitutions <n>`
: Maximal number of substitutions to search for. Default value determined by the preset.

`--max-indels <n>`
: Maximal number of indels to search for. Default value determined by the preset.

`--max-errors <n>`
: Maximal number of substitutions and indels combined to search for. Default value determined by the preset.

`-w, --whitelist <tag=value>`
: Use whitelist-driven correction for one of the tags.

Usage: --whitelist CELL=preset:737K-august-2016 or -w UMI=file: my_umi_whitelist.txt.

If not specified mixcr will set correct whitelists if --tag-preset was used on align step.

Default value determined by the preset.

`--memory-budget <n>`
: Memory budget in bytes. Default: 4Gb

`-r, --report <path>`
: [Report](./report-refineTagsAndSort.md) file (human readable version, see `-j / --json-report` for machine readable report).

`-j, --json-report <path>`
: JSON formatted [report](./report-refineTagsAndSort.md) file.

`--use-local-temp`
: Store temp files in the same folder as output file.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

## Hardware recommendations

Barcode correction step is memory consuming. If barcode correction is enabled the amount of memory required for processing is proportional to the number of unique barcodes. In the extreme case of millions of unique barcodes MiXCR may require up to 32Gb of RAM. If the barcode correction is switched off (with `--dont-correct` option), there are no such memory requirements, since MiXCR offloads sorting to the disk if there is not enough RAM.
