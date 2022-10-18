mixcr align \
    --species hsa \
    -p kAligner2_4.0 \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OcParameters.parameters.floatingRightBound=false \
	--tagPattern "^N{22}(R1:*) \ ^(UMI:N{17})(R2:*)" \
	--report results/13_d60_LN_germCenterB.report.txt \
	--json-report results/13_d60_LN_germCenterB.report.json \
	 raw/13_d60_LN_germCenterB_R1.fastq.gz \
	 raw/13_d60_LN_germCenterB_R2.fastq.gz \
	 results/13_d60_LN_germCenterB.vdjca