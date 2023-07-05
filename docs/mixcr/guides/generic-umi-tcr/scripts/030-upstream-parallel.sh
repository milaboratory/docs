#!/usr/bin/env bash

mkdir -p results

ls raw/*_1* | \
  sed 's:SRR[0-9]*_:SRR\{\{n\}\}_:g' | \
  uniq | \
  parallel -j2 --line-buffer \
  'mixcr analyze generic-amplicon-with-umi -f \
    --species hsa \
    --rna \
    --rigid-left-alignment-boundary \
    --floating-right-alignment-boundary C \
    --tag-pattern '^(R1:*)\^(UMI:N{12})' \
    {} \
    {=s:OTHER_1:OTHER_2:=} \
    results/{=s:.*TCR-seq_::; s:_Homo.*::=}'