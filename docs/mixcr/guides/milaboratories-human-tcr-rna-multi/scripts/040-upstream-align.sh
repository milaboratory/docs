mixcr align \
    --species hsa \
    -p default_4.0 \
	-OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OсParameters.parameters.floatingRightBound=false \
	--tag-pattern "^N{0:2}tggtatcaacgcagagt(UMI:N{14})N{21}(R1:*) \ ^N{20}(R2:*)" \
	--report results/Multi_TRA_FS115_1.report.txt \
	--json-report results/Multi_TRA_FS115_1.report.json \
	 raw/Multi_TRA_FS115_1_R1.fastq.gz \
	 raw/Multi_TRA_FS115_1_R2.fastq.gz \
	 results/Multi_TRA_FS115_1.vdjca