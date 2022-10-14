mixcr exportPlots diversity \
	--metadata metadata.tsv \
	--plot-type boxplot \
	--metric normalizedShannonWienerIndex \
	--primary-group tissue \
	--facet-by condition \
	--primary-group-values Tumor,LN,DLN,Blood,BM \
	pa/individual.json.gz \
	figs/diversity.svg
