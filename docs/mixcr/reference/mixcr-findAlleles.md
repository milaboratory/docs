# `mixcr findAlleles`

Find alleles that are specific to this donor. Result is a library with found allele variants and clns files that aligned on it.

Terms:
* **Complementary gene type** - if we search for mutations in V genes it will be J, and it will be V if we search in J genes.
* **Naive by complementary gene** - if clone have no mutations in the best hit of **complementary gene type**.
* **Lower bound of diversity** - count of different combinations of CDR3 length and gene id of **complementary gene type**.

Briefly, allele search for specific gene type (V or J) consists of the following steps:

1. Grouping clones
    
   All clones grouped by the same gene.

2. Collect all uniq mutations

   Collect all individual mutations in the group. Subsequent insertions or deletions viewed as one element.

3. Filter mutations

   Filter all mutations by **lower bound of diversity** of clones containing this mutation.

4. Group clones by allele candidates

   Remove all filtered out mutations from clones and group them by left mutations. 
   Result is allele candidates and clones that contains all mutations of this candidate.
   Some allele candidates will not have any mutations.

5. Filter allele candidates

   Filter candidates by **lower bound of diversity** and **naive by complementary gene** clones count.

6. Get top of allele candidates by **lower bound of diversity**

   Group clones by allele candidates. If clone is too far from any candidate than it will not be assigned to any group.
   Sort allele candidates by **lower bound of diversity** of its clones and get top allele candidates.

7. Try to add allele without mutations.

   If there is no allele without mutations in found alleles, then try to add it.
   Group clones by allele candidates with added (as in 6.). Get the top alleles or with high **lower bound of diversity**.

8. Enrich alleles with mutations that exist in almost all clones

9. Filter alleles by **naive by complementary gene** clones count

For each allele (even if it is the same as germline), try to find mutations in CDR3:

1. Use for search only naive clones that have no mutations in both V and J genes.

2. Extract all CDR3 nucleotide sequences of clones that was aligned to specific allele.

3. For each position in CDR3 starting from CDR3Begin for V and from CDR3End for J:

   1. Group clones by letter in this position.
   2. Test most frequent letter: if clones count with this letter or count of uniq **complementary genes** are less than thresholds, then stop search.
   3. For next loop step use only clones that have most frequent letter in this position. 

4. Compare found letters with germline

## Command line options

```
mixcr findAlleles [-f] [-nw]
    [--verbose] 
    [--use-local-temp]
    [--export-alleles-mutations <path>] 
    [--export-library <path>] 
    [-o <template.clns>] 
    [-j <jsonReport>] 
    [-r <reportFile>] 
    [-t <threads>] 
    [-O <String=String>]...
    input_file.clns [input_file2.clns ...]...
```
The command returns a highly-compressed, memory- and CPU-efficient binary `.clns` (clones) file that holds exhaustive information about clonotypes. Clonotype tables can be further extracted in tabular form using [`exportClones`](./mixcr-export.md#clonotype-tables) or in human-readable form using [`exportClonesPretty`](./mixcr-exportPretty.md#clonotypes). Additionally, MiXCR produces a comprehensive [report](./report-findAlleles.md) which provides a detailed summary of each stage of assembly pipeline.

Basic command line options are:

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Show verbose warning messages.

`--use-local-temp`
: Put temporary files in the same folder as the output files.

`--export-alleles-mutations`
: Path to write descriptions and stats for all result alleles, existed and new (see below).

`--export-library`
: Path to write library with found alleles.

`-o <template.clns>`
: Output template may contain {file_name} and {file_dir_path},

outputs for '-o /output/folder/{file_name}_with_alleles.clns input_file.clns input_file2.clns' will be /output/folder/input_file_with_alleles.clns and /output/folder/input_file2_with_alleles.clns,

outputs for '-o {file_dir_path}/{file_name}_with_alleles.clns /some/folder1/input_file.clns /some/folder2/input_file2.clns' will be /seme/folder1/input_file_with_alleles.clns and /some/folder2/input_file2_with_alleles.clns,

Resulted outputs must be uniq

`-r, --report <reportFile>`
: [Report](./report-findAlleles.md) file (human readable version, see -j / --json-report for machine readable report)

`-j, --json-report <jsonReport>`
: JSON formatted [report](./report-findAlleles.md) file

`-t, --threads <threads>`
: Specify number of processing threads

`-O  <String=String>` 
: Overrides default find alleles parameter values (see below).

## Find allele parameters

Find allele parameters that may be tuned:

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

## Alleles description table

Columns:

* `alleleName`: name of allele in built library. If this a new allele, then it will contain count of mutations from known allele and how many mutations was found in CDR3.
* `geneName`: name of gene of allele. The same for heterozygous.
* `type`: V or J.
* `alleleMutationsReliableGeneFeatures`: gene features on which allele was found (include CDR3 part that was used for search). Outside this range there may be or may not other allele mutations.
* `alleleMutationsReliableRanges`: ranges in genome of `alleleMutationsReliableGeneFeatures`.
* `mutations`: allele mutations from germline.
* `clonesCount`: clones count that was aligned to this allele.
* `naivesCount`: count of clones with no mutations in V and J.
* `lowerDiversityBound`: **lower bound of diversity** of clones.
* `totalClonesCountForGene`: total clones count of this allele and its zygotes (the same `geneName`)
* `clonesCountWithNegativeScoreChange`: count of clones that align better on original library than on build one
* `filteredForAlleleSearchNaivesCount`: counts of clones with no mutations in V and J after `useClonesWithCountGreaterThen` filter
* `filteredForAlleleSearchClonesCount`: counts of clones after `useClonesWithCountGreaterThen` filter
* `filteredForAlleleSearchClonesCountWithNegativeScoreChange`: count of clones that align better on original library than on build one after `useClonesWithCountGreaterThen` filter
* `scoreDelta`: stats of score change of clones (size, sum, min, max, avg, quadraticMean, stdDeviation)
