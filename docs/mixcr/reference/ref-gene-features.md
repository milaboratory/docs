# Gene features and anchor points

There are several immunologically important parts of TCR/BCR gene
(**gene features**). For example, such regions are three complementarity
determining regions (`CDR1`, `CDR2` and `CDR3`), four framework regions
(`FR1`, `FR2`, `FR3` and `FR4`) etc.

The key feature of MiXCR is the possibility to specify:

-   regions of reference V, D, J and C genes sequences that are used in
    [alignment of raw reads](./mixcr-align.md)
-   regions of sequence to be exported by
    [`exportAlignments`](./mixcr-export.md#alignments)
-   regions of sequence to use as clonal sequence in
    [clone assembly](./mixcr-assemble.md)
-   regions of clonal sequences to be exported by
    [`exportClones`](./mixcr-export.md#clonotype-tables)

For convenience, in MiXCR these regions can be specified in terms of
above-mentioned immunological gene features. The illustrated list of
predefined gene features can be found below. The set of possible gene
regions is not limited by this list:

-   boundary points of gene features (called **anchor points**) can be
    used to specify begin and end of custom gene regions
-   gene features can be concatenated (e.g. `VTranscript =
    {V5UTRBegin:L1End}+{L2Begin:VEnd}`).
-   offsets can be added or subtracted from original positions of
    **anchor points** to define even more custom gene regions (for more
    detailed description see [gene feature syntax](#gene-feature-syntax))
-   clones can be [assembled](./mixcr-assemble.md) by a list of disjointed features (e.g. 
    `[{FR1Begin:CDR1End},{FR3Begin:FR4End}]`).

Naming of gene features is based on IMGT convention described in
*Lefranc et al. (2003), Developmental & Comparative Immunology 27.1
(2003): 55-77*.

## Germline features

Features defined for germline genes are mainly used in
[`align`](./mixcr-align.md) and [export](./mixcr-export.md).

### V Gene structure

![](./pics/gene-features-v-gene-structure-light.svg#only-light)
![](./pics/gene-features-v-gene-structure-dark.svg#only-dark)

Additionally, to core gene features in V region (like `FR3`) we introduce
`VGene`, `VTranscript` and `VRegion` for convenience.

### D Gene structure

![](./pics/gene-features-d-gene-structure-light.svg#only-light)
![](./pics/gene-features-d-gene-structure-dark.svg#only-dark)

### J Gene structure

![](./pics/gene-features-j-gene-structure-light.svg#only-light)
![](./pics/gene-features-j-gene-structure-dark.svg#only-dark)

## Mature TCR/BCR gene features

Features described here (like `CDR3`) cannot not be used for
[`align`](./mixcr-align.md), since they are not defined for germline genes.

### V(D)J junction structure

Important difference between rearranged TCR/BCR sequence and germline
sequence of its segments lies in the fact that during V(D)J
recombination exact cleavage positions at the end of V gene, begin and
end of D gene and begin of J gene varies. As a result in most cases
actual `VEnd`, `DBegin`, `DEnd` and `JBegin` anchor positions are not
covered by alignment:

![](./pics/gene-features-V(D)J-junction-structure-1-light.svg#only-light)
![](./pics/gene-features-V(D)J-junction-structure-1-dark.svg#only-dark)

In order to use actual V, D, J gene boundaries we introduce four
additional anchor positions: `VEndTrimmed`, `DBeginTrimmed`,
`DEndTrimmed` and `JBeginTrimmed` and several named gene features:
`VDJunction`, `DJJunction` and `VJJunction`. On the following
picture one can see the structure of V(D)J junction:

![](./pics/gene-features-V(D)J-junction-structure-2-light.svg#only-light)
![](./pics/gene-features-V(D)J-junction-structure-2-dark.svg#only-dark)

If D gene is not found in the sequence or is not present in target locus
(e.g. TRA), `DBeginTrimmed` and `DEndTrimmed` anchor points as well
as `VDJunction` and `DJJunction` gene features are not defined.

Similar to `...Trimmed` anchor points in V(D)J junction there is a
`V5UTRBeginTrimmed` anchor point representing left bound of alignment
upstream start codon. This point is required because 5'UTR could have
different length from transcript to transcript, and because library of
gene segments inside MiXCR does not have information on exact 5'UTR lengths.


## Gene feature syntax

Syntax for gene features is the same everywhere. The best way to explain it is by example:

- to enter any gene feature listed in the next section just use its name: `VTranscript`, `CDR2`, `V5UTR` etc.
- to define a gene feature consisting of several concatenated features use +: `V5UTR+L1+L2+VRegion` is equivalent to 
`VTranscript`
- to create gene feature starting at anchor point X and ending at anchor point Y use {X:Y} syntax: `{CDR3Begin:CDR3End}`
for `CDR3`.
- one can add or subtract offset from original position of anchor point using positive or negative integer value in 
brackets after anchor point name AnchorPoint(offset): `{CDR3Begin(+3):CDR3End}` for CDR3 without first three nucleotides
(coding conserved cysteine), `{CDR3Begin(-6):CDR3End(+6)}` for CDR3 with 6 nucleotides downstream its left bound and 6 
nucleotides upstream its right bound.
- one can specify offsets for predefined gene feature boundaries using GeneFeatureName(leftOffset, rightOffset) syntax:
`CDR3(3,0)`, `CDR3(-6,6)` - equivalents of two examples from previous item
- all syntax constructs can be combined: `{L1Begin(-12):L1End}+L2+VRegion(0,+10)}`.
- disjointed set of features can be provided for clone assembly: `[{FR1Begin:CDR1End},{FR3Begin:FR4End}]`.


`V5UTRGermline` (*equals to*  `{UTR5Begin:V5UTREnd}`) 
:  5'UTR; germline                                                                                                                                                          

 `VTranscript` (*equals to*  `{UTR5Begin:L1End}` + `{L2Begin:VEnd}`) 
:  `V5UTR` + `Exon1` + `VExon2`. Common reference feature used in alignments for cDNA data obtained using 5'RACE (that may contain UTRs).                                   

 `VGene` (*equals to*  `{UTR5Begin:VEnd}`) 
:  `{V5UTRBegin:VEnd}`. Common reference feature used in alignments for genomic DNA data.                                                                                   

 `VTranscriptWithP` (*equals to*  `{UTR5Begin:L1End}` + `{L2Begin:VEnd}` + `{VEnd:VEnd (-20)}`) 
:  `V5UTR` + `Exon1` + `VExon2`. Common reference feature used in alignments for cDNA data obtained using 5'RACE (that may contain UTRs). Contains reference for P region.  

 `VGeneWithP` (*equals to*  `{UTR5Begin:VEnd}` + `{VEnd:VEnd (-20)}`) 
:  `{V5UTRBegin:VEnd}`. Common reference feature used in alignments for genomic DNA data. Contains reference for P region.                                                  

 `VDJTranscript` (*equals to*  `{UTR5Begin:L1End}` + `{L2Begin:FR4End}`) 
:  First two exons with 5'UTR of IG/TCR gene.                                                                                                                               

 `V5UTR` (*equals to*  `{V5UTRBeginTrimmed:V5UTREnd}`) 
:  5'UTR in aligned sequence; trimmed                                                                                                                                       

 `L1` (*equals to*  `{L1Begin:L1End}`) 
:  Part of lider sequence in first exon. The same as `Exon1`.                                                                                                               

 `VLIntronL` (*equals to*  `{L1Begin:L2End}`) 
:  `L1` + `VIntron` + `L2`                                                                                                                                                  

 `Exon1` (*equals to*  `{L1Begin:L1End}`) 
:  First exon. The same as `L1`.                                                                                                                                            

 `L` (*equals to*  `{L1Begin:L1End}` + `{L2Begin:L2End}`) 
:  Full leader sequence                                                                                                                                                     

 `VTranscriptWithout5UTR` (*equals to*  `{L1Begin:L1End}` + `{L2Begin:VEnd}`) 
:  `Exon1` + `VExon2`. Common reference feature used in alignments for mRNA data obtained without 5'RACE.                                                                   

 `VTranscriptWithout5UTRWithP` (*equals to*  `{L1Begin:L1End}` + `{L2Begin:VEnd}` + `{VEnd:VEnd (-20)}`) 
:  `Exon1` + `VExon2`. Common reference feature used in alignments for mRNA data obtained without 5'RACE. Contains reference for P region.                                  

 `VDJTranscriptWithout5UTR` (*equals to*  `{L1Begin:L1End}` + `{L2Begin:FR4End}`) 
:  First two exons of IG/TCR gene.                                                                                                                                          

 `VIntron` (*equals to*  `{VIntronBegin:VIntronEnd}`) 
:  Intron in V region.                                                                                                                                                      

 `L2` (*equals to*  `{L2Begin:L2End}`) 
:  Part of leader sequence in second exon.                                                                                                                                   

 `Exon2` (*equals to*  `{L2Begin:FR4End}`) 
:  Full second exon of IG/TCR gene.                                                                                                                                         

 `VExon2` (*equals to*  `{L2Begin:VEnd}`) 
:  Second exon of V gene.                                                                                                                                                   

 `VExon2Trimmed` (*equals to*  `{L2Begin:VEndTrimmed}`) 
:  Second exon of V gene trimmed. Ends within CDR3 in V (D)J rearrangement.                                                                                                  

 `VRegion` (*equals to*  `{FR1Begin:VEnd}`) 
:  Full V Region; germline                                                                                                                                                  

 `VRegionWithP` (*equals to*  `{FR1Begin:VEnd}` + `{VEnd:VEnd (-20)}`) 
:  Full V Region with P-segment; to be used as alignment reference                                                                                                          

 `VRegionTrimmed` (*equals to*  `{FR1Begin:VEndTrimmed}`) 
:  Full V Region in rearranged sequence, e.g. after trimming                                                                                                                

 `FR1` (*equals to*  `{FR1Begin:FR1End}`) 
:  Framework 1                                                                                                                                                              

 `VDJRegion` (*equals to*  `{FR1Begin:FR4End}`) 
:  Full V, D, J assembly without 5'UTR and leader sequence.                                                                                                                 

 `CDR1` (*equals to*  `{CDR1Begin:CDR1End}`) 
:  CDR1 (Complementarity determining region 1)                                                                                                                              

 `FR2` (*equals to*  `{FR2Begin:FR2End}`) 
:  Framework 2                                                                                                                                                              

 `CDR2` (*equals to*  `{CDR2Begin:CDR2End}`) 
:  CDR2 (Complementarity determining region 2)                                                                                                                              

 `FR3` (*equals to*  `{FR3Begin:FR3End}`) 
:  Framework 2                                                                                                                                                              

 `CDR3` (*equals to*  `{CDR3Begin:CDR3End}`) 
:  CDR3 (Complementarity determining region 3). Cys from V region and Phe/Trp from J region included.                                                                       

 `VCDR3Part` (*equals to*  `{CDR3Begin:VEndTrimmed}`) 
:  Part of V region inside CDR3 (commonly starts from Cys)                                                                                                                  

 `GermlineVCDR3Part` (*equals to*  `{CDR3Begin:VEnd}`) 
:  Part of V region inside CDR3 (commonly starts from Cys)                                                                                                                  

 `ShortCDR3` (*equals to*  `{CDR3Begin (3):CDR3End (-3)}`) 
:  CDR3 (Complementarity determining region 3). Cys from V region and Phe/Trp from J region excluded.                                                                       

 `VDJunction` (*equals to*  `{VEndTrimmed:DBeginTrimmed}`) 
:  N region between V and D genes; not defined for loci without D genes and for V (D)J rearrangement with unidentified D region.                                             

 `VJJunction` (*equals to*  `{VEndTrimmed:JBeginTrimmed}`) 
:  Region between V and J regions. For loci without D genes - fully composed from non-template nucleotides. May contain D region.                                           

 `VPSegment` (*equals to*  `{VEnd:VEndTrimmed}`) 
:  P-segment of V gene                                                                                                                                                      

 `GermlineVPSegment` (*equals to*  `{VEnd:VEnd (-20)}`) 
:  P-segment of V gene to be used as alignment reference                                                                                                                    

 `DRegion` (*equals to*  `{DBegin:DEnd}`) 
:  Full D Region; germline                                                                                                                                                  

 `DLeftPSegment` (*equals to*  `{DBeginTrimmed:DBegin}`) 
:  Left P-segment of D gene                                                                                                                                                 

 `DCDR3Part` (*equals to*  `{DBeginTrimmed:DEndTrimmed}`) 
:  Full D Region in rearranged sequence, e.g. after trimming                                                                                                                

 `DJJunction` (*equals to*  `{DEndTrimmed:JBeginTrimmed}`) 
:  N region between V and D genes; not defined for loci without D genes and for V (D)J rearrangement with unidentified D region.                                             

 `DRightPSegment` (*equals to*  `{DEnd:DEndTrimmed}`) 
:  Right P-segment of D gene                                                                                                                                                

 `GermlineDPSegment` (*equals to*  `{DEnd:DBegin}`) 
:  P-segment of D gene to be used as alignment reference                                                                                                                    

 `DRegionWithP` (*equals to*  `{DEnd:DBegin}` + `{DBegin:DEnd}` + `{DEnd:DBegin}`) 
:  Full D Region with P-segment; to be used as alignment reference                                                                                                          

 `JRegion` (*equals to*  `{JBegin:FR4End}`) 
:  Full J Region; germline                                                                                                                                                  

 `GermlineJCDR3Part` (*equals to*  `{JBegin:CDR3End}`) 
:  Part of J region inside CDR3 (commonly ends with Phe/Trp)                                                                                                                

 `GermlineJPSegment` (*equals to*  `{JBegin (20):JBegin}`) 
:  P-segment of J gene to be used as alignment reference                                                                                                                    

 `JRegionWithP` (*equals to*  `{JBegin (20):JBegin}` + `{JBegin:FR4End}`) 
:  Full J Region with P-segment; to be used as alignment reference                                                                                                          

 `JPSegment` (*equals to*  `{JBeginTrimmed:JBegin}`) 
:  P-segment of J gene                                                                                                                                                      

 `JRegionTrimmed` (*equals to*  `{JBeginTrimmed:FR4End}`) 
:  Full J Region in rearranged sequence, e.g. after trimming                                                                                                                

 `JCDR3Part` (*equals to*  `{JBeginTrimmed:CDR3End}`) 
:  Part of J region inside CDR3 (commonly ends with Phe/Trp)                                                                                                                

 `FR4` (*equals to*  `{FR4Begin:FR4End}`) 
:  Framework 4 (J region after CDR3)                                                                                                                                        

 `CExon1` (*equals to*  `{CBegin:CExon1End}`) 
:  First exon of C Region                                                                                                                                                   

 `CRegion` (*equals to*  `{CBegin:CEnd}`) 
:  Full C region                                                                                                                                                            


# **List of predefined reference points**

 `UTR5Begin`           
:  Beginning of IG/TCR transcript                                                             

 `V5UTREnd`            
:  End of 5'UTR, beginning of IG/TCR CDS as listed in database                                

 `V5UTRBeginTrimmed`   
:  End of 5'UTR, beginning of IG/TCR CDS as observed in the data                              

 `L1Begin`             
:  End of 5'UTR, beginning of IG/TCR CDS                                                      

 `L1End`               
:  End of first exon, beginning of V intron                                                   

 `VIntronBegin`        
:  End of first exon, beginning of V intron                                                   

 `VIntronEnd`          
:  End of V intron, beginning of second exon                                                  

 `L2Begin`             
:  End of V intron, beginning of second exon                                                  

 `L2End`               
:  End of lider sequence, beginning of sequence that codes IG/TCR protein, beginning of FR1.  

 `FR1Begin`            
:  End of lider sequence, beginning of sequence that codes IG/TCR protein, beginning of FR1.  

 `FR1End`              
:  End of FR1, beginning of CDR1                                                              

 `CDR1Begin`           
:  End of FR1, beginning of CDR1                                                              

 `CDR1End`             
:  End of CDR1, beginning of FR2                                                              

 `FR2Begin`            
:  End of CDR1, beginning of FR2                                                              

 `FR2End`              
:  End of FR2, beginning of CDR2                                                              

 `CDR2Begin`           
:  End of FR2, beginning of CDR2                                                              

 `CDR2End`             
:  End of CDR2, beginning of FR3                                                              

 `FR3Begin`            
:  End of CDR2, beginning of FR3                                                              

 `FR3End`              
:  End of FR3, beginning of CDR3                                                              

 `CDR3Begin`           
:  End of FR3, beginning of CDR3                                                              

 `VEndTrimmed`         
:  End of V region after V(D)J rearrangement (commonly inside CDR3)                           

 `VEnd`                
:  End of V region in genome                                                                  

 `DBegin`              
:  Beginning of D region in genome                                                            

 `DBeginTrimmed`       
:  Beginning of D region after VDJ rearrangement                                              

 `DEndTrimmed`         
:  End of D region after VDJ rearrangement                                                    

 `DEnd`                
:  End of D region in genome                                                                  

 `JBegin`              
:  Beginning of J region in genome                                                            

 `JBeginTrimmed`       
:  Beginning of J region after V(D)J rearrangement                                            

 `CDR3End`             
:  End of CDR3, beginning of FR4                                                              

 `FR4Begin`            
:  End of CDR3, beginning of FR4                                                              

 `FR4End`              
:  End of FR4                                                                                 

 `CBegin`              
:  Beginning of C Region                                                                      

 `CExon1End`           
:  End of C Region first exon (Exon 3 of assembled TCR/IG gene)                               

 `CEnd`                
:  End of C Region                                                                            
