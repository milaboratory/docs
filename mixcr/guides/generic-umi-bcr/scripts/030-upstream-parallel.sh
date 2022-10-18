#!/usr/bin/env bash

mkdir -p results/

ls raw/*R1* | \
	parallel -j 4 \
	'mixcr analyze nebnext-mouse-bcr-full-length \
	{} \
	{=s:R1:R2:=} \
	{=s:.*/:results/:;s:_R.*::=}'