
mixcr assemble \
	--report results/mouse_3_Cd4Cre.assemble.report.txt \
	--json-report results/mouse_3_Cd4Cre.assemble.report.json \
	-OassemblingFeatures={FR1Begin:FR4End} \
	-OseparateByC=true \
	mouse_3_Cd4Cre.corrected.vdjca \
	mouse_3_Cd4Cre.clns