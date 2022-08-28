#!/bin/bash

mixcr exportQc align -f results/*.clns plots/alignQc.svg

mixcr exportQc coverage -f \
debug/P23-T0-DPOS_debug.vdjca \
plots/P23-T0-DPOS_debug.coverage.svg


mixcr exportQc chainUsage -f results/*.clns plots/chainUsage.svg


mixcr exportPlots diversity -f \
--chains TRAD \
--metric ShannonWiener \
--plot-type boxplot-bindot \
--primary-group Time \
--primary-group-values T0,M1,M2 \
--facet-by Marker \
pa/i.json.gz \
plots/diversity_facets.svg


mixcr exportPlots diversity -f \
--chains TRAD \
--metric ShannonWiener \
--primary-group Marker \
--secondary-group Time \
--secondary-group-values T0,M1,M2 \
pa/i.json.gz \
plots/diversity.svg


mixcr exportPlots vUsage -f \
--chains TRAD \
--palette density \
--color-key Patient \
pa/i.json.gz \
plots/vUsage.svg


mixcr exportPlots overlap -f \
--chains TRAD \
--metric F1Index \
--palette density \
--color-key Patient \
pa/o.json.gz \
plots/overlap.svg


mixcr exportPlots overlap -f \
--chains TRAD \
--metric F1Index \
--palette density \
pa/o.time_marker.json.gz \
plots/overlap.time_marker.svg