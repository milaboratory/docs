mixcr align \
    --species hsa \
    -p generic-amplicon-with-umi \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OсParameters.parameters.floatingRightBound=true \
	--tag-pattern "^(R1:*) \ ^(UMI:N{12})N{12}(R2:*)" \
	--report results/mice_tumor_1.report.txt \
	--json-report results/mice_tumor_1.report.json \
	 raw/mice_tumor_1_R1.fastq.gz \
	 raw/mice_tumor_1_R2.fastq.gz \
	 results/mice_tumor_1.vdjca