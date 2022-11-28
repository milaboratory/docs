# `mixcr exportShmTreesNewick`

Export SHM trees in [NEWICK](https://en.wikipedia.org/wiki/Newick_format) format.

NEWICK will be printed with distances, leafs and nodeId as content.

## Command line options

```
mixcr exportShmTreesNewick 
    [--filter-min-nodes <n>] 
    [--filter-min-height <n>] 
    [--ids <id>[,<id>...]]... 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    [[--filter-in-feature <gene_feature>] [--pattern-max-errors <n>] (--filter-aa-pattern <pattern> | --filter-nt-pattern <pattern>)] 
    trees.shmt outputDir
```

`trees.shmt`
: Input file produced by 'findShmTrees' command.

`outputDir`
: Output directory to write newick files. Separate file for every tree will be created

`--filter-min-nodes <n>`
: Minimal number of nodes in tree

`--filter-min-height <n>`
: Minimal height of the tree

`--ids <id>[,<id>...]`   
: Filter specific trees by id

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

Filter by pattern options:

`--filter-in-feature <gene_feature>`
: Match pattern inside specified gene feature. Default: CDR3

`--pattern-max-errors <n>`
: Max allowed subs & indels. Default: 0

`--filter-aa-pattern <pattern>`
: Filter specific trees by aa pattern.

`--filter-nt-pattern <pattern>`
: Filter specific trees by nt pattern.

