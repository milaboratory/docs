# `mixcr exportPreset`

Export a preset file given the preset name and a set of mix-ins

```
mixcr exportPreset 
    [--add-step <step>] 
    [--remove-step <step>] 
    [-s <species>] 
    [-b <library>] 
    [--dna] 
    [--rna] 
    [--floating-left-alignment-boundary [<anchor_point>]] 
    [--rigid-left-alignment-boundary [<anchor_point>]] 
    [--floating-right-alignment-boundary (<gene_type>|<anchor_point>)] 
    [--rigid-right-alignment-boundary [(<gene_type>|<anchor_point>)]] 
    [--tag-pattern <pattern>]
    [--keep-non-CDR3-alignments] 
    [--drop-non-CDR3-alignments] 
    [--limit-input <n>] 
    [--assemble-clonotypes-by <gene_features>] 
    [--split-clones-by <gene_type>]... 
    [--dont-split-clones-by <gene_type>]... 
    [--assemble-contigs-by <gene_features>] 
    [--impute-germline-on-export] 
    [--dont-impute-germline-on-export] 
    [--prepend-export-clones-field <field> [<param>...]]...
    [--append-export-clones-field <field> [<param>...]]... 
    [--prepend-export-alignments-field <field> [<param>...]]... 
    [--append-export-alignments-field <field> [<param>...]]... 
    [-M <key=value>]... 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    preset_name [preset_file.(yaml|yml)]
```

`preset_name`
: Preset name to export.

`[preset_file.(yaml|yml)]`
: Path where to write preset yaml file. Will write to output if omitted.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

In addition to these parameters, any of the [available mix-in options](overview-mixins-list.md) may ve additionally specify at `exportPreset`. 
