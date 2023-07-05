mixcr align \
    --species hsa \
    -p generic-amplicon \
    --tag-pattern "^N{32}(R1:*)\^N{26}(R2:*)" \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	--report results/SRR8365468_HIP2_male.report \
	--json-report results/SRR8365468_HIP2_male.json \
	 raw/SRR8365468_HIP2_male_R1.fastq.gz \
	 raw/SRR8365468_HIP2_male_R2.fastq.gz \
	 results/SRR8365468_HIP2_male.vdjca