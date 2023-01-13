mkdir -p debug

mixcr align \
    --species hsa \
    -p  bundle-umi-kaligner2-v1-base \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OcParameters.parameters.floatingRightBound=true \
	--tag-pattern "^N{7}(R1:*) \ ^(UMI:N{12})N{4}(R2:*)" \
	--not-aligned-R1 debug/MISC9_notAligned_R1.fastq \
    --not-aligned-R2 debug/MISC9_notAligned_R2.fastq \
	--report debug/MISC9.report.txt \
	--json-report debug/MISC9.report.json \
	 raw/MISC9_R1.fastq.gz \
	 raw/MISC9_R2.fastq.gz \
	 debug/MISC9.vdjca