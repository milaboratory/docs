mkdir -p debug

mixcr align \
    --species hsa \
    -p kAligner2_4.0 \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OcParameters.parameters.floatingRightBound=false \
	--tag-pattern "^N{22}(R1:*) \ ^(UMI:N{17})(R2:*)" \
	--report debug/13_d60_LN_germCenterB.report.txt \
	--json-report debug/13_d60_LN_germCenterB.report.json \
	--not-aligned-R1 debug/13_d60_LN_germCenterB_notAligned_R1.fastq \
    --not-aligned-R2 debug/13_d60_LN_germCenterB_notAligned_R2.fastq \
	 raw/13_d60_LN_germCenterB_R1.fastq.gz \
	 raw/13_d60_LN_germCenterB_R2.fastq.gz \
	 debug/13_d60_LN_germCenterB.vdjca