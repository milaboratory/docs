MiXCR postanalysis block includes two main types of analysis:

- Individual (Biophysics, Diversity, V/J/VJ-Usage, CDR3/V-Spectratype)
- Overlap analysis

```
mixcr postanalysis individual
    [-f] [--drop-outliers] [-nw] [--only-productive] [--verbose]
    [--chains <chains>] --default-downsampling
    <defaultDownsampling> [--metadata <metadata>]
    [--preproc-tables <preprocOut>] [--tables <tablesOut>]
    [--group <isolationGroups>]... [-O <String=String>]...
    [<inOut>...]
```


