mkdir -p pa/
mixcr postanalysis individual \
	--metadata metadata.tsv \
	--default-downsampling count-umi-auto \
	--default-weight-function umi \
	--only-productive \
	--tables pa/pa.i.tsv \
	--preproc-tables pa/preproc.i.tsv \
	results/*.clns \
	pa/individual.json.gz
