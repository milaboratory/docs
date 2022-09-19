#!/usr/bin/env bash

mkdir -p results

ls raw/*_1* | \
  sed 's:SRR[0-9]*_:SRR\{\{n\}\}_:g' | \
  uniq | \
  parallel -j2 --line-buffer \
  'mixcr analyze amplicon -f \
    --species hsa \
    --starting-material rna \
    --receptor-type tcr \
    --5-end v-primers \
    --3-end c-primers \
    --adapters adapters-present \
    --umi-pattern "^(R1:*)\^(UMI:N{"12"})" \
    {} \
    {=s:OTHER_1:OTHER_2:=} \
    results/{=s:.*TCR-seq_::; s:_Homo.*::=}'