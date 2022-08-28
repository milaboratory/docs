# `assemblePartial` report

MiXCR generates a comprehensive summary of partial assembly performance. Assemble reports may be generated right along with [`assemblePartial`](./mixcr-assemblePartial.md) command using `-r`/`--report` for `txt` report and `-j/--json-report` for report in a json format, or can be exported using [`exportReports`](./mixcr-exportReports.md) command.

??? note "Show sample report"
    === ".txt"
        ```
        ============== AssemblePartial Report ==============
        Analysis date: Thu Jul 28 11:51:13 CEST 2022
        Input file(s): clones_newMiXcr/Donor1_MBC_2010_corrected.vdjca
        Output file(s): clones_newMiXcr/Donor1_MBC_2010_partialAssemble.vdjca
        Version: ; built=Fri Jul 15 01:51:38 CEST 2022; rev=aa769be87b; lib=repseqio.v2.0
        Command line arguments: assemblePartial -f --report clones_newMiXcr/Donor1_MBC_2010_assemblePartialReport.txt -j clones_newMiXcr/Donor1_MBC_2010_assemblePartialReport.json clones_newMiXcr/Donor1_MBC_2010_corrected.vdjca clones_newMiXcr/Donor1_MBC_2010_partialAssemble.vdjca
        Analysis time: 12.71m
        Independent runs: 118472787
        Total alignments analysed: 118472787
        Number of output alignments: 118169463 (99.74%)
        Alignments already with CDR3 (no overlapping is performed): 5420162 (4.58%)
        Successfully overlapped alignments: 302715 (0.26%)
        Left parts with too small N-region (failed to extract k-mer): 4530050 (3.82%)
        Extracted k-mer diversity: 19607617
        Dropped due to wildcard in k-mer: 0 (0%)
        Dropped due to too short NRegion parts in overlap: 51841 (0.04%)
        Dropped overlaps with empty N region due to no complete NDN coverage: 3958 (0%)
        Number of left-side alignments: 1835970 (1.55%)
        Number of right-side alignments: 3167157 (2.67%)
        Complex overlaps: 0 (0%)
        Over-overlaps: 197 (0%)
        Partial alignments written to output: 112446586 (94.91%)
        ```
    === ".json"
        ```json
        {
          "type": "partialAlignmentsAssemblerReport",
          "commandLine": "assemblePartial -f --report clones_newMiXcr/Donor1_MBC_2010_assemblePartialReport.txt -j clones_newMiXcr/Donor1_MBC_2010_assemblePartialReport.json clones_newMiXcr/Donor1_MBC_2010_corrected.vdjca clones_newMiXcr/Donor1_MBC_2010_partialAssemble.vdjca",
          "inputFiles": [
            "clones_newMiXcr/Donor1_MBC_2010_corrected.vdjca"
          ],
          "outputFiles": [
            "clones_newMiXcr/Donor1_MBC_2010_partialAssemble.vdjca"
          ],
          "version": "; built=Fri Jul 15 01:51:38 CEST 2022; rev=aa769be87b; lib=repseqio.v2.0",
          "independentRuns": 6478545,
          "totalProcessed": 118472787,
          "outputAlignments": 118169463,
          "withCDR3": 5420162,
          "overlapped": 302715,
          "leftTooShortNRegion": 4530050,
          "kMerDiversity": 19607617,
          "droppedWildcardsInKMer": 0,
          "droppedSmallOverlapNRegion": 51841,
          "droppedNoNRegion": 3958,
          "leftParts": 1835970,
          "rightParts": 3167157,
          "complexOverlaps": 0,
          "overOverlaps": 197,
          "partialAlignmentsAsIs": 112446586
        }
        ```

`Independent runs`
: Number of independent `assemblePartial` rounds

`Total alignments analysed`
: Number of total input alignments

`Number of output alignments`
: Number of total output alignments

`Alignments already with CDR3 (no overlapping is performed)`
: Number of input alignments that already covered `CDR3`

`Successfully overlapped alignments`
: Number of overlapped alignments

`Left parts with too small N-region (failed to extract k-mer)`
: Number of left alignments with too small N-region (not enough entropy to assign to a unique molecule) 

`Extracted k-mer diversity`
: Number of different k-mers

`Dropped due to wildcard in k-mer`
: Dropped alignments due wildcards in k-mers

`Dropped due to too short NRegion parts in overlap`
: Dropped due too small number of N letters in overlap (not enough entropy to assign to a unique molecule)

`Dropped overlaps with empty N region due to no complete NDN coverage`
: Dropped due absent N letters in overlap (not enough entropy to assign to a unique molecule)

`Number of left-side alignments`
: Number of left alignments

`Number of right-side alignments`
: Number of right alignments

`Complex overlaps`
: Multiple overlaps for same molecule

`Over-overlaps`
: Over overlaped alignments

`Partial alignments written to output`
: Partial (no full CDR3) alignments written to output
