# `mitool consensus`

Assemble consensuses for sequences inside tag groups.(ex. UMI-based correction)

Usage: 
```shell
mitool consensus [OPTIONS] SOURCE DESTINATION
```
Arguments:
`SOURCE`
: Input `*.mic` file

`DESTINATION`
: Output `*.mic` file.

Options:

`-g, --group-tag <TEXT>`
: Tags to build groups of reads for consensus assembly (e.g. `CELL`, `UMI`, etc...). If not set MiTool will use defaults
if preset was specified on the `parse` step.

`-a, --assemble-tag <TEXT>`
: Tags to assemble consensuses for (e.g. `R1`, `R2`, `PAYLOAD`, etc...). If not set MiTool will use defaults if preset 
was specified on the parse step.

`--use-system-temp`
: Use system temp folder for temporary files

`-t, --threads <INT>
: Number of processing threads

`-r, --report <PATH>`
: Human readable report file. If file already exists, it will be overwritten.

`-O <VALUE>`
: Override consensus assembly parameters.

`-h, --help`
: Show this message and exit
