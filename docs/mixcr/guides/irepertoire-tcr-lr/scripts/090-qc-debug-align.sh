mkdir -p debug
mixcr align \
    -s hsa \
    -p default_4.0 \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=true \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=true \
    -OallowPartialAlignments=true \
    -OallowNoCDR3PartAlignments=true \
    raw/CRC003_therapy-08_R1.fastq.gz raw/CRC003_therapy-08_R2.fastq.gz \
    debug/CRC003_therapy-08_debug.vdjca