mkdir -p debug
mixcr align -f \
    --species hsa \
    -p kAligner2_4.0 \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=true \
    -OjParameters.parameters.floatingRightBound=false \
    -OallowNoCDR3PartAlignments=true \
    -OallowPartialAlignments=true \
    --not-aligned-R1 debug/SRR8365280_HIP1_female_IgG4_notAligned_R1.fastq \
    --not-aligned-R2 debug/SRR8365280_HIP1_female_IgG4_notAligned_R2.fastq \
    -r debug/SRR8365280_HIP1_female_IgG4_debug.report \
     raw/SRR8365280_HIP1_female_IgG4_R1.fastq.gz raw/SRR8365280_HIP1_female_IgG4_R2.fastq.gz \
     debug/SRR8365280_HIP1_female_IgG4_debug.vdjca