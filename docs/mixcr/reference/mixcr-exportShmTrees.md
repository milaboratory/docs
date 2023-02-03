# Export SHM Trees

MiXCR provides functions for export [SHM Trees](#shm-trees-tables), [SHM Trees with all nodes](#shm-trees-with-nodes-tables) in a tab-delimited way. Additionally, SHM trees may be export in [`NEWICK format`](#newick).

`.shmt` produced by [`findShmTrees`](./mixcr-findShmTrees.md) and holds SHM trees and clonotypes that included in trees.

## SHM trees tables

```
mixcr exportShmTrees [-f]
    [--filter-min-nodes <n>] 
    [--filter-min-height <n>] 
    [--ids <id>[,<id>...]]...
    [--chains <chains>] 
    [--preset <preset>]
    [--preset-file <file>]
    [--no-header]
    [--not-covered-as-empty] 
    [<exportField>]...
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    [[--filter-in-feature <gene_feature>] [--pattern-max-errors <n>] (--filter-aa-pattern <pattern> | --filter-nt-pattern <pattern>)] 
    trees.shmt [trees.tsv]
```

Exports tab-delimited info from `.shmt` file for found SHM trees, without information about each node.

Command line options:

`trees.shmt`
: Input file produced by 'findShmTrees' command.

`[trees.tsv]`
: Path to output table. Print in stdout if omitted.

`--filter-min-nodes <n>`
: Minimal number of nodes in tree

`--filter-min-height <n>`
: Minimal height of the tree

`--ids <id>[,<id>...]`
: Filter specific trees by id

`--chains <chains>`
: Export only trees that contains clones with specific chain (e.g. TRA or IGH).

`-p, --preset <preset>`
: Specify preset of export fields (possible values: 'full', 'min'; 'full' by default)

`-pf, --preset-file <presetFile>`
: Specify preset file of export fields

`--no-header`
: Don't print column names

`--not-covered-as-empty`
: Export not covered regions as empty text.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.

`<exportField>`
: A list of [export fields](#export-fields)

Filter by pattern options:

`--filter-in-feature <gene_feature>`
: Match pattern inside specified gene feature. Default: CDR3

`--pattern-max-errors <n>`
: Max allowed subs & indels. Default: 0

`--filter-aa-pattern <pattern>`
: Filter specific trees by aa pattern.

`--filter-nt-pattern <pattern>`
: Filter specific trees by nt pattern.

## SHM trees with nodes tables

```
mixcr exportShmTreesWithNodes [-f]
    [--only-observed] 
    [--filter-min-nodes <n>] 
    [--filter-min-height <n>] 
    [--ids <id>[,<id>...]]... 
    [--chains <chains>] 
    [--preset <preset>] 
    [--preset-file <presetFile>] 
    [--no-header]
    [--not-covered-as-empty]
    [<exportField>]...
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose]  
    [--help] 
    [[--filter-in-feature <gene_feature>] [--pattern-max-errors <n>] (--filter-aa-pattern <pattern> | --filter-nt-pattern <pattern>)] 
    trees.shmt [trees.tsv]
```

Exports tab-delimited info from `.shmt` file for every node of SHM trees.

Command line options:

`trees.shmt`
: Input file produced by 'findShmTrees' command.

`[trees.tsv]`
: Path where to write output export table. Print in stdout if omitted.

`--only-observed`
: Exclude nodes that was reconstructed by algorithm

`--filter-min-nodes <n>`
: Minimal number of nodes in tree

`--filter-min-height <n>`
: Minimal height of the tree

`--ids <id>[,<id>...]`
: Filter specific trees by id

`--chains <chains>`
: Export only trees that contains clones with specific chain (e.g. TRA or IGH).

`-p, --preset <preset>`
: Specify preset of export fields (possible values: 'min', 'full'; 'full' by default)

`-pf, --preset-file <presetFile>`
: Specify preset file of export fields

`--no-header`
: Don't print column names

`--not-covered-as-empty`
: Export not covered regions as empty text.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.

`<exportField>`
: A list of [export fields](#export-fields)

Filter by pattern options:

`--filter-in-feature <gene_feature>`
: Match pattern inside specified gene feature. Default: CDR3

`--pattern-max-errors <n>`
: Max allowed subs & indels. Default: 0

`--filter-aa-pattern <pattern>`
: Filter specific trees by aa pattern.

`--filter-nt-pattern <pattern>`
: Filter specific trees by nt pattern.

## NEWICK

```
mixcr exportShmTreesNewick 
    [--filter-min-nodes <n>] 
    [--filter-min-height <n>] 
    [--ids <id>[,<id>...]]... 
    [--chains <chains>]
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    [[--filter-in-feature <gene_feature>] [--pattern-max-errors <n>] (--filter-aa-pattern <pattern> | --filter-nt-pattern <pattern>)] 
    trees.shmt outputDir
```

Export SHM trees in [NEWICK](https://en.wikipedia.org/wiki/Newick_format) format.

NEWICK will be printed with distances, leafs. As content nodeId will be printed.

Command line options:

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

`--chains <chains>`
: Export only trees that contains clones with specific chain (e.g. TRA or IGH).

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

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

## Examples

For convenience, MiXCR provides two predefined sets of fields for exporting SHM trees: `min` (will export minimal required information about tree or tree nodes) and `full` (used by default); one can use these sets by specifying the `--preset` option:

```shell
> mixcr exportShmTrees --preset min trees.shmt trees.tsv
```

One can add additional columns to the preset in the following way:

```shell
> mixcr exportShmTreesWithNodes --preset min -qFeature CDR2 trees.shmt trees_with_nodes.tsv
```

One can also put all specify export fields in a separate file

```shell
> cat myFields.txt
-vHits
-dHits
-nFeature CDR3
 
> mixcr exportShmTreesWithNodes --preset-file myFields.txt trees.shmt trees_with_nodes.tsv
```

## Export fields

### SHM tree-specific fields

The following fields are available for both `exportShmTrees` and `exportShmTreesWithNodes`:

`-treeId`
: SHM tree id

`-numberOfClonesInTree`
: Number of uniq clones in the SHM tree

`-totalReadsCountInTree`
: Total sum of read counts of clones in the SHM tree

`-totalUniqueTagCountInTree <(Molecule|Cell|Sample)>`
: Total count of unique tags in the SHM tree with specified type

The following fields are only available for `exportShmTrees`:

`-vHit`
: Export best V hit

`-jHit`
: Export best J hit

`-nFeature <gene_feature> <germline|mrca>`
: Export nucleotide sequence of specified gene feature of specified node type.

`-allNFeatures <(germline|mrca)>`
: Export nucleotide sequences for all covered gene features.

`-aaFeature <gene_feature> <germline|mrca>`
: Export amino acid sequence of specified gene feature of specified node type.

`-allAAFeatures <(germline|mrca)>`
: Export nucleotide sequences for all covered gene features.

### SHM tree node-specific fields

The following fields are available only for `exportShmTreesWithNodes`:

`-nodeId`
: Node id in SHM tree

`-isObserved`
: Is node have clones. All other nodes are reconstructed by algorithm

`-parentId`
: Parent node id in SHM tree

`-distance <(germline|mrca|parent)>`
: Distance from another node in number of mutations.

`-fileName`
: Name of clns file with sample

`-nFeature <gene_feature> [<(germline|mrca|parent)>]`
: Export nucleotide sequence of specified gene feature. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-allNFeatures [<(germline|mrca|parent)>]`
: Export nucleotide sequences for all covered gene features. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-aaFeature <gene_feature> [<(germline|mrca|parent)>]`
: Export amino acid sequence of specified gene feature. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-allAAFeatures [<(germline|mrca|parent)>]`
: Export amino acid sequences for all covered gene features. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-lengthOf <gene_feature> [<(germline|mrca|parent)>]`
: Export length of specified gene feature. If second arg is omitted, then feature length will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-allLengthOf [<(germline|mrca|parent)>]`
: Export lengths for all covered gene features. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-nMutations <gene_feature> <(germline|mrca|parent)>`
: Extract nucleotide mutations from specific node for specific gene feature.

`-allNMutations <(germline|mrca|parent)>`
: Extract nucleotide mutations from specific node for all covered gene features.

`-nMutationsRelative <gene_feature> <relative_to_gene_feature> <(germline|mrca|parent)>`
: Extract nucleotide mutations from specific node for specific gene feature relative to another feature.

`-aaMutations <gene_feature> <(germline|mrca|parent)>`
: Extract amino acid mutations from specific node for specific gene feature.

`-allAAMutations <(germline|mrca|parent)>`
: Extract amino acid mutations from specific node for all covered gene features.

`-aaMutationsRelative <gene_feature> <relative_to_gene_feature> <(germline|mrca|parent)>`
: Extract amino acid mutations from specific node for specific gene feature relative to another feature.

`-mutationsDetailed <gene_feature> <(germline|mrca|parent)>`
: Detailed list of nucleotide and corresponding amino acid mutations from specific node. Format `<nt_mutation>:<aa_mutation_individual>:<aa_mutation_cumulative>`, where `<aa_mutation_individual>` is an expected amino acid mutation given no other mutations have occurred, and `<aa_mutation_cumulative>` amino acid mutation is the observed amino acid mutation combining effect from all others.

`-allMutationsDetailed <(germline|mrca|parent)>`
: Detailed list of nucleotide and corresponding amino acid mutations from specific node for all covered gene features.

`-mutationsDetailedRelative <gene_feature> <relative_to_gene_feature> <(germline|mrca|parent)>`
: Detailed list of nucleotide and corresponding amino acid mutations written, positions relative to specified gene feature. Format <nt_mutation>:<aa_mutation_individual>:<aa_mutation_cumulative>, where <aa_mutation_individual> is an expected amino acid mutation given no other mutations have occurred, and <aa_mutation_cumulative> amino acid mutation is the observed amino acid mutation combining effect from all other. WARNING: format may change in following versions.

The following fields are available only for `exportShmTreesWithNodes` on nodes with clones:

`-targets`
: Export number of targets

`-dHit`
: Export best D hit

`-cHit`
: Export best C hit

`-vGene`
: Export best V hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-dGene`
: Export best D hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-jGene`
: Export best J hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-cGene`
: Export best C hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-vFamily`
: Export best V hit family name (e.g. TRBV12 for TRBV12-3*00)

`-dFamily`
: Export best D hit family name (e.g. TRBV12 for TRBV12-3*00)

`-jFamily`
: Export best J hit family name (e.g. TRBV12 for TRBV12-3*00)

`-cFamily`
: Export best C hit family name (e.g. TRBV12 for TRBV12-3*00)

`-vHitScore`
: Export score for best V hit

`-dHitScore`
: Export score for best D hit

`-jHitScore`
: Export score for best J hit

`-cHitScore`
: Export score for best C hit

`-vHitsWithScore`
: Export all V hits with score

`-dHitsWithScore`
: Export all D hits with score

`-jHitsWithScore`
: Export all J hits with score

`-cHitsWithScore`
: Export all C hits with score

`-vHits`
: Export all V hits

`-dHits`
: Export all D hits

`-jHits`
: Export all J hits

`-cHits`
: Export all C hits

`-vGenes`
: Export all V gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-dGenes`
: Export all D gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-jGenes`
: Export all J gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-cGenes`
: Export all C gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-vFamilies`
: Export all V gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-dFamilies`
: Export all D gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-jFamilies`
: Export all J gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-cFamilies`
: Export all C gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-vAlignment`
: Export best V alignment

`-dAlignment`
: Export best D alignment

`-jAlignment`
: Export best J alignment

`-cAlignment`
: Export best C alignment

`-vAlignments`
: Export all V alignments

`-dAlignments`
: Export all D alignments

`-jAlignments`
: Export all J alignments

`-cAlignments`
: Export all C alignments

`-qFeature <gene_feature>`
: Export quality string of specified gene feature

`-nFeatureImputed <gene_feature>`
: Export nucleotide sequence of specified gene feature using letters from germline (marked lowercase) for uncovered regions

`-allNFeaturesImputed [<from_reference_point> <to_reference_point>]`
: Export nucleotide sequence using letters from germline (marked lowercase) for uncovered regions for all gene features between specified reference points (in separate columns).

For example, `-allNFeaturesImputed FR3Begin FR4End` will export `-nFeatureImputed FR3`, `-nFeatureImputed CDR3`, `-nFeatureImputed FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-aaFeatureImputed <gene_feature>`
: Export amino acid sequence of specified gene feature using letters from germline (marked lowercase) for uncovered regions

`-allAAFeaturesImputed [<from_reference_point> <to_reference_point>]`
: Export amino acid sequence using letters from germline (marked lowercase) for uncovered regions for all gene features between specified reference points (in separate columns).

For example, `-allAAFeaturesImputed FR3Begin FR4End` will export `-aaFeatureImputed FR3`, `-aaFeatureImputed CDR3`, `-aaFeatureImputed FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-minFeatureQuality <gene_feature>`
: Export minimal quality of specified gene feature

`-allMinFeaturesQuality [<from_reference_point> <to_reference_point>]`
: Export minimal quality for all gene features between specified reference points (in separate columns).

For example, `-allMinFeaturesQuality FR3Begin FR4End` will export `-minFeatureQuality FR3`, `-minFeatureQuality CDR3`, `-minFeatureQuality FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-allNFeaturesWithMinQuality [<from_reference_point> <to_reference_point>]`
: Export nucleotide sequences and minimal quality for all gene features between specified reference points (in separate columns).

For example, `-allNFeaturesWithMinQuality FR3Begin FR4End` will export `-nFeature FR3`, `-minFeatureQuality FR3`, `-nFeature CDR3`, `-minFeatureQuality CDR3`, `-nFeature FR4`, `-minFeatureQuality FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-allNFeaturesImputedWithMinQuality [<from_reference_point> <to_reference_point>]`
: Export nucleotide sequences and minimal quality for all gene features between specified reference points (in separate columns).

For example, `-allNFeaturesImputedWithMinQuality FR3Begin FR4End` will export `-nFeatureImputed FR3`, `-minFeatureQuality FR3`, `-nFeatureImputed CDR3`, `-minFeatureQuality CDR3`, `-nFeatureImputed FR4`, `-minFeatureQuality FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-avrgFeatureQuality <gene_feature>`
: Export average quality of specified gene feature

`-allAvrgFeaturesQuality [<from_reference_point> <to_reference_point>]`
: Export average quality for all gene features between specified reference points (in separate columns).

For example, `-allAvrgFeaturesQuality FR3Begin FR4End` will export `-avrgFeatureQuality FR3`, `-avrgFeatureQuality CDR3`, `-avrgFeatureQuality FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-positionInReferenceOf <reference_point>`
: Export position of specified reference point inside reference sequences (clonal sequence / read sequence).

`-allPositionsInReference [<from_reference_point> <to_reference_point>]`
: Export position inside reference sequences (clonal sequence / read sequence) for all reference points between specified (in separate columns).

For example, `-allPositionsInReference FR3Begin FR4End` will export `-positionInReferenceOf FR3Begin`, -positionInReferenceOf CDR3Begin`, -positionInReferenceOf CDR3End` and `-positionInReferenceOf FR4End`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-positionOf <reference_point>`
: Export position of specified reference point inside target sequences (clonal sequence / read sequence).

`-allPositions [<from_reference_point> <to_reference_point>]`
: Export position inside target sequences (clonal sequence / read sequence) for all reference points between specified (in separate columns).

For example, `-allPositions FR3Begin FR4End` will export `-positionOf FR3Begin`, -positionOf CDR3Begin`, -positionOf CDR3End` and `-positionOf FR4End`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-defaultAnchorPoints`
: Outputs a list of default reference points (like CDR2Begin, FR4End, etc. see documentation bellow
for the full list and formatting)

`-cloneId`
: Unique clone identifier

`-readCount`
: Number of reads assigned to the clonotype

`-readFraction`
: Fraction of reads assigned to the clonotype

`-targetSequences`
: Export aligned sequences (targets), separated with comma

`-targetQualities`
: Export aligned sequence (target) qualities, separated with comma

`-vIdentityPercents`
: V alignment identity percents

`-dIdentityPercents`
: D alignment identity percents

`-jIdentityPercents`
: J alignment identity percents

`-cIdentityPercents`
: C alignment identity percents

`-vBestIdentityPercent`
: V best alignment identity percent

`-dBestIdentityPercent`
: D best alignment identity percent

`-jBestIdentityPercent`
: J best alignment identity percent

`-cBestIdentityPercent`
: C best alignment identity percent

`-chains`
: Chains

`-topChains`
: Top chains

`-geneLabel <label>`
: Export gene label (i.e. ReliableChain)

`-tagCounts`
: All tags with counts

`-tags <(Molecule|Cell|Sample)>`
: All tags values (i.e. CELL barcode or UMI sequence).

`-uniqueTagCount <(Molecule|Cell|Sample)>`
: Unique tag count

Tag type will be used for filtering tags for export.

`-uniqueTagFraction <(Molecule|Cell|Sample)>`
: Fraction of unique tags (UMI, CELL, etc.) the clone or alignment collected.

Tag type will be used for filtering tags for export.

`-cellGroup`
: Cell group (for single cell analysis)

