ls results/*repl1.clns | parallel \
	'mixcr overlapScatterPlot \
		--chains TRA,TRB \
		--downsampling none \
		--criteria "CDR3|NT|V|J" \
		--no-log \
		{} \
		{=s:repl1:repl2:=} \
		{=s:.*/:figs/:;s:_.*:.svg:=}'