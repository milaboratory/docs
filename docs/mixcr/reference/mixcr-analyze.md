
```
mixcr analyze amplicon
    -s <species> \
    --starting-material <startingMaterial> \
    --5-end <5End> --3-end <3End> \
    --adapters <adapters> \
    [OPTIONS] input_file1 [input_file2] output_prefix
```

The following table lists the required options for ```analyze amplicon``` command. This set of high-level options unambiguously determines all parameters of the underline MiXCR pipeline.


[//]: # (<div class="arguments-table"></div>)
| Option                | Description                                                                                                                                                                                                                                                                                                                                                   |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `-s, --species`       | Species (organism). Possible values: `hsa` (or HomoSapiens), `mmu` (or MusMusculus), `rat`, `spalax`, `alpaca` or any species from IMGT ® library, if it is used (see here import segments)                                                                                                                                                                   |
| `--starting-material` | Type of starting material. Two values possible: rna (RNA) and dna (DNA).                                                                                                                                                                                                                                                                                      |
| `--5-end`             | 5’-end of the library. There are two possible values: no-v-primers — no V gene primers (e.g. 5’RACE with template switch oligo or a like), v-primers — V gene single primer / multiple.                                                                                                                                                                       |                                                                                                                                                                           |
| `--3-end`             | 3’-end of the library. There are three possible values: j-primers — J gene single primer / multiplex, j-c-intron-primers — J-C intron single primer / multiplex, c-primers — C gene single primer / multiplex (e.g. IGHC primers specific to different immunoglobulin isotypes).                                                                              |
| `--adapters`          | Presence of PCR primers and/or adapter sequences. If sequences of primers used for PCR or adapters are present in sequencing data, it may influence the accuracy of V, J and C gene segments identification and CDR3 mapping. There are two possible values: adapters-present (adapters may be present) and no-adapters (absent or nearly absent or trimmed). |

The following parameters are optional:

| Option                        | 	Default               | 	Description                                                                                                                                                                                                                                                                                                   |
|-------------------------------|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `--report`                    | `analysis_name.report` | Report file name.                                                                                                                                                                                                                                                                                              |
| `--receptor-type`             | `xcr`                  | Dedicated receptor type for analysis. By default, all T- and B-cell receptor chains are analyzed. MiXCR has special aligner kAligner2, which is used when B-cell receptor type is selected. Possible values for --receptor-type are: `xcr` (all chains),`tcr`,`bcr`,`tra`,`trb`,`trg`,`trd`,`igh`,`igk`,`igl`. |
| `--contig-assembly`           | `false`                | Whether to assemble full receptor sequences (assembleContigs).                                                                                                                                                                                                                                                 |
| `--impute-germline-on-export` | `false`                | Use germline segments (printed with lowercase letters) for uncovered gene features.                                                                                                                                                                                                                            |
| `--region-of-interest`        | `CDR3`                 | MiXCR will use only reads covering the whole target region; reads which partially cover selected region will be dropped during clonotype assembly. All non-CDR3 options require long high-quality paired-end data. See [Gene features](geneFeatures.md) and anchor points for details.                         |
| `--only-productive`           | `false`                | Filter out-of-frame and stop-codons in export                                                                                                                                                                                                                                                                  |
| `--align`                     |                        | Additional parameters for align step specified with double quotes (e.g –align “–limit 1000” –align “-OminSumScore=100”)                                                                                                                                                                                        |
| `--assemble`                  |                        | Additional parameters for assemble step specified with double quotes (e.g –assemble “-ObadQualityThreshold=0”).                                                                                                                                                                                                |
| `--assembleContigs`           |                        | Additional parameters for assembleContigs step specified with double quotes.                                                                                                                                                                                                                                   |
| `--export`                    |                        | Additional parameters for exportClones step specified with double quotes.                                                                                                                                                                                                                                      |

The complete help information information can be obtained via:

```mixcr analyze help amplicon```

