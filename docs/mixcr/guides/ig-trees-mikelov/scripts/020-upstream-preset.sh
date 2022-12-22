mixcr analyze generic-bcr-amplicon-umi \
	--species human \
	--tag-pattern "^N{19}(R1:*)\^tggtatcaacgcagagtac(UMI:N{19})tct>{2}(R2:*)" \
    --rna \
    --rigid-left-alignment-boundary \
    --rigid-right-alignment-boundary C \
    --assemble-clonotypes-by VDJRegion \
    --split-clones-by C \
    --remove-step exportClones \
	raw/IM_p01_PBL_1_R1.fastq.gz \
	raw/IM_p01_PBL_1_R2.fastq.gz \
	results/IM_p01_PBL_1
