# `mitool correct`

Correct tag sequences

Usage: 

```shell
mitool correct [OPTIONS] SOURCE DESTINATION
```

Arguments:
`SOURCE`
: Input *.mic file

`DESTINATION`:
Output *.mic file.

Options:

`-t, --tag <TEXT>`
: Name(s) of the tags to correct, each subsequent tag is 
corrected inside the group of equal tags going before it in the list. To correct a tag against a fixed set add a set 
specification separated by a hash sign after the tag name, i.e. `"CELL#preset:737K-august-2016"` or `"UMI#file:my_umi_list.txt"`.
    !!! note
        if `--preset` was used on the `parse` step you most probably can run this command without additional parameters
        as the appropriate defaults will be set for you from the preset collection

`-p, --power <FLOAT>` (*default*: `0.001` or from preset)
: This parameter determines how thorough the procedure should eliminate variants looking like errors. Smaller value leave
less erroneous variants at the cost of accidentally correcting true variants. This value approximates the fraction of 
erroneous variants the algorithm will miss (type II errors).

`-s, --substitution-rate <FLOAT>` (*default*: `0.001` or from preset)
: Expected background non-sequencing-related substitution rate 

`-i, --indel-rate <FLOAT>` (*default*: `1.0E-5` or from preset)       
: Expected background non-sequencing-related indel rate

`-q, --min-quality <INT>` (*default*: `12` or from preset)    
: Minimal quality score for the tag. Tags having positions with lower quality score will be discarded, if not corrected.

`--max-substitutions <INT>` (*default*: `2` or from preset)
: Maximal number of substitutions to search for.

`--max-indels <INT>`(*default*: `2` or from preset)
: Maximal number of indels to search for.

`--max-errors <INT>` (*default*: `3` or from preset)
: Maximal number of indels and substitutions
combined to search for.

`--use-system-temp`
: Use system temp folder for temporary files

`-r, --report <PATH>`
: Human readable report file. If file already exists, it will be overwritten.

`-h, --help`:
Show this message and exit

