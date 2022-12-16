# `mixcr findShmTrees`

Reconstructs somatic hypermutations trees from cloneset(s).

![](pics/findShmTrees-light.svg#only-light)
![](pics/findShmTrees-dark.svg#only-dark)

All inputs `.clns` files must be fully covered by the same feature, have the same library produced by [`findAlleles`](mixcr-findAlleles.md), the same scoring of V and J genes and the same features to align.

Briefly, lineage reconstruction algorithm groups clones with same V- and J- genes, applies initial clustering inside those groups to find clusters of clones sharing enough number of common mutations and not too distant NDN regions, refining clusters by attaching individual clones, followed by final trees reconstruction and recombination. All steps of the algorithm heavily rely on the alignments with reference segments, compared to many other algorithms for the task, which don't take into account structure of the underlying sequence, and "wild-type" states of the V and J regions, which are exactly known thanks to the allele reconstruction step.

## Command line options

```
mixcr findShmTrees 
   [--v-gene-names <gene_name>]... 
   [--j-gene-names <gene_name>]... 
   [--cdr3-lengths <n>]... 
   [--min-count <n>] 
   [--build-from <path>] 
   [-O <key=value>]... 
   [--report <path>] 
   [--json-report <path>] 
   [--use-local-temp] 
   [--threads <n>] 
   [--force-overwrite] 
   [--no-warnings] 
   [--verbose] 
   [--help] 
   (input_file.clns|directory)... output_file.shmt
```
The command returns a highly-compressed, memory- and CPU-efficient binary `.shmt` (SHM trees) file that holds exhaustive information about SHM trees. SHM trees can be further extracted in tabular form using [`exportShmTrees`](./mixcr-exportShmTrees.md#shm-trees-tables), [`exportShmTreesWithNodes`](./mixcr-exportShmTrees.md#shm-trees-with-nodes-tables) or newick form using [`exportShmTreesNewick`](./mixcr-exportShmTrees.md#newick). Additionally, MiXCR produces a comprehensive [report](./report-findShmTrees.md) which provides a detailed summary of SHM trees search.

Basic command line options are:

`(input_file.clns|directory)...`
: Paths to clns files or to directory with clns files that was processed by 'findAlleles' command.

In case of directory no filter by file type will be applied.

`output_file.shmt`
: Path where to write output trees

`--v-gene-names <gene_name>`
: List of VGene names to filter clones

`--j-gene-names <gene_name>`
: List of JGene names to filter clones

`--cdr3-lengths <n>`
: List of CDR3 nucleotide sequence lengths to filter clones

`--min-count <n>`
: Filter clones with counts great or equal to that parameter

`-bf, --build-from <path>`
: If specified, trees will be build from data in the file. Main logic of command will be omitted. File must be formatted as tsv and have 3 columns: treeId, fileName, cloneId V and J genes will be chosen by majority of clones in a clonal group. CDR3 length must be the same in all clones. treeId - uniq id for clonal group, fileName - file name as was used in command line to search for clone, cloneId - clone id in the specified file

`-O <key=value>`
: Overrides default build SHM parameter values

`-r, --report <path>`
: [Report](./report-findShmTrees.md) file (human readable version, see `-j / --json-report` for machine readable report).

`-j, --json-report <path>`
: JSON formatted [report](./report-findShmTrees.md) file.

`--use-local-temp`
: Put temporary files in the same folder as the output files.

`-t, --threads <n>`
: Processing threads

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.

## Lineage reconstruction algorithm parameters

The following algorithm parameters may be tuned.

`-OtopologyBuilder.topToVoteOnNDNSize=5`
: Count of clones nearest to the root that will be used to determinate borders of NDN region (default `5`).

`-OtopologyBuilder.multiplierForNDNScore=2.5`
: Multiplier of NDN score on calculating distance between clones in a tree (default `2.5`).

`-OtopologyBuilder.penaltyForReversedMutations=10`
: Penalty that will be multiplied by reversed mutations count (default `10`).

`-OtopologyBuilder.countOfNodesToProbe=3`
: Count of the nearest nodes to added that will be proceeded to find optimal insertion (default `3`).

`-Osteps[0].algorithm.commonMutationsCountForClustering=5`
: Min count of common mutations in V and J genes for pair to form edge in cluster (default `5`) 

`-Osteps[0].algorithm.maxNDNDistanceForClustering=1.0`
: Max penalty of NDN mutations per NDN length for pair to form edge in cluster (default `1.0`) 

`-Osteps[1].threshold=0.45`
: Clone will be accepted if distanceFromRoot / changeOfDistanceOnCloneAdd >= `threshold` (default `0.45`) 

`-Osteps[1].maxNDNDistance=1.5`
: Max penalty of NDN mutations per NDN length for pair (default `1.5`) 

`-Osteps[2].maxNDNDistanceBetweenRoots=0.3`
: Trees will be combined if distance between roots will be less than this value (default `0.3`) 
