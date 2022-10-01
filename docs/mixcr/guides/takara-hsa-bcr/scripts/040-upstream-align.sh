mixcr align \
    --species hsa \
    -p kAligner2_4.0 \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OjParameters.parameters.floatingRightBound=true \
	--report results/FebControl1.report.txt \
	--json-report results/FebControl1.report.json \
	 raw/FebControl1_R1.fastq.gz \
	 raw/FebControl1_R2.fastq.gz \
	 results/FebControl1.vdjca