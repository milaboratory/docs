#!/usr/bin/env bash

mkdir -p results

ls raw/*_R1* | \
  parallel -j2 --line-buffer \
  'mixcr analyze amplicon -f \
    --species hsa \
    --starting-material rna \
    --receptor-type bcr \
    --5-end no-v-primers \
    --3-end c-primers \
    --adapters no-adapters \
    --assemble "-OassemblingFeatures={FR1Begin:FR4End}" \
    --umi-pattern "^N{"7"}(R1:*) \ ^(UMI:N{"12"})N{"4"}(R2:*)" \
    --report {=s:.*/:results/:;s:_R1.*:\.report:=} \
    {} \
    {=s:R1:R2:=} \
    {=s:.*/:results/:;s:_R1.*::=}'