mixcr findAlleles \
	--report results/IM.findAlleles.report.txt \
	--json-report results/IM.findAlleles.report.json \
	--export-alleles-mutations results/IM_alleles.tsv \
	--export-library results/IM_alleles.json \
	--output-template {file_dir_path}/{file_name}.reassigned.clns \
	results/*.clns
