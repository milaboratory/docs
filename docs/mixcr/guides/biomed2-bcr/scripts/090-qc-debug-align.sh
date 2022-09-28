mkdir -p debug
mixcr align -f \
	--species hsa \
	-p kAligner2_4.0 \
	--tag-pattern "^N{32}(R1:*)\^N{26}(R2:*)" \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
    -OallowNoCDR3PartAlignments=true \
    -OallowPartialAlignments=true \
    --not-aligned-R1 debug/SRR8365459_HIP1_female_notAligned_R1.fastq \
    --not-aligned-R2 debug/SRR8365459_HIP1_female_notAligned_R2.fastq \
    --report debug/SRR8365459_HIP1_female_debug.report \
     raw/SRR8365459_HIP1_female_R1.fastq.gz raw/SRR8365459_HIP1_female_R2.fastq.gz \
     debug/SRR8365459_HIP1_female_debug.vdjca