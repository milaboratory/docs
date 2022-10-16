mixcr postanalysis overlap \
	--metadata metadata.tsv \
	--default-downsampling count-umi-auto \
	--default-weight-function umi \
	--only-productive \
	--chains IGH \
	--tables pa/postanalysis.overlap.tsv \
	--preproc-tables pa/preproc.overlap.tsv \
	results/*.clns \
	pa/overlap.json.gz