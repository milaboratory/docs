#!/usr/bin/env bash

mkdir -p results/

ls raw/*_1* | \
	parallel -j 4 \
	'mixcr analyze bcr-amplicon -f \
	+species mmu \
	+rna \
	+rigidLeftAlignmentBoundary \
	+rigidRightAlignmentBoundary \
	+tagPattern "^N{"4"}ccctcctttaattcccN{"22"}(R2:*)\^N{"4"}gaggagagagagagagN{"26"}(R1:*)" \
	+assembleClonotypesBy {"CDR1Begin:FR4End"} \
	{} \
	{=s:R1:R2:=} \
	{=s:.*/:results/:;s:_R.*::=}'