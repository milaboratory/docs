mixcr align \
	    -p default_4.0 \
    --species mmu \
    --tag-pattern '^(R1:*)\^(UMI:N{12})' \
    --report result/M1_4T1_replica1_Blood.align.report.txt \
    --json-report result/M1_4T1_replica1_Blood.align.report.json \
    -OvParameters.geneFeatureToAlign="VTranscriptWithout5UTRWithP" \
    -OvParameters.parameters.floatingLeftBound=false \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=false \
    raw/M1_4T1_replica1_Blood_R1.fastq.gz \
    raw/M1_4T1_replica1_Blood_R2.fastq.gz \
    results/M1_4T1_replica1_Blood.vdjca