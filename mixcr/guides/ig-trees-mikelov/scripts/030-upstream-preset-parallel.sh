mkdir results/

ls raw/*R1* | parallel -j4 \
'mixcr analyze generic-bcr-amplicon-umi \
	--species human \
	--tag-pattern "^N{"19"}(R1:*)\^tggtatcaacgcagagtac(UMI:N{"19"})tct>{"2"}(R2:*)" \
	--rna \
	--rigid-left-alignment-boundary \
	--rigid-right-alignment-boundary C \
	--assemble-clonotypes-by VDJRegion \
	--split-clones-by C \
	--remove-step exportClones \
	{} \
	{=s:R1:R2:=} \
    {=s:.*/:results/:;s:_R.*::=}'