mixcr align \
    --species mmu \
    -p shotgun-base \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OсParameters.parameters.floatingRightBound=false \
	-OallowPartialAlignments=true \
	--report results/CD8T_REH_4h_rep1.report.txt \
	--json-report results/CD8T_REH_4h_rep1.report.json \
	 raw/CD8T_REH_4h_rep1.fastq.gz \
	 results/CD8T_REH_4h_rep1.vdjca