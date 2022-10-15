mkdir -p pa/
mixcr postanalysis individual \
	--metadata metadata.tsv \
	--default-downsampling count-reads-auto \
	--default-weight-function read \
	--only-productive \
	--chains IGH \
	--tables pa/pa.i.tsv \
	--preproc-tables pa/preproc.i.tsv \
	results/*.clns \
	pa/individual.json.gz
