# `mixcr exportPreprocTables`

Export postanalysis [preprocessing summary tables](./mixcr-postanalysis.md#preprocessing-summary-tables) in a tabular form.

```
mixcr exportPreprocTables 
    [--chains <chain>]... 
    [-nw] [--verbose] [-h] 
    pa.json[.gz] table.tsv
```

Allows to export in tab-delimited (`.tsv`) or coma-separated (`.csv`) formats. Option `--chains` may be used to export results only for a specified chains.

The output name is actually a pattern that is used to export different chains into separate files. For example exporting [overlap](./mixcr-postanalysis.md#overlap-postanalysis) metrics with the following command:
```shell
> mixcr exportPreprocTables pa/o.pa.json pa/o.preproc.tsv 
```

will produce the following files in the output:
```shell
> ls preproc/* 

o.preproc.IGH.tsv
o.preproc.IGKL.tsv
o.preproc.TRAD.tsv
o.preproc.TRB.tsv
o.preproc.TRG.tsv
```
