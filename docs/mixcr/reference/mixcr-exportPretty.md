# Exporting formatted alignments and clonotypes

MiXCR is able to export [alignments](#raw-alignments) and [clonotypes](#clonotypes) as pretty formatted human-readable text for manual analysis. This is useful both to inspect alignments and to facilitate optimization of analysis parameters and library preparation protocol.

## Raw alignments 

```
mixcr exportAlignmentsPretty 
    [--top] 
    [--gene] 
    [--limit-before <n>] 
    [--limit <n>] 
    [--chains <chains>] 
    [--skip <n>] 
    [--cdr3-equals <seq>] 
    [--feature <gene_feature>] 
    [--read-contains <seq>] 
    [--filter <s>] 
    [--descriptions] 
    [--read-ids <id>]... 
    [--clone-ids <id>]... 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    alignments.(vdjca|clna) [output.txt]
```
Exports pretty formatted alignments from `.vdjca` file.

`alignments.(vdjca|clna)`
: Path to input file with alignments.

`[output.txt]`
: Path where to write export. Will write to output if omitted.

`-t, --top`
: Output only top hits

`-a, --gene`
: Output full gene sequence

`-b, --limit-before <n>`
: Limit number of alignments before filtering

`-n, --limit <n>`
: Limit number of filtered alignments; no more than N alignments will be outputted

`-s, --skip <n>`
: Number of output alignments to skip

`-c, --chains <chains>`
: Filter export to a specific protein chain gene (e.g. TRA or IGH). Default: ALL

`-e, --cdr3-equals <seq>`
: Output only alignments where CDR3 exactly equals to given sequence

`-g, --feature <gene_feature>`
: Output only alignments which contain a corresponding gene feature

`-r, --read-contains <seq>`
: Output only alignments where target read contains a given substring

`--filter <s>`
: Custom filter

`-d, --descriptions`
: Print read descriptions

`-i, --read-ids <id>`
: List of read ids to export

`--clone-ids <id>`
: List of clone ids to export

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.


Example:
```shell
> mixcr exportAlignmentsPretty --skip 1000 --limit 10 input.vdjca
```
this will export 10 results after skipping the first 1000 records. Skipping earlier records is often useful  because the first sequences in a fastq file may have lower than average read quality.

Pretty alignments have the following structure:

<pre style="font-size: 10px">

  &gt;&gt;&gt; Read id: 1

                                                      5'UTR&gt;&lt;L1                               
   Quality    88888888888888888888888887888888888888888888888888888888888888888888888887888878
   Target0  0 AAGGCCTTTCCACTTGGTGATCAGCACTGAGCACAGAGGACTCACCATGGAGTTGGGGCTGAGCTGGGTTTTCCTTGTTG 79
IGHV3-7*00 54 aaggcctttccacttggtgatcagcactgagcacagaggactcaccatggaAttggggctgagctgggttttccttgttg 133

                        L1&gt;&lt;L2     L2&gt;&lt;FR1                                                     
   Quality     88888888887888888888888888888889989989989889999997999999989999999999999999999899
   Target0  80 CTATTTTAGAAGGTGTCCAGTGTGAGGTGAAGTTGGTGGAGTCTGGGGGAGGCCTGGTCCAGCCTGGGGGGTCCCTGAGA 159
IGHV3-7*00 134 ctattttagaaggtgtccagtgtgaggtgCagCtggtggagtctgggggaggcTtggtccagcctggggggtccctgaga 213

                             FR1&gt;&lt;CDR1              CDR1&gt;&lt;FR2                                  
   Quality     999999999999999999999999999999999999999999999 9999999999999999999999999999999999
   Target0 160 CTCTCCTGTGAAGCCTCCGGATTCACCTTTAGTAGTTATTGGATG-GCATGGGTCCGCCAGGGTCCAGGGCAGGGGCTGG 238
IGHV3-7*00 214 ctctcctgtgCagcctcTggattcacctttagtagCtattggatgAgc-tgggtccgccaggCtccagggAaggggctgg 292

                         FR2&gt;&lt;CDR2              CDR2&gt;&lt;FR3                                      
   Quality     99999999999999999999999999999999999799999999999999999999999999998999899898999999
   Target0 239 AATGGGTGGGCAACATAAGGCCGGATGGAAGTGAGAGTTGGTACTTGGAGTCTGTGATGGGGCGATTCATGATATCTAGA 318
IGHV3-7*00 293 aGtgggtggCcaacataaAgcAAgatggaagtgagaAAtACtaTGtggaCtctgtgaAgggCcgattcaCCatCtcCaga 372

                                                                                 FR3&gt;&lt;CDR3      
    Quality     99899899999999988989999889979988888888878878788888888878888888778788888888878888
    Target0 319 GACAACGCCAAGAAGTCACTTTATCTGCAAATGGACAGCCTGAGAGTCGAGGACACGGCCGTCTATTATTGTGCGACTTC 398
 IGHV3-7*00 373 gacaacgccaagaaCtcactGtatctgcaaatgAacagcctgagagCcgaggacacggcTgtGtattaCtgtgcga     448
IGHD3-10*00  12                                                                              ttc 14

                                 CDR3&gt;&lt;FR4                                                      
    Quality     88888788888888888888888787788777887787777877777877787787877878788788777767778788
    Target0 399 GGAGGAGCCGGAGGACTACTGGGGCCAGGGAGCCCTGGTCACCGTCTCCTCGGCTTCCACCAAGGGCCCATCGGTCTTCC 478
IGHD3-10*00  15 gg-ggag                                                                          20
   IGHJ4*00   8              gactactggggccagggaAccctggtcaccgtctcctc                              45
   IGHG4*00   0                                                      cttccaccaagggcccatcggtcttcc 26
   IGHG3*00   0                                                      cttccaccaagggcccatcggtcttcc 26
   IGHG2*00   0                                                      cCtccaccaagggcccatcggtcttcc 26
   IGHG1*00   0                                                      cCtccaccaagggcccatcggtcttcc 26
   IGHGP*00 194                                                    AgcCtccaccaagggcccatcggtcttcc 222

                  
 Quality     87370
 Target0 479 CCTTG 483
IGHG4*00  27 ccCtg 31
IGHG3*00  27 ccCtg 31
IGHG2*00  27 ccCtg 31
IGHG1*00  27 ccCtg 31
IGHGP*00 223 ccCtg 227

</pre>


Usage of the `--verbose` option will produce alignments in a slightly different format:


<pre style="font-size: 10px">&gt;&gt;&gt; Read id: 12343    <span style="color:red;"><--- Index of analysed read in input file</span>

&gt;&gt;&gt; Target sequences (input sequences):

Sequence0:   <span style="color:red;"><--- Read 1 from paired-end read</span>
Contains features: CDR1, VRegionTrimmed, L2, L, Intron, VLIntronL, FR1, Exon1,              <span style="color:red;"><--- Gene features</span>
VExon2Trimmed                                                                                    <span style="color:red;">found in read 1</span>

    0 TCTTGGGGGATTCGGTGATCAGCACTGAACACAGAGGACTCACCATGGAGTTTGGGCTGAACTGGGTTTTCCTCGTTGCT 79  <span style="color:red;"><--- Sequyence & quality </span>
      FGGEGGGGGDG8F78CFC6CEFF&lt;,CFG9EED,6,CFCC&lt;EEGFG,CE:CCAFFGGC87CEF?A?FBC@FGGFG&gt;B,FC9          <span style="color:red;">of read 1</span>

   80 CTATTAAGAGGTGTCCAGTGTCAGGTGCAGCTGGTGGAGTCTGGGGGTGGCGTGTTCCAGCCTGGGGGGTCCGTGAGACT 159
      F9,A,95AFE,B?,E,C,9AC&lt;FGA&lt;EE5??,A,A&lt;:=:E,=B8C7+++8,++@+,885=D7:@8E+:5*1**11**++&lt
  160 CTCCTGTGCAGCGTCGGGATGCACATCATGGAGCTATGGCCAGCCCTGGGTACGCCAGGCTACAGGCCACGGGCTGGAGG 239
      &lt;++*++0++2A:ECE5EC5**2@C+:++++++22*2:+29+*2***25/79*0299))*/)*0*0*.75)7:)1)1/)))

  240 GGGTGCGTGGTAGATGGGAA 259
      )9:.)))*1)12***-/).)

Sequence1:   <span style="color:red;"><--- Read 2 from paired-end read</span>
Contains features: JCDR3Part, DCDR3Part, DJJunction, CDR2, JRegionTrimmed, CDR3, VDJunction,
VJJunction, VCDR3Part, ShortCDR3, FR4, FR3

    0 CGAGGCAAGAGGCTGGTGTGGGTGGCGGTTATATGGTATGGTGGAAGTAATAAACACTATGCAGACCCCGTGAAGGGCCG 79
      **0*0**)2**/**5D7&lt;15*9&lt;5:1+*0:GF:=C&gt;6A52++*:2+++FF&gt;&gt;3&lt;++++++302**:**/&lt;+**;:/**2+

   80 ATTCACCATCGCCAGAGACAATTCCAAGAACACGCTGTATCTGCAAATGAAGAGCCTGAGAGCCGAGGACACGGCTTTGT 159
      +++&lt;0***C:2+9GGFB?,5,4,+,2F&lt;&gt;FC=*,,C:&gt;,=,@,,;3&lt;@=,3,,&lt;3,CF?=**&lt;&gt;@,?3,&lt;&lt;:3,CC,E,@

  160 ATTACTGTGCGAGAGGTCAACAGGGTGACTATGTCTACGGTAGGGACGTCGGGGGCCAAGGGACCACGGTCACCGTCTCC 239
      ,@;FCF@+F@FGGF9FD,F&gt;&gt;+B:=,,=&gt;&lt;GFCGGCFEGFF?+=B+7EF&gt;+FFA,8F&lt;E:,5+GDFFE,@F?,,7GGDFE

  240 TCAGGGAGTGCATCCGCCCCAACCCTTTTCCCCCTCTCTGCGTTGATACCACTGGCAGCTC 300
      C,FGGGEFCCGEEGGCFCC:8FGEGGGE@DFB-GFGGGGF@GFGFE&lt;,GFCCFCAGC@CCC

&gt;&gt;&gt; Gene features that can be extracted from this (paired-)read:                         <span style="color:red;"><--- For paired-end reads</span>
JCDR3Part, CDR1, VRegionTrimmed, L2, DCDR3Part, VDJTranscriptWithout5UTR, Exon2, L,           <span style="color:red;">some gene features</span>
DJJunction, Intron, FR2, CDR2, VDJRegion, JRegionTrimmed, CDR3, VDJunction, VJJunction,       <span style="color:red;">can be extracted by</span>
VLIntronL, FR1, VCDR3Part, ShortCDR3, Exon1, FR4, VExon2Trimmed, FR3                          <span style="color:red;">merging sequence</span>
                                                                                             <span style="color:red;">information</span>

&gt;&gt;&gt; Alignments with V gene:

IGHV3-33*00 (total score = 1638.0) <span style="color:red;"><--- Alignment of both reads with IGHV3-33</span>
Alignment of Sequence0 (score = 899.0):   <span style="color:red;"><--- Alignment of IGHV3-33 with read 1 from paired-end read</span>
    65 ATTCGGTGATCAGCACTGAACACAGAGGACTCACCATGGAGTTTGGGCTGAGCTGGGTTTTCCTCGTTGCTCTTTTAAGA 144 <span style="color:red;"><--- Germline</span>
       ||||||||||||||||||||||||||||||||||||||||||||||||||| ||||||||||||||||||||| ||||||
     9 ATTCGGTGATCAGCACTGAACACAGAGGACTCACCATGGAGTTTGGGCTGAACTGGGTTTTCCTCGTTGCTCTATTAAGA 88  <span style="color:red;"><--- Read</span>
       DG8F78CFC6CEFF&lt;,CFG9EED,6,CFCC&lt;EEGFG,CE:CCAFFGGC87CEF?A?FBC@FGGFG&gt;B,FC9F9,A,95AF     <span style="color:red;"><--- Quality score</span>

   145 GGTGTCCAGTGTCAGGTGCAGCTGGTGGAGTCTGGGGGAGGCGTGGTCCAGCCTGGGAGGTCCCTGAGACTCTCCTGTGC 224
       |||||||||||||||||||||||||||||||||||||| |||||| ||||||||||| ||||| ||||||||||||||||
    89 GGTGTCCAGTGTCAGGTGCAGCTGGTGGAGTCTGGGGGTGGCGTGTTCCAGCCTGGGGGGTCCGTGAGACTCTCCTGTGC 168
       E,B?,E,C,9AC&lt;FGA&lt;EE5??,A,A&lt;:=:E,=B8C7+++8,++@+,885=D7:@8E+:5*1**11**++&lt;&lt;++*++0++

   225 AGCGTCTGGATTCACCTTCA-GTAGCTATGGCATGCACTGGGTCCGCCAGGCTCCAGGCAAGGGGCTGGAGTGGGTG 300
       |||||| |||| || | ||| | |||||||||  || |||||| ||||||||| ||||| | ||||||||| |||||
   169 AGCGTCGGGATGCA-CATCATGGAGCTATGGCCAGCCCTGGGTACGCCAGGCTACAGGCCACGGGCTGGAGGGGGTG 244
       2A:ECE5EC5**2@ C+:++++++22*2:+29+*2***25/79*0299))*/)*0*0*.75)7:)1)1/))))9:.)

Alignment of Sequence1 (score = 739.0):   <span style="color:red;"><--- Alignment of IGHV3-33 with read 2 from paired-end read</span>
   279 AGGCAAGGGGCTGGAGTGGGTGGCAGTTATATGGTATGATGGAAGTAATAAATACTATGCAGACTCCGTGAAGGGCCGAT 358
       ||||||| |||||| ||||||||| ||||||||||||| ||||||||||||| ||||||||||| |||||||||||||||
     2 AGGCAAGAGGCTGGTGTGGGTGGCGGTTATATGGTATGGTGGAAGTAATAAACACTATGCAGACCCCGTGAAGGGCCGAT 81
       0*0**)2**/**5D7&lt;15*9&lt;5:1+*0:GF:=C&gt;6A52++*:2+++FF&gt;&gt;3&lt;++++++302**:**/&lt;+**;:/**2+++

   359 TCACCATCTCCAGAGACAATTCCAAGAACACGCTGTATCTGCAAATGAACAGCCTGAGAGCCGAGGACACGGCTGTGTAT 438
       |||||||| |||||||||||||||||||||||||||||||||||||||| |||||||||||||||||||||||| |||||
    82 TCACCATCGCCAGAGACAATTCCAAGAACACGCTGTATCTGCAAATGAAGAGCCTGAGAGCCGAGGACACGGCTTTGTAT 161
       +&lt;0***C:2+9GGFB?,5,4,+,2F&lt;&gt;FC=*,,C:&gt;,=,@,,;3&lt;@=,3,,&lt;3,CF?=**&lt;&gt;@,?3,&lt;&lt;:3,CC,E,@,@

   439 TACTGTGCGAGAG 451
       |||||||||||||
   162 TACTGTGCGAGAG 174
       ;FCF@+F@FGGF9

IGHV3-30*00 (total score = 1582.0)  <span style="color:red;"><--- Alternative hit for V gene</span>
Alignment of Sequence0 (score = 885.0):
    65 ATTCGGTGATCAGCACTGAACACAGAGGACTCACCATGGAGTTTGGGCTGAGCTGGGTTTTCCTCGTTGCTCTTTTAAGA 144
       ||||||||||||||||||||||||||||||||||||||||||||||||||| ||||||||||||||||||||| ||||||
     9 ATTCGGTGATCAGCACTGAACACAGAGGACTCACCATGGAGTTTGGGCTGAACTGGGTTTTCCTCGTTGCTCTATTAAGA 88
       DG8F78CFC6CEFF&lt;,CFG9EED,6,CFCC&lt;EEGFG,CE:CCAFFGGC87CEF?A?FBC@FGGFG&gt;B,FC9F9,A,95AF

   145 GGTGTCCAGTGTCAGGTGCAGCTGGTGGAGTCTGGGGGAGGCGTGGTCCAGCCTGGGAGGTCCCTGAGACTCTCCTGTGC 224
       |||||||||||||||||||||||||||||||||||||| |||||| ||||||||||| ||||| ||||||||||||||||
    89 GGTGTCCAGTGTCAGGTGCAGCTGGTGGAGTCTGGGGGTGGCGTGTTCCAGCCTGGGGGGTCCGTGAGACTCTCCTGTGC 168
       E,B?,E,C,9AC&lt;FGA&lt;EE5??,A,A&lt;:=:E,=B8C7+++8,++@+,885=D7:@8E+:5*1**11**++&lt;&lt;++*++0++

   225 AGCCTCTGGATTCACCTTCA-GTAGCTATGGCATGCACTGGGTCCGCCAGGCTCCAGGCAAGGGGCTGGAGTGGGTG 300
       ||| || |||| || | ||| | |||||||||  || |||||| ||||||||| ||||| | ||||||||| |||||
   169 AGCGTCGGGATGCA-CATCATGGAGCTATGGCCAGCCCTGGGTACGCCAGGCTACAGGCCACGGGCTGGAGGGGGTG 244
       2A:ECE5EC5**2@ C+:++++++22*2:+29+*2***25/79*0299))*/)*0*0*.75)7:)1)1/))))9:.)

Alignment of Sequence1 (score = 697.0):
   279 AGGCAAGGGGCTGGAGTGGGTGGCAGTTATATCATATGATGGAAGTAATAAATACTATGCAGACTCCGTGAAGGGCCGAT 358
       ||||||| |||||| ||||||||| |||||||  |||| ||||||||||||| ||||||||||| |||||||||||||||
     2 AGGCAAGAGGCTGGTGTGGGTGGCGGTTATATGGTATGGTGGAAGTAATAAACACTATGCAGACCCCGTGAAGGGCCGAT 81
       0*0**)2**/**5D7&lt;15*9&lt;5:1+*0:GF:=C&gt;6A52++*:2+++FF&gt;&gt;3&lt;++++++302**:**/&lt;+**;:/**2+++

   359 TCACCATCTCCAGAGACAATTCCAAGAACACGCTGTATCTGCAAATGAACAGCCTGAGAGCTGAGGACACGGCTGTGTAT 438
       |||||||| |||||||||||||||||||||||||||||||||||||||| ||||||||||| |||||||||||| |||||
    82 TCACCATCGCCAGAGACAATTCCAAGAACACGCTGTATCTGCAAATGAAGAGCCTGAGAGCCGAGGACACGGCTTTGTAT 161
       +&lt;0***C:2+9GGFB?,5,4,+,2F&lt;&gt;FC=*,,C:&gt;,=,@,,;3&lt;@=,3,,&lt;3,CF?=**&lt;&gt;@,?3,&lt;&lt;:3,CC,E,@,@

   439 TACTGTGCGAGAG 451
       |||||||||||||
   162 TACTGTGCGAGAG 174
       ;FCF@+F@FGGF9

&gt;&gt;&gt; Alignments with D gene:

IGHD4-17*00 (total score = 40.0)
Alignment of Sequence1 (score = 40.0):
     7 GGTGACTA 14
       ||||||||
   183 GGTGACTA 190
       :=,,=&gt;&lt;G

IGHD4-23*00 (total score = 36.0)
Alignment of Sequence1 (score = 36.0):
     0 TGACTACGGT 9
       || |||||||
   191 TGTCTACGGT 200
       FCGGCFEGFF

IGHD2-21*00 (total score = 35.0)
Alignment of Sequence1 (score = 35.0):
    13 GGTGACT 19
       |||||||
   183 GGTGACT 189
       :=,,=&gt;&lt;

&gt;&gt;&gt; Alignments with J gene:

IGHJ6*00 (total score = 172.0)
Alignment of Sequence1 (score = 172.0):
    22 GGACGTCTGGGGCAAAGGGACCACGGTCACCGTCTCCTCA 61
       ||||||| ||||| ||||||||||||||||||||||||||
   203 GGACGTCGGGGGCCAAGGGACCACGGTCACCGTCTCCTCA 242
       =B+7EF&gt;+FFA,8F&lt;E:,5+GDFFE,@F?,,7GGDFEC,F

&gt;&gt;&gt; Alignments with C gene:

No hits.
</pre>


## Clonotypes 

```
mixcr exportClonesPretty 
    [--limitBefore <n>] 
    [--limit <n>] 
    [--skip <n>] 
    [--clone-ids <id>]... 
    [--chains <chains>] 
    [--cdr3-equals <seq>] 
    [--clonal-sequence-contains <seq>] 
    [--force-overwrite] 
    [--no-warnings] 
    [--verbose] 
    [--help] 
    clones.(clns|clna) [output.txt]
```
Exports pretty formatted clonotypes from `.clnx` files. Especially useful after [`assembleContigs`](./mixcr-assembleContigs.md) to manually check how contig clonotypes are covered.

`clones.(clns|clna)`
: Path to input file with clones

`[output.txt]`
: Path where to write export. Will write to output if omitted.

`-b, --limitBefore <n>`
:   Limit number of alignments before filtering

`-n, --limit <n>`
: Limit number of filtered alignments; no more than N alignments will be outputted

`-s, --skip <n>`
: Number of output alignments to skip

`-i, --clone-ids <id>`
: List of clone ids to export

`-c, --chains <chains>`
: Filter export to a specific protein chain gene (e.g. TRA or IGH). Default: ALL

`-e, --cdr3-equals <seq>`
: Only output clones where CDR3 (not whole clonal sequence) exactly equals to given sequence

`-r, --clonal-sequence-contains <seq>`
: Only output clones where target clonal sequence contains sub-sequence.

`-f, --force-overwrite`
: Force overwrite of output file(s).

`-nw, --no-warnings`
: Suppress all warning messages.

`--verbose`
: Verbose messages.

`-h, --help`
: Show this help message and exit.
