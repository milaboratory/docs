# `mixcr exportTables`

Export [postanalysis](./mixcr-postanalysis.md) results in a tabular form.

```
mixcr exportTables [-f] 
    [--chains <chains>]...
    pa.json.gz
    dir/pa.(tsv|csv)
```

Allows to export in tab-delimited (`.tsv`) or coma-separated (`.csv`) formats. Option `--chains` may be used to export results only for a specified chains.

The output name is actually a pattern that is used to export different metrics into separate files. For example exporting [overlap](./mixcr-postanalysis.md#overlap-postanalysis) metrics with the following command:
```shell
> mixcr exportTables pa/o.json.gz pa/o.tsv 
```

will produce the following files in the output:
```shell
> ls pa/* 

o.F1Index.TRAD.tsv
o.F1Index.TRB.tsv
o.F1Index.TRG.tsv
o.F2Index.TRAD.tsv
o.F2Index.TRB.tsv
o.F2Index.TRG.tsv
...
```