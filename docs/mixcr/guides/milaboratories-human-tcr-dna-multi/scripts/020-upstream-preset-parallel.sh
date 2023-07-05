#!/usr/bin/env bash

mkdir -p results

ls raw/*R1* |
	parallel -j 2 --line-buffer \
	"mixcr analyze milab-human-dna-tcr-multiplex \
	{} \
	{=s:.*/:results/:;s:_R.*::=}"