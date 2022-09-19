mixcr postanalysis overlap -f \
    --factor-by Time,Marker \
    --metadata metadata.tsv \
    --default-downsampling count-umi-auto \
    --default-weight-function umi \
    --only-productive \
    --tables pa/o.tm.tsv \
    --preproc-tables pa/o.preproc.tm.tsv \
    results/*.clns \
    pa/o.tm.json.gz