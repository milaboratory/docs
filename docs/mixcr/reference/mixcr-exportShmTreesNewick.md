# `mixcr exportShmTreesNewick`

Export SHM trees in [NEWICK](https://en.wikipedia.org/wiki/Newick_format) format.

NEWICK will be printed with distances, leafs and nodeId as content.

## Command line options

```
mixcr exportShmTreesNewick [-f] [-nw] [--verbose] 
    trees.shmt 
    outputDir
```

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Show verbose warning messages.

`trees.shmt`
: Input file produced by findShmTrees.

`outputDir`
: Output directory to write newick files. Separate file for every tree will be created.

