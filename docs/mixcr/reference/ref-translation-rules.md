№ Translation rules

All processing inside MiXCR is performed on the nucleotide level, sequences are translated only while exporting results (`exportClones`, `exportAlignments`, `exportAlignmentsPretty` and `exportClonesPretty`).

MiXCR uses special rules for translation of out-of-frame sequences. The procedure make extensive use of information about anchor point positions inside the target sequence.

All gene features having length that is a multiple of 3 (e.g. in-frame `CDR3`), are translated as is, without any special rules. In all other cases, amino acid sequence is padded with special `_` symbol in place of incomplete codon. The following paragraph describes rules for placing `_` inside amino acid sequence.

All anchor points in MiXCR (and RepSeq.io library) are either (a) triplet-boundary-attached (like `CDR3Begin`, `L1Begin`), such anchor points are known to always point to the first nucleotide in triplet, and (b) non-triplet-boundary-attached (like `VEnd`, `V5UTRBegin` or `VIntronEnd`). This way there may be four cases for gene feature (gene region bounded by two anchor points):

- (e.g. `CDR3`, `FR3`, etc..) both, left and right boundary anchor points are triplet-boundary-attached. In this case  sequence is divided into triplets starting from both sides simultaneously: one from the left side, one from the right side and so on. One or two nucleotides left after such procedure are translated as "incomplete codon" (`_`).

  ```
    ATT GAC AG  ACA
     I   D   _   T
  ```
- (e.g. `VCDR3Part`, `L1` etc..) left boundary anchor point is triplet-boundary-attached and right boundary point is not. In this case  sequence is divided into triplets starting from the left side. One or two nucleotides left after such procedure are translated as "incomplete codon" (`_`).

  ```
    ATG GAC AG
     M   D   _
  ```

- (e.g. `JCDR3Part`, `L2`, etc..) right boundary anchor point is triplet-boundary-attached and left boundary point is not. In this case  sequence is divided into triplets starting from the right side. One or two nucleotides left after such procedure are translated as "incomplete codon" (`_`).

  .. raw:: html

  ```
    AG  ATT GAC
     _   I   D
  ```

- if both anchor points are not triplet-boundary-attached, translation is performed starting from left side, like described in second case.