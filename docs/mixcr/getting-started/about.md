# What is MiXCR

MiXCR is a universal software for fast and accurate analysis of raw T- or B- cell receptor repertoire sequencing data. It works with any kind of sequencing data:
 - Bulk repertoire sequencing data with or without UMIs
 - Single cell sequencing data including but not limited to 10x Genomics protocols 
 - RNA-Seq or any other kind of fragmented/shotgun data which may contain just a tiny fraction of target sequences
 - and any other kind of sequencing data containing TCRs or BCRs 

Powerful downstream analysis tools allow to obtain vector plots and tabular results for multiple measures. Key features include:
 - Ability to group samples by metadata values and compare repertoire features between groups 
 - Comprehensive repertoire normalization and filtering 
 - Statistical significance tests with proper p-value adjustment
 - Repertoire overlap analysis
 - Vector plots output (.svg / .pdf)
 - Tabular outputs

Other key features:

- Clonotype assembly by arbitrary gene feature, including *full-length* variable region
- PCR / Sequencing error correction with or without aid of UMI or Cell barcodes
- Robust and dedicated aligner algorithms for maximum extraction with zero false-positive rate
- Supports any custom barcode sequences architecture (UMI / Cell)
- _Human_, _Mice_, _Rat_, _Spalax_, _Alpaca_, _Monkey_
- Support IMGT reference
- Barcodes error-correction
- Adapter trimming
- Optional CDR3 reconstruction by assembling overlapping fragmented sequencing reads into complete CDR3-containing contigs when the read position is floating (e.g. shotgun-sequencing, RNA-Seq etc.)
- Optional contig assembly to build longest possible TCR/IG sequence from available data (with or without aid of UMI or Cell barcodes) 
- Comprehensive quality control reports provided at all the steps of the pipeline
- Regions not covered by the data may be imputed from germline
- Exhaustive output information for clonotypes and alignments:
    - nucleotide and amino acid sequences of all immunologically relevant regions (FR1, CDR1, ..., CDR3, etc..)
    - identified V, D, J, C genes
    - comprehensive information on nucleotide and amino acid mutations
    - positions of all immunologically relevant points in output sequences
    - and many more informative columns
- Ability to backtrack fate of each raw sequencing read through t

# Who uses MiXCR 
MiXCR is used by 8 out of 10 world leading pharmaceutical companies in the R&D for:
- Vaccine development
- Antibody discovery
- Cancer immunotherapy research

Widely adopted by academic community with 1000+ citations in peer-reviewed scientific publications.

