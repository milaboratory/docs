mixcr align \
	-p generic-amplicon-with-umi
    --species mmu \
    --report result/Multi_TRA_10ng_3.align.report.txt \
    --json-report result/Multi_TRA_10ng_3.align.report.json \
    --tagPattern "^N{22}(R1:*) \ ^(UMI:N{17})(R2:*)" \
    -OvParameters.parameters.floatingLeftBound=false \
    -OjParameters.parameters.floatingRightBound=false \
    -OcParameters.parameters.floatingRightBound=false \
    raw/mouse_3_Cd4Cre_R1.fastq.gz \
    raw/mouse_3_Cd4Cre_R2.fastq.gz \
    results/mouse_3_Cd4Cre.vdjca