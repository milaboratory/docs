```
mixcr align [-f] [--high-compression] [-nw] [--overwrite-if-required]
[--tag-parse-unstranded] [--verbose] [--write-all] [-b <library>] [-j
<jsonReport>] [-n <limit>] [--not-aligned-R1 <failedReadsR1>] [--not-aligned-R2
<failedReadsR2>] [-p <alignerParametersName>] [-r <reportFile>] [--read-buffer
<readBufferSize>] -s <species> [-t <threads>] [--tag-max-budget <tagMaxBudget>]
[--tag-pattern <tagPattern>] [--tag-pattern-file <tagPatternFile>]
[--tag-pattern-name <tagPatternName>] [--trimming-quality-threshold
<trimmingQualityThreshold>] [--trimming-window-size <trimmingWindowSize>] [-O
<String=String>]... files
```

```mixcr align``` command aligns input raw files with sequences (ex.FASTQ) against immune receptor references sequences 
according to the species provided with ```-s```. If sequences include any barcodes (UMI, CellID, etc.) a regex-like pattern
can be provided (```--tag-pattern```) and the tags will be assigned to every alignment. The command returns a binary 
.vdjca file that can be exported with ```mixcr exportAlignments``` or ```mixcr exportAlignmentsPretty```.

[//]: # (<div class="arguments-table"></div>)

| Option                                                   | Description                                                                                                                                                                                 |
|----------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `-s, --species`                                          | Species (organism). Possible values: `hsa` (or HomoSapiens), `mmu` (or MusMusculus), `rat`, `spalax`, `alpaca` or any species from IMGT ® library, if it is used (see here import segments) |
| `-r, --report <reportFile>`                              | Report file (human readable version, see -j / --json-report for machine readable report)                                                                                                    |
| `-j, --json-report <jsonReport>`                         | JSON formatted report file                                                                                                                                                                  |
| `-b, --library <library>`                                | V/D/J/C gene library                                                                                                                                                                        |
| `--tag-pattern <tagPattern>`                             | Tag pattern to extract from the read.                                                                                                                                                       |
| `--tag-pattern-name <tagPatternName>`                    | Tag pattern name from the built-in list.                                                                                                                                                    |                                                                                                                                                                           |
| `--tag-pattern-file <tagPatternFile>`                    | Read tag pattern from a file.                                                                                                                                                               |
| `--tag-parse-unstranded`                                 | If paired-end input is used, determines whether to try all combinations of mate-pairs or only match reads to the corresponding pattern sections (i.e. first file to first section, etc...)  |
| `--tag-max-budget <tagMaxBudget>`                        | Maximal bit budget, higher values allows more substitutions in small letters.                                                                                                               |                                                                                                                                                                                            |
| `-n, --limit <limit>`                                    | Maximal number of reads to process                                                                                                                                                          |
| `-t, --threads <threads>`                                | Processing threads                                                                                                                                                                          |
| `-nw, --no-warnings`                                     | Suppress all warning messages.                                                                                                                                                              |
| `--verbose`                                              | Verbose warning messages.                                                                                                                                                                   |
| `-f, --force-overwrite`                                  | Force overwrite of output file(s).                                                                                                                                                          |
| `--overwrite-if-required`                                | Overwrite output file if it is corrupted or if it was generated from different input file or with different parameters. -f /--force-overwrite overrides this option.                        |
| `--read-buffer <readBufferSize>`                         | Species (organism), as specified in library file or taxon id. Possible values: hs, HomoSapiens, musmusculus, mmu, hsa, 9606, 10090 etc.                                                     |
| `--high-compression`                                     | Use higher compression for output file, 10~25% slower, minus 30~50% of file size.                                                                                                           |
| `-trimming-quality-threshold <trimmingQualityThreshold>` | Read pre-processing: trimming quality threshold                                                                                                                                             |
| `--trimming-window-size <trimmingWindowSize>`            | Read pre-processing: trimming window size                                                                                                                                                   |
| `-p, --preset <alignerParametersName>`                   | Parameters preset.                                                                                                                                                                          |
| `-O  <String=String>`                                    | Overrides default aligner parameter values. ex. `-OvParameters.geneFeatureToAlign=VTranscript`. See next section.                                                                           |
| `--write-all`                                            | Write alignment results for all input reads (even if alignment failed).                                                                                                                     |
| `--not-aligned-R1 <failedReadsR1>`                       | Pipe not aligned R1 reads into separate file.                                                                                                                                               |
| `--not-aligned-R2 <failedReadsR2>`                       | Pipe not aligned R2 reads into separate file.                                                                                                                                               |


## Aligner parameters

MiXCR uses a wide range of parameters that controls aligner behaviour. There are some global parameters and gene-specific parameters organized in groups: ``vParameters``, ``dParameters``, ``jParameters`` and ``cParameters``. Each group of parameters may contains further subgroups of parameters etc. In order to override some parameter value one can use ``-O`` followed by fully qualified parameter name and parameter value (e.g. ``-Ogroup1.group2.parameter=value``).

One of the key MiXCR features is ability to specify particular :ref:`gene regions <ref-geneFeatures>` which will be extracted from reference and used as a targets for alignments. Thus, each sequencing read will be aligned to these extracted reference regions. Parameters responsible for target gene regions are:

| Parameter                          | Default value    | Description                                                |
|------------------------------------|------------------|------------------------------------------------------------|
| ``vParameters.geneFeatureToAlign`` | ``VRegionWithP`` | region in V gene which will be used as target in ``align`` |
| ``dParameters.geneFeatureToAlign`` | ``DRegionWithP`` | region in D gene which will be used as target in ``align`` |
| ``jParameters.geneFeatureToAlign`` | ``JRegionWithP`` | region in J gene which will be used as target in ``align`` |
| ``cParameters.geneFeatureToAlign`` | ``CExon1``       | region in C gene which will be used as target in ``align`` |

It is important to specify these gene regions such that they will fully cover target clonal gene region which will be used in :ref:`assemble <ref-assemble>` (e.g. CDR3).

One can override default gene regions in the following way:

::

    mixcr align -OvParameters.geneFeatureToAlign=VTranscript input_file1 [input_file2] output_file.vdjca

Other global aligner parameters are:


| Parameter                                                     | Default value | Description                                                                                                                                                                                                                                                                                                                                                     |
|---------------------------------------------------------------|---------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ``saveOriginalReads``                                         | ``false``     | Save original sequencing reads in ``.vdjca`` file.                                                                                                                                                                                                                                                                                                              |
| ``allowPartialAlignments``                                    | ``false``     | Save incomplete alignments (e.g. only V / only J) in ``.vdjca`` file                                                                                                                                                                                                                                                                                            |
| ``allowChimeras``                                             | ``false``     | Accept alignments with different loci of V and J genes (by default such alignments are dropped).                                                                                                                                                                                                                                                                |
| ``minSumScore``                                               | ``120.0``     | Minimal total alignment score value of V and J genes.                                                                                                                                                                                                                                                                                                           |
| ``maxHits``                                                   | ``5``         | Maximal number of hits for each gene type: if input sequence align to more than ``maxHits`` targets, then only  top ``maxHits`` hits will be kept.                                                                                                                                                                                                              |
| ``vjAlignmentOrder`` (*only for single-end analysis*)         | ``VThenJ``    | Order in which V and J genes aligned in target (possible values ``JThenV`` and ``VThenJ``). Parameter affects only *single-read* alignments and alignments of overlapped paired-end reads. Non-overlaping paired-end reads are always processed in ``VThenJ`` mode. ``JThenV`` can be used for short reads (~100bp) with full (or nearly full) J gene coverage. |
| ``relativeMinVFR3CDR3Score`` (*only for paired-end analysis*) | ``0.7``       | Relative minimal alignment score of ``FR3+VCDR3Part`` region for V gene. V hit will be kept only if its ``FR3+VCDR3Part`` part aligns with score greater than ``relativeMinVFR3CDR3Score * maxFR3CDR3Score``, where ``maxFR3CDR3Score`` is the maximal alignment score for ``FR3+VCDR3Part`` region among all of V hits for current input reads pair.           |
| ``readsLayout`` (*only for paired-end analysis*)              | ``Opposite``  | Relative orientation of paired reads. Available values: ``Opposite``, ``Collinear``, ``Unknown``                                                                                                                                                                                                                                                                |

.. raw:: html

   <!--
   | `relativeMinVScore` <br> (_only for paired-end analysis_)| 0.7 | Relative minimum score of V gene. Only those V hits will be considered, which score is greater then `relativeMinVScore * maxVScore`, where `maxVScore` is the maximum score throw all obtained V hits. |-->

One can override these parameters in the following way:

    mixcr align --species hs -OmaxHits=3 input_file1 [input_file2] output_file.vdjca

### V, J and C aligners parameters

MiXCR uses same types of aligners to align V, J and C genes (``KAligner`` from `MiLib <https://github.com/milaboratory/milib>`_; the idea of ``KAligner`` is inspired by `this article <http://nar.oxfordjournals.org/content/41/10/e108>`_). These parameters are placed in ``parameters`` subgroup and can be overridden using e.g. ``-OjParameters.parameters.mapperKValue=7``. The following parameters for V, J and C aligners are available:

| Parameter              | Default V value | Default J value | Default C value | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|------------------------|-----------------|-----------------|-----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ``mapperKValue``       | ``5``           | ``5``           | ``5``           | Length of seeds used in aligner.                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ``floatingLeftBound``  | ``true``        | ``true``        | ``false``       | Specifies whether left bound of  alignment is fixed or float: if ``floatingLeftBound`` set to false, the left bound of either target or query will be aligned. Default values are suitable in most cases.                                                                                                                                                                                                                                                                            |
| ``floatingRightBound`` | ``true``        | ``false``       | ``false``       | Specifies whether right bound of alignment is fixed or float: if ``floatingRightBound`` set to false, the right bound of either target or query will be aligned. Default values are suitable in most cases. If your target molecules have no primer sequences in J Region (e.g. library was amplified using primer to the C region) you can change value of this parameter for J gene to ``false`` to increase J gene identification accuracy and overall specificity of alignments. |
| ``minAlignmentLength`` | ``15``          | ``15``          | ``15``          | Minimal length of aligned region.                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ``maxAdjacentIndels``  | ``2``           | ``2``           | ``2``           | Maximum number of indels between two seeds.                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ``absoluteMinScore``   | ``40.0``        | ``40.0``        | ``40.0``        | Minimal score of alignment: alignments with smaller score will be dropped.                                                                                                                                                                                                                                                                                                                                                                                                           |
| ``relativeMinScore``   | ``0.87``        | ``0.87``        | ``0.87``        | Minimal relative score of  alignments: if alignment score is smaller than ``relativeMinScore * maxScore``,  where ``maxScore`` is the best score among all alignments for particular gene type (V, J or C) and input sequence, it will be dropped.                                                                                                                                                                                                                                   |
| ``maxHits``            | ``7``           | ``7``           | ``7``           | Maximal number of hits: if input sequence align with more than ``maxHits`` queries, only top ``maxHits`` hits will be kept.                                                                                                                                                                                                                                                                                                                                                          |

These parameters can be overridden like in the following example:
```
    mixcr align --species hs  \
                -OvParameters.parameters.minAlignmentLength=30 \
                -OjParameters.parameters.relativeMinScore=0.7 \ 
                input_file1 [input_file2] output_file.vdjca
```

Scoring used in aligners is specified by ``scoring`` subgroup of
parameters. It contains the following parameters:

| Parameter        | Default value                        | Description                                                                                                                                                                                                                                                                                                                              |
|------------------|--------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ``subsMatrix``   | ``simple(match = 5, mismatch = -9)`` | Substitution matrix. Available types:<br/> - ``simple`` - a matrix with diagonal elements equal to ``match`` and other elements equal to ``mismatch``<br/> - ``raw`` - a complete set of 16 matrix elements should be specified;  for  example: ``raw(5,-9,-9,-9,-9,5,-9,-9,-9,-9,5,-9,-9,-9,-9,5)``(*equivalent to the  default value*) |
| ``gapPenalty``   | ``-12``                              | Penalty for gap.                                                                                                                                                                                                                                                                                                                         |

Scoring parameters can be overridden in the following way:

```

    mixcr align --species hs -OvParameters.parameters.scoring.gapPenalty=-20 input_file1 [input_file2] output_file.vdjca

```
```

    mixcr align --species hs -OvParameters.parameters.scoring.subsMatrix=simple(match=4,mismatch=-11) \
                 input_file1 [input_file2] output_file.vdjca

```

### D aligner parameters

The following parameters can be overridden for D aligner:

| Parameter              | Default value  | Description                                                                                                                                                                                                     |
|------------------------|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ``absoluteMinScore``   | ``25.0``       | Minimal score of alignment: alignments with smaller scores will be dropped.                                                                                                                                     |
| ``relativeMinScore``   | ``0.85``       | Minimal relative score of alignment: if alignment score is smaller than ``relativeMinScore * maxScore``, where ``maxScore`` is the best score among all alignments for particular sequence, it will be dropped. |
| ``maxHits``            | ``3``          | Maximal number of hits: if input sequence align with more than ``maxHits`` queries, only top ``maxHits`` hits will be kept.                                                                                                                   |

One can override these parameters like in the following example:

```
    mixcr align --species hs -OdParameters.absoluteMinScore=10 input_file1 [input_file2] output_file.vdjca
```

Scoring parameters for D aligner are the following:

| Parameter      | Default value                       | Description                                                                                                                                                                                                                                                                                                                |
|----------------|-------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ``type``       | ``linear``                          | Type of scoring. Possible values: ``affine``, ``linear``.                                                                                                                                                                                                                                                                  |
| ``subsMatrix`` | ``simple(match = 5,mismatch = -9)`` | Substitution matrix. Available types:<br/>- a matrix with diagonal elements equal to ``match`` and other elements equal to ``mismatch``<br/> - ``raw`` - a complete set of 16 matrix elements should be specified; for  example: ``raw(5,-9,-9,-9,-9,5,-9,-9,-9,-9,5,-9,-9,-9,-9,5)`` (*equivalent to the  default value*) |
| ``gapPenalty`` | ``-12``                             | Penalty for gap.                                                                                                                                                                                                                                                                                                           |

These parameters can be overridden in the following way:

```
mixcr align --species hs -OdParameters.scoring.gapExtensionPenalty=-5 input_file1 [input_file2] output_file.vdjca
```
### Report

Summary of alignment procedure can be exported with in a human-readable .txt file with `-r`/`--report` option. Also
a JSON formatted report file can be generated using `-j`/ `--json-report` option.

??? note "Example"
    === "txt"
        ```
        Analysis date: Tue Jul 05 12:14:17 CEST 2022
        Input file(s): input_R1_001.fastq.gz,input_R1_001_R2_001.fastq.gz
        Output file(s): output.vdjca
        Version: unspecified; built=Mon Jul 04 17:40:12 CEST 2022; rev=8faa71789a; lib=repseqio.v2.0
        Command line arguments: align -s HomoSapiens --tag-pattern-name 10x -OvParameters.geneFeatureToAlign=VTranscript -OvParameters.parameters.floatingLeftBound=false -OjParameters.parameters.floatingRightBound=false -OcParameters.parameters.floatingRightBound=false -OallowPartialAlignments=true -OallowNoCDR3PartAlignments=true -r alignReport.txt -j alignReport.json -f input_R1_001.fastq.gz,input_R1_001_R2_001.fastq.gz output.vdjca
        Analysis time: 4.93m
        Total sequencing reads: 14492930
        Successfully aligned reads: 11268087 (77.75%)
        Alignment failed, no hits (not TCR/IG?): 1903444 (13.13%)
        Alignment failed because of low total score: 1321399 (9.12%)
        Overlapped: 0 (0%)
        Overlapped and aligned: 0 (0%)
        Alignment-aided overlaps: 0 (NaN%)
        Overlapped and not aligned: 0 (0%)
        No CDR3 parts alignments, percent of successfully aligned: 5583522 (49.55%)
        Partial aligned reads, percent of successfully aligned: 3844149 (34.12%)
        TRA chains: 1876416 (16.65%)
        TRB chains: 6864261 (60.92%)
        TRD chains: 178 (0%)
        TRG chains: 3061 (0.03%)
        TRA,TRD chains: 2479701 (22.01%)
        IGH chains: 1030 (0.01%)
        IGK chains: 30 (0%)
        IGL chains: 43410 (0.39%)
        Realigned with forced non-floating bound: 0 (0%)
        Realigned with forced non-floating right bound in left read: 0 (0%)
        Realigned with forced non-floating left bound in right read: 0 (0%)
        ```
    === "JSON"
        ```
        {
        "timestamp": "2022-07-05 10:14:17.021+0000",
        "commandLine": "align -s HomoSapiens --tag-pattern-name 10x -OvParameters.geneFeatureToAlign=VTranscript -OvParameters.parameters.floatingLeftBound=false -OjParameters.parameters.floatingRightBound=false -OcParameters.parameters.floatingRightBound=false -OallowPartialAlignments=true -OallowNoCDR3PartAlignments=true -r alignReport.txt -j alignReport.json -f input_R1_001.fastq.gz input_R2_001.fastq.gz output.vdjca",
        "inputFiles": [
        "input_R1_001.fastq.gz",
        "input_R1_001_R2_001.fastq.gz"
        ],
        "outputFiles": [
        "output.vdjca"
        ],
        "chimeras": 0,
        "noCDR3PartsAlignments": 5583522,
        "partialAlignments": 3844149,
        "realignedWithForcedNonFloatingBound": 0,
        "realignedWithForcedNonFloatingRightBoundInLeftRead": 0,
        "realignedWithForcedNonFloatingLeftBoundInRightRead": 0,
        "trimmingReport": null,
        "action": "align",
        "totalReadsProcessed": 14492930,
        "aligned": 11268087,
        "notAligned": 3224843,
        "notAlignedReasons": {
        "VAndJOnDifferentTargets": 0,
        "LowTotalScore": 1321399,
        "NoCDR3Parts": 0,
        "NoHits": 1903444,
        "NoVHits": 0,
        "NoJHits": 0,
        },
        "overlapped": 0,
        "alignmentAidedOverlaps": 0,
        "overlappedAligned": 0,
        "overlappedNotAligned": 0,
        "pairedEndAlignmentConflicts": 0,
        "vChimeras": 0,
        "jChimeras": 0,
        "chainUsage": {
        "total": 11268087,
        "chimeras": 0,
        "chains": {
        "TRA": 1876416,
        "TRB": 6864261,
        "TRD": 178,
        "TRG": 3061,
        "TRA,TRD": 2479701,
        "IGH": 1030,
        "IGK": 30,
        "IGL": 43410
        }
        },
        "version": "unspecified; built=Mon Jul 04 17:40:12 CEST 2022; rev=8faa71789a; lib=repseqio.v2.0",
        "executionTimeMillis": 295978
        }
        ```


`Total sequencing reads	` / `totalReadsProcessed`
: Total number of analysed sequencing.

`Successfully aligned reads	` / `total`
: Number of successful alignments. Number of alignments written to the output file. Without
`-OallowPartialAlignments=true` (default behaviour): number of reads with both V and J alignments, that passed all 
alignment thresholds. With `-OallowPartialAlignments=true`: number of reads with at least one 
of V or J alignments, that passed all alignment thresholds and cover at least one nucleotide of CDR3.

`Alignment failed, no hits (not TCR/IG?)` / `NoHits`
: Number of reads without TCR or IG sequences

`Alignment failed because of low total score` / `LowTotalScore`
: Number of alignments that failed due to a low alignment score

`Overlapped` / `overlapped`
: Total number of overlapped paired-end reads

`Overlapped and aligned` / `overlappedAligned`
: Total number of reads that were overlapped and aligned (in any order) 

`Alignment-aided overlaps` / `alignmentAidedOverlaps`
: Number of reads that were overlapped only after alignment. High value, may indicate problems with the sequencing data 
being analysed (any data pre-processing step may be the source of this problem or this may be a sign of invitro 
chimerization). Small number of such events is ok, especially for RNA-Seq and similar data, that contains unspliced 
or wrongly spliced sequences.

`Overlapped and not aligned` / `overlappedNotAligned`
: Number of overlapped paired-end reads that did not result in alignment

`No CDR3 parts alignments, percent of successfully aligned` / `noCDR3PartsAlignments`
: Number of alignments that lack CDR3 sequence

`Partial aligned reads, percent of successfully aligned` / `partialAlignments`
: Number of reads that partially cover CDR3 region but lack either V or J gene

`chains`
: Number of reads aligned with this type of immunological chain. E.g. TRB for TRBV+TRBJ[+TRBC].

`Realigned with forced non-floating bound` / `realignedWithForcedNonFloatingBound`
: Number of global alignments. If one read has gene segment on the right side, and another read has the same gene segment
on the left side, global alignment will be applied and reads edges will be preserved.

`Realigned with forced non-floating right bound in left read` / `realignedWithForcedNonFloatingRightBoundInLeftRead`
: Number of global alignments on the right side of the left read

`Realigned with forced non-floating left bound in right read` / `realignedWithForcedNonFloatingRightBoundInRightRead`
: Number of global alignments on the left side of the right read

The following fields present only in JSON format:

`NoCDR3Parts`
: Number of alignments filtered due to absence of CDR3 region

`NoVHits`
: Number of alignments filtered due to absence of V gene

`NoJHits`
: Number of alignments filtered due to absence of J gene

`notAligned`
: Total number of not aligned reads

`VAndJOnDifferentTargets`
: Number of alignments that failed because V gene is present only in one read, J gene only present in another
and reads don't overlap.

`pairedEndAlignmentConflicts`
: Number of alignments where two reads overlap but the overlapping region has a very low score. In that case that 
alignment will be treated as not-overlapped and only one read sequence with the best score will be preserved.

`vChimeras` \ `jChimeras`
: Number of events where different V or J genes correspondingly were aligned in different paired-end reads. This type of
chimerization is different from one mentioned for “Chimeras” report line. High number of such events for V genes is a 
strong evidence of sample preparation problems, raw data should be manually inspected to verify expected library structure.

`Chimeras`
: Number of detected chimeras. Chimeric alignment is defined as having V, J or C genes from the incompatible chains, 
e.g. TRBV / TRAJ or IGHV / TRBC, etc…)