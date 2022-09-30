mkdir -p debug

mixcr align \
    --species hsa \
    -p kAligner2_4.0 \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OjParameters.parameters.floatingRightBound=true \
	--not-aligned-R1 debug/MISC9_notAligned_R1.fastq \
    --not-aligned-R2 debug/MISC9_notAligned_R2.fastq \
	--report debug/MISC9.report.txt \
	--json-report debug/MISC9.report.json \
	 raw/MISC9_R1.fastq.gz \
	 raw/MISC9_R2.fastq.gz \
	 debug/MISC9.vdjca