#!/usr/bin/env bash

mkdir -p results

ls /raw/*.gz |
	parallel -j 2 --line-buffer \
	"mixcr analyze rnaseq-tcr-cdr3 \
	{} \
	{=s:.*/:results/:;s:\.fastq\.gz::=}"