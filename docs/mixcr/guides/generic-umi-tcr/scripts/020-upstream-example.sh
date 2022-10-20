mixcr analyze generic-tcr-amplicon-umi \
    --species hsa \
    --rna \
    --rigid-left-alignment-boundary \
    --floating-right-alignment-boundary C \
    --tag-pattern '^(R1:*)\^(UMI:N{12})' \
    raw/SRR{{n}}_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_1.fastq.gz \
    raw/SRR{{n}}_GSM4195461_TCR-seq_P15-T0-TIGIT_Homo_sapiens_OTHER_2.fastq.gz \
    results/P15-T0-TIGIT