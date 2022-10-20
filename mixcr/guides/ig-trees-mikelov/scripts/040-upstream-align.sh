mixcr align \
    -p bundle-umi-kaligner2-v1-base \
    --species human \
	-OvParameters.geneFeatureToAlign="VRegionWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	-OcParameters.parameters.floatingRightBound=false \
	--tagPattern "^N{19}(R1:*)\^tggtatcaacgcagagtac(UMI:N{19})tct>{2}(R2:*)" \
	--report results/IM_p01_Bmem_1.align.report.txt \
	--json-report results/IM_p01_Bmem_1.align.report.json \
	 raw/IM_p01_Bmem_1_R1.fastq.gz \
	 raw/IM_p01_Bmem_1_R2.fastq.gz \
	 results/IM_p01_Bmem_1.vdjca