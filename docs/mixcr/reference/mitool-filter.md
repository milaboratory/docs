# `mitool filter`

Filter sequences in `.mic` file

Usage: 

```shell
mitool filter [OPTIONS] SOURCE
```

Arguments:

`<SOURCE>`
: Input `*.mic` file

Options:

`-c, --channel <TEXT...>`            
: Filter expression followed by the destination `*.mic` file name 
    !!! tip 
        it might be a good idea to wrap filtering expression in `'` (single quote char) to prevent interpretation of 
        it's content by the shell)

`-l, --channels-from-file <PATH>`    
: Load channel list from a two column tab-separated table file (filter + output file name).

`-t, --channels-from-tag-table <PATH>`
: Load channel list from a tab-separated table with header setting tag names and cells tag values that are to be matched.

`-h, --help`
: Show this message and exit

