mkdir -p pa/
mixcr postanalysis individual \
	--chains TRA,TRB \
	--default-downsampling count-reads-min \
	--default-weight-function read \
	--tables pa/pa.i.tsv \
	--preproc-tables pa/preproc.i.tsv \
	results/*.clns \
	pa/individual.json.gz
