# `mixcr exportReports`

Export all reports from any MiXCR binary file (`.vdjca`, `.clns`, `.clna` and `.shmt`).

```
mixcr exportReports 
    [--step <step>] 
    [--yaml | --json] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    data.(vdjca|clns|clna|shmt) [report.(txt|json|yaml)]
```

Command line options:

`data.(vdjca|clns|clna|shmt)`
: Path to input file.

`[report.(txt|json|yaml)]`
: Path where to write reports. Print in stdout if omitted.

`--yaml`
: Export as yaml

`--json`
: Export as json

`--step <step>`
: Export report only for a specific step

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

If the output file is not specified then MiXCR will print to a standard output. 

Example:
```shell
> mixcr exportReports SRR18293077.clns
```
```
============== Align Report ==============
Analysis time: 0ns
Total sequencing reads: 2822242
Successfully aligned reads: 2268488 (80.38%)
Paired-end alignment conflicts eliminated: 347051 (12.3%)
Alignment failed, no hits (not TCR/IG?): 157004 (5.56%)
Alignment failed because of absence of V hits: 664 (0.02%)
Alignment failed because of absence of J hits: 249090 (8.83%)
No target with both V and J alignments: 146985 (5.21%)
Alignment failed because of low total score: 11 (0%)
Overlapped: 1925221 (68.22%)
Overlapped and aligned: 1707873 (60.51%)
Alignment-aided overlaps: 34224 (2%)
Overlapped and not aligned: 217348 (7.7%)
No CDR3 parts alignments, percent of successfully aligned: 1980 (0.09%)
Partial aligned reads, percent of successfully aligned: 83299 (3.67%)
V gene chimeras: 28914 (1.02%)
J gene chimeras: 2 (0%)
IGH chains: 2268488 (100%)
Realigned with forced non-floating bound: 1862490 (65.99%)
Realigned with forced non-floating right bound in left read: 223659 (7.92%)
Realigned with forced non-floating left bound in right read: 223659 (7.92%)
============== Assemble Report ==============
Analysis time: 0ns
Final clonotype count: 2267
Average number of reads per clonotype: 679.8
Reads used in clonotypes, percent of total: 1541099 (54.61%)
Reads used in clonotypes before clustering, percent of total: 1721089 (60.98%)
Number of reads used as a core, percent of used: 1616095 (93.9%)
Mapped low quality reads, percent of used: 104994 (6.1%)
Reads clustered in PCR error correction, percent of used: 179990 (10.46%)
Reads pre-clustered due to the similar VJC-lists, percent of used: 0 (0%)
Reads dropped due to the lack of a clone sequence, percent of total: 1 (0%)
Reads dropped due to low quality, percent of total: 0 (0%)
Reads dropped due to failed mapping, percent of total: 191224 (6.78%)
Reads dropped with low quality clones, percent of total: 0 (0%)
Clonotypes eliminated by PCR error correction: 5373
Clonotypes dropped as low quality: 0
Clonotypes pre-clustered due to the similar VJC-lists: 0
Clonotypes dropped in fine filtering: 0
Partially aligned reads attached to clones by tags: 0 (0%)
Partially aligned reads with ambiguous clone attachments by tags: 0 (0%)
Partially aligned reads failed to attach to clones by tags: 0 (0%)
IGH chains: 2267 (100%)
============== AssembleContigs Report ==============
Analysis time: 0ns
Initial clonotype count: 2267
Final clonotype count: 3946 (174.06%)
Canceled assemblies: 0 (0%)
Number of premature termination assembly events, percent of number of initial clonotypes: 3.0 (0.13%)
Longest contig length: 657
Clustered variants: 258 (6.14%)
Reads in clustered variants: 62599.800854822184 (4.06%)
Reads in divided (newly created) clones: 980085.3968117408 (63.6%)
Clones with ambiguous letters in splitting region: 482 (12.21%)
Reads in clones with ambiguous letters in splitting region: 132203.66869592396 (8.58%)
Average number of ambiguous letters per clone with ambiguous letters in splitting region: 5.304979253112033
```
