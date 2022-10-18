# `findShmTrees` report

MiXCR generates a comprehensive summary of search for trees process. Find trees reports may be generated right along with [`findShmTrees`](./mixcr-findShmTrees.md) command using `-r`/`--report` for `txt` report and `-j/--json-report` for report in a json format, or can be exported using [`exportReports`](./mixcr-exportReports.md) command.

??? note "Show sample report"
    === ".txt"
        ```
        ======================================
        Analysis date: Thu Oct 06 17:42:26 CEST 2022
        Input file(s): alleles/MRK_p02_Bmem_1_CGTACTAG-AAGGAGTA_L00M.with_alleles.clns,alleles/MRK_p03_Bmem_1_TCCTGAGC-GTAAGGAG_L00M.with_alleles.clns
        Output file(s): trees/result.shmt
        Version: ; built=Thu Oct 06 17:39:13 CEST 2022; rev=585abb5a1a; lib=repseqio.v2.0
        Command line arguments: findShmTrees -j trees/report.json -r trees/report.txt alleles/MRK_p02_Bmem_1_CGTACTAG-AAGGAGTA_L00M.with_alleles.clns alleles/MRK_p03_Bmem_1_TCCTGAGC-GTAAGGAG_L00M.with_alleles.clns trees/result.shmt
        Analysis time: 2.58s
        Step 1: Building initial trees
            Clones was added: 254
            Trees created: 101
        Step 2: Attaching clones by distance change
            Clones was added: 6
        Step 3: Combining trees
            Trees combined: 0
        Total trees count: 101
        Total clones count in trees: 260
        ======================================
        ```
    === ".json"
        ```json
        {
          "type": "buildSHMTreeReport",
          "commandLine": "findShmTrees -j trees/report.json -r trees/report.txt alleles/MRK_p02_Bmem_1_CGTACTAG-AAGGAGTA_L00M.with_alleles.clns alleles/MRK_p03_Bmem_1_TCCTGAGC-GTAAGGAG_L00M.with_alleles.clns trees/result.shmt",
          "inputFiles": [
            "alleles/MRK_p02_Bmem_1_CGTACTAG-AAGGAGTA_L00M.with_alleles.clns",
            "alleles/MRK_p03_Bmem_1_TCCTGAGC-GTAAGGAG_L00M.with_alleles.clns"
          ],
          "outputFiles": [
            "trees/result.shmt"
          ],
          "version": "; built=Thu Oct 06 17:39:13 CEST 2022; rev=585abb5a1a; lib=repseqio.v2.0",
          "stepResults": [
            {
              "step": {
                "name": "BuildingInitialTrees",
                "algorithm": {
                  "type": "BronKerbosch",
                  "commonMutationsCountForClustering": 5,
                  "maxNDNDistanceForClustering": 1.0
                }
              },
              "clonesWasAdded": 254,
              "cloneNodesWasAdded": 253,
              "treesCountDelta": 101,
              "commonVJMutationsCounts": {
                "size": 101,
                "sum": "..."
              },
              "clonesCountInTrees": {
                "size": 101,
                "sum": "..."
              },
              "wildcardsScore": {
                "size": 101,
                "sum": "..."
              },
              "wildcardsScoreForRoots": {
                "size": 101,
                "sum": "..."
              },
              "maxNDNsWildcardsScoreInTree": {
                "size": 101,
                "sum": "..."
              },
              "surenessOfDecisions": {
                "size": 101,
                "sum": "..."
              },
              "mutationsRateDifferences": {
                "size": 338,
                "sum": "..."
              },
              "minMutationsRateDifferences": {
                "size": 101,
                "sum": "..."
              },
              "maxMutationsRateDifferences": {
                "size": 101,
                "sum": "..."
              }
            },
            {
              "step": {
                "name": "AttachClonesByDistanceChange",
                "threshold": 0.45,
                "maxNDNDistance": 1.5
              },
              "clonesWasAdded": 6,
              "cloneNodesWasAdded": 6,
              "treesCountDelta": 0,
              "commonVJMutationsCounts": {
                "size": 101,
                "sum": "..."
              },
              "clonesCountInTrees": {
                "size": 101,
                "sum": "..."
              },
              "wildcardsScore": {
                "size": 101,
                "sum": "..."
              },
              "wildcardsScoreForRoots": {
                "size": 101,
                "sum": "..."
              },
              "maxNDNsWildcardsScoreInTree": {
                "size": 101,
                "sum": "..."
              },
              "surenessOfDecisions": {
                "size": 101,
                "sum": "..."
              },
              "mutationsRateDifferences": {
                "size": 349,
                "sum": "..."
              },
              "minMutationsRateDifferences": {
                "size": 101,
                "sum": "..."
              },
              "maxMutationsRateDifferences": {
                "size": 101,
                "sum": "..."
              }
            },
            {
              "step": {
                "name": "CombineTrees",
                "maxNDNDistanceBetweenRoots": 0.3
              },
              "clonesWasAdded": 0,
              "cloneNodesWasAdded": 0,
              "treesCountDelta": 0,
              "commonVJMutationsCounts": {
                "size": 101,
                "sum": "..."
              },
              "clonesCountInTrees": {
                "size": 101,
                "sum": "..."
              },
              "wildcardsScore": {
                "size": 101,
                "sum": "..."
              },
              "wildcardsScoreForRoots": {
                "size": 101,
                "sum": "..."
              },
              "maxNDNsWildcardsScoreInTree": {
                "size": 101,
                "sum": "..."
              },
              "surenessOfDecisions": {
                "size": 101,
                "sum": "..."
              },
              "mutationsRateDifferences": {
                "size": 349,
                "sum": "..."
              },
              "minMutationsRateDifferences": {
                "size": 101,
                "sum": "..."
              },
              "maxMutationsRateDifferences": {
                "size": 101,
                "sum": "..."
              }
            }
          ]
        }
        ```

`Step N: ...`
: Summary of step result. `Clones was added:` - how many clones was added to any tree, `Trees created:` - how many trees was created on this step, `Trees combined:` - how many trees was combined.

`Total trees count`
: Total count of trees found by command.

`Total clones count in trees`
: How many uniq clones included in found trees.

`stepResults`
: Stats for every step. `step` - name and parameters of step, `clonesWasAdded` - count of uniq clones that was added, `cloneNodesWasAdded` - count of clones that are uniq by target sequence (tree structure doesn't distinct C genes and sample names, that clones will be on the same node), `treesCountDelta` - change of tree count, `commonVJMutationsCounts` - stats of VJ mutations count of MRCA, `clonesCountInTrees` - stats of clones count, `wildcardsScore` - stats of wildcards in NDN (average for every tree), `wildcardsScoreForRoots` - stats of wildcards in NDN (for MRCA nodes), `maxNDNsWildcardsScoreInTree` - stats of wildcards in NDN (max for every tree), `surenessOfDecisions` - stats of main metric that used on this step, `mutationsRateDifferences` - stats of ratio between mutation rate in NDN and outside it (for every node), `minMutationsRateDifferences` - stats of ratio between mutation rate in NDN and outside it (min for tree), `maxMutationsRateDifferences` - stats of ratio between mutation rate in NDN and outside it (max for tree), 
