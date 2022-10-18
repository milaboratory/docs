mkdir -p debug

mixcr align \
    --species hsa \
    -p default_4.0 \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OcParameters.parameters.floatingRightBound=true \
	--tag-pattern "^(R1:*) \ ^(UMI:N{12})N{12}(R2:*)" \
	--not-aligned-R1 debug/mice_tumor_2_notAligned_R1.fastq \
    --not-aligned-R2 debug/mice_tumor_2_notAligned_R2.fastq \
    -OallowNoCDR3PartAlignments=true \
    -OallowPartialAlignments=true \
	--report debug/mice_tumor_2.report.txt \
	--json-report debug/mice_tumor_2.report.json \
	 raw/mice_tumor_2_R1.fastq.gz \
	 raw/mice_tumor_2_R2.fastq.gz \
	 debug/mice_tumor_2.vdjca