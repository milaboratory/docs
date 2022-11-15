# `mixcr exportClonesOverlap`

Exports overlap table for a given list of clonesets.

```
mixcr exportClonesOverlap 
    [--chains <chain>[,<chain>...]]... 
    [--criteria <s>] 
    [--only-productive] 
    [<exportField>]...
    [--force-overwrite]
    [--no-warnings] 
    [--verbose]
    [--help]
    cloneset.(clns|clna)... output.tsv
```

The resulting tab-delimited `.tsv` table contains:

 - "overlap" columns corresponding to the criteria used for overlap and common for all samples
 - other export columns that are not used in the overlap for each of the sample individually

Since the resulting `.tsv` table may be rather large, MiXCR by default exports only overlap columns and clonotype counts and fractions in each of the samples. One can specify additional columns to export per cloneset using standard MiXCR notation used in [`exportClones`](./mixcr-export.md) command.

Other command line options are: 

`cloneset.(clns|clna)...`
: Paths to input files

`output.tsv`
: Path template where to write output export tables. For each `chain` will be generated table with path `{outputDir}/{outputFileName}.{chain}.tsv`

`--chains <chain>[,<chain>...]`
: Output overlap for specified chains only; if multiple chains are specified, results per each chains will be exported in separate files.

`--criteria <s>`
: Overlap criteria. Defines the rules to treat clones as equal. It allows to specify gene feature for overlap (nucleotide or amino acid), and optionally use V and J hits. Examples: `CDR3|AA|V|J` (overlap by a.a. CDR3 and V and J), `VDJRegion|AA` (overlap by a.a. `VDJRegion`), `CDR3|NT|V` (overlap by nt CDR3 and V). Default: CDR3|AA|V|J

`--only-productive`
: Filter out-of-frame sequences and clonotypes with stop-codons

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

`<exportField>`
: A list of [export fields](./mixcr-export.md#export-fields) for clones.

## Example

Build and export overlap for TRA/TRD chain:
```shell
> mixcr exportClonesOverlap \
  --chains TRAD \
  --only-productive \
  --criteria "CDR3|AA|V|J" \
  clonesets/*.clns
  overlapTable.tsv 
```

The resulting table:

| aaSeqCDR3    | vGene      | jGene     | nSamples | sample1_countAggregated | sample2_countAggregated | ... |
|--------------|------------|-----------|----------|-------------------------|-------------------------|-----|
| CAVRDSNYQLIW | TRAV1-2*00 | TRAJ33*00 | 23       | 12387                   | 0                       | ... |
| CAVKDSNYQLIW | TRAV1-2*00 | TRAJ33*00 | 19       | 12                      | 234                     | ... |
| ...          | ...        | ...       | ...      | ...                     | ...                     | ... |


Here column `nSamples` is number of samples containing the clonotype and 
 columns `samplei_countAggregated` — sum of the counts of all clonotypes in `samplei` with this amino acid sequence, V- and J-gene assignments.
