#!/usr/bin/env bash

mkdir -p figs

mixcr exportQc align results/*.clns figs/030-alignQc.svg
mixcr exportQc chainUsage results/*.clns figs/050-chainUsage.svg

# check that the commands just work (no output)
mixcr exportReports --json results/P15-T0-TIGIT.clns results/P15-T0-TIGIT.report.json