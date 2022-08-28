# `mitool tag-stat`

Print statistics regarding tags in a `mic` file.

Usage: 
```shell
mitool tag-stat [OPTIONS] SOURCE [DESTINATION]
```
Arguments:

`<SOURCE>`
: Input *.mic file

`DESTINATION`
: Output *.txt file, if not specified, output will be printed to stdout

Options:

`-t, --tags <TEXT>`
: Name(s) of the tags to export

`-l, --top <INT>`
: Output results only for the top-N tags

`-h, --help`
: Show this message and exit

