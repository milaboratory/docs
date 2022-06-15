MiXCR postanalysis block includes two main types of analysis:

- Individual (Biophysics, Diversity, V/J/VJ-Usage, CDR3/V-Spectratype)
- Overlap analysis

```
mixcr postanalysis individual
    [-f] [--drop-outliers] [-nw] [--only-productive] [--verbose]
    [--chains <chains>] --default-downsampling
    <defaultDownsampling> [--metadata <metadata>]
    [--preproc-tables <preprocOut>] [--tables <tablesOut>]
    [--group <isolationGroups>]... [-O <String=String>]...
    [<inOut>...]
```
[//]: # (<div class="arguments-table"></div>)
| Option                | Description                                                                                                                                                                                                                                                                                                                                                   |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `-s, --species`       | Species (organism). Possible values: `hsa` (or HomoSapiens), `mmu` (or MusMusculus), `rat`, `spalax`, `alpaca` or any species from IMGT ® library, if it is used (see here import segments)                                                                                                                                                                   |
| `--starting-material` | Type of starting material. Two values possible: rna (RNA) and dna (DNA).                                                                                                                                                                                                                                                                                      |
| `--5-end`             | 5’-end of the library. There are two possible values: no-v-primers — no V gene primers (e.g. 5’RACE with template switch oligo or a like), v-primers — V gene single primer / multiple.                                                                                                                                                                       |                                                                                                                                                                           |
| `--3-end`             | 3’-end of the library. There are three possible values: j-primers — J gene single primer / multiplex, j-c-intron-primers — J-C intron single primer / multiplex, c-primers — C gene single primer / multiplex (e.g. IGHC primers specific to different immunoglobulin isotypes).                                                                              |
| `--adapters`          | Presence of PCR primers and/or adapter sequences. If sequences of primers used for PCR or adapters are present in sequencing data, it may influence the accuracy of V, J and C gene segments identification and CDR3 mapping. There are two possible values: adapters-present (adapters may be present) and no-adapters (absent or nearly absent or trimmed). |

