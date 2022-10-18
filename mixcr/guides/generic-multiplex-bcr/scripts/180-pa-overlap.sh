mixcr postanalysis overlap \
	--factor-by tissue,condition \
	--metadata metadata.tsv \
	--default-downsampling count-reads-auto \
	--default-weight-function read \
	--only-productive \
	--tables pa/postanalysis.overlap.tsv \
	--preproc-tables pa/preproc.overlap.tsv \
	results/*.clns \
	pa/overlap.tissue_condition.json.gz