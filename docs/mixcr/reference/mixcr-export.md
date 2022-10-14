# Export

Export clonotypes or raw alignments in a tabular form.

![](pics/export.svg)

MiXCR uses three highly efficient binary formats that hold exhaustive information on the clonotypes, alignments, barcodes and original sequencing reads:

- `.vdjca` produced by [`align`](./mixcr-align.md) and holds alignments
- `.clns` produced by [`assemble`](./mixcr-assemble.md) and [`assembleContigs`](./mixcr-assembleContigs.md) holds clonotypes
- `.clna` produced by [`assemble`](./mixcr-assemble.md) and holds both clonotypes and alignments

MiXCR provides functions for export [alignments](#alignments) and [clonotype tables](#clonotype-tables) in a tab-delimited way. For human-readable formatted output see [pretty export](./mixcr-exportPretty.md).

## Clonotype tables

```
mixcr exportClones [-fn]
    [--split-by-tag <tag>]
    [--chains <chains>]
    [--minimal-clone-count <count>]
    [--minimal-clone-fraction <fraction>]
    [--filter-out-of-frames]
    [--filter-stops]
    [--preset <preset>]
    [--preset-file <file>]
    [<exportField>]...
    input.(vdjca|clna)
    [output.tsv]
```

Exports tab-delimited table of alignments from `.vdjca` and `.clna` files.

Command line options:

`-n, --limit <limit>`

:   output first `n` clones

`--chains, -c <chains>`

:   filter only specified chains

`--split-by-tag <tag>`

:   split clonotype containing multiple values for specified `tag` into multiple rows (one row for one `tag` value). Typically, used for single cell analysis with `--split-by-tag cell` option to export clonotype that present in multiple cells in separate rows

`--minimal-clone-count, -m <count>`

:   export clonotypes with count greater than specified value

`--minimal-clone-fraction, -q <fraction>`

:   export clonotypes with clone abundance greater than specified value

`--filter-out-of-frames`, `-o`

:   do not export clonotypes with out-of-frame CDR3 sequences

`--filter-stops`, `-t`

:   do not export clonotypes with CDR3 sequences containing stop codons

`--preset, -p <preset>`

:   use specified preset of [export fields](#export-fields). Possible values: `min`, `full` (default), `minImputed`, `fullImputed`

`--preset-file <file>`

:   file containing a list of [export fields](#export-fields) to be exported

`<exportField>`

:   a list of [export fields](#export-fields)

## Alignments

```
mixcr exportAlignments [-fn]
    [--chains <chains>]
    [--preset <preset>]
    [--preset-file <file>]
    [<exportField>]...
    input.(vdjca|clna)
    [output.tsv]
```

Exports tab-delimited alignments from `.vdjca` and `.clna` files.

Command line options:

`-n, --limit <limit>`
:   output first `n` alignments

`--chains, -c <chains>`
:   filter only specified chains

`--preset, -p <preset>`
:   use specified preset of [export fields](#export-fields). Possible values: `min`, `full` (default), `minImputed`, `fullImputed`

`--preset-file <file>`
:   file containing a list of [export fields](#export-fields) to be exported

`<exportField>`
:   a list of [export fields](#export-fields)

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

These fields available for both `exportAlignments` and `exportClones`:

`-targets`
: Number of targets

`-vHit`
: Best V hit

`-dHit`
: Best D hit

`-jHit`
: Best J hit

`-cHit`
: Best C hit

`-vGene`
: Best V hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-dGene`
: Best D hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-jGene`
: Best J hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-cGene`
: Best C hit gene name (e.g. TRBV12-3 for TRBV12-3*00)

`-vFamily`
: Best V hit family name (e.g. TRBV12 for TRBV12-3*00)

`-dFamily`
: Best D hit family name (e.g. TRBV12 for TRBV12-3*00)

`-jFamily`
: Best J hit family name (e.g. TRBV12 for TRBV12-3*00)

`-cFamily`
: Best C hit family name (e.g. TRBV12 for TRBV12-3*00)

`-vHitScore`
: Score for best V hit

`-dHitScore`
: Score for best D hit

`-jHitScore`
: Score for best J hit

`-cHitScore`
: Score for best C hit

`-vHitsWithScore`
: All V hits with score

`-dHitsWithScore`
: All D hits with score

`-jHitsWithScore`
: All J hits with score

`-cHitsWithScore`
: All C hits with score

`-vHits`
: All V hits

`-dHits`
: All D hits

`-jHits`
: All J hits

`-cHits`
: All C hits

`-vGenes`
: All V gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-dGenes`
: All D gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-jGenes`
: All J gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-cGenes`
: All C gene names (e.g. TRBV12-3 for TRBV12-3*00)

`-vFamilies`
: All V gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-dFamilies`
: All D gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-jFamilies`
: All J gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-cFamilies`
: All C gene family anmes (e.g. TRBV12 for TRBV12-3*00)

`-vAlignment`
: Best V alignment

`-dAlignment`
: Best D alignment

`-jAlignment`
: Best J alignment

`-cAlignment`
: Best C alignment

`-vAlignments`
: All V alignments

`-dAlignments`
: All D alignments

`-jAlignments`
: All J alignments

`-cAlignments`
: All C alignments

`-nFeature <gene_feature>`
: Nucleotide sequence of specified gene feature

`-qFeature <gene_feature>`
: Quality string of specified gene feature

`-aaFeature <gene_feature>`
: Amino acid sequence of specified gene feature

`-nFeatureImputed <gene_feature>`
: Nucleotide sequence of specified gene feature using letters from germline (marked lowercase) for uncovered regions

`-aaFeatureImputed <gene_feature>`
: Amino acid sequence of specified gene feature using letters from germline (marked lowercase) for uncovered regions

`-minFeatureQuality <gene_feature>`
: Minimal quality of specified gene feature

`-avrgFeatureQuality <gene_feature>`
: Average quality of specified gene feature

`-lengthOf <gene_feature>`
: Length of specified gene feature.

`-nMutations <gene_feature>`
: Extract nucleotide mutations for specific gene feature; relative to germline sequence.

`-nMutationsRelative <gene_feature> <relative_to_gene_feature>`
: Extract nucleotide mutations for specific gene feature relative to another feature.

`-aaMutations <gene_feature>`
: Extract amino acid mutations for specific gene feature

`-aaMutationsRelative <gene_feature> <relative_to_gene_feature>`
: Extract amino acid mutations for specific gene feature relative to another feature.

`-mutationsDetailed <gene_feature>`
: Detailed list of nucleotide and corresponding amino acid mutations. Format
`<nt_mutation>:<aa_mutation_individual>:<aa_mutation_cumulative>`, where `<aa_mutation_individual>` is an
expected amino acid mutation given no other mutations have occurred, and `<aa_mutation_cumulative>`
amino acid mutation is the observed amino acid mutation combining effect from all others.

`-mutationsDetailedRelative <gene_feature> <relative_to_gene_feature>`
: Detailed list of nucleotide and corresponding amino acid mutations written, positions relative to specified gene feature. Format <nt_mutation>:<aa_mutation_individual>:<aa_mutation_cumulative>, where <aa_mutation_individual> is an expected amino acid mutation given no other mutations have occurred, and <aa_mutation_cumulative> amino acid mutation is the observed amino acid mutation combining effect from all other. WARNING: format may change in following versions.

`-positionInReferenceOf <reference_point>`
: Position of specified reference point inside reference sequences (clonal sequence / read sequence).

`-positionOf <reference_point>`
: Position of specified reference point inside target sequences (clonal sequence / read sequence).

`-defaultAnchorPoints`
: Outputs a list of default reference points (like CDR2Begin, FR4End, etc. see documentation bellow
for the full list and formatting)

`-targetSequences`
: Aligned sequences (targets), separated with comma

`-targetQualities`
: Aligned sequence (target) qualities, separated with comma

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

`-tagCounts`
: All tags with counts

`-tag <tag>`
: Tag value (i.e. cell barcode or UMI sequence)

`-uniqueTagCount <tag>`
: Unique tag count

### Alignment-specific fields

The following fields are only available for `exportAlignments`:

`-readIds`
: Id(s) of read(s) corresponding to alignment

`-descrsR1`
: Description lines from initial `.fasta` or `.fastq` file for R1 reads (only available if `-OsaveOriginalReads=
true` was used in `align` command)

`-descrsR2`
: Description lines from initial `.fastq` file for R2 reads (only available if `-OsaveOriginalReads=true` was
used in `alig`n command)

`-readHistory`
: Read history

`-cloneId`
: To which clone alignment was attached (make sure using `.clna` file as input for `exportAlignments`)

`-cloneIdWithMappingType`
: To which clone alignment was attached with additional info on mapping type (make sure using `.clna` file as input for
`exportAlignments`)

### Clonotype-specific fields

The following fields are only available for `exportClones`:

`-cloneId`
: Unique clone identifier

`-count`
: Clone count

`-fraction` 	
: Clone fraction

`-tagFractions`
: All tags with fractions

`-cellGroup`
: Cell group (for single cell analysis)

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
