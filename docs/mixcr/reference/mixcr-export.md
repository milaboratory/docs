# Export

Export clonotypes or raw alignments in a tabular form.

![](pics/export-light.svg#only-light)
![](pics/export-dark.svg#only-dark)

MiXCR uses four highly efficient binary formats that hold exhaustive information on the clonotypes, alignments, barcodes and original sequencing reads:

- `.vdjca` produced by [`align`](./mixcr-align.md) and holds alignments
- `.clns` produced by [`assemble`](./mixcr-assemble.md) and [`assembleContigs`](./mixcr-assembleContigs.md) holds clonotypes
- `.clna` produced by [`assemble`](./mixcr-assemble.md) and holds both clonotypes and alignments
- `.shmt` produced by [`findShmTrees`](./mixcr-findShmTrees.md) and holds clonotypes, alignments and SHM trees

MiXCR provides functions for export [alignments](#alignments), [clonotype tables](#clonotype-tables), [SHM trees tables](#shm-trees-tables) and [SHM with nodes tables](#shm-trees-with-nodes-tables) in a tab-delimited way. For human-readable formatted output see [pretty export](./mixcr-exportPretty.md).

## Clonotype tables

```
mixcr exportClones 
    [--chains <chains>] 
    [--filter-out-of-frames] 
    [--filter-stops] 
    [--split-by-tag <tag>] 
    [--split-files-by <splitFilesBy>]... 
    [--dont-split-files] 
    [--no-header] 
    [--drop-default-fields] 
    [--prepend-columns] 
    [<exportField>]...
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    data.(clns|clna) [table.tsv]
```

Exports tab-delimited table of alignments from `.clns` and `.clna` files.

Command line options:

`data.(clns|clna)`
: Path to input file with clones

`[table.tsv]`
: Path where to write export table. Will write to output if omitted.

`-c, --chains <chains>`
: Limit export to specific chain (e.g. TRA or IGH) (fractions will be recalculated). Default value determined by the preset.

`-o, --filter-out-of-frames`
: Exclude clones with out-of-frame clone sequences (fractions will be recalculated). Default value determined by the preset.

`-t, --filter-stops`
: Exclude sequences containing stop codons (fractions will be recalculated). Default value determined by the preset.

`--split-by-tag <tag>`
: Split clones by tag values Default value determined by the preset.

`--split-files-by <splitFilesBy>`
: Split files by (currently the only supported value is "geneLabel:reliableChain" etc... ). Default value determined by the preset.

`--dont-split-files`
: Don't split files.

`--no-header`
: Don't print first header line, print only data Default value determined by the preset.

`--drop-default-fields`
: Don't export fields from preset.

`--prepend-columns`
: Added columns will be inserted before default columns. By default columns will be added after default columns

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

`<exportField>`
: A list of [export fields](#export-fields)

## Alignments

```
mixcr exportAlignments [-f]
    [--chains <chains>] 
    [--no-header] 
    [--drop-default-fields] 
    [--prepend-columns] 
    [<exportField>]...
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    data.(vdjca|clns|clna) [table.tsv]
```

Exports tab-delimited alignments from `.vdjca`, `.clns` and `.clna` files.

Command line options:

`data.[vdjca|clns|clna]`
: Path to input file

`[table.tsv]`
: Path where to write export table. Will write to output if omitted.

`-c, --chains <chains>`
: Limit export to specific chain (e.g. TRA or IGH) (fractions will be recalculated) Default value determined by the preset.

`--no-header`
: Don't print first header line, print only data Default value determined by the preset.

`--drop-default-fields`
: Don't export fields from preset.

`--prepend-columns`
: Added columns will be inserted before default columns. By default columns will be added after default columns

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

`<exportField>`
: A list of [export fields](#export-fields)

## SHM trees tables

```
mixcr exportShmTrees [-f]
    [--ids <id>[,<id>...]]... 
    [--filter-min-nodes <n>] 
    [--filter-min-height <n>] 
    [--preset <preset>]
    [--preset-file <file>]
    [--no-header] 
    [<exportField>]...
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    [[--filter-in-feature <gene_feature>] [--pattern-max-errors <n>] (--filter-aa-pattern <pattern> | --filter-nt-pattern <pattern>)] 
    trees.shmt [trees.tsv]
```

Exports tab-delimited alignments from `.shmt` file.

Command line options:

`trees.shmt`
: Input file produced by 'findShmTrees' command.

`[trees.tsv]`
: Path to output table. Print in stdout if omitted.

`--no-header`
: Don't print column names

`--ids <id>[,<id>...]`   
: Filter specific trees by id

`--filter-min-nodes <n>` 
: Minimal number of nodes in tree

`--filter-min-height <n>`
: Minimal height of the tree

`-p, --preset <preset>`
: Specify preset of export fields (possible values: 'full', 'min'; 'full' by default)

`-pf, --preset-file <presetFile>`
: Specify preset file of export fields

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

`<exportField>`
: A list of [export fields](#export-fields)

Filter by pattern options:

`--filter-in-feature <gene_feature>`
: Match pattern inside specified gene feature. Default: CDR3

`--pattern-max-errors <n>`
: Max allowed subs & indels. Default: 0

`--filter-aa-pattern <pattern>`
: Filter specific trees by aa pattern.

`--filter-nt-pattern <pattern>`
: Filter specific trees by nt pattern.

## SHM trees with nodes tables

```
mixcr exportShmTreesWithNodes [-f]
    [--ids <id>[,<id>...]]... 
    [--filter-min-nodes <n>] 
    [--filter-min-height <n>] 
    [--onlyObserved] 
    [--preset <preset>] 
    [--preset-file <presetFile>] 
    [--no-header]
    [<exportField>]...
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose]  
    [--help] 
    [[--filter-in-feature <gene_feature>] [--pattern-max-errors <n>] (--filter-aa-pattern <pattern> | --filter-nt-pattern <pattern>)] 
    trees.shmt [trees.tsv]
```

Exports tab-delimited alignments from `.shmt` file.

Command line options:

`trees.shmt`
: Input file produced by 'findShmTrees' command.

`[trees.tsv]`
: Path where to write output export table. Print in stdout if omitted.

`--ids <id>[,<id>...]`   
: Filter specific trees by id

`--filter-min-nodes <n>`
: Minimal number of nodes in tree

`--filter-min-height <n>`
: Minimal height of the tree

`--no-header`
: Don't print column names

`--onlyObserved`
: Exclude nodes that was reconstructed by algorithm

`-p, --preset <preset>`
: Specify preset of export fields (possible values: 'min', 'full'; 'full' by default)

`-pf, --preset-file <presetFile>`
: Specify preset file of export fields

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose warning messages.

`-h, --help`
: Show this help message and exit.

`<exportField>`
: A list of [export fields](#export-fields)

Filter by pattern options:

`--filter-in-feature <gene_feature>`
: Match pattern inside specified gene feature. Default: CDR3

`--pattern-max-errors <n>`
: Max allowed subs & indels. Default: 0

`--filter-aa-pattern <pattern>`
: Filter specific trees by aa pattern.

`--filter-nt-pattern <pattern>`
: Filter specific trees by nt pattern.

## Examples

### Default export

```shell
> mixcr exportClones clones.clns clones.tsv
```

The resulting tab-delimited text file will contain default set of columns (`--preset full`) which includes clonotype abundances, nucleotide and amino acid clonotype sequences, Phred qualities, all or just best hit for V, D, J and C genes, corresponding alignments, nucleotide and amino acid sequences of gene regions present in sequence, etc. Example output (for BCR full-length data):

| cloneId | cloneCount         | cloneFraction        | allVHitsWithScore   | allDHitsWithScore             | allJHitsWithScore | allCHitsWithScore  | allVAlignments                                                                                                                                                                                                                                                                            | allDAlignments                                                                                                                                                    | allJAlignments                                                        | allCAlignments | nSeqFR1                                                                     | minQualFR1 | nSeqCDR1                 | minQualCDR1 | nSeqFR2                                             | minQualFR2 | nSeqCDR2                 | minQualCDR2 | nSeqFR3                                                                                                         | minQualFR3 | nSeqCDR3                                                        | minQualCDR3 | nSeqFR4                         | minQualFR4 | aaSeqFR1                  | aaSeqCDR1 | aaSeqFR2          | aaSeqCDR2 | aaSeqFR3                              | aaSeqCDR3             | aaSeqFR4    | refPoints                                                                           | targetSequences                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | targetQualities                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|---------|--------------------|----------------------|---------------------|-------------------------------|-------------------|--------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------|----------------|-----------------------------------------------------------------------------|------------|--------------------------|-------------|-----------------------------------------------------|------------|--------------------------|-------------|-----------------------------------------------------------------------------------------------------------------|------------|-----------------------------------------------------------------|-------------|---------------------------------|------------|---------------------------|-----------|-------------------|-----------|---------------------------------------|-----------------------|-------------|-------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1       | 157166.58695588264 | 0.10205277935802338  | IGHV3-8*00(887.9)   |                               | IGHJ4*00(175.5)   | IGHG2B_hinge(26.6) | 0&#124;293&#124;316&#124;43&#124;336&#124;SG0CSG11CST18AST20GSG28CSA37GSA68CSA77CSA81CSA87GSG88CSG91ASC92TSA94TST95CSC97GSC98GSG101ASG103CSA115TSG117CST144GST149CSA154CSA156CSG157CSG160ASG169CST192ASG214ASC230TSC234GST237GSA238CSG253CSC254ASA259GSA260TSG266AST278ASA290G&#124;891.0 |                                                                                                                                                                   | 24&#124;68&#124;68&#124;342&#124;386&#124;ST31CSC39TSG45T&#124;178.0  |                | CAGGTGCAGCTCGTGGAGACGGGGGGAGCCTTGGTGCGGCCTGGGGGGTCTCTGAGACTCTCCTGTGCCGCCTCT | 58         | GGCTTCCCCTTCGCTAATTTCGGG | 58          | ATAACCTGGGTCCGCCTGCCTCCAGGAAAGGGGCTCGAGTGGGTCGCAGAC | 58         | ATTACTCCTGATGGTGGTACCACA | 58          | TACTATGCAGACTCCGTGAAGGGCCGGTTCACCATCTCCAAAGACAACGCCAAGAATACGGTGGCTCTGCAAATGAACACACTGAGTCCTGAAGACACGGCCGTATATTAC | 58         | TGTGCGACCCCGATGTATGACCACTGG                                     | 13          | GGTCAGGGTACCCAGGTCACCGTCTCCTCAG | 58         | QVQLVETGGALVRPGGSLRLSCAAS | GFPFANFG  | ITWVRLPPGKGLEWVAD | ITPDGGTT  | YYADSVKGRFTISKDNAKNTVALQMNTLSPEDTAVYY | CATPMYDHW             | GQGTQVTVSS_ | ::::43:118:142:193:217:328:-3:336:::::342:-4:355:386::                              | CCTCGCGGCCCAGCCGGCCATGGCCGGCCCGGGAGCGGCCGCTCAGGTGCAGCTCGTGGAGACGGGGGGAGCCTTGGTGCGGCCTGGGGGGTCTCTGAGACTCTCCTGTGCCGCCTCTGGCTTCCCCTTCGCTAATTTCGGGATAACCTGGGTCCGCCTGCCTCCAGGAAAGGGGCTCGAGTGGGTCGCAGACATTACTCCTGATGGTGGTACCACATACTATGCAGACTCCGTGAAGGGCCGGTTCACCATCTCCAAAGACAACGCCAAGAATACGGTGGCTCTGCAAATGAACACACTGAGTCCTGAAGACACGGCCGTATATTACTGTGCGACCCCGATGTATGACCACTGGGGTCAGGGTACCCAGGTCACCGTCTCCTCAGCGCACCACAGCGAAGACCCCTCGGCGCGCCAGGCCTGCACTAGTGGTGCGCCGGT                                                                                                                                                    | +;33335:4<=678=8=9?98:=9?9@8C?9C@9:9:A9@9:9[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[...........................[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[9968<7694:891::69@988:::>?:9:>8::::99<8:9:9::;997798<79                                                                                                                                                    |
| 2       | 113072.80475962501 | 0.07342142002972953  | IGHV3-8*00(887.9)   |                               | IGHJ4*00(175.5)   | IGHG2B_hinge(26.6) | 0&#124;293&#124;316&#124;43&#124;336&#124;SG0CSG11CST18ASG28CSA37GSA68CSA77CSA81CSA87GSG88CSG91ASC92TSA94TST95CSC97GSC98GSG101ASG103CSA115TSG117CST144GST149CSA154CSA156CSG157CSG160ASG169CST192ASG214ASC230TSC234GST237GSA238CSG253CSC254ASA259GSA260TSG266AST278ASA290G&#124;905.0      |                                                                                                                                                                   | 24&#124;68&#124;68&#124;342&#124;386&#124;ST31CSC39TSG45T&#124;178.0  |                | CAGGTGCAGCTCGTGGAGACTGGGGGAGCCTTGGTGCGGCCTGGGGGGTCTCTGAGACTCTCCTGTGCCGCCTCT | 58         | GGCTTCCCCTTCGCTAATTTCGGG | 58          | ATAACCTGGGTCCGCCTGCCTCCAGGAAAGGGGCTCGAGTGGGTCGCAGAC | 58         | ATTACTCCTGATGGTGGTACCACA | 58          | TACTATGCAGACTCCGTGAAGGGCCGGTTCACCATCTCCAAAGACAACGCCAAGAATACGGTGGCTCTGCAAATGAACACACTGAGTCCTGAAGACACGGCCGTATATTAC | 58         | TGTGCGACCCCGATGTATGACCACTGG                                     | 13          | GGTCAGGGTACCCAGGTCACCGTCTCCTCAG | 58         | QVQLVETGGALVRPGGSLRLSCAAS | GFPFANFG  | ITWVRLPPGKGLEWVAD | ITPDGGTT  | YYADSVKGRFTISKDNAKNTVALQMNTLSPEDTAVYY | CATPMYDHW             | GQGTQVTVSS_ | ::::43:118:142:193:217:328:-3:336:::::342:-4:355:386::                              | CCTCGCGGCCCAGCCGGCCATGGCCGGCCCGGGAGCGGCCGCTCAGGTGCAGCTCGTGGAGACTGGGGGAGCCTTGGTGCGGCCTGGGGGGTCTCTGAGACTCTCCTGTGCCGCCTCTGGCTTCCCCTTCGCTAATTTCGGGATAACCTGGGTCCGCCTGCCTCCAGGAAAGGGGCTCGAGTGGGTCGCAGACATTACTCCTGATGGTGGTACCACATACTATGCAGACTCCGTGAAGGGCCGGTTCACCATCTCCAAAGACAACGCCAAGAATACGGTGGCTCTGCAAATGAACACACTGAGTCCTGAAGACACGGCCGTATATTACTGTGCGACCCCGATGTATGACCACTGGGGTCAGGGTACCCAGGTCACCGTCTCCTCAGCGCACCACAGCGAAGACCCCTCGGCGCGCCAGGCCTGCACTAGTGGTGCGCCGGTNGT                                                                                                                                                 | +<33345:5==789>9>:@:::=;A;@9E@;EA:;:;A;@:;:[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[...........................[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[9968<7694:891::69@988:::>?:9:>8::::99<8:9:9::;997798<79!.,                                                                                                                                                 |
| 3       | 17367.706440640646 | 0.011277350661302765 | IGHV3-3*00(1386.3)  | IGHD4(35),IGHD2(30)           | IGHJ4*00(224.4)   | IGHG2C_hinge(40.5) | 0&#124;295&#124;316&#124;141&#124;436&#124;SG11CSA14GST18ASG35TSG144TSA175T&#124;1391.0                                                                                                                                                                                                   | 26&#124;33&#124;57&#124;453&#124;460&#124;&#124;35.0;54&#124;60&#124;102&#124;451&#124;457&#124;&#124;30.0                                                        | 22&#124;68&#124;68&#124;471&#124;517&#124;&#124;230.0                 |                | CAGGTGCAGCTCGTGGAGACTGGGGGAGGATTGGTTCAGGCTGGGGGCTCTCTGAGACTCTCCTGTGCAGCCTCT | 58         | GGACGCACCTTCAGTAGCTATGCC | 58          | ATGGGCTGGTTCCGCCAGGCTCCAGGGAAGGAGCGTGAGTTTGTATCAGCT | 58         | ATTAGCTGGAGTGGTGGTAGCACA | 58          | TTCTATGCAGACTCCGTGAAGGGCCGATTCACCATCTCCAGAGACAACGCCAAGAACACGGTGTATCTGCAAATGAACAGCCTGAAACCTGAGGACACGGCCGTTTATTAC | 58         | TGTGCAGCAGCAACGCACCGACACGATGGGTTGGCGCTAATCGGGGAGTATGACTACTGG    | 9           | GGCCAGGGGACCCAGGTCACCGTCTCCTCAG | 58         | QVQLVETGGGLVQAGGSLRLSCAAS | GRTFSSYA  | MGWFRQAPGKEREFVSA | ISWSGGST  | FYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYY | CAAATHRHDGLALIGEYDYW  | GQGTQVTVSS_ | ::::141:216:240:291:315:426:-2:436:453:-7:-5:460:471:-2:486:517::                   | CTCGCGGCCCAGCCGGCCATGGCCGGTTGGGCCGCGAGTAATAACAATCCAGCGGCTGCCGTAGGCAATAGGTATTTCATTTTAAATTCCTCCTGAANCCTCGCGGCCCAGCCGGCCATGGCCGGCCCGGGAGCGGCCGCTCAGGTGCAGCTCGTGGAGACTGGGGGAGGATTGGTTCAGGCTGGGGGCTCTCTGAGACTCTCCTGTGCAGCCTCTGGACGCACCTTCAGTAGCTATGCCATGGGCTGGTTCCGCCAGGCTCCAGGGAAGGAGCGTGAGTTTGTATCAGCTATTAGCTGGAGTGGTGGTAGCACATTCTATGCAGACTCCGTGAAGGGCCGATTCACCATCTCCAGAGACAACGCCAAGAACACGGTGTATCTGCAAATGAACAGCCTGAAACCTGAGGACACGGCCGTTTATTACTGTGCAGCAGCAACGCACCGACACGATGGGTTGGCGCTAATCGGGGAGTATGACTACTGGGGCCAGGGGACCCAGGTCACCGTCTCCTCAGAACCCAAGACACCAAAACCACAACCGGCGCGCCAGGCCTGCACTAGTGGTGCGCCGGTTGCGCCGGTCGGT | CCCCCGGGGGGGGGGGGGGGGGGGGGGGGFGGGGGGCGGDDFGGGEGGGFGGGGGEEGGGGGGGGGGGGGGGGFFDFGGGGGGGGEGFA9EGFGGGG!);22335:5><89;>=<<@==>>?@B>=G@@B@>?@AC@I?F=[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[************************************************************[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[++8+7+6+4++++6+1+9<+++++99+++?+++++++9+++7+8*778++*85**888[[30[26.1CCC8 |
| 4       | 14959.662854752114 | 0.009713738792425266 | IGHV3-3*00(1386.3)  | IGHD4(35),IGHD2(30)           | IGHJ4*00(224.4)   | IGHG2C_hinge(40.5) | 0&#124;295&#124;316&#124;45&#124;340&#124;SG11CSA14GSG35TSG144T&#124;1419.0                                                                                                                                                                                                               | 26&#124;33&#124;57&#124;357&#124;364&#124;&#124;35.0;54&#124;60&#124;102&#124;355&#124;361&#124;&#124;30.0                                                        | 22&#124;68&#124;68&#124;375&#124;421&#124;SA46T&#124;216.0            |                | CAGGTGCAGCTCGTGGAGTCTGGGGGAGGATTGGTTCAGGCTGGGGGCTCTCTGAGACTCTCCTGTGCAGCCTCT | 58         | GGACGCACCTTCAGTAGCTATGCC | 58          | ATGGGCTGGTTCCGCCAGGCTCCAGGGAAGGAGCGTGAGTTTGTATCAGCT | 58         | ATTAGCTGGAGTGGTGGTAGCACA | 58          | TACTATGCAGACTCCGTGAAGGGCCGATTCACCATCTCCAGAGACAACGCCAAGAACACGGTGTATCTGCAAATGAACAGCCTGAAACCTGAGGACACGGCCGTTTATTAC | 58         | TGTGCAGCAGCAACGCACCGACACGATGGGTTGGCGCTAATCGGGGAGTATGACTACTGG    | 9           | GGCCAGGGGTCCCAGGTCACCGTCTCCTCAG | 58         | QVQLVESGGGLVQAGGSLRLSCAAS | GRTFSSYA  | MGWFRQAPGKEREFVSA | ISWSGGST  | YYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYY | CAAATHRHDGLALIGEYDYW  | GQGSQVTVSS_ | ::::45:120:144:195:219:330:-2:340:357:-7:-5:364:375:-2:390:421::                    | CTCCTCGCGGCCCAGCCGGCCATGGCCGGCCCGGGAGCGGCCGCTCAGGTGCAGCTCGTGGAGTCTGGGGGAGGATTGGTTCAGGCTGGGGGCTCTCTGAGACTCTCCTGTGCAGCCTCTGGACGCACCTTCAGTAGCTATGCCATGGGCTGGTTCCGCCAGGCTCCAGGGAAGGAGCGTGAGTTTGTATCAGCTATTAGCTGGAGTGGTGGTAGCACATACTATGCAGACTCCGTGAAGGGCCGATTCACCATCTCCAGAGACAACGCCAAGAACACGGTGTATCTGCAAATGAACAGCCTGAAACCTGAGGACACGGCCGTTTATTACTGTGCAGCAGCAACGCACCGACACGATGGGTTGGCGCTAATCGGGGAGTATGACTACTGGGGCCAGGGGTCCCAGGTCACCGTCTCCTCAGAACCCAAGACACCAAAACCACAACCGGCGCGCCAGGCCTGCACTAGTGGTGCGCCGGTTGCGCCGGTT                                                                                                    | AC+;33446<6>>:;=A?A>DA??>BCAC<DC@CG@C?BEBEAF=[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[************************************************************[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[++8+7+6+4++++6+1+9<+++++99+++?+++++++9+++7+8*778++48753;8:0----[-[-C                                                                                                    |
| 5       | 13653.505182577868 | 0.008865613097855052 | IGHV3S61*00(1332.4) | IGHD5(76)                     | IGHJ7*00(210.9)   | IGHG2B_hinge(40)   | 0&#124;297&#124;316&#124;63&#124;360&#124;SG0CSG39CSG103CST152ASA156CSG157AST174CSC185TSC221T&#124;1359.0,                                                                                                                                                                                | 18&#124;36&#124;54&#124;371&#124;389&#124;SA20G&#124;76.0,                                                                                                        | 26&#124;74&#124;74&#124;394&#124;442&#124;SG29CSA38T&#124;212.0,      | ,              | CAGGTGCAGCTCGTGGAGTCTGGGGGAGGCTTGGTGCAGCCTGGGGGGTCTCTGAGACTCTCCTGTGCAGCCTCT | 58         | GGATTCACTTTGGATTATTATGCC | 58          | ATAGCCTGGTTCCGCCAGGCCCCAGGGAAGGAGCGCGAGGGGGTCTCATGT | 58         | ATAAGTCATAGTGATGGTAGCACA | 58          | CACTATGCAGATTCCGTGAAGGGCCGATTCACCATCTCCAGAGACAATGCCAAGAACACGGTGTATCTGCAAATGAACAGCCTGAAACCTGAGGACACGGCCGTTTATTAC | 58         | TGTGCGACAGATGCGCTTTCGCAGTGCGGTAGTAGCTGGTACCAAGACGCCATGGACTTCTGG | 9           | GGCAAAGGGACCCTGGTCACCGTCTCCTCAG | 58         | QVQLVESGGGLVQPGGSLRLSCAAS | GFTLDYYA  | IAWFRQAPGKEREGVSC | ISHSDGST  | HYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYY | CATDALSQCGSSWYQDAMDFW | GKGTLVTVSS_ | ::::63:138:162:213:237:348:1:360:371:0:0:389:394:-6:411:442::,::::::::::::::::::::: | CTCGCGGCCCNNNCGGCCNNCCTCGCGGCCCAGCCGGCCATGGCCGGCCCGGGAGCGGCCGCTCAGGTGCAGCTCGTGGAGTCTGGGGGAGGCTTGGTGCAGCCTGGGGGGTCTCTGAGACTCTCCTGTGCAGCCTCTGGATTCACTTTGGATTATTATGCCATAGCCTGGTTCCGCCAGGCCCCAGGGAAGGAGCGCGAGGGGGTCTCATGTATAAGTCATAGTGATGGTAGCACACACTATGCAGATTCCGTGAAGGGCCGATTCACCATCTCCAGAGACAATGCCAAGAACACGGTGTATCTGCAAATGAACAGCCTGAAACCTGAGGACACGGCCGTTTATTACTGTGCGACAGATGCGCTTTCGCAGTGCGGTAGTAGCTGGTACCAAGACGCCATGGACTTCTGGGGCAAAGGGACCCTGGTCACCGTCTCCTCAGAACCCAAGACACCAAA,ACTAGTGGTGCGCCGGTTNGTCTTCGCTGTGGTGCGCCGGT                                                                                         | CCCCCGGGG[!!![[[[[!!,:22235:5=<78:>;;;>;:<::@<:8;@:<:89;=>=@9:9[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[***************************************************************[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[''='<':(7'''';'1,;(='<9>'''88(':7;'!GEEFCGFCGGFGGGGGGCCCCC                                                                                         |

One can customize the list of fields that will be exported. For example, in order to export just clone count, best hits for V and J genes with corresponding alignments and CDR3 amino acid sequence, one can do:

```shell
> mixcr exportClones \
    -count \
    -vHit -jHit \
    -vAlignment -jAlignment \
    -aaFeature CDR3 \
    clones.clns \
    clones.tsv
```

The columns in the resulting file will be exported in exactly the same order as parameters on the command line.

For convenience, MiXCR provides two predefined sets of fields for exporting: `min` (will export minimal required information about clones or alignments) and `full` (used by default); one can use these sets by specifying the `--preset` option:

```shell
> mixcr exportClones --preset min clones.clns clones.txt
```

One can add additional columns to the preset in the following way:

```shell
> mixcr exportClones --preset min -qFeature CDR2 clones.clns clones.tsv
```

One can also put all specify export fields in a separate file

```shell
> cat myFields.txt
-vHits
-dHits
-feature CDR3
 
> mixcr exportClones --preset-file myFields.txt clones.clns clones.tsv
```

### UMI libraries

```shell
> mixcr exportClones \
    -uniqueTagCount umi \
    -p full \
    clones.clns \
    clones.tsv
```

There are several options to export columns related to tagged analysis. In the above example we pass `-uniqueTagCount` option to add a column with UMI count. We also specify option to use full preset of other columns.

It is also possible to export full list of UMIs with their read counts that were used to build a clonotype:

```shell
> mixcr exportClones \
    -uniqueTagCount umi \
    -tagCounts \
    -p full \
    clones.clns \
    clones.tsv
```

| cloneId | uniqueTagCountUMI | tagCounts                                                   | cloneCount         | ... |
|---------|-------------------|-------------------------------------------------------------|--------------------|-----|
| 1       | 901               | {AGGATCTAGCTC=47.0,GATTCAGGCAAA=12.0,GTTTGTATATAG=119.0 ... | 157166.58695588264 | ... |
| 2       | 123               | {AGGGTACACCAG=12.0,GTTTAAAAATAA=42.0,ATTACAGCCTAA=19.0 ...  | 113072.80475962501 | ... |
| 3       | 110               | {GCAAGCGCTGGC=40.0,TCGAAAAAAACA=42.0,AGCACAGGTGAT=113.0 ... | 17367.706440640646 | ... |
| 4       | 98                | {CGATCGAAGGAT=47.0,ACCCGCATCAGA=112.0,TCAGTTTGTAAA=1.0 ...  | 14959.662854752114 | ... |
| 5       | 82                | {CTGTGGATAGTA=117.0,ATCCAGAAGCGT=12.0,ATCGGTGATCAC=93.0 ... | 13653.505182577868 | ... |
| ...     | ...               | ...                                                         | ...                | ... |

### Single cell libraries

Export paired TCR-alpha/beta or BCR-heavy/light clonotype pairs from single cell data:

```shell
> mixcr exportClones \
    --split-by-tag cell \
    -tag cell \
    -cellGroup \
    -uniqueTagCount UMI \
    -count \
    -vFamily -jFamily \
    -aaFeature CDR3 \
    -nFeatureImputed VDJRegion \
    clones.clns \
    clones.tsv
```

Here we use `--split-by-tag` option to export cells that contain the same clonotype on separate rows, `-tag` to export cell barcode for each clonotype and `-cellGroup` which is cell identifier.

| tagValueCELL | cellGroup | uniqueTagCountUMI | cloneCount      | bestVFamily | bestJFamily | nSeqCDR3                                                           | aaSeqVDJRegionImputed                                                                                                                 |
|--------------|-----------|-------------------|-----------------|-------------|-------------|--------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| CTAGGCTAGC   | 11        | 198               | 10716.64        | IGLV1       | IGLJ3       | TGCGGAACATGGGATAGCAGCCTGAGTGCTTGGGTGTTC                            | QVQLVESGGALVRPGGSLRLSCAASGFPFANFGITWVRLPPGKGLEWVADITPDGGTTYYADSVKGRFTISKDNAKNTVALQMNTLSPEDTAVYYCATPMYDHWGQGTQVTVSS_                   |
| CTAGGCTAGC   | 11        | 93                | 11372.5962501   | IGKV1       | IGKJ1       | TGTCAACAGTCTGAAAATCTCCCTCCGACGTTC                                  | QVQLVETGGGLVQAGGSLRLSCAASGRTFSSYAMGWFRQAPGKEREFVSAISWSGGSTFYADSVKGRFTISRDNAKNTVYLQMNSLKPEDTAVYYCAAATHRHDGLALIGEYDYWGQGTQVTVSS_        |
| CTAGGCTAGC   | 11        | 80                | 17467.0640646   | IGHV2       | IGHJ5       | TGTGCACGGATACGGAGGTATAGCAGTGGCTGGTACTCAACGAACTGGTTCGACCCCTGG       | QVQLVETGGGLVQAGGSLRLSCAASGFTFDDYVIGWFRQAPGKEREGVSCINSSDGSTYYADSVKGRFTISSDNAKNTVYLQMNSLKPEDTAVYYCAAELIDRLIAIMGASCPLEYDYWGQGTQVTVSS_    |
| TGCTGAATCG   | 187       | 98                | 12959.5475211   | IGKV3       | IGKJ2       | TGTCAACTCGATTGCATTGCACCTCCGACGTTC                                  | QVQLVETGGRLGAGWGVSETLLCLLWIQFP\*I\*YRVVPPGPREGA\*GSWMY\*FQRW\*YIPSRLREGPIHHLPRQFEECGISAHEQLET*RHGRLLLCKRSGRMCCVYRGLLPRHGLLGQRDPGHRLL_ |
| TGCTGAATCG   | 187       | 82                | 11653.182577868 | IGHV1       | IGHJ2       | TGTGCACTACGTAGCAAGGTATAGCAGCTAGGCTGCTGGTGCAACTAGGCTAGCTTCGACCCCTGG | QLQLVESGGGLVQAGGSLRLSCAASGRTDSRYTMGWFRQAPGKEREIVAQISPFGGNQYYADSVKGRFTISRDNAKNTVYLQMNSLKAEDTAVYYCYAEGPGRWVAGTWTRDYWGQGTQVTISS_         |
| ...          | ...       | ...               | ...             | ...         | ...         | ...                                                                | ...                                                                                                                                   |

In the above example we specified particular columns to export. To export all columns one can use simply:

```shell
> mixcr exportClones \
    --split-by-tag cell \
    -tag cell \
    -cellGroup \
    -uniqueTagCount UMI \
    -p full \
    clones.clns \
    clones.tsv
```

### Export contigs with imputation

When V-D-J contigs assembled with [assembleContigs](./mixcr-assembleContigs.md) does not cover all gene features, it still might be useful to impute non covered parts from germline (for example for the purposes of synthesis). Typically, there may be uncovered parts in `VDJRegion` for example due to long CDR3 region and non-overlapping R1 or R2, or in case of fragmented data (RNA-Seq or 10x single cell).

```shell
> mixcr exportClones \
    -aaFeatureImputed VDJRegion \
    -nFeatureImputed VDJRegion \
    -p min \
    clones.clns clones.tsv  
```

MiXCR allows to export gene features with imputation using `-nFeatureImputed` and `-aaFeatureImputed` export fields. The resulting sequences will have imputed letters in lower case:

| cloneId | aaSeqImputedVDJRegion                                                                                                             | nSeqImputedVDJRegion                                                                                                                                                                                                                                                                                                                                                                              | cloneCount         | cloneFraction        | allVHitsWithScore  | ... |
|---------|-----------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------|----------------------|--------------------|-----|
| 1550    | evqlvesggglvqpggslrlscaasgftfssyamswvrqapgkgpEXXAAITSGGIXXXXXX*RAXHHLQRQCQR*E*GVSANEQPET*GHGRLLLRSGRI*ARLLGPGDPGHCLL_             | gaggtgcagctggtggagtctgggggaggcttggtgcagcctggggggtctctgagactctcctgtgcagcctctggattcaccttcagtagctatgccatgagctgggtccgccaggctccaggaaaggggcccgAGTNGGNCGCAGCTATTACTAGTGGTGGTATCNNAANATGNNANNCNNCNTGAAGGGCNNTTCACCATCTCCAGAGACAATGTCAACGCTAAGAATAGGGTGTATCTGCAAATGAACAGCCTGAAACCTGAGGACACGGCCGTCTATTACTGCGAAGCGGTAGGATATGAGCTCGACTACTGGGGCCAGGGGACCCAGGTCACTGTCTCCTCAG                                    | 14959.662854752114 | 0.009713738792425266 | IGHV3-3*00(1386.3) | ... |
| 2739    | QVQLVETGGALVHPGGSLRLSCVVSGFT*IIMP*PGSARSRGRSVRGSXVLvvvmvahtmqtp*radspspettprtrcick*ta*nlrtrpfiTAQQPTSGRAMKVVSTRNSMITGARGPRSPSLQ   | CAGGTGCAGCTCGTGGAGACGGGTGGAGCGTTGGTGCACCCTGGGGGGTCGCTGAGACTCTCCTGTGTCGTCTCTGGATTCACTTGAATTATTATGCCATAGCCTGGTTCCGCCAGGTCCCGGGGAAGGAGCGTGAGGGGATCTCANGTATTAGtagtagtgatggtagcacatactatgcagactccgtgaagggccgattcaccatctccagagacaacgccaagaacacggtgtatctgcaaatgaacagcctgaaacctgaggacacggccgtttattacTGCGCAGCAGCCCACTTCGGGGCGTGCTATGAAGGTAGTTTCGACGCGAAACTCTATGATCACTGGGGCCAGGGGACCCAGGTCACCGTCTCTTCAG     | 17367.706440640646 | 0.011277350661302765 | IGHV3-3*00(1386.3) | ... |
| 2940    | QVQLVEXGGGLXQXGGSLKLSCAASGLTFDDYAIGWFRQVPGKXREGIXCVGSRGXxyyadsvXXXXXXXIXXXXXTXSLDLNSLIPEDTATYQCAAVTSDLGCTHYMLQNDIEYDYWGRGTQVTVST_ | CAGGTGCAGCTCGTGGAGNCNGGGGGAGGNTTGGNGCAGNCTGGGGGGTCTCTGAAACTCTCCTGTGCAGCCTCTGGACTCACTTTCGACGATTATGCCATCGGCTGGTTCCGNCAGGTTCCAGGGAAGNAGCGCGAGGGGATCTGNTGTGTCGGTAGTCGAGGNNNCNCatactatgcagactccgtgaANNNNNGATTNNNCATNNCCATTGNCANCGNCAANNACACGNAGTCTCTGGATTTGAACAGCCTGATCCCTGAGGACACGGCCACATATCAATGTGCGGCAGTCACCTCGGACCTGGGATGTACGCACTATATGTTGCAGAATGATATCGAGTATGACTACTGGGGCCGGGGGACCCAGGTCACCGTCTCGACAG | 157166.58695588264 | 0.10205277935802338  | IGHV3-8*00(887.9)  | ... |
| 3283    | qvqlvesggglvqaggslrlscaasgrtfssyamgwfrqapgkerefvaaiswXGSTXXYADSAKDRFVISRDNGKNMAYLXLTSLKPDDTGIYLCAADIQCQTDPRHLPFGSWGWGQGTQVTVSS_   | caggtgcagctggtagagtctgggggaggattggtgcaggctgggggctctctgagactctcctgtgcagcctctggacgcaccttcagtagctatgccatgggctggttccgccaggctccagggaaggagcgtgagtttgtagcagctattagctggANAGGTTCAACCANGNACTATGCCGACTCCGCGAAGGACCGATTCGTCATTTCCAGAGACAACGGCAAGAACATGGCGTACTTGTANTTAACCAGCCTGAAGCCTGACGACACTGGCATTTATCTCTGTGCGGCGGACATCCAGTGTCAGACTGACCCCCGTCATCTCCCTTTTGGTTCCTGGGGTTGGGGCCAGGGGACGCAAGTCACCGTCTCCTCGG       | 113072.80475962501 | 0.07342142002972953  | IGHV3-8*00(887.9)  | ... |

One can also use default presets with imputation (all gene features will use imputation option):

```shell
> mixcr exportClones \
    -aaFeatureImputed VDJRegion \
    -nFeatureImputed VDJRegion \
    -p fullImputed \
    clones.clns clones.tsv  
```

## Export fields

### Common fields

These fields available for `exportAlignments`, `exportClones` and `exportShmTreesWithNodes` (for `exportShmTreesWithNodes` only for nodes with clones):

`-targets`
: Export number of targets

`-vHit`
: Export best V hit

`-dHit`
: Export best D hit

`-jHit`
: Export best J hit

`-cHit`
: Export best C hit

`-vGene`
: Export best V hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-dGene`
: Export best D hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-jGene`
: Export best J hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-cGene`
: Export best C hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-vFamily`
: Export best V hit family name (e.g. TRBV12 for TRBV12-3*00)

`-dFamily`
: Export best D hit family name (e.g. TRBV12 for TRBV12-3*00)

`-jFamily`
: Export best J hit family name (e.g. TRBV12 for TRBV12-3*00)

`-cFamily`
: Export best C hit family name (e.g. TRBV12 for TRBV12-3*00)

`-vHitScore`
: Export score for best V hit

`-dHitScore`
: Export score for best D hit

`-jHitScore`
: Export score for best J hit

`-cHitScore`
: Export score for best C hit

`-vHitsWithScore`
: Export all V hits with score

`-dHitsWithScore`
: Export all D hits with score

`-jHitsWithScore`
: Export all J hits with score

`-cHitsWithScore`
: Export all C hits with score

`-vHits`
: Export all V hits

`-dHits`
: Export all D hits

`-jHits`
: Export all J hits

`-cHits`
: Export all C hits

`-vGenes`
: Export all V gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-dGenes`
: Export all D gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-jGenes`
: Export all J gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-cGenes`
: Export all C gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-vFamilies`
: Export all V gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-dFamilies`
: Export all D gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-jFamilies`
: Export all J gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-cFamilies`
: Export all C gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-vAlignment`
: Export best V alignment

`-dAlignment`
: Export best D alignment

`-jAlignment`
: Export best J alignment

`-cAlignment`
: Export best C alignment

`-vAlignments`
: Export all V alignments

`-dAlignments`
: Export all D alignments

`-jAlignments`
: Export all J alignments

`-cAlignments`
: Export all C alignments

`-qFeature <gene_feature>`
: Export quality string of specified gene feature

`-nFeatureImputed <gene_feature>`
: Export nucleotide sequence of specified gene feature using letters from germline (marked lowercase) for uncovered regions

`-allNFeaturesImputed [<from_reference_point> <to_reference_point>]`
: Export nucleotide sequence using letters from germline (marked lowercase) for uncovered regions for all gene features between specified reference points (in separate columns).

For example, `-allNFeaturesImputed FR3Begin FR4End` will export `-nFeatureImputed FR3`, `-nFeatureImputed CDR3`, `-nFeatureImputed FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-aaFeatureImputed <gene_feature>`
: Export amino acid sequence of specified gene feature using letters from germline (marked lowercase) for uncovered regions

`-allAaFeaturesImputed [<from_reference_point> <to_reference_point>]`
: Export amino acid sequence using letters from germline (marked lowercase) for uncovered regions for all gene features between specified reference points (in separate columns).

For example, `-allAaFeaturesImputed FR3Begin FR4End` will export `-aaFeatureImputed FR3`, `-aaFeatureImputed CDR3`, `-aaFeatureImputed FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-minFeatureQuality <gene_feature>`
: Export minimal quality of specified gene feature

`-allMinFeaturesQuality [<from_reference_point> <to_reference_point>]`
: Export minimal quality for all gene features between specified reference points (in separate columns).

For example, `-allMinFeaturesQuality FR3Begin FR4End` will export `-minFeatureQuality FR3`, `-minFeatureQuality CDR3`, `-minFeatureQuality FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-allNFeaturesWithMinQuality [<from_reference_point> <to_reference_point>]`
: Export nucleotide sequences and minimal quality for all gene features between specified reference points (in separate columns).

For example, `-allNFeaturesWithMinQuality FR3Begin FR4End` will export `-nFeature FR3`, `-minFeatureQuality FR3`, `-nFeature CDR3`, `-minFeatureQuality CDR3`, `-nFeature FR4`, `-minFeatureQuality FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-allNFeaturesImputedWithMinQuality [<from_reference_point> <to_reference_point>]`
: Export nucleotide sequences and minimal quality for all gene features between specified reference points (in separate columns).

For example, `-allNFeaturesImputedWithMinQuality FR3Begin FR4End` will export `-nFeatureImputed FR3`, `-minFeatureQuality FR3`, `-nFeatureImputed CDR3`, `-minFeatureQuality CDR3`, `-nFeatureImputed FR4`, `-minFeatureQuality FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-avrgFeatureQuality <gene_feature>`
: Export average quality of specified gene feature

`-allAvrgFeaturesQuality [<from_reference_point> <to_reference_point>]`
: Export average quality for all gene features between specified reference points (in separate columns).

For example, `-allAvrgFeaturesQuality FR3Begin FR4End` will export `-avrgFeatureQuality FR3`, `-avrgFeatureQuality CDR3`, `-avrgFeatureQuality FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-positionInReferenceOf <reference_point>`
: Export position of specified reference point inside reference sequences (clonal sequence / read sequence).

`-allPositionsInReference [<from_reference_point> <to_reference_point>]`
: Export position inside reference sequences (clonal sequence / read sequence) for all reference points between specified (in separate columns).

For example, `-allPositionsInReference FR3Begin FR4End` will export `-positionInReferenceOf FR3Begin`, -positionInReferenceOf CDR3Begin`, -positionInReferenceOf CDR3End` and `-positionInReferenceOf FR4End`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-positionOf <reference_point>`
: Export position of specified reference point inside target sequences (clonal sequence / read sequence).

`-allPositions [<from_reference_point> <to_reference_point>]`
: Export position inside target sequences (clonal sequence / read sequence) for all reference points between specified (in separate columns).

For example, `-allPositions FR3Begin FR4End` will export `-positionOf FR3Begin`, -positionOf CDR3Begin`, -positionOf CDR3End` and `-positionOf FR4End`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-defaultAnchorPoints`
: Outputs a list of default reference points (like CDR2Begin, FR4End, etc. see documentation bellow
for the full list and formatting)

`-targetSequences`
: Export aligned sequences (targets), separated with comma

`-targetQualities`
: Export aligned sequence (target) qualities, separated with comma

`-vIdentityPercents`
: V alignment identity percents

`-dIdentityPercents`
: D alignment identity percents

`-jIdentityPercents`
: J alignment identity percents

`-cIdentityPercents`
: C alignment identity percents

`-vBestIdentityPercent`
: V best alignment identity percent

`-dBestIdentityPercent`
: D best alignment identity percent

`-jBestIdentityPercent`
: J best alignment identity percent

`-cBestIdentityPercent`
: C best alignment identity percent

`-chains`
: Chains

`-topChains`
: Top chains

`-geneLabel <label>`
: Export gene label (i.e. ReliableChain)

`-tagCounts`
: All tags with counts

`-tag <tag_name>`
: Tag value (i.e. CELL barcode or UMI sequence)

`-allTags <(Sample|Cell|Molecule)>`
: Tag values (i.e. CELL barcode or UMI sequence) for all available tags in separate columns.

Tag type will be used for filtering tags for export.

`-uniqueTagCount <tag_name>`
: Unique tag count

`-allUniqueTagsCount <(Sample|Cell|Molecule)>`
: Unique tag count for all available tags in separate columns.

Tag type will be used for filtering tags for export.


These fields available for both `exportAlignments` and `exportClones`:

`-lengthOf <gene_feature>`
: Export length of specified gene feature.

`-allLengthOf [<from_reference_point> <to_reference_point>]`
: Export length for all gene features between specified reference points (in separate columns).

For example, `-allLengthOf FR3Begin FR4End` will export `-lengthOf FR3`, `-lengthOf CDR3`, `-lengthOf FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-nFeature <gene_feature>`
: Export nucleotide sequence of specified gene feature

`-allNFeatures [<from_reference_point> <to_reference_point>]`
: Export nucleotide sequences for all gene features between specified reference points (in separate columns).

For example, `-allNFeatures FR3Begin FR4End` will export `-nFeature FR3`, `-nFeature CDR3`, `-nFeature FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-aaFeature <gene_feature>`
: Export amino acid sequence of specified gene feature

`-allAaFeatures [<from_reference_point> <to_reference_point>]`
: Export amino acid sequence for all gene features between specified reference points (in separate columns).

For example, `-allAaFeatures FR3Begin FR4End` will export `-aaFeature FR3`, `-aaFeature CDR3`, `-aaFeature FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-nMutations <gene_feature>`
: Extract nucleotide mutations for specific gene feature; relative to germline sequence.

`-allNMutations [<from_reference_point> <to_reference_point>]`
: Extract nucleotide mutations relative to germline sequence for all gene features between specified reference points (in separate columns).

For example, `-allNMutations FR3Begin FR4End` will export `-nMutations FR3`, `-nMutations CDR3`, `-nMutations FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-nMutationsRelative <gene_feature> <relative_to_gene_feature>`
: Extract nucleotide mutations for specific gene feature relative to another feature.

`-aaMutations <gene_feature>`
: Extract amino acid mutations for specific gene feature

`-allAaMutations [<from_reference_point> <to_reference_point>]`
: Extract amino acid nucleotide mutations relative to germline sequence for all gene features between specified reference points (in separate columns).

For example, `-allAaMutations FR3Begin FR4End` will export `-aaMutations FR3`, `-aaMutations CDR3`, `-aaMutations FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-aaMutationsRelative <gene_feature> <relative_to_gene_feature>`
: Extract amino acid mutations for specific gene feature relative to another feature.

`-mutationsDetailed <gene_feature>`
: Detailed list of nucleotide and corresponding amino acid mutations. Format `<nt_mutation>:<aa_mutation_individual>:<aa_mutation_cumulative>`, where `<aa_mutation_individual>` is an expected amino acid mutation given no other mutations have occurred, and `<aa_mutation_cumulative>` amino acid mutation is the observed amino acid mutation combining effect from all others.

`-allMutationsDetailed [<from_reference_point> <to_reference_point>]`
: Detailed list of nucleotide and corresponding amino acid mutations for all gene features between specified reference points (in separate columns).

For example, `-allMutationsDetailed FR3Begin FR4End` will export `-mutationsDetailed FR3`, `-mutationsDetailed CDR3`, `-mutationsDetailed FR4`.

By default, boundaries will be got from analysis parameters if possible or `FR1Begin FR4End` otherwise.

`-mutationsDetailedRelative <gene_feature> <relative_to_gene_feature>`
: Detailed list of nucleotide and corresponding amino acid mutations written, positions relative to specified gene feature. Format <nt_mutation>:<aa_mutation_individual>:<aa_mutation_cumulative>, where <aa_mutation_individual> is an expected amino acid mutation given no other mutations have occurred, and <aa_mutation_cumulative> amino acid mutation is the observed amino acid mutation combining effect from all other. WARNING: format may change in following versions.


### Alignment-specific fields

The following fields are only available for `exportAlignments`:

`-readIds`
: Id(s) of read(s) corresponding to alignment

`-descrsR1`
: Export description lines from initial `.fasta` or `.fastq` file for R1 reads (only available if `-OsaveOriginalReads= true` was used in `align` command)

`-descrsR2`
: Export description lines from initial `.fastq` file for R2 reads (only available if `-OsaveOriginalReads=true` was used in `align`n command)

`-readHistory`
: Read history

`-cloneId`
: To which clone alignment was attached (make sure using `.clna` file as input for `exportAlignments`)

`-cloneIdWithMappingType`
: To which clone alignment was attached with additional info on mapping type (make sure using `.clna` file as input for `exportAlignments`)

### Clonotype-specific fields

The following fields are available for `exportClones` and `exportShmTreesWithNodes` (for `exportShmTreesWithNodes` only for nodes with clones):

`-cloneId`
: Unique clone identifier

`-readCount`
: Number of reads assigned to the clonotype

`-readFraction`
: Fraction of reads assigned to the clonotype

`-uniqueTagFraction <tag_name>`
: Fraction of unique tags (UMI, CELL, etc.) the clone or alignment collected.

`-allUniqueTagFractions <(Sample|Cell|Molecule)>`
: Fractions of unique tags (i.e. CELL barcode or UMI sequence) for all available tags in separate columns.

Tag type will be used for filtering tags for export.

`-cellGroup`
: Cell group (for single cell analysis)

### SHM tree-specific fields

The following fields are available for both `exportShmTrees` and `exportShmTreesWithNodes`:

`-treeId`
: SHM tree id

`-uniqClonesCount`
: Number of uniq clones in the SHM tree

`-totalClonesCount`
: Total sum of counts of clones in the SHM tree

The following fields are only available for `exportShmTrees`:

`-nFeature <gene_feature> <germline|mrca>`
: Export nucleotide sequence of specified gene feature of specified node type.

`-allNFeatures <(germline|mrca)>`
: Export nucleotide sequences for all covered gene features.

`-aaFeature <gene_feature> <germline|mrca>`
: Export amino acid sequence of specified gene feature of specified node type.

`-allAaFeatures <(germline|mrca)>`
: Export nucleotide sequences for all covered gene features.

### SHM tree node-specific fields

The following fields are available only for `exportShmTreesWithNodes`:

`-nodeId`
: Node id in SHM tree

`-isObserved`
: Is node have clones. All other nodes are reconstructed by algorithm

`-parentId`
: Parent node id in SHM tree

`-distance <(germline|mrca|parent)>`
: Distance from another node

`-fileName`
: Name of clns file with sample

`-nFeature <gene_feature> [<(germline|mrca|parent)>]`
: Export nucleotide sequence of specified gene feature. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-allNFeatures [<(germline|mrca|parent)>]`
: Export nucleotide sequences for all covered gene features. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-aaFeature <gene_feature> [<(germline|mrca|parent)>]`
: Export amino acid sequence of specified gene feature. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-allAaFeatures [<(germline|mrca|parent)>]`
: Export amino acid sequences for all covered gene features. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-lengthOf <gene_feature> [<(germline|mrca|parent)>]`
: Export length of specified gene feature. If second arg is omitted, then feature length will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-allLengthOf [<(germline|mrca|parent)>]`
: Export lengths for all covered gene features. If second arg is omitted, then feature will be printed for current node. Otherwise - for corresponding `parent`, `germline` or `mrca`

`-nMutations <gene_feature> <(germline|mrca|parent)>`
: Extract nucleotide mutations from specific node for specific gene feature.

`-allNMutations <(germline|mrca|parent)>`
: Extract nucleotide mutations from specific node for all covered gene features.

`-nMutationsRelative <gene_feature> <relative_to_gene_feature> <(germline|mrca|parent)>`
: Extract nucleotide mutations from specific node for specific gene feature relative to another feature.

`-aaMutations <gene_feature> <(germline|mrca|parent)>`
: Extract amino acid mutations from specific node for specific gene feature.

`-allAaMutations <(germline|mrca|parent)>`
: Extract amino acid mutations from specific node for all covered gene features.

`-aaMutationsRelative <gene_feature> <relative_to_gene_feature> <(germline|mrca|parent)>`
: Extract amino acid mutations from specific node for specific gene feature relative to another feature.

`-mutationsDetailed <gene_feature> <(germline|mrca|parent)>`
: Detailed list of nucleotide and corresponding amino acid mutations from specific node. Format `<nt_mutation>:<aa_mutation_individual>:<aa_mutation_cumulative>`, where `<aa_mutation_individual>` is an expected amino acid mutation given no other mutations have occurred, and `<aa_mutation_cumulative>` amino acid mutation is the observed amino acid mutation combining effect from all others.

`-allMutationsDetailed <(germline|mrca|parent)>`
: Detailed list of nucleotide and corresponding amino acid mutations from specific node for all covered gene features.

`-mutationsDetailedRelative <gene_feature> <relative_to_gene_feature> <(germline|mrca|parent)>`
: Detailed list of nucleotide and corresponding amino acid mutations written, positions relative to specified gene feature. Format <nt_mutation>:<aa_mutation_individual>:<aa_mutation_cumulative>, where <aa_mutation_individual> is an expected amino acid mutation given no other mutations have occurred, and <aa_mutation_cumulative> amino acid mutation is the observed amino acid mutation combining effect from all other. WARNING: format may change in following versions.


## Default anchor point positions

Positions of anchor points produced by the `-defaultAnchorPoints` option are outputted as a colon separated
list. If an anchor point is not covered by the target sequence nothing is printed for it, but flanking colon
symbols are preserved to maintain positions in array. See example:

```shell
:::::::::108:117:125:152:186:213:243:244:
```

If there are several target sequences (e.g. paired-end reads or multi-part clonal sequnce), an array is
outputted for each target sequence. In this case arrays are separated by a comma:

```shell
2:61:107:107:118:::::::::::::,:::::::::103:112:120:147:181:208:238:239:
```

Even if there are no anchor points in one of the parts:

```shell
:::::::::::::::::,:::::::::108:117:125:152:186:213:243:244:
```

The following table shows the correspondence between anchor points and positions in the default anchor
point array:

| Anchors point                                                                           | Zero-based position | One-based position  |
|-----------------------------------------------------------------------------------------|---------------------|---------------------|
| V5UTRBeginTrimmed                                                                       | 0                   | 1                   |
| V5UTREnd / L1Begin                                                                      | 1                   | 2                   |
| L1End / VIntronBegin                                                                    | 2                   | 3                   |
| VIntronEnd / L2Begin                                                                    | 3                   | 4                   |
| L2End / FR1Begin                                                                        | 4                   | 5                   |
| FR1End / CDR1Begin                                                                      | 5                   | 6                   |
| CDR1End / FR2Begin                                                                      | 6                   | 7                   |
| FR2End / CDR2Begin                                                                      | 7                   | 8                   |
| CDR2End / FR3Begin                                                                      | 8                   | 9                   |
| FR3End / CDR3Begin                                                                      | 9                   | 10                  |
| Number of 3’ V deletions (negative value), or length of 3’ V P-segment (positive value) | 10                  | 11                  |
| VEndTrimmed, next position after last aligned nucleotide of V gene                      | 11                  | 12                  |
| DBeginTrimmed, position of first aligned nucleotide of D gene                           | 12                  | 13                  |
| Number of 5’ D deletions (negative value), or length of 5’ D P-segment (positive value) | 13                  | 14                  |
| Number of 3’ D deletions (negative value), or length of 3’ D P-segment (positive value) | 14                  | 15                  |
| DEndTrimmed, next position after last aligned nucleotide of D gene                      | 15                  | 16                  |
| JBeginTrimmed, position of first aligned nucleotide of J gene                           | 16                  | 17                  |
| Number of 3’ J deletions (negative value), or length of 3’ J P-segment (positive value) | 17                  | 18                  |
| CDR3End / FR4Begin                                                                      | 18                  | 19                  |
| FR4End                                                                                  | 19                  | 20                  |
| CBegin                                                                                  | 20                  | 21                  |
| CExon1End                                                                               | 21                  | 22                  |
