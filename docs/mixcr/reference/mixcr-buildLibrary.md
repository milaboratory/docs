# `mixcr buildLibrary`

Build custom V/D/J/C gene segment library. See [how to create custom library](../guides/create-custom-library.md).

## Command line options 

```
mixcr buildLibrary 
    --species <species_name>
    --chain <chain>
    [--taxon-id <taxon_id>]
    (--v-genes-from-species <species> | [--v-genes-from-fasta <v.fasta> --v-gene-feature <gene_feature>])
    (--j-genes-from-species <species> | [--j-genes-from-fasta <j.fasta> [--j-gene-feature <gene_feature>]])
    [--d-genes-from-species <species> | [--d-genes-from-fasta <j.fasta> [--d-gene-feature <gene_feature>]]]
    [--c-genes-from-species <species> | [--c-genes-from-fasta <j.fasta> [--c-gene-feature <gene_feature>]]]
    [--do-not-infer-points]
    [--keep-intermediate]
    [--debug]
    [--force-overwrite]
    [--no-warnings]
    [--verbose]
    [--help]
    library.json[.gz]
```

`--species <species_name>`
: Species name

`--chain <chain>`
: Immunological chain

`--v-genes-from-fasta <v.fasta>`
: FASTA file with Variable genes

`--v-gene-feature <gene_feature>`
: Gene feature corresponding to Variable gene sequences in FASTA (e.g. VRegion or VGene)

`--v-genes-from-species <species>`
: Species to take Variable genes from it (human, mmu, lamaGlama, alpaca, rat, spalax)

`--j-genes-from-fasta <j.fasta>`
: FASTA file with Joining genes

`--j-gene-feature <gene_feature>`
: Gene feature corresponding to Joining gene sequences in FASTA (`JRegion` by default)

`--j-genes-from-species <species>`
: Species to take Joining genes from it (human, mmu, lamaGlama, alpaca, rat, spalax)

`--d-genes-from-fasta <j.fasta>`
: FASTA file with Diversity genes

`--d-gene-feature <gene_feature>`
: Gene feature corresponding to Diversity gene sequences in FASTA (`DRegion` by default)

`--d-genes-from-species <species>`
: Species to take Diversity genes from it (human, mmu, lamaGlama, alpaca, rat, spalax)

`--c-genes-from-fasta <j.fasta>`
: FASTA file with Constant genes

`--c-gene-feature <gene_feature>`
: Gene feature corresponding to Constant gene sequences in FASTA (`CExon1` by default)

`--c-genes-from-species <species>`
: Species to take Constant genes from it (human, mmu, lamaGlama, alpaca, rat, spalax)

`--taxon-id <taxon_id>`
: Taxon ID

`--do-not-infer-points`
: Do not infer reference points

`--keep-intermediate`
: Keep intermediate files

`--debug`
: Print library debugging information

`-f`, `--force-overwrite`
: Force overwrite of output file(s).

`library.json[.gz]`
: Output library.
