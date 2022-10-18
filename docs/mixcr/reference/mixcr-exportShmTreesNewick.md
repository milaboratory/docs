# `mixcr exportShmTreesNewick`

Export SHM trees in [NEWICK](https://en.wikipedia.org/wiki/Newick_format) format.

NEWICK will be printed with distances, leafs and nodeId as content.

## Command line options

```
mixcr exportShmTreesNewick 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    trees.shmt outputDir
```

`trees.shmt`
: Input file produced by 'findShmTrees' command.

`outputDir`
: Output directory to write newick files. Separate file for every tree will be created

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.
