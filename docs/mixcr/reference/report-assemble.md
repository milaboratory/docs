# `assemble` report

MiXCR generates a comprehensive summary of assembly performance. Assemble reports may be generated right along with [`assemble`](./mixcr-assemble.md) command using `-r`/`--report` for `txt` report and `-j/--json-report` for report in a json format, or can be exported using [`exportReports`](./mixcr-exportReports.md) command.

??? note "Show sample report"
    === ".txt"
        ```
        ============== Assemble Report ==============
        Analysis time: 0ns
        Number of input groups: 22887
        Number of input alignments: 401520
        Number of output pre-clonotypes: 21677
        Number of clonotypes per group
        
        0: + 120 (0.57%) = 120 (0.57%)
        1: + 20134 (95.85%) = 20254 (96.42%)
        2: + 710 (3.38%) = 20964 (99.8%)
        3: + 41 (0.2%) = 21005 (100%)
        Number of core alignments: 373026 (92.9%)
        Discarded core alignments: 14079 (3.77%)
        Empirically assigned alignments: 1049 (0.26%)
        Empirical assignment conflicts: 1 (0%)
        UMI+VJ-gene empirically assigned alignments: 1050 (0.26%)
        VJ-gene empirically assigned alignments: 0 (0%)
        UMI empirically assigned alignments: 0 (0%)
        Number of ambiguous UMIs: 751
        Number of ambiguous V-genes: 404
        Number of ambiguous J-genes: 64
        Number of ambiguous UMI+V/J-gene combinations: 468
        Unassigned alignments: 19570 (4.87%)
        Final clonotype count: 2419
        Average number of reads per clonotype: 152.4
        Reads used in clonotypes, percent of total: 368667 (33.95%)
        Reads used in clonotypes before clustering, percent of total: 369350 (34.02%)
        Number of reads used as a core, percent of used: 367264 (99.44%)
        Mapped low quality reads, percent of used: 2086 (0.56%)
        Reads clustered in PCR error correction, percent of used: 683 (0.18%)
        Reads pre-clustered due to the similar VJC-lists, percent of used: 0 (0%)
        Reads dropped due to the lack of a clone sequence, percent of total: 22 (0%)
        Reads dropped due to low quality, percent of total: 0 (0%)
        Reads dropped due to failed mapping, percent of total: 4687 (0.43%)
        Reads dropped with low quality clones, percent of total: 0 (0%)
        Clonotypes eliminated by PCR error correction: 113
        Clonotypes dropped as low quality: 0
        Clonotypes pre-clustered due to the similar VJC-lists: 0
        Clonotypes dropped in fine filtering: 0
        Partially aligned reads attached to clones by tags: 0 (0%)
        Partially aligned reads with ambiguous clone attachments by tags: 0 (0%)
        Partially aligned reads failed to attach to clones by tags: 0 (0%)
        TRB chains: 1024 (42.33%)
        TRAD chains: 1370 (56.63%)
        TRG chains: 25 (1.03%)
        ```
    === ".json"
        ```json
        {
          "type": "assemblerReport",
          "commandLine": "assemble -r P15-M2-DNEG_assembleReport.txt -f P15-M2-DNEG_corrected.vdjca P15-M2-DNEG.clns",
          "inputFiles": [
            "P15-M2-DNEG_corrected.vdjca"
          ],
          "outputFiles": [
            "P15-M2-DNEG.clns"
          ],
          "version": "unspecified; built=Sat Jul 09 19:09:10 CEST 2022; rev=204bb4540f; lib=repseqio.v2.0",
          "preCloneAssemblerReport": {
            "type": "preCloneAssemblerReport",
            "inputGroups": 22887,
            "inputAlignments": 401520,
            "clonotypes": 21677,
            "clonotypesPerGroup": {
              "0": 120,
              "1": 20134,
              "2": 710,
              "3": 41
            },
            "coreAlignments": 373026,
            "discardedCoreAlignments": 14079,
            "empiricallyAssignedAlignments": 1049,
            "vjEmpiricallyAssignedAlignments": 0,
            "umiEmpiricallyAssignedAlignments": 0,
            "gatEmpiricallyAssignedAlignments": 1050,
            "empiricalAssignmentConflicts": 1,
            "unassignedAlignments": 19570,
            "umiConflicts": 751,
            "gatConflicts": 468,
            "geneConflicts": {
              "Variable": 404,
              "Joining": 64
            },
            "coreClonotypesDroppedByTagSuffix": 0,
            "coreAlignmentsDroppedByTagSuffix": 0
          },
          "totalReadsProcessed": 1085843,
          "initialClonesCreated": 2532,
          "readsDroppedNoTargetSequence": 22,
          "readsDroppedLowQuality": 16,
          "coreReads": 367264,
          "readsDroppedFailedMapping": 4687,
          "lowQualityRescued": 2086,
          "clonesClustered": 113,
          "readsClustered": 683,
          "clones": 2419,
          "clonesDroppedAsLowQuality": 0,
          "clonesDroppedInFineFiltering": 0,
          "clonesPreClustered": 0,
          "readsPreClustered": 0,
          "readsInClones": 368667,
          "readsInClonesBeforeClustering": 369350,
          "readsDroppedWithLowQualityClones": 0,
          "clonalChainUsage": {
            "type": "chainUsage",
            "chimeras": 0,
            "total": 2419,
            "chains": {
              "TRB": 1024,
              "TRAD": 1370,
              "TRG": 25
            }
          },
          "readsAttachedByTags": 0,
          "readsWithAmbiguousAttachmentsByTags": 0,
          "readsFailedToAttachedByTags": 0
        }
        ```

## Pre-clone assembler report

The first part of the report is dedicated to [UMI and cell barcodes based consensus assembly](./mixcr-assemble.md#pre-clone-assembler-parameters):

`Number of input groups`
: number of groups defined by unique barcodes combination. In case of single-cell UMI-barcoded library equals to unique CellId+UMI groups.

`Number of input alignments`
: Total number of alignments in the input `.vdjca` file.

`Number of output pre-clonotypes`
: Total number of consensuses assembled among all groups.

`Number of clonotypes per group`
: number consensus assembled per number of groups.
??? note "How to read this value"
    ```
    Number of clonotypes per group
    0: + 1209 (0.04%) = 1209 (0.04%)
    1: + 2891630 (98.45%) = 2892839 (98.5%)
    2~3: + 44182 (1.5%) = 2937021 (100%)
    ```

    - For 1209 groups 0 consensuses were assembled due to various reasons such as bad quality, low number
    of reads or other conflicts. 
    - For 2891630 groups 1 consensus was assembled. 
    - For 44182 groups 2 or 3 consensuses were assembled.

`Number of core alignments`
: number of alignments that cover `assemblingFeature` which were used to assemble consensuses

`Discarded core alignments`
: number of alignments that cover `assemblingFeature` but were not assigned to any consensuses

`Empirically assigned alignments`
: Number of alignments that do not cover `assemblingFeature` but were still assigned to consensuses. Those alignments will be used by [`mixcr assembleContigs`](mixcr-assembleContigs.md) if applied.

`Empirical assignment conflicts`
: Number of conflicts encountered in empirical assignment

`UMI+VJ-gene empirically assigned alignments`
: Number of alignments that were assigned to consensuses based on UMI, V and J genes sequences.

`VJ-gene empirically assigned alignments`
: Number of alignments that were assigned to consensuses based on V and J genes sequences.

`UMI empirically assigned alignments`
: Number of alignments that were assigned to consensuses based on UMI sequence.

`Number of ambiguous UMIs`
: number of UMI conflict events.

`Number of ambiguous V-genes`
: number of events when two or more consensuses inside alignment group share the same V-genes, thus V-gene driven empirical assignment was not possible.

`Number of ambiguous J-genes`
: number of events when two or more consensuses inside alignment group share the same J-genes, thus J-gene driven empirical assignment was not possible.

`Number of ambiguous UMI+V/J-gene combinations`
: number of UMI+V/J-gene conflict events.

`Unassigned alignments`
: alignments that were not assigned to any consensuses due to the various reasons

## Assembler and clustering report 

The rest of the report is describes assembly regardless of barcodes:

`Final clonotype count`
: Number of clonotypes left after all artificial diversity error-corrections (PCR-errors and V/J/C mis-assignment correction)

`Average number of reads per clonotype`
: Average number of reads per final clonotype

`Reads used in clonotypes, percent of total`
: Total number of reads assembled into final clonotypes (percent of total number of reads). This number excludes or includes reads from clonotypes eliminated in error-correction depending on `-OaddReadsCountOnClustering`

`Reads used in clonotypes before clustering, percent of total`
: Number of reads used in clonotypes before clustering (PCR-error correction) (percent of total number of reads)

`Number of reads used as a core, percent of used`
: number of core alignments with no low quality nucleotides (defined by `badQualityThreshold`). These alignments form core clonotypes. (percent of reads used in clonotypes)

`Mapped low quality reads, percent of used`
: Number of rescued low quality reads that were aggregated by the corresponding clonotype. See [mapping](mixcr-assemble.md#assemble-algorithm)

`Reads clustered in PCR error correction, percent of used`
: Number of reads clustered in PCR error correction, percent of used. See [clustering](mixcr-assemble.md#assemble-algorithm)

`Reads pre-clustered due to the similar VJC-lists, percent of used`
: Reads pre-clustered due to the similar VJC-lists, percent of used

`Reads dropped due to the lack of a clone sequence, percent of total`
: Reads dropped due to the lack of a clone sequence (`assemblingFeature`), percent of total

`Reads dropped due to low quality, percent of total`
: Reads dropped due to too many positions with low quality, percent of total

`Reads dropped due to failed mapping, percent of total`
: Reads dropped due to failed mapping, percent of total. See [mapping](mixcr-assemble.md#assemble-algorithm)

`Reads dropped with low quality clones, percent of total`
: Reads dropped with low quality clones, percent of total

`Clonotypes eliminated by PCR error correction`
: Number of clonotypes eliminated by PCR error correction

`Clonotypes dropped as low quality`
: Number of clonotypes dropped due to low quality after mapping, pre-clustering and clustering.

`Clonotypes pre-clustered due to the similar VJC-lists`
: Clonotypes pre-clustered due to the similar VJC-lists
