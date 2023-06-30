# List of quality checks

Each [preset](overview-built-in-presets.md) contains a list of its specific recommended quality checks. When running MiXCR using [`analyze`](#mixcr-analyze.md) command, it will automatically generate the summary and print it to the standard output. One can also use [`mixcr qc`](mixcr-qc.md) command to export report from .clns file:
```
mixcr qc clonotypes.clns
```
<pre><code>  Successfully aligned reads:                           90.027% [OK]
  Off target (non TCR/IG) reads:                        8.28%   [OK]
  Reads with no V or J hits:                            1.63%   [OK]
  Reads with no barcode:                                0.0%    [OK]
  Overlapped paired-end reads:                          92.096% [OK]
  Alignments that do not cover VDJRegion:               7.72%   <span style="color:yellow">[WARN]</span>
  Tag groups that do not cover VDJRegion:               4.51%   [OK]
  Barcode collisions in clonotype assembly:             0.090%  [OK]
  Unassigned alignments in clonotype assembly:          1.16%   [OK]
  Reads used in clonotypes:                             78.39%  <span style="color:yellow">[WARN]</span>
  Alignments dropped due to low sequence quality:       0.0%    [OK]
  Alignments clustered in PCR error correction:         0.026%  [OK]
  Clonotypes clustered in PCR error correction:         0.022%  [OK]
  Clones dropped in post-filtering:                     0.0%    [OK]
  Alignments dropped in clones post-filtering:          0.0%    [OK]
  Reads dropped in tags error correction and filtering: 7.18%   <span style="color:yellow">[WARN]</span>
  UMIs artificial diversity eliminated:                 31.55%  <span style="color:yellow">[WARN]</span>
  Reads dropped in UMI error correction and whitelist:  0.58%   [OK]
  Reads dropped in tags filtering:                      6.59%   <span style="color:yellow">[WARN]</span>
</code></pre>

Below one can find a list of available quality control checks.

## Available checks 

### Successfully aligned reads

Sequencing reads that have been accurately mapped to their respective V, D, and J gene segments during the [alignment process](mixcr-align.md). This metric is crucial for assessing data quality. Low rate of aligned reads is a strong signal of either wet lab problems or misused analysis settings.

### Off target (non TCR/IG) reads

Sequencing reads that do not map on T or B cell receptor gene segments. High rate of off-target reads may be a result of:

 - primers mis-annealing to a non-target loci; 
 - DNA contamination in RNA material; 
 - other protocol and/or wet lab issues; 
 - wrong choice of species in analysis settings (e.g. you have a cat library while used a human reference library).

In order to troubleshoot, one can rerun [alignment](mixcr-align.md) and save not aligned reads into separate files (using `--not-aligned-R1` and `--not-aligned-R2` options). Then pick a few random non-aligned sequences and BLAST them to identify whether they are coming from contamination / non-target loci or aligned to different species. If there are no [BLAST](https://blast.ncbi.nlm.nih.gov) hits, check whether the sequences are artificial (e.g. adapters).

### Reads with no V or J hits
Sequencing reads that cover either V or J region but not both of them simultaneously. There might be several reasons for that. One common reason is incorrect orientation of reads, typically caused by some pre-processing of the input data performed before MiXCR. A common example is pre-processing with external tools like MiGEC, which is a legacy tool for handling UMIs and demultiplexing. MiGEC reverse complements one of the reads, thus requiring running MiXCR with `-OreadsLayout=Collinear` option.

Another reason is a very low sequencing quality in one of the reads when [sequencing](qc-sequencing-quality.md) has completely failed.

Finally, it might be a wrong use of the analysis preset: if the input data is randomly fragmented (RNA-, Exome-Seq, 10x etc.) and the used preset is designed for amplicon libraries, you would see a high percentage here (since with amplicon settings MiXCR drops all reads that do not full cover CDR3 region). So check and use an [appropriate preset](overview-built-in-presets.md) for fragmented data.


### Reads with no barcode

For barcoded data means that barcodes can't be extracted using the specified tag pattern. For custom library preparation protocols, the first thing to check is that a correct [tag pattern](ref-tag-pattern.md) and/or a correct analysis preset are used. If the library is unstranded, one should use either `--tag-parse-unstranded` option or change the preset accordingly. Finally, the quality of data may be low, so that tags can't be parsed because of too many sequencing errors.


### Overlapped paired-end reads

Paired-end sequencing reads that overlap, meaning that the ends of the forward and reverse reads extend into the same region of the DNA fragment they were sequenced from.

For the full-length amplicon protocols sequenced with 250+250 or 300+300, one expects a high rate of overlapped reads to cover the complete VDJ rearrangement. Low overlap rate in such case may signal about various problems in the wet lab e.g. poor [sequencing quality](qc-sequencing-quality.md) or size selection.

Contrary, for relatively short reads (e.g. 150+150 and shorter) prepared with 5'RACE technology, one expects a very low rate of overlapped reads. The high rate will be a clear signal of failed size selection during the library prep.


### Reads dropped in tags error correction and filtering

Sequencing reads that were dropped during the [barcode error correction and filtering](mixcr-refineTagsAndSort.md). High rate of dropped reads may signal either about poor quality of the library, significant under sequencing, mistakes at library pooling and various other reasons. A deeper look at other QC metrics and MiXCR reports may help to reveal the exact reason.

### UMI artificial diversity eliminated

Number of barcodes that were corrected or dropped during the barcode sequencing and PCR error correction. Barcodes with low sequence quality nucleotides that can’t be corrected (i.e. no barcodes with good quality within the allowed number of mutations) are dropped. It is normal to have up to 50% of barcodes corrected, however unexpectedly high numbers here is a signal about poor sequencing quality.

### Reads dropped in $tag error correction and whitelist

Sequencing reads that were dropped along with dropped bad quality barcodes during the UMI sequencing and PCR error correction. The high rate of dropped reads here signals about [poor sequencing quality](qc-sequencing-quality.md) and related issues.

### Reads dropped in tags filtering

Sequencing reads that were dropped in [barcode filtering](mixcr-refineTagsAndSort.md). High rate of dropped reads may signal either about poor quality of the library, significant under sequencing, mistakes at library pooling and various other reasons.

### Tag groups with no assembling feature

Number of tag groups which do not contain any reads that cover clonotype assembling feature. For amplicon protocols one should expect around zero tag groups with no assembling feature. A high rate here signals about either failed wet lab library preparation or misuse of the analysis settings. A typical scenario of wrong settings is when one specifies full-length VDJRegion as an assembling feature, while either the protocol is not designed for this purpose (i.e. multiplex protocol with primers in frameworks) or short sequencing was used (e.g. 150+150).

### Barcode collisions in clonotype assembly

Number of barcodes that resulted in multiple consensus sequences. Typically, one expects that one tag group (e.g. one UMI) results in exactly a single consensus sequence, so that the sequences with the same UMI are highly similar (within several mismatches or indels coming from PCR and sequencing errors). A tiny fraction of barcodes may result in more than one consensus due to the birth paradox. High collision rate signals about poor barcode diversity related to e.g. too short barcode sequence, protocol design problems or some wet lab issues.

### Unassigned alignments in clonotype assembly

Number of alignments that we dropped in [clonotype assembly](mixcr-assemble.md) because of the high barcode collision rate. Typically, one expects that the sequences with the same tag group (e.g. UMI) are coming from the same molecule and are highly similar (within several mismatches or indels coming from PCR and sequencing errors). When a single tag group has too many reads with completely different CDR3 sequences, MiXCR will drop them as unreliable. A high rate of unassigned alignments may signal about suboptimal design of the library architecture and preparation protocol. Manual inspection of raw reads will help to debug the exact problem.

### Reads used in clonotypes

Percent of the raw sequencing reads used in the resulting clonotypes. For high quality of data prepared with targeted VDJ protocols (either amplicon or fragmented), one expects that a significant percentage of raw sequencing reads are finally used to build clonotypes. Low percent of used clonotypes may signal about various problems, and other QC metrics may help to understand the reason.

### Alignments without assembling feature

Number of aligned reads that do not cover [clonotype assembling feature](mixcr-assemble.md). Each amplicon protocol is designed to cover a specific part of the VDJ region, depending on the position of primers. High rate of alignments which do not cover assembling feature specified signals about wrong setting for the assembling feature. The most common reason is that one is trying to extract full-length clonal sequences of the receptors (`VDJRegion`), but the library is prepared in such a way that it does not cover the full length of the receptor or a    short sequencing was used (to cover the full length one at least need 250+250 bp technology).

### Alignments dropped due to low sequence quality

Number of aligned sequencing reads that contain low sequencing quality nucleotides inside clonotype assembling feature (e.g. CDR3) and that MiXCR was unable to rescue by assigning to high quality clonotypes in error correction. High rate of such alignments is a clear signal of poor sequencing quality (check sequencing quality reports).

### Alignments clustered in PCR error correction

Number of aligned reads used in the clonotypes that were clustered in PCR error correction. Since the background PCR error rate is more or less same for all amplicon protocols, a high rate here would be a signal of misused analysis setting in most cases (for example use of an inappropriate reference library).

### Clonotypes clustered in PCR error correction

Number of clonotypes that were clustered in PCR error correction. Since the background PCR error rate is more or less same for all amplicon protocols, a high rate here would be a signal of misused analysis setting in most cases (for example use of a inappropriate reference library).

### Clones dropped in post-filtering

Number of clonotypes that were dropped in the post filtering.

### Alignments dropped in clones post-filtering

Number of aligned reads that were dropped along with clonotypes in the post filtering.