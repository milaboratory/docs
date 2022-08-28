# `repseqio debug`

Outputs extensive information on genes in the library.

Usage: 

```
repseqio debug [--all] [--name <regex>] input_library.json[.gz]
```

Options:

`-a, --all`
: Check all genes, used with `-p` option.

`-n, --name <regex>`
: Gene name pattern, regexp string, all genes with matching gene name will be exported.

`-p, --problems`
: Print only genes with problems, checks only functional genes by default (see `-a` option).
