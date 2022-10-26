#!/usr/bin/env bash

mkdir -p results

ls raw/*R1* |
	parallel -j 2 --line-buffer \
	"mixcr analyze milab-human-tcr-dna-multiplex-cdr3 \
	{} \
	{=s:.*/:results/:;s:_R.*::=}"