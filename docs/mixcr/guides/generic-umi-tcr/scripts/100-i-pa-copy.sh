mixcr exportPlots diversity -f \
  --plot-type boxplot-bindot \
  --primary-group Time \
  --primary-group-values T0,M1,M2 \
  --facet-by Marker \
  pa/i.json.gz \
  figs/080-diversity-facets.svg

mixcr exportPlots diversity -f \
  --primary-group Marker \
  --secondary-group Time \
  --secondary-group-values T0,M1,M2 \
  pa/i.json.gz \
  figs/090-diversity-secondary-grouping.svg


mixcr exportPlots vUsage -f \
  --palette density \
  --color-key Patient \
  pa/i.json.gz \
  figs/100-vUsage.svg