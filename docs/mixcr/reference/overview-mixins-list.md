# Mix-in options list

MiXCR provides a set of mix-in options allowing to configure analysis pipeline using high-level primitives.


### Alignment mix-in options

The following mix-in options configure [`align`](mixcr-align.md) step. 

`--species`
: ==:fontawesome-solid-puzzle-piece: Species== <p>
Species (organism), as specified in library file or taxon id.

Possible values: hs, HomoSapiens, musmusculus, mmu, hsa, 9606, 10090 etc.

`--library`
: Specify reference V-, D-, J-, C- gene segment library. 

`--split-by-sample`
: Split output alignments files by sample.

`--dont-split-by-sample`
: Don't split output alignments files by sample.

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

`--tag-pattern`
: ==:fontawesome-solid-puzzle-piece: Tag pattern== <p>
Specify [tag pattern](ref-tag-pattern.md) for barcoded data.

`--keep-non-CDR3-alignments`
: ==:fontawesome-solid-puzzle-piece: Debug== <p>
Preserve alignments that do not cover CDR3 region or cover it only partially in the `.vdjca` file.

`--drop-non-CDR3-alignments`
: ==:fontawesome-solid-puzzle-piece: Debug== <p>
Drop all alignments that do not cover CDR3 region or cover it only partially.

`--limit-input`
: ==:fontawesome-solid-puzzle-piece: Debug== <p>
  Maximal number of reads to process.


### Clonotype assembly mix-in options

The following mix-in options configure [`assemble`](mixcr-assemble.md) step.

`--assemble-clonotypes-by <gene_features>`
: Specify [gene features used to assemble clonotypes](mixcr-assemble.md#core-assembler-parameters). One may specify any custom [gene region](ref-gene-features.md) (e.g. `FR3+CDR3`); target clonal sequence can even be disjoint. Note that `assemblingFeatures` must cover CDR3.

`--split-clones-by <gene_type>`
: Clones with equal clonal sequence but different gene will not be merged.

`--dont-split-clones-by <gene_type>`
: Clones with equal clonal sequence but different gene will be merged into single clone.

### Contig assembly mix-in options

The following mix-in options configure [`assembleContigs`](mixcr-assembleContigs.md) step.

`--assemble-contigs-by <gene_features>`
: Selects the region of interest for the action. Clones will be separated if inconsistent nucleotides will be detected in the region, assembling procedure will be limited to the region, and only clonotypes that fully cover the region will be outputted, others will be filtered out.

### Export mix-in options

The following mix-in options configure clonotype [`export`](mixcr-export.md) step.

`--impute-germline-on-export`
: Export nucleotide sequences using letters from germline (marked lowercase) for uncovered regions.

`--dont-impute-germline-on-export`
: Export nucleotide sequences only from covered region.

`--prepend-export-clones-field <field> [<param>...]`
: Add clones export column before other columns. First param is field name as it is in `exportClones` command, left params are params of the field

`--append-export-clones-field <field> [<param>...]`
: Add clones export column after other columns. First param is field name as it is in `exportClones` command, left params are params of the field

`--prepend-export-alignments-field <field> [<param>...]`
: Add clones export column before other columns. First param is field name as it is in `exportAlignments` command, left params are params of the field

`--append-export-alignments-field <field> [<param>...]`
: Add clones export column after other columns. First param is field name as it is in `exportAlignments` command, left params are params of the field

### Pipeline configuration mix-ins

The following mix-in options configure general pipeline execution.

`--add-step <step_name>`
: Add execution step. 

`--remove-step <step_name>`
: Remove execution step.
