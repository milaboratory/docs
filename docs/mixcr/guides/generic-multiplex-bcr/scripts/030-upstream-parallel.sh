#!/usr/bin/env bash

mkdir -p results/

ls raw/*_1* | \
	parallel -j 4 \
	'mixcr analyze bcr-amplicon -f \
	--species mmu \
	--rna \
	--rigid-left-alignment-boundary \
	--rigid-right-alignment-boundary \
	--tagPattern "^N{"4"}ccctcctttaattccc{"21"}(R1:*)\^N{"4"}gaggagagagagagagN{"26"}(R2:*)" \
	--assemble-clonotypes-by {CDR1Begin:FR4End} \
	{} \
	{=s:R1:R2:=} \
	{=s:.*/:results/:;s:_R.*::=}'