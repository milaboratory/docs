#!/usr/bin/env bash

mkdir -p figs

mixcr exportQc align -f results/*.vdjca figs/20-alignQc.svg
mixcr exportQc chainUsage -f results/*.vdjca figs/30-chainUsageQc.svg
mixcr exportQc coverage -f results/FebControl1.vdjca figs/40-coverage.svg