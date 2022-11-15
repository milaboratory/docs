ls results/*_1.clns | parallel \
	'mixcr overlapScatterPlot \
		--downsampling none \
		--criteria "CDR3|NT|V|J" \
		{} \
		{=s:_1:_2:=} \
		{=s:.*/:figs/:;s:\d.clns:overlap.svg:=}'