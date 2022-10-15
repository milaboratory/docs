# `mixcr findShmTrees`

Build trees of somatic hypermutations (**SHM**) from input clns files.

Input files must be processed by findAlleles.

Briefly, SHM trees search consists of the following steps:

1. Grouping clones with the same V, J and CDR3 length.

   All next steps will be produced on those groups separately.

2. Initial clusterization

   Clones may form edge if they have enough the same mutations in V and J genes and have small distance between NDN segments (gene feature {VEndTrimmed:JBeingTrimmed}).

3. Attach clones

   Try to attach single clones for trees formed by clusters. Clone must be not far from tree trunk (comparing distance from root and change of distance if clone will be added). Clone must not be too far by distance between NDN segment of the clone and a node.

4. Combine trees

   Try to combine trees with similar roots. Roots will be compared by NDN.

## Command line options

```
mixcr findShmTrees [-f] [-nw] 
   [--verbose] 
   [--use-local-temp] 
   [-bf <buildFrom>]
   [--min-count <minCountForClone>] 
   [--cdr3-lengths <CDR3LengthToFilter>]... 
   [--j-gene-names <JGenesToFilter>]... 
   [--v-gene-names <VGenesToFilter>]... 
   [-O <String=String>]...
   [-j <jsonReport>] 
   [-r <reportFile>] 
   [-t <threads>]
   input_file.clns
   [input_file2.clns ....] 
   output_file.shmt
```
The command returns a highly-compressed, memory- and CPU-efficient binary `.shmt` (SHM trees) file that holds exhaustive information about SHM trees. SHM trees can be further extracted in tabular form using [`exportShmTrees`](./mixcr-export.md#shm-trees-tables), [`exportShmTreesWithNodes`](./mixcr-export.md#shm-trees-with-nodes-tables) or newick form using [`exportShmTreesNewick`](./mixcr-exportShmTreesNewick.md). Additionally, MiXCR produces a comprehensive [report](./report-findShmTrees.md) which provides a detailed summary of SHM trees search.

Basic command line options are:

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Show verbose warning messages.

`--use-local-temp`
: Put temporary files in the same folder as the output files.

`[-bf <buildFrom>]`
: If specified, trees will be build from data in the file. Main logic of command will be omitted. File must be formatted as tsv and have 3 columns: treeId, fileName, cloneId. V and J genes will be chosen by majority of clones in a clonal group. CDR3 length must be the same in all clones. treeId - uniq id for clonal group, fileName - file name as was used in command line to search for clone, cloneId - clone id in the specified file.

`[--min-count <minCountForClone>]`
: Filter clones with counts great or equal to that parameter

`[--cdr3-lengths <CDR3LengthToFilter>]...`
: List of CDR3 nucleotide sequence lengths to filter clones

`[--j-gene-names <JGenesToFilter>]...`
: List of JGene names to filter clones

`[--v-gene-names <VGenesToFilter>]...`
: List of VGene names to filter clones

`-r, --report <reportFile>`
: [Report](./report-findShmTrees.md) file (human readable version, see -j / --json-report for machine readable report)

`-j, --json-report <jsonReport>`
: JSON formatted [report](./report-findShmTrees.md) file

`-t, --threads <threads>`
: Specify number of processing threads

`-O  <String=String>` 
: Overrides default find alleles parameter values (see below).

## Find SHM trees parameters

Find SHM tree parameters that may be tuned:

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