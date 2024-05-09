# `mixcr findAlleles`

By default, all build-it MiXCR reference libraries have a single *00 allele for each gene (e.g. IGHV7-4-1*00,  IGHV3-47*00
etc.). Because it is quite complicated to distinguish a true allelic variant from sample preparation errors or hypermutations (for B cells),including those in hot spot positions, MiXCR uses a dedicated algorithm that looks at the presence of certain gene sequence across multiple different clones from the same organism to validate allelic variants with sufficient statistical significance. `mixcr findAlleles` finds V- and J-gene allelic variants in a given sample(s), creates a new [repseq.io](ref-repseqio-json-format.md) reference library and re-aligns clonotypes against it, inferring alleles in place of original *00. 

![](pics/findAlleles-light.svg#only-light)
![](pics/findAlleles-dark.svg#only-dark)

Clonotypes passed as input must be assembled by the same [gene feature](mixcr-assemble.md#core-assembler-parameters). So, for example `.clns` files with [contigs](overview-analysis-overview.md#contig-assemblymixcr-assemblecontigsmd), must be assembled using [`assembleContigs`](mixcr-assembleContigs.md) with `--assemble-contigs-by` option. All input '.clns' files must have been generated using the same initial reference library, with the same scoring of V and J genes and the same features to align.

Note, that allelic inference requires presence of a substantial amount of clones for a given V/J gene to return a statistically significant result. If the information from the data was not enough to determine an allele for a certain gene, this gene will retain original *00 allele number.

## Command line options

```
mixcr findAlleles 
   (--output-template <template.clns> | --no-clns-output) 
   [--export-library <path.(json|fasta)>] 
   [--export-alleles-mutations <path>] 
   [-O <key=value>]... 
   [--report <path>] 
   [--json-report <path>] 
   [--use-local-temp] 
   [--threads <n>] 
   [--force-overwrite] 
   [--no-warnings] 
   [--verbose] 
   [--help] 
   (input_file.(clns|clna)|directory)...
```

The command returns a highly-compressed, memory- and CPU-efficient binary `.clns` (clones) file that holds exhaustive information about clonotypes re-aligned to novelly discovered allelic variants. The resulting [reference library](ref-repseqio-json-format.md) is built-in in the `.clns` file but also may be exported directly with `--export-library` option. Clonotype tables can be further extracted in tabular form using [`exportClones`](./mixcr-export.md#clonotype-tables) or in human-readable form using [`exportClonesPretty`](./mixcr-exportPretty.md#clonotypes). Additionally, MiXCR produces a comprehensive [report](./report-findAlleles.md) which provides a detailed summary of allele search.

Basic command line options are:

`(input_file.(clns|clna)|directory)`
: Input files or directory with files for allele search. 

In case of directory no filter by file type will be applied.

`--output-template <template.clns>`
: Output template may contain {file_name} and {file_dir_path},

outputs for '-o /output/folder/{file_name}_with_alleles.clns input_file.clns input_file2.clns' will be /output/folder/input_file_with_alleles.clns and /output/folder/input_file2_with_alleles.clns,

outputs for '-o {file_dir_path}/{file_name}_with_alleles.clns /some/folder1/input_file.clns /some/folder2/input_file2.clns' will be /seme/folder1/input_file_with_alleles.clns and /some/folder2/input_file2_with_alleles.clns

Resulted outputs must be uniq

`--no-clns-output`
: Command will not realign input clns files. Must be specified if `--output-template` is omitted.

`--export-library <path.(json|fasta)>`
: Paths where to write library with found alleles and other genes that exits in inputs.

For `.json` library will be written in reqpseqio format.

For `.fasta` library will be written in FASTA format with gene name and reliable range in description. There will be several records for one gene if clnx were assembled by composite gene feature.

`--export-alleles-mutations <path>`
: Path to write descriptions and stats (see [below](#allelic-variants-summary-table)) for all result alleles, existed and new (see below).

`-O  <key=value>`
: Overrides default build SHM parameter values

`-r, --report <path>`
: [Report](./report-findAlleles.md) file (human-readable version, see `-j / --json-report` for machine-readable report).

`-j, --json-report <path>`
: JSON formatted [report](./report-findAlleles.md) file.

`--use-local-temp`
: Put temporary files in the same folder as the output files.

`-t, --threads <n>`
: Processing threads

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--dont-remove-unused-genes`
: do not remove genes that were not found in the sample(s) from the new library.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.

`-r, --report <reportFile>`
: [Report](./report-findAlleles.md) file (human readable version, see -j / --json-report for machine readable report)

`-j, --json-report <jsonReport>`
: JSON formatted [report](./report-findAlleles.md) file

`-t, --threads <threads>`
: Specify number of processing threads

`-O  <String=String>` 
: Overrides default find alleles parameter values (see below).


Example:
```shell
mixcr findAlleles \
    --output-template {file_name}.allelic.clns \
    --output-library alleles.repseqio.json \
    --export-alleles-mutations allele_stats.tsv \
    donor1_t1.clns donor1_t2.clns donor1_t3.clns
```

## Allelic variants summary table

Summary table produced with `--export-alleles-mutations` contain the following columns:

`alleleName`
: allele name in a resulting library; for novel allelic variants will contain count of mutations from known allele and number of mutations in CDR3. Some alleles will still have *00 due to the lack of data for statistical significant identification.

`geneName`
: gene name; the same for heterozygous

`type`
: `Variable` or `Joining` gene segment.

`status`
: `DE_NOVO` - new allelic variant aligned to the known one with mismatches
  `FOUND_KNOWN_VARIANT` - known allele from the database
  `ALIGNED_ON_KNOWN_VARIANT` - not enough info to search all present alleles. But the one found is a known variant from the library
  `NOT_CHANGED_AFTER_SEARCH` - the allele was originally identified correctly
  `COULD_NOT_BE_ALIGNED_ON_KNOWN_VARIANT` - the search was done, but there was not enough info to identify the allele correctly
  `NO_CLONES_TO_SEARCH` - not enough clones to perform the search
  `REMOVED_BECAUSE_NO_TOP_HITS_IN_RESULT_FILES` - there is no clone where this gene is the top hit
  `REMOVED_BECAUSE_NOT_REPRESENTED_IN_SOURCE_FILES` - this gene was not present in the original data

`enoughInfo`
: `true` or `false` value states if there was enough info to infer an allele.

`reliableRegion`
: gene features inside which allele was found (including CDR3 part that was used for search)

`mutations`
: allele mutations from known other allelic variant

`varianceOf`
: refers to the identifier of a known allelic variant from which the current variant has mutated.

`naivesCount`
: count of clones with no hypermutations in V and J

`lowerDiversityBound`
: lower bound of diversity of clones. The number of combinations of a J for V gene( and V for gene) with different CDR3 length.

`clonesCount`
: clones count that was aligned to this allele

`totalClonesCountForGene`
: total clones count of this allele and its zygotes (the same `geneName`). Before realignment.

`clonesCountWithNegativeScoreChange`
: count of clones that align better on original library than on build one

`filteredForAlleleSearchNaivesCount`
: counts of clones with no mutations in V and J after `useClonesWithCountGreaterThen` filter.

`filteredForAlleleSearchClonesCount`
: counts of clones after `useClonesWithCountGreaterThen` filter

`filteredForAlleleSearchClonesCountWithNegativeScoreChange`
: count of clones that align better on original library than on build one after `useClonesWithCountGreaterThen` filter

`scoreDelta`
: stats of score change of clones after realignment (size, sum, min, max, avg, quadraticMean, stdDeviation)


## Allele inference algorithm parameters

Below one can find parameters of inference algorithms that may be tuned.

`-OfilterForDataWithUmi.useClonesWithCountGreaterThen=0`
: If data has UMI tag then search alleles only by clones with count greater or equal to value (default `0`).

`-OfilterForDataWithoutUmi.useClonesWithCountGreaterThen=1`
: If data has no UMI tag then search alleles only by clones with count greater or equal to value (default `1`).

`-OsearchAlleleParameter.topByDiversity=0.25`
: Percentage to get top of alleles by **lower bound of diversity** (default `0.25`).

`-OsearchAlleleParameter.minRelativePenaltyBetweenAllelesForCloneAlign=0.15`
: On decision about clone matching to allele will check relation between score penalties between the best and the next alleles (default `0.15`).

`-OsearchAlleleParameter.diversityRatioToSearchCommonMutationsInAnAllele=0.95`
: After an allele is found, it will be enriched with mutations that exists in this portion of clones that aligned on the allele (default `0.95`).

`-OsearchAlleleParameter.minCountOfNaiveClonesToAddAllele=2`
: Alleles will be filtered by min count of clones that are **naive by complementary gene** (default `2`).

`-OdiversityThresholds.minDiversityForMutation=0.03`
: Min percentage from max diversity (count of different CDR3 length multiply by count of uniq **complementary genes**) of mutation for it may be considered as a candidate for allele mutation (default `0.03`).

`-OdiversityThresholds.minDiversityForAllele=0.03`
: Filter out allele candidates with percentage from max diversity (count of different CDR3 length multiply by count of uniq **complementary genes**) less than this parameter (default `0.03`).

`-OdiversityThresholds.diversityForSkipTestForRatioForZeroAllele=0.1`
: If percentage from max diversity (count of different CDR3 length multiply by count of uniq **complementary genes**) of zero allele greater or equal to this, than it will not be tested by diversity ratio (default `0.1`).

`-OsearchMutationsInCDR3.minClonesCount=5`
: Letter must be represented in not less than `minClonesCount` clones (default `5`).

`-OsearchMutationsInCDR3.minPartOfTheSameLetter=0.7`
: Portion of clones from group that must have the same letter (default `0.7`).

`-OsearchMutationsInCDR3.minDiversity=0.5`
: Letter must be represented by not less than `minDiversity` percentage of diversity by **complementary gene** (default `0.5`).

`-OsearchMutationsInCDR3=null`
: If searchMutationsInCDR3 set to null there will be no search for mutations in CDR3

