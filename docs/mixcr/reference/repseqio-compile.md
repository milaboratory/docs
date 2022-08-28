# `repseqio compile`

Compiles a library into self-contained compiled library file, by embedding sequence information into "sequenceFragments" section.

Usage: 
```
repseqio compile [-f] [-s <length>] input.json[.gz] output.json[.gz]
```

Options:

`-f, --force`
: Force overwrite of output file(s).

`-s, --surrounding <length>`
: Length of surrounding sequences to include into library. Number of upstream and downstream nucleotides around V/D/J/C segments to embed into output library's "sequenceFragments" section. More nucleotides will be included, more surrounding sequences will be possible to request using gene features with offset (like `JRegion(-12, +3)`), at the same time size of output file will be greater. Default 30.
