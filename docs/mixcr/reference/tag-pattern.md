# Pattern syntax

Patterns are used in ```mixcr align``` to specify which sequences must pass to the
output and which sequences must be filtered out. Also, capture groups in patterns
are used for barcode extraction. Patterns must always be specified after 
```--tag-pattern``` option (or in a file ```--tag-pattern-file```) and must always
 be in double quotes.

Examples:
```
mixcr align \
-s mmu \
--tag-pattern "^(UMI:N{3:5})attgcccgAAA\*" \
input_R1.fastq input_R2.fastq output.vdjca
```
## Basic Syntax Elements

Many syntax elements in patterns are similar to regular expressions, but there 
are differences. Uppercase and lowercase letters are used to specify the sequence 
that must be matched, but uppercase letters don’t allow indels between them and 
lowercase letters allow indels. Indels on left and right borders of uppercase 
letters are also not allowed. Standard IUPAC wildcards (N, W, S, M etc) are
also allowed in both uppercase and lowercase sequences.

`\` character is very important syntax element: it used as read separator. There can be single-read input files, in this case \ character must not be used. In multi-read inputs \ must be used, and number of reads in pattern must be equal to number of input FASTQ files (or to number of reads in input MIF file if --input-format MIF parameter is used). There can be many reads, but the most common case is 2 reads: R1 and R2. By default, extract action will check input reads in order they specified in --input argument, or if input file is MIF, then in order they saved in MIF file. If --try-reverse-order argument is specified, it will also try the combination with 2 swapped last reads (for example, if there are 3 reads, it will try R1, R2, R3 and R1, R3, R2 combinations), and then choose the match with better score.

Another important syntax element is capture group. It looks like (group_name:query) where group_name is any sequence of letters and digits (like UMI or SB1) that you use as group name. Group names are case sensitive, so UMI and umi are different group names. query is part of query that will be saved as this capture group. It can contain nested groups and some other syntax elements that are allowed inside single read (see below).

R1, R2, R3 etc are built-in group names that contain full matched reads. You can override them by specifying manually in the query, and overridden values will go to output instead of full reads. For example, query like this