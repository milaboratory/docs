mixcr analyze bcr_amplicon \
    +species mmu \
    +rna \
    +rigidLeftAlignmentBoundary \
    +rigidRightAlignmentBoundary \
    +tagPattern ^N{4}ccctcctttaattccc{21}(R1:*)\^N{4}gaggagagagagagagN{26}(R2:*) \
    +assembleClonotypesBy {CDR1Begin:FR4End} \
    raw/M1_4T1_replica1_Blood_R1.fastq.gz \
    raw/M1_4T1_replica1_Blood_R2.fastq.gz \
    results/M1_4T1_replica1_Blood