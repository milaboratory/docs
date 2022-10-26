mixcr align \
    --species mmu \
    -p bundle-kaligner1-v1-base \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	--report results/S_s.report \
	--json-report results/S_s.json \
	 raw/S_s_R1.fastq.gz \
	 raw/S_s_R2.fastq.gz \
	 results/S_s.vdjca