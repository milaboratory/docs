# `findAlleles` report

MiXCR generates a comprehensive summary of search for alleles process. Find alleles reports may be generated right along with [`findAlleles`](./mixcr-findAlleles.md) command using `-r`/`--report` for `txt` report and `-j/--json-report` for report in a json format, or can be exported using [`exportReports`](./mixcr-exportReports.md) command.

??? note "Show sample report"
    === ".txt"
        ```
        ======================================
        Analysis date: Tue Oct 04 09:44:33 CEST 2022
        Input file(s): current.clns
        Output file(s): out/alleles_descrition.csv
        Version: ; built=Tue Oct 04 09:44:19 CEST 2022; rev=411bb5fda4; lib=repseqio.v2.0
        Command line arguments: findAlleles -f -t 1 -OsearchMutationsInCDR3=null --debugDir debug -j out/report.json -r out/report.txt --export-alleles-mutations out/alleles_descrition.csv current.clns
        Analysis time: 7.95s
        Clones score delta stats:
            size: 31103
            sum: 2332903.6998901367
            min: -290.0
            max: 348.0
            avg: 75.00574542295395
            quadratic mean: 104.13486938273368
            std deviation: 72.23833436751467
        Clones count with no change of score: 93048
        Clones count with negative score change: 1124
        Found alleles: 21
        Zygotes: {1=41, 2=9}
        Not enough information for allele search: [IGHJ2P*00, IGHV1-69D*00, IGHV3-65*00, IGHV4-28*00]
        Genes with enough information for allele search: 40 (80%)
        The same mutations in almost all clones, but not enough naive clones: {}
        Possible additional allele, but not enough naive clones: {}
        Found alleles that don't fit well to data: {}
        ======================================
        ```
    === ".json"
        ```json
        {
          "type": "findAllelesReport",
          "commandLine": "findAlleles -f -t 1 --debugDir debug -j out/report.json --export-alleles-mutations out/alleles_descrition.csv current.clna",
          "inputFiles": [
            "current.clna"
          ],
          "outputFiles": [
            "out/alleles_descrition.csv"
          ],
          "version": "; built=Tue Oct 04 15:17:35 CEST 2022; rev=ce6588ad8b; lib=repseqio.v2.0",
          "searchHistoryForBCells": {
            "IGHV1-58*00": {
              "alleles": {
                "addedKnownAllele": null,
                "enrichedMutations": {},
                "discardedEnrichedMutations": [],
                "filteredOutByNaiveCount": [],
                "result": [
                  "SA24G"
                ]
              },
              "clonesCount": 69,
              "diversity": 27,
              "enoughDiversity": true,
              "differentMutationsCount": 35,
              "mutationsWithEnoughDiversityCount": 1
            },
            "IGHJ4*00": {
              "alleles": {
                "addedKnownAllele": null,
                "enrichedMutations": {},
                "discardedEnrichedMutations": [],
                "filteredOutByNaiveCount": [],
                "result": [
                  ""
                ]
              },
              "clonesCount": 11299,
              "diversity": 620,
              "enoughDiversity": true,
              "differentMutationsCount": 48,
              "mutationsWithEnoughDiversityCount": 0
            },
            "IGHV3-48*00": {
              "alleles": {
                "addedKnownAllele": null,
                "enrichedMutations": {},
                "discardedEnrichedMutations": [],
                "filteredOutByNaiveCount": [],
                "result": [
                  "SC17T,SA21G,SG22A,SC23A,SA87G,ST146C,SA187C,SG203T",
                  ""
                ]
              },
              "clonesCount": 522,
              "diversity": 83,
              "enoughDiversity": true,
              "differentMutationsCount": 158,
              "mutationsWithEnoughDiversityCount": 22
            }
          },
          "clonesCountWithNoChangeOfScore": 68999,
          "clonesCountWithNegativeScoreChange": 3246,
          "clonesScoreDeltaStats": {
            "size": 59844,
            "sum": 5723950.600250244,
            "min": -377.0,
            "max": 464.0,
            "avg": 95.64786110972268,
            "quadraticMean": 128.11717838119927,
            "stdDeviation": 85.23860317260785
          },
          "foundAlleles": 20,
          "zygotes": {
            "1": 43,
            "2": 6,
            "3": 1
          },
          "allelesScoreChange": {
            "IGHV1-58*00-M1-501828652": {
              "size": 790,
              "sum": 22272.0,
              "min": -29.0,
              "max": 29.0,
              "avg": 28.19240506329114,
              "quadraticMean": 29.0,
              "stdDeviation": 6.80050270548995
            },
            "IGHJ4*00": {
              "size": 0,
              "sum": 0.0,
              "min": "NaN",
              "max": "NaN",
              "avg": "NaN",
              "quadraticMean": "NaN",
              "stdDeviation": "NaN"
            },
            "IGHV3-48*00": {
              "size": 0,
              "sum": 0.0,
              "min": "NaN",
              "max": "NaN",
              "avg": "NaN",
              "quadraticMean": "NaN",
              "stdDeviation": "NaN"
            },
            "IGHV3-48*00-M8-833988740": {
              "size": 2185,
              "sum": 341243.0,
              "min": 29.0,
              "max": 232.0,
              "avg": 156.17528604118993,
              "quadraticMean": 166.98923491249082,
              "stdDeviation": 59.12938978989992
            }
          }
        }
        ```

`Clones score delta stats	` / `clonesScoreDeltaStats`
: Stats of score change (V plus J) after aligning clone on built library.

`Clones count with no change of score	` / `clonesCountWithNoChangeOfScore`
: Clones count with no change of score (V plus J).

`Clones count with negative score change	` / `clonesCountWithNegativeScoreChange`
: How many clones align better on original library than on built one.

`Found alleles` / `foundAlleles`
: Found alleles that weren't exist in original library.

`Zygotes` / `zygotes`
: How many homozygous, heterozygous etc. Some genes are duplicated so 3 and 4 zygotes are not uncommon.

`Not enough information for allele search`
: Genes that have not enough clones to determinate alleles.

`Genes with enough information for allele search`
: How much genes had enough information to infer allele or it's absence. 

`The same mutations in almost all clones, but not enough naive clones`
: Alleles that have the same mutations in almost all clones, but there are not enough naive clones by complimentary gene with that mutation subset.

`Possible additional allele, but not enough naive clones`
: May be there is one more allele, but there are not enough naive clones to be sure.

`Found alleles that don't fit well to data`
: Alleles that make average clones scores worse.

`searchHistoryForBCells`
: Info about process of allele search

`allelesScoreChange`
: Stats of clones score change for every allele
