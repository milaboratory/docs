#!/usr/bin/env bash
mkdir -p trees

mixcr findShmTrees \
	--report trees/IM_trees.log \
	results/*.reassigned.clns \
	trees/IM.shmt
