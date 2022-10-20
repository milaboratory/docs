head -500 results/IM_p01_Bmem_1_IGH.txt | sed 's:|:\\|:g' > figs/IM_p01_Bmem_1_IGH.txt
head -500 trees/IM_trees.txt | sed 's:|:\\|:g' > figs/IM_trees.txt
cp IM_newick/4992.tree figs/4992.tree


