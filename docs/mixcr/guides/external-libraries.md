# Using external library

MiXCR has a built-in set of reference libraries that were carefully created by our team. However, one can use other external libraries, such as IMGT or any other. These libraries have toi be property compiled to use with MiXCR.

## Using IMGT library

Compiled IMGT library file for MiXCR can be downloaded at
[https://github.com/repseqio/library-imgt/releases](https://github.com/repseqio/library-imgt/releases).
In order to use the library put the `.json` library file to one of the following locations:

- `~/.mixcr/libraries` folder
- the directory from where mixcr is started
- libraries/ subfolder of mixcr installation folder


Use `mixcr -v` to see what folders mixcr uses to look for library `.json` file.
```shell
> mixcr -v
    ...
Library search path:
- built-in libraries
- /home/username/.
- /home/username/.mixcr/libraries
- /software/mixcr/libraries
```

Option `--library` specifies the library to use for `mixcr align`. If the short name is given (ex.``–library imgt``) mixcr will look for the latest version in the folder. Otherwise, to use one of the old versions give the full name including
the version number (ex. `-library imgt.201631-4`)

Example:
```shell
> mixcr align --library imgt input_R1.fastq input_R2.fastq alignments.vdjca
```

    
    