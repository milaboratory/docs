# `mixcr groupClones`

Groups clones in .clna/.clns files by Cell tags. Grouped clones can be exported using [`mixcr exportCloneGroups`](./mixcr-export.md#clone-groups-by-cell). Each group represents a reliable set of clones (chains) present in all cells within the group. Some clones cannot be assigned to any group and will be labeled as `undefined`. Additionally, some clones may be labeled as `contamination` if they are evenly spread across multiple different cell groups. See the detailed explanation below.


```
mixcr groupClones 
    [-O <key=value>]
    [--report <path>] 
    [--json-report <path>] 
    [--use-local-temp]
    [--force-overwrite]
    [--no-warnings]
    [--verbose]
    [--help] 
    clones.(clns|clna) 
    grouped.(clns|clna)
```

`clones.(clns|clna)`
: Path to input file.

`grouped.(clns|clna)`
: Path where to write output. Will have the same file type.

`-r, --report <path>`
: Report file (human-readable version, see `-j / --json-report` for machine readable report).

`-j, --json-report <path>`
: JSON formatted report file.

`--use-local-temp`
: Put temporary files in the same folder as the output files.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.

`-O  <key=value>`
: Overrides for the clone grouping parameters.


This function looks at how a set of clones in one cell corresponds to the set of clones across other cells. Note, that it does not rely on the read/umi count of the clone, as abundance filters have been already applied during barcodes correction and clonotype assemble.

The process begins with a clone that has the highest count of **cells** associated with it. The algorithm then attempts to find all clones that can be connected to this base clone through cell IDs and form a group. To include a connected clone in a group, two conditions must be satisfied:

    - The cells IDs of the base clone should overlap with those of the connected clone by at least 80%.
    - The original cell IDs (before calculations) of the connected clone should overlap with the cell IDs of the base clone by at least 20%.

If there are no connected clones, or if all connected clones meet the first requirement but not the second, a group consisting solely of the base clone is formed. This approach addresses situations where only one chain was expressed, and all cells are contaminated.

Cell IDs excluded during the intersection should be saved for future rounds of calculation, as a single clone can be part of several groups. The process is repeated for each clone. The threshold for guaranteed overlap should be sufficient to filter out cross-contamination by clones represented randomly in many cells.

Therefore, grouping results from merging similar cells into a group, and the crucial aspect is the clonotype content of the cells rather than the read count. `Undefined` means there was not enough information across the dataset to assign a certain clone to a group. This might still be a valid cell or perhaps two cells in one well, but we can't really tell for sure. There is also a possible `Contamination` value, that indicates that more than 80% of the cells in which this clone has been found have already been assigned to other groups with different sets of clones, suggesting random contamination of different cells.

Example:

Imagine we have a few cells

| Number of cells | Set of clones |
|-----------------|---------------|
| 10              | a, b, c       |
| 5               | d, g          |
| 5               | e, f          |
| 1               | a, c, d, e    |

Clones `a`, `b`, and `c` will be assigned to group 1 because we have 10 cells with this set of clones. Clones `d` and `g` will be assigned to group 2, and clones `e` and `f` to group 3. However, for the last cell, we can't assign a and c to group 1 because group 1 does not include clones `d` and `e`. Additionally, clone 'd' has only been observed in a set with 'g', and clone 'e' only with 'f'. Therefore, all four clones from this last cell can't be assigned to any group and will be labeled as `Undefined`. It could be that this cell is a doublet of two cells: 'a', 'c' and 'd', 'e', or maybe 'a', 'e' and 'd', 'c', etc., but we can't be sure. In this example we describe the logic behind the algorithm, the actual thresholds described above may not be met here.

