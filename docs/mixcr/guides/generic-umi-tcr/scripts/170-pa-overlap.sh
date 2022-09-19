mixcr postanalysis overlap -f \
    --metadata metadata.tsv \
    --default-downsampling count-umi-auto \
    --default-weight-function umi \
    --only-productive \
    --tables pa/o.tsv \
    --preproc-tables pa/o.preproc.tsv \
    results/*.clns \
    pa/o.json.gz