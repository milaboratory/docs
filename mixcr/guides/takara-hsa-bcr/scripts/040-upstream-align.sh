mixcr align \
    --species hsa \
    -p bundle-umi-kaligner2-v1-base \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OсParameters.parameters.floatingRightBound=true \
	--tag-pattern "^N{7}(R1:*) \ ^(UMI:N{12})N{4}(R2:*)" \
	--report results/FebControl1.report.txt \
	--json-report results/FebControl1.report.json \
	 raw/FebControl1_R1.fastq.gz \
	 raw/FebControl1_R2.fastq.gz \
	 results/FebControl1.vdjca