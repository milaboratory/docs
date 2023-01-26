# Export a preset file given the preset name or source file and a set of mix-ins

This command can help to understand structure of [preset](overview-built-in-presets.md) or compare [presets](overview-built-in-presets.md).

Exported file may be a starting point for writing custom preset. 

## Command line options
```
mixcr exportPreset
    (--preset-name <preset> | --mixcr-file <input.(vdjca|clns|clna)>) 
    [--no-validation] 
    
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    
    # mix-ins
    [--add-step <step>] 
    [--remove-step <step>] 
    [-s <species>] 
    [-b <library>] 
    [--split-by-sample] 
    [--dont-split-by-sample] 
    [--sample-table sample_table.tsv] 
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
    [--add-export-clone-table-splitting <(geneLabel|tag):key>]
    [--reset-export-clone-table-splitting] 
    [--add-export-clone-grouping <(geneLabel|tag):key>] 
    [--reset-export-clone-grouping] 
    [-M <key=value>]... 

    # output
    [preset_file.(yaml|yml)]
```

`[preset_file.(yaml|yml)]`
: Path where to write preset yaml file. Will write to output if omitted.

`--preset-name <preset>`
: Preset name to export (see [complete list of available presets](overview-built-in-presets.md)).

`--mixcr-file <input.(vdjca|clns|clna)>`
: File that was processed by MiXCR.

`--no-validation`
: Don't validate preset before export.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.


In addition to these parameters, any of the [available mix-in options](overview-mixins-list.md) may be additionally specify at `exportPreset`. 

## Examples

```shell
> mixcr exportPreset --mixcr-file result.vdjca preset.yaml
```

Result is preset file used to process `result.vdjca`. The same may be applied to `*.clns` or `*.clna` files.

```shell
> mixcr exportPreset --preset-name 10x-vdj-bcr preset.yaml
```

Result is preset file of `10x-vdj-bcr` preset.

```shell
> mixcr exportPreset --preset-name generic-tcr-amplicon \ 
    --species hs \
    --dna \
    --floating-left-alignment-boundary \
    --floating-right-alignment-boundary J \
    preset.yaml
```

Result is `generic-tcr-amplicon` preset with all required mixins set.

```shell
> mixcr exportPreset --preset-name generic-tcr-amplicon \
    --no-validation \
    preset.yaml
```

Result is `generic-tcr-amplicon` preset without some required mixins. Useful for comparing presets or writing custom preset.

```shell
> diff \
    <(mixcr exportPreset --preset-name 10x-vdj-bcr) \
    <(mixcr exportPreset --preset-name 10x-vdj-tcr)
```

Comparing two presets between each other. Alternatively, one can export them in separate files and use some other tool for comparison.


