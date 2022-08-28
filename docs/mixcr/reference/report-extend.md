# `extend` report

MiXCR generates a comprehensive summary of extender performance. Extender reports may be generated right along with [`extend`](./mixcr-extend.md) command using `-r`/`--report` for `txt` report and `-j/--json-report` for report in a json format, or can be exported using [`exportReports`](./mixcr-exportReports.md) command.

??? note "Show sample report"
    === ".txt"
        ```
        ============== Extend Report ==============
        Input file(s): result/Treg_REH_4h_rep1.rescued_1.vdjca
        Output file(s): result/Treg_REH_4h_rep1.extended.vdjca
        Version: ; built=Fri Jul 15 01:51:38 CEST 2022; rev=aa769be87b; lib=repseqio.v2.0
        Command line arguments: --report result/Treg_REH_4h_rep1.report --threads 24 result/Treg_REH_4h_rep1.rescued_1.vdjca result/Treg_REH_4h_rep1.extended.vdjca
        Analysis time: 0ns
        Extended alignments count: 152 (3.57%)
        V extensions total: 0 (0%)
        V extensions with merged targets: 0 (0%)
        J extensions total: 152 (3.57%)
        J extensions with merged targets: 0 (0%)
        V+J extensions: 0 (0%)
        Mean V extension length: NaN
        Mean J extension length: 8.480263157894736
        ```
    === ".json"
        ```json
        {
          "type": "extenderReport",
          "commandLine": "--report result/Treg_REH_4h_rep1.report --threads 24 result/Treg_REH_4h_rep1.rescued_1.vdjca result/Treg_REH_4h_rep1.extended.vdjca",
          "inputFiles": [
            "result/Treg_REH_4h_rep1.rescued_1.vdjca"
          ],
          "outputFiles": [
            "result/Treg_REH_4h_rep1.extended.vdjca"
          ],
          "version": "; built=Fri Jul 15 01:51:38 CEST 2022; rev=aa769be87b; lib=repseqio.v2.0",
          "totalProcessed": 4252,
          "totalExtended": 152,
          "vExtended": 0,
          "vExtendedMerged": 0,
          "jExtended": 152,
          "jExtendedMerged": 0,
          "vjExtended": 0,
          "meanVExtensionLength": "NaN",
          "meanJExtensionLength": 8.480263157894736
        }
        ```

`Extended alignments count`
: Number of extended alignments/clones

`V extensions total`
: Number of V-gene extensions 

`V extensions with merged targets`
: Number of V-gene extensions that lead to the overlap of targets (e.g. R1 and R2)

`J extensions total`
: Number of J-gene extensions

`J extensions with merged targets`
: Number of J-gene extensions that lead to the overlap of targets (e.g. R1 and R2)


`V+J extensions`
: Number of alignments/clones where both V and J genes were extended 

`Mean V extension length`
: Mean nucleotide length of V extensions

`Mean J extension length`
: Mean nucleotide length of J extensions
