---
hide:
  - toc
  - navigation
---
<style>
  .md-content__button {
    display: none;
  }
  .md-content > .md-content__inner {
      margin: 0 auto;
  }
</style>

![](about-light.svg#only-light)
![](about-dark.svg#only-dark)


# About

MiXCR is a software platform for immune profiling with Next-Generation Sequencing (NGS) data. It is used by majority of Big Pharma in the R&D for vaccine development, antibody discovery and cancer immunotherapy research.

MiXCR provides a seamless analytical pipeline starting from raw sequencing data to biological insights. It works with any wet lab protocol and data types. It extracts repertores from target amplicon sequencing protocols with and without molecular barcodes, shotgun and RNA-Seq libraries, various single cell technologies and is flexible to be tuned for any custom protocol.

Out of the box, it provides dedicated analytical pipelines for all kits from popular commercial vendors, standard sequencing data types and widely adopted public protocols. The whole analytical pipeline can be conducted as easy as one line. Few examples:

=== "10x Genomics"
    ```shell
    mixcr analyze \
          10x-vdj-bcr \
          in_R1.fq.gz \
          in_R2.fq.gz \
          output
    ```
=== "Takara Bio"
    ```shell
    mixcr analyze \
          takara-human-bcr-full-length \
          in_R1.fq.gz \
          in_R2.fq.gz \
          output
    ```
=== "RNA-Seq data"
    ```shell
    mixcr analyze \
          rnaseq-cdr3 \
          in_R1.fq.gz \
          in_R2.fq.gz \
          output
    ```

A full list of available presets [can be found here](reference/overview-built-in-presets.md).

The downstream analysis provided by MiXCR includes: 

 - data normalization
 - inference of novel allelic variants
 - reconstruction of B cell lineages
 - various types of repertoire profiles
 - powerful functionality to build repertoires overlap
 
Check out more in our [reference documentation](reference/overview-analysis-overview.md) and tutorial guides. 




