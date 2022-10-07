# assemble overlapping fragmented sequencing reads
# First round
mixcr assemblePartial \
  --report results/CD8T_REH_4h_rep1.report.txt \
  --json-report results/CD8T_REH_4h_rep1.report.json \
  results/CD8T_REH_4h_rep1.vdjca \
  results/CD8T_REH_4h_rep1.passembled.1.vdjca

#Second round  
mixcr assemblePartial \
  --report results/CD8T_REH_4h_rep1.report.txt \
  --json-report results/CD8T_REH_4h_rep1.report.json \
  results/CD8T_REH_4h_rep1.passembled.1.vdjca \
  results/CD8T_REH_4h_rep1.passembled.2.vdjca