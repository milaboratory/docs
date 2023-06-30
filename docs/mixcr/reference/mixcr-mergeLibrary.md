# `mixcr mergeLibrary`

Merge list of custom V/D/J/C gene segment libraries into one library. See [how to create custom library](../guides/create-custom-library.md).

## Command line options

```
mixcr buildLibrary 
    [--force-overwrite]
    [--no-warnings]
    [--verbose]
    [--help]
    input.json[.gz]...
    output.json[.gz]
```

Merge multiple library files into single library.

`-f`, `--force-overwrite`
: Force overwrite of output file(s).