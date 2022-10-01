mkdir -p debug
mixcr align -f \
    --species mmu \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=false \
    -OjParameters.parameters.floatingRightBound=false \
    --not-aligned-R1 debug/S_s_R1.fastq \
    --not-aligned-R2 debug/S_s_R2.fastq \
    --report debug/S_s.report \
    --json-report debug/S_s.json \
     raw/S_s_R1.fastq.gz \
     raw/S_s_R2.fastq.gz \
     debug/S_s.vdjca