mixcr align \
    --species hsa \
    -p bundle-umi-kaligner2-v1-base \
    -tag-pattern '^N{0:2}tggtatcaacgcagagt(UMI:N{14})N{20}(R1:*) \ ^N{22}(R2:*)' \
	-OvParameters.geneFeatureToAlign="VTranscriptWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OcParameters.parameters.floatingRightBound=false
	--report results/DChu_p1_1.align.report.txt \
	--json-report results/DChu_p1_1.align.report.json \
	 raw/DChu_p1_1_R1.fastq.gz \
     raw/DChu_p1_1_R2.fastq.gz \
     results/DChu_p1_1.vdjca