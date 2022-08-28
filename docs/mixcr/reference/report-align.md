# `align` report

MiXCR generates a comprehensive summary of alignment performance. Alignment reports may be generated right along with [`align`](./mixcr-align.md) command using `-r`/`--report` for `txt` report and `-j/--json-report` for report in a json format, or can be exported using [`exportReports`](./mixcr-exportReports.md) command. Alignment reports may be also visualized using [`exportQc` command](./mixcr-exportQc.md#alignment-reports).

??? note "Show sample report"
    === ".txt"
        ```
        ============== Align Report ==============
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
    === ".json"
        ```json
        {
           "timestamp":"2022-07-05 10:14:17.021+0000",
           "commandLine":"align -s HomoSapiens --tag-pattern-name 10x -OvParameters.geneFeatureToAlign=VTranscript -OvParameters.parameters.floatingLeftBound=false -OjParameters.parameters.floatingRightBound=false -OcParameters.parameters.floatingRightBound=false -OallowPartialAlignments=true -OallowNoCDR3PartAlignments=true -r alignReport.txt -j alignReport.json -f input_R1_001.fastq.gz input_R2_001.fastq.gz output.vdjca",
           "inputFiles":[
              "input_R1_001.fastq.gz",
              "input_R1_001_R2_001.fastq.gz"
           ],
           "outputFiles":[
              "output.vdjca"
           ],
           "chimeras":0,
           "noCDR3PartsAlignments":5583522,
           "partialAlignments":3844149,
           "realignedWithForcedNonFloatingBound":0,
           "realignedWithForcedNonFloatingRightBoundInLeftRead":0,
           "realignedWithForcedNonFloatingLeftBoundInRightRead":0,
           "trimmingReport":null,
           "action":"align",
           "totalReadsProcessed":14492930,
           "aligned":11268087,
           "notAligned":3224843,
           "notAlignedReasons":{
              "VAndJOnDifferentTargets":0,
              "LowTotalScore":1321399,
              "NoCDR3Parts":0,
              "NoHits":1903444,
              "NoVHits":0,
              "NoJHits":0
           },
           "overlapped":0,
           "alignmentAidedOverlaps":0,
           "overlappedAligned":0,
           "overlappedNotAligned":0,
           "pairedEndAlignmentConflicts":0,
           "vChimeras":0,
           "jChimeras":0,
           "chainUsage":{
              "total":11268087,
              "chimeras":0,
              "chains":{
                 "TRA":1876416,
                 "TRB":6864261,
                 "TRD":178,
                 "TRG":3061,
                 "TRA,TRD":2479701,
                 "IGH":1030,
                 "IGK":30,
                 "IGL":43410
              }
           },
           "version":"unspecified; built=Mon Jul 04 17:40:12 CEST 2022; rev=8faa71789a; lib=repseqio.v2.0",
           "executionTimeMillis":295978
        }
        ```

`Total sequencing reads	` / `totalReadsProcessed`
: Total number of analysed sequencing.

`Successfully aligned reads	` / `total`
: Number of successful alignments. Number of alignments written to the output file. Without `-OallowPartialAlignments=true` (default behaviour): number of reads with both V and Jalignments, that passed all alignment thresholds. With `-OallowPartialAlignments=true`: number of reads with at least one of V or J alignments, that passed all alignment thresholds and cover at least one nucleotide of CDR3.

`Alignment failed, no hits (not TCR/IG?)` / `NoHits`
: Number of reads without TCR or IG sequences

`Alignment failed because of low total score` / `LowTotalScore`
: Number of alignments that failed due to a low alignment score

`Overlapped` / `overlapped`
: Total number of overlapped paired-end reads

`Overlapped and aligned` / `overlappedAligned`
: Total number of reads that were overlapped and aligned (in any order)

`Alignment-aided overlaps` / `alignmentAidedOverlaps`
: Number of reads that were overlapped only after alignment. High value, may indicate problems with the sequencing data being analysed (any data pre-processing step may be the source of this problem or this may be a sign of invitro chimerization). Small number of such events is ok, especially for RNA-Seq and similar data, that contains unspliced or wrongly spliced sequences.

`Overlapped and not aligned` / `overlappedNotAligned`
: Number of overlapped paired-end reads that did not result in alignment

`No CDR3 parts alignments, percent of successfully aligned` / `noCDR3PartsAlignments`
: Number of alignments that lack CDR3 sequence

`Partial aligned reads, percent of successfully aligned` / `partialAlignments`
: Number of reads that partially cover CDR3 region but lack either V or J gene

`chains`
: Number of reads aligned with this type of immunological chain. E.g. TRB for TRBV+TRBJ\[+TRBC\].

`Realigned with forced non-floating bound` / `realignedWithForcedNonFloatingBound`
: Number of global alignments. If one read has gene segment on the right side, and another read has the same gene segment on the left side, global alignment will be applied and reads edges will be preserved.

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
: Number of alignments that failed because V gene is present only in one read, J gene only present in another and reads don't overlap.

`pairedEndAlignmentConflicts`
: Number of alignments where two reads overlap but the overlapping region has a very low score. In that case that
alignment will be treated as not-overlapped and only one read sequence with the best score will be preserved.

`vChimeras` \ `jChimeras`
: Number of events where different V or J genes correspondingly were aligned in different paired-end reads. This type of chimerization is different from one mentioned for “Chimeras” report line. High number of such events for V genes is a strong evidence of sample preparation problems, raw data should be manually inspected to verify expected library structure.

`Chimeras`
: Number of detected chimeras. Chimeric alignment is defined as having V, J or C genes from the incompatible chains, e.g. TRBV / TRAJ or IGHV / TRBC, etc…)