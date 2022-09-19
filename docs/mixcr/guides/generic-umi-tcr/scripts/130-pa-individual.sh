mixcr postanalysis individual -f \
    --metadata metadata.tsv \
    --default-downsampling count-umi-auto \
    --default-weight-function umi \
    --only-productive \
    --tables pa/i.tsv \
    --preproc-tables pa/i.preproc.tsv \
    results/*.clns \
    pa/i.json.gz