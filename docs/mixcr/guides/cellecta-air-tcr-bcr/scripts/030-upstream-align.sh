mixcr align \
    --species hsa \
    -p bundle-umi-kaligner2-v1-base \
    -tag-pattern '^(R1:*) \ ^(UMI:N{14})' \
    --rna
	-OvParameters.parameters.floatingLeftBound=true \
	-OjParameters.parameters.floatingRightBound=false \
	-OcParameters.parameters.floatingRightBound=true
	--report results/Sample1.align.report.txt \
	--json-report results/Sample1.align.report.json \
	 raw/Sample1_R1.fastq.gz \
     raw/Sample1_R2.fastq.gz \
     results/Sample1.vdjca