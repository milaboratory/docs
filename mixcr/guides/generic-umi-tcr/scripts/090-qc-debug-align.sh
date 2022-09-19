mkdir -p debug
mixcr align -f \
    --species hsa \
    --tag-pattern '^(R1:*)\^(UMI:N{12})' \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=true \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    -OallowNoCDR3PartAlignments=true \
    -OallowPartialAlignments=true \
    --not-aligned-R1 debug/na.fastq \
    raw/SRR{{n}}_GSM4195532_TCR-seq_P23-T0-DPOS_Homo_sapiens_OTHER_1.fastq.gz \
    raw/SRR{{n}}_GSM4195532_TCR-seq_P23-T0-DPOS_Homo_sapiens_OTHER_2.fastq.gz \
    debug/P23-T0-DPOS_debug.vdjca