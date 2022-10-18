mixcr exportPlots diversity \
    --metadata metadata.tsv \
    --chain IGH \
    --plot-type boxplot \
    --metric inverseSimpsonIndex \
    --primary-group genotype \
    pa/individual.json.gz \
    figs/diversity.pdf
