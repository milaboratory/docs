mixcr align \
    --species hsa \
    -p generic-amplicon \
	-OvParameters.geneFeatureToAlign="VGeneWithP" \
	-OvParameters.parameters.floatingLeftBound=false \
	-OjParameters.parameters.floatingRightBound=false \
	--report results/DNA77_repl1.align.report.txt \
	--json-report results/DNA77_repl1.align.report.json \
	 raw/DNA77_repl1_R1.fastq.gz \
	 results/DNA77_repl1.vdjca