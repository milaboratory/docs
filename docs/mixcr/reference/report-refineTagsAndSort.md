# `refineTagsAndSort` report

MiXCR generates a comprehensive summary of `refineTagsAndSort` command. Refine reports may be generated right along with [``refineTagsAndSort``](./mixcr-refineTagsAndSort.md) command using `-r`/`--report` for `txt` report and `-j/--json-report` for report in a json format, or can be exported using [`exportReports`](./mixcr-exportReports.md) command.

??? note "Show sample report"
    === ".txt"
        ```
        ============== Refine Report ==============
        Analysis date: Sat Oct 01 08:42:50 CEST 2022
        Input file(s): results/01a_d110_LN_germCenterB.vdjca
        Output file(s): results/01a_d110_LN_germCenterB.refined.vdjca
        Version: ; built=Mon Sep 26 10:55:18 CEST 2022; rev=8c998df1ab; lib=repseqio.v2.0
        Command line arguments: --report results/01a_d110_LN_germCenterB.refine.report.txt --json-report results/01a_d110_LN_germCenterB.refine.report.json results/01a_d110_LN_germCenterB.vdjca results/01a_d110_LN_germCenterB.refined.vdjca
        Analysis time: 4.19s
        Time spent in correction: 1.71s
        UMI input diversity: 11117
        UMI output diversity: 1253 (11.27%)
        UMI input reads: 87258
        UMI output count: 82711 (94.79%)
        UMI mean reads per tag: 7.85
        UMI input core diversity: 1852 (16.66%)
        UMI input core reads: 77675 (89.02%)
        UMI directly corrected diversity: 5364 (48.25%)
        UMI directly corrected reads: 5849 (6.7%)
        UMI diversity filtered by tag quality: 4500 (40.48%)
        UMI reads filtered by tag quality: 4547 (5.21%)
        UMI diversity filtered by whitelist: 0 (0%)
        UMI recursively corrected: 230
        Number of output records: 82064 (94.05%)
        Filter report:
          Number of groups: 1253
          Number of groups accepted: 958 (76.46%)
          Total records weight: 82711.0
          Records weight accepted: 82064.0 (99.22%)
          Operator #0:
            Effective threshold: 11.0
        ``` 
    === ".json"
        ```
        refineTagsAndSortrefineTagsAndSort{
          "type": "refineTagsAndSort",
          "commandLine": "--report results/01a_d110_LN_germCenterB.refine.report.txt --json-report results/01a_d110_LN_germCenterB.refine.report.json results/01a_d110_LN_germCenterB.vdjca results/01a_d110_LN_germCenterB.refined.vdjca",
          "inputFiles": [
            "results/01a_d110_LN_germCenterB.vdjca"
          ],
          "outputFiles": [
            "results/01a_d110_LN_germCenterB.refined.vdjca"
          ],
          "version": "; built=Mon Sep 26 10:55:18 CEST 2022; rev=8c998df1ab; lib=repseqio.v2.0",
          "correctionReport": {
            "inputRecords": 87258,
            "outputRecords": 82064,
            "steps": [
              {
                "tagName": "UMI",
                "inputGroups": 1,
                "inputDiversity": 11117,
                "inputCount": 87258,
                "coreDiversity": 1852,
                "coreCount": 77675,
                "directlyCorrectedDiversity": 5364,
                "directlyCorrectedCount": 5849,
                "filteredDiversity": 4500,
                "filteredCount": 4547,
                "recursivelyCorrected": 230,
                "diversityFilteredByWhitelist": 0,
                "outputDiversity": 1253,
                "outputCount": 82711
              }
            ],
            "filterReport": {
              "type": "filter_groups_report",
              "groupingKeys": [
                "UMI"
              ],
              "numberOfGroups": 1253,
              "numberOfGroupsAccepted": 958,
              "totalWeight": 82711,
              "totalWeightAccepted": 82064,
              "operatorReports": [
                {
                  "type": "generic_hist_report",
                  "threshold": 11
                }
              ],
              "metricHists": [
                {
                  "metric": {
                    "type": "group_metric_sum_weight",
                    "reportHist": {
                      "log": true,
                      "binNumber": 0,
                      "minBinWidth": 0.2
                    }
                  },
                  "hist": {
                    "bins": [
                      {
                        "from": 1,
                        "to": 1.5848931924611136,
                        "weight": 168
                      },
                      {
                        "from": 1.5848931924611136,
                        "to": 2.51188643150958,
                        "weight": 61
                      },
                      {
                        "from": 2.51188643150958,
                        "to": 3.981071705534973,
                        "weight": 13
                      },
                      {
                        "from": 3.981071705534973,
                        "to": 6.309573444801933,
                        "weight": 33
                      },
                      {
                        "from": 6.309573444801933,
                        "to": 10,
                        "weight": 19
                      },
                      {
                        "from": 10,
                        "to": 15.848931924611142,
                        "weight": 20
                      },
                      {
                        "from": 15.848931924611142,
                        "to": 25.11886431509581,
                        "weight": 45
                      },
                      {
                        "from": 25.11886431509581,
                        "to": 39.810717055349734,
                        "weight": 96
                      },
                      {
                        "from": 39.810717055349734,
                        "to": 63.09573444801933,
                        "weight": 199
                      },
                      {
                        "from": 63.09573444801933,
                        "to": 100,
                        "weight": 323
                      },
                      {
                        "from": 100,
                        "to": 158.48931924611142,
                        "weight": 170
                      },
                      {
                        "from": 158.48931924611142,
                        "to": 251.18864315095823,
                        "weight": 99
                      },
                      {
                        "from": 251.18864315095823,
                        "to": 398.1071705534973,
                        "weight": 7
                      }
                    ],
                    "collectionSpec": {
                      "log": true,
                      "binNumber": 0,
                      "minBinWidth": 0.2
                    }
                  }
                }
              ]
            }
          }
        }
        ```

## Correction Report

The following set of fields is reported for every processed tag-name. In this example the report only contains `UMI` tag.

`UMI input diversity`
: Number of unique tag values in the input `vdjca` file.

`UMI output diversity`
: Number of unique tag values in the output `vdjca` file.

`UMI input reads`
:  Total number of UMIs in the original `.vdjca` file (usually equals to the number of successfully aligned reads in `mixcr align` report)

`UMI output count`
: Total number of UMIs in the output file

`UMI mean reads per tag`
: Average number of reads per UMI (equals `UMI input reads`/`UMI input diversity`)

`UMI input core diversity`
: Number of UMIs used as a core.

`UMI input core reads`
: Number of reads that contribute to core UMIs.

`UMI directly corrected diversity`
: Number of unique UMI sequences that were corrected and assigned to the core UMIs (artificial diversity).

`UMI directly corrected reads`
: Number of reads contributed to the corrected UMI sequences.

`UMI diversity filtered by tag quality`
:

`UMI reads filtered by tag quality`
:

`UMI diversity filtered by whitelist`
: Number of unique UMIs that were dropped by whitelist.

`UMI recursively corrected`
: 

`Number of output records`
:


## Filter report

`Number of groups`
: Initial number of unique groups of tags after correction.

`Number of groups accepted`
: Number of unique groups of tags after filtering.

`Total records weight`
: Total number of input groups.

`Records weight accepted`
: Total number of groups of tags after filtering.

`Effective threshold`
: Reads per group threshold used for filtering.