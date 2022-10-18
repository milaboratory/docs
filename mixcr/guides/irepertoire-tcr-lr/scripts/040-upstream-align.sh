mixcr align \
    --species hsa \
    -p default_4.0 \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=true \
	-OjParameters.parameters.floatingRightBound=false \
	-OcParameters.parameters.floatingRightBound=true \
	--report results/CRC016_preTherapy.report.txt \
	--json-report results/CRC016_preTherapy.report.json \
	 raw/CRC016_preTherapy_R1.fastq.gz \
	 raw/CRC016_preTherapy_R2.fastq.gz \
	 results/CRC016_preTherapy.vdjca