# `mixcr refineTagsAndSort`

Corrects sequencing and PCR errors _inside_ barcode sequences and sorts resulting file by tags. This step does extremely important job by correcting artificial diversity caused by errors in barcodes.

## Command line options

```
> mixcr refineTagsAndSort [-f] \
    [--dont-correct] \
    [--report <report>] \
    [--json-report <jsonReport>] \
    [--power <power>] \
    [--substitution-rate <backgroundSubstitutionRate>] \
    [--indel-rate <backgroundIndelRate>] \
    [--min-quality <minQuality>] \
    [--max-substitutions <maxSubstitutions>] \
    [--max-indels <maxIndels>] \
    [--use-system-temp] \
    [--memory-budget <memoryBudget>] \
    alignments.vdjca \
    alignments.refined.vdjca
```
Command takes input `.vdjca` file produced at [`align`](mixcr-align.md) step and writes the resulting `.vdjca` file with corrected barcode sequences. Additionally, it provides a comprehensive [report](report-refineTagsAndSort.md) with the correction performance.   

`-f, --force-overwrite`
: Force overwrite of output file(s).

`--dont-correct`
: Don't correct barcodes, only sort alignments by tags.

`-r, --report <reportFile>`
: Report file (human readable version, see -j / --json-report for machine readable report)

`-j, --json-report <reportFile>`
: JSON report.

`-p, --power <power>`      
: This parameter determines how thorough the procedure should eliminate variants looking like errors. Smaller value leave less erroneous variants at the cost of accidentally correcting true variants. This value approximates the fraction of erroneous variants the algorithm will miss (type II errors). Default is `1E-3`.

`-s, --substitution-rate <backgroundSubstitutionRate>`
: Expected background non-sequencing-related substitution rate. Default is `1E-3`.

`-i, --indel-rate <backgroundIndelRate>`
: Expected background non-sequencing-related indel rate. Default is `1E-5`.

`-q, --min-quality <minQuality>`
: Minimal [Phred33](https://en.wikipedia.org/wiki/Phred_quality_score) quality score for the tag. Tags having positions with lower quality score will be discarded, if not corrected. Default is `12`.

`--max-substitutions <maxSubstitutions>`
: Maximal number of substitutions to search for. Default is `2`.

`--max-indels <maxIndels>`
: Maximal number of indels to search for. Default is `1`.

`--max-errors <n>`
: Maximal number of substitutions and indels combined to search for.

`--use-local-temp`
: Store temp files in the same folder as output file.

`--memory-budget <memoryBudget>`
: Memory budget. Default is `4294967296` (4Gb).


## Hardware recommendations

Barcode correction step is memory consuming. If barcode correction is enabled the amount of memory required for processing is proportional to the number of unique barcodes. In the extreme case of millions of unique barcodes MiXCR may require up to 32Gb of RAM. If the barcode correction is switched off (with `--dont-correct` option), there are no such memory requirements, since MiXCR offloads sorting to the disk if there is not enough RAM.