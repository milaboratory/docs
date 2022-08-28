# `assembleContigs` report

MiXCR generates a comprehensive summary of contig assembly performance. Assemble reports may be generated right along with [`assembleContigs`](./mixcr-assembleContigs.md) command using `-r`/`--report` for `txt` report and `-j/--json-report` for report in a json format, or can be exported using [`exportReports`](./mixcr-exportReports.md) command.

??? note "Show sample report"
    === ".txt"
        ```
        ============== AssembleContigs Report ==============
        Analysis date: Mon Jul 11 10:46:49 CEST 2022
        Input file(s): result/Donor1_MBC_2010.clna
        Output file(s): result/Donor1_MBC_2010.clns
        Version: unspecified; built=Mon Jul 04 17:40:12 CEST 2022; rev=8faa71789a; lib=repseqio.v2.0
        Command line arguments: assembleContigs -r result/Donor1_MBC_2010_assembleContigsReport.txt -f result/Donor1_MBC_2010.clna result/Donor1_MBC_2010.clns
        Analysis time: 2.09s
        Initial clonotype count: 1784
        Final clonotype count: 1784 (100%)
        Canceled assemblies: 0 (0%)
        Number of premature termination assembly events, percent of number of initial clonotypes: 0.0 (0%)
        Longest contig length: 303
        Clustered variants: 0 (0%)
        Reads in clustered variants: 0.0 (0%)
        Reads in divided (newly created) clones: 0.0 (0%)
        Clones with ambiguous letters in splitting region: 0 (0%)
        Reads in clones with ambiguous letters in splitting region: 0.0 (0%)
        Average number of ambiguous letters per clone with ambiguous letters in splitting region: NaN
        ```
    === ".json"
        ```json
        {
          "type": "fullSeqAssemblerReport",
          "commandLine": "assembleContigs -r result/Donor1_MBC_2010_assembleContigsReport.txt -j result/Donor1_MBC_2010_assembleContigsReport.json -f result/Donor1_MBC_2010.clna result/Donor1_MBC_2010.clns",
          "inputFiles": [
            "result/Donor1_MBC_2010.clna"
          ],
          "outputFiles": [
            "result/Donor1_MBC_2010.clns"
          ],
          "version": "; built=Fri Jul 15 01:51:38 CEST 2022; rev=aa769be87b; lib=repseqio.v2.0",
          "clonesWithAmbiguousLetters": 85,
          "clonesWithAmbiguousLettersInSplittingRegion": 0,
          "readsWithAmbiguousLetters": 296,
          "readsWithAmbiguousLettersInSplittingRegion": 0,
          "totalAmbiguousLetters": 185,
          "totalAmbiguousLettersInSplittingRegion": 0,
          "initialCloneCount": 1784,
          "canceledAssemblies": 0,
          "finalCloneCount": 1784,
          "totalReadsProcessed": 2723,
          "clonesClustered": 0,
          "readsClustered": 0,
          "longestContigLength": 303,
          "totalDividedVariantReads": 0,
          "assemblePrematureTerminationEvents": 0
        }
        ```

`Initial clonotype count`
: Number of input clonotypes

`Final clonotype count`
: Number of final clonotypes (may be greater than initial number if [`-OsubCloningRegion`](./mixcr-assembleContigs.md#full-sequence-assembler-parameters) is specified)

`Canceled assemblies`
: Number of skipped clonotypes  

`Number of premature termination assembly events, percent of number of initial clonotypes`
: Number of cancelled assemblies due to no hits on the final clone factory step

`Longest contig length`
: Length of the longest contig

`Clustered variants`
: Number of clusterized variant branches

`Reads in clustered variants`
: Number of reads in clustered variants

`Reads in divided (newly created) clones`
: Number of reads in the newly created clones (if [`-OsubCloningRegion`](./mixcr-assembleContigs.md#full-sequence-assembler-parameters) is specified and hypermutated variants discovered)

`Clones with ambiguous letters in splitting region`
: Number of clonotypes with ambiguous letters inside `subCloningRegion` (MiXCR will use `N`s for such letters)  

`Reads in clones with ambiguous letters in splitting region`
: Number of reads in such ambiguous clonotypes

`Average number of ambiguous letters per clone with ambiguous letters in splitting region`
: Average number of ambiguous letters per clone with ambiguous letters in splitting region