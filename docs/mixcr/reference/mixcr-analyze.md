# `mixcr analyze`

A single command to execute complete MiXCR analysis pipeline, from the raw fastq files to resulting clone-sets (in a tabular and binary formats). Each MiXCR preset, among other parameters, defines a sequence of steps required to analyze the target dataset type, `analyze` retrieves this information, and executed all the steps for you, setting meaningful names for the intermediate files and saving all the reports along the pipeline in both `txt` and `json` formats (if not set otherwise by command line options).

??? warning "Starting from MiXCR 4.1 logic of this command was changed completely"

    Previous logic with `mixcr analyze amplicon ...` and `mixcr analyze shotgun ...` was remove in MiXCR 4.1 in favour of the new logic centered around the preset

## Command line options

```
mixcr analyze [--add-step <step>] [--remove-step <step>] 
    [-b <library>] 
    [-s <species>] 
    [--tag-pattern <pattern>] 
    [--limit-input <n>] 
    [--dna] [--rna] 
    [--floating-left-alignment-boundary [<anchor_point>]]
	[--rigid-left-alignment-boundary [<anchor_point>]]
	[--floating-right-alignment-boundary (<gene_type>|<anchor_point>)] 
	[--rigid-right-alignment-boundary [(<gene_type>|<anchor_point>)]] 
	[--split-clones-by <gene_type>]... 
	[--assemble-clonotypes-by <gene_features>]
	[--keep-non-CDR3-alignments] [--drop-non-CDR3-alignments]
	[--dont-split-clones-by <gene_type>]... 
	[--assemble-contigs-by <gene_features>] 
	[--impute-germline-on-export]
	[--dont-impute-germline-on-export]
	[--prepend-export-clones-field <field> [<param>...]]...
	[--append-export-clones-field <field> [<param>...]]...
	[--prepend-export-alignments-field <field> [<param>...]]...
	[--append-export-alignments-field <field> [<param>...]]... 
	[-M <key=value>]... 
	[--no-reports] [--no-json-reports] 
	[-f] [-nw] [--verbose] [-h] 
	<preset_name> input_R1.fastq[.gz] [input_R2.fastq[.gz]] output_prefix
```

### Analyze-specific command line options:

`<preset_name>`
: Name of the analysis preset (see complete list of available presets in the corresponding [section](./overview-presets.md))

`input_R1.fastq[.gz] [input_R2.fastq[.gz]]`
: Paths of input files with sequencing data

`output_prefix`
: Path prefix telling mixcr where to put all output files

`-M  <key=value>`
: Overrides preset parameters

`--no-reports`
: Don't output report files for each of the steps

`--no-json-reports`
: Don't output json report files for each of the steps

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

### Params to change pipeline steps:

`--add-step <step>`
: Add a step to pipeline

`--remove-step <step>`
: Remove a step from pipeline

### Params for align command:

`-b, --library <library>`
: V/D/J/C gene library. By default, the `default` MiXCR reference library is used. One can also use [external libraries](../guides/external-libraries.md)

`-s, --species <species>`
: Species (organism). Possible values: `hsa` (or HomoSapiens), `mmu` (or MusMusculus), `rat`, `spalax`, `alpaca`, `lamaGlama`, `mulatta` (_Macaca Mulatta_), `fascicularis` (_Macaca Fascicularis_) or any species from [IMGT ® library](../guides/external-libraries.md).

`--tag-pattern <pattern>`
: Specify [tag pattern](ref-tag-pattern.md) for barcoded data.

`--limit-input <n>`
: Maximal number of reads to process on [align](./mixcr-align.md).

`--dna`
: ==:fontawesome-solid-puzzle-piece: Material type== <p>
  For DNA starting material. Setups V [gene feature to align](mixcr-align.md#gene-features-to-align) to [`VGeneWithP`](ref-gene-features.md) (full intron) and also instructs MiXCR to skip C gene alignment since it is too far from CDR3 in DNA data.

`--rna`
: ==:fontawesome-solid-puzzle-piece: Material type== <p>
  For RNA starting material; setups [`VTranscriptWithP`](ref-gene-features.md) (full exon) [gene feature to align](mixcr-align.md#gene-features-to-align) for V gene and [`CExon1`](ref-gene-features.md) for C gene.

`--floating-left-alignment-boundary [<anchor_point>]`
: ==:fontawesome-solid-puzzle-piece: Left alignment boundary== <p>
  Configures [aligners](mixcr-align.md#v-j-and-c-aligners-parameters) to use semi-local alignment at reads 5'-end. Typically used with V gene single primer / multiplex protocols, or if there are non-trimmed adapter sequences at 5'-end. Optional [anchor point](ref-gene-features.md) may be specified to instruct MiXCR where the primer is located and strip V [feature to align](mixcr-align.md#gene-features-to-align) accordingly, resulting in a more precise alignments.

`--rigid-left-alignment-boundary [<anchor_point>]`
: ==:fontawesome-solid-puzzle-piece: Left alignment boundary== <p>
  Configures [aligners](mixcr-align.md#v-j-and-c-aligners-parameters) to use global alignment at reads 5'-end. Typically used for 5'RACE with template switch oligo or a like protocols. Optional [anchor point](ref-gene-features.md) may be specified to instruct MiXCR how to strip V [feature to align](mixcr-align.md#gene-features-to-align).

`--floating-right-alignment-boundary (<gene_type>|<anchor_point>)`
: ==:fontawesome-solid-puzzle-piece: Right alignment boundary== <p>
  Configures [aligners](mixcr-align.md#v-j-and-c-aligners-parameters) to use semi-local alignment at reads 3'-end. Typically used with J or C gene single primer / multiplex protocols, or if there are non-trimmed adapter sequences at 3'-end. Requires either gene type (`J` for J primers / `C` for C primers) or [anchor point](ref-gene-features.md) to be specified. In latter case MiXCR will additionally strip [feature to align](mixcr-align.md#gene-features-to-align) accordingly.

`--rigid-right-alignment-boundary [(<gene_type>|<anchor_point>)]`
: ==:fontawesome-solid-puzzle-piece: Right alignment boundary== <p>
  Configures [aligners](mixcr-align.md#v-j-and-c-aligners-parameters) to use global alignment at reads 3'-end. Typically used for J-C intron single primer / multiplex protocols. Optional gene type (`J` for J primers / `C` for C primers) or [anchor point](ref-gene-features.md) may be specified to instruct MiXCR where how to strip J or C [feature to align](mixcr-align.md#gene-features-to-align).

### Params for assemble command:

`--assemble-clonotypes-by <gene_features>`
: Specify [gene features used to assemble clonotypes](mixcr-assemble.md#core-assembler-parameters). One may specify any custom [gene region](ref-gene-features.md) (e.g. `FR3+CDR3`); target clonal sequence can even be disjoint. Note that `assemblingFeatures` must cover CDR3.

`--keep-non-CDR3-alignments`
: ==:fontawesome-solid-puzzle-piece: Debug== <p>
  Preserve alignments that do not cover CDR3 region or cover it only partially in the `.vdjca` file.

`--drop-non-CDR3-alignments`
: ==:fontawesome-solid-puzzle-piece: Debug== <p>
  Drop all alignments that do not cover CDR3 region or cover it only partially.

`--split-clones-by <gene_type>`
: Clones with equal clonal sequence but different gene will not be merged.

`--dont-split-clones-by <gene_type>`
: Clones with equal clonal sequence but different gene will be merged into single clone.

### Params for assembleContigs command:

`--assemble-contigs-by <gene_features>`
: Selects the region of interest for the action. Clones will be separated if inconsistent nucleotides will be detected in the region, assembling procedure will be limited to the region, and only clonotypes that fully cover the region will be outputted, others will be filtered out.

### Params for export commands:

`--impute-germline-on-export`
: Export nucleotide sequences using letters from germline (marked lowercase) for uncovered regions

`--dont-impute-germline-on-export`
: Export nucleotide sequences only from covered region

`--prepend-export-clones-field <field> [<param>...]`
: Add clones export column before other columns. First param is field name as it is in `exportClones` command, left params are params of the field

`--append-export-clones-field <field> [<param>...]`
: Add clones export column after other columns. First param is field name as it is in `exportClones` command, left params are params of the field

`--prepend-export-alignments-field <field> [<param>...]`
: Add clones export column before other columns. First param is field name as it is in `exportAlignments` command, left params are params of the field

`--append-export-alignments-field <field> [<param>...]`
: Add clones export column after other columns. First param is field name as it is in `exportAlignments` command, left params are params of the field

