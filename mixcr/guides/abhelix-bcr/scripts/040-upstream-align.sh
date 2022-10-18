mixcr align \
    --species hsa \
    -p kAligner2_4.0 \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=true \
	--report results/SRR8365277_HIP1_female_IgG1.report \
	--json-report results/SRR8365277_HIP1_female_IgG1.json \
	 raw/SRR8365277_HIP1_female_IgG1_R1.fastq.gz \
	 raw/SRR8365277_HIP1_female_IgG1_R2.fastq.gz \
	 results/SRR8365277_HIP1_female_IgG1.vdjca