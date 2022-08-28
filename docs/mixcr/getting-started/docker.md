# Using with Docker

Official MiXCR Docker repository is [hosted on the GitHub](https://github.com/milaboratory/mixcr/pkgs/container/mixcr%2Fmixcr) along with this repo.

Example:

```shell
> docker run --rm \
    -e MI_LICENSE="...license-token..." \
    -v /path/to/raw/data:/raw:ro \
    -v /path/to/put/results:/work \
    ghcr.io/milaboratory/mixcr/mixcr:latest \
    align -s hs \
    /raw/data_R1.fastq.gz \
    /raw/data_R2.fastq.gz \
    alignments.vdjca 
```

## Tags

The docker repo provides pre-built docker images for all release versions of MiXCR starting from 1.1. Images come in two flavours: "mixcr only" (i.e tag `4.0.0`) and co-bundled "mixcr + imgt reference" (i.e. tag `4.0.0-imgt`), for the latter please see the license note below. All bundled versions before and including `4.0.0` contain IMGT reference version `202214-2` from [here](https://github.com/repseqio/library-imgt/releases/tag/v8), this might be different from the images from the previous official docker registry on Docker Hub (which is now deprecated and planned for removal).

See [docker packages](https://github.com/milaboratory/mixcr/pkgs/container/mixcr%2Fmixcr) page for the full list of tags including development builds.

## Setting the license

There are several ways to pass the license for mixcr when executed inside a container:

1. Using environment variable:

   ```shell
   docker run \
       -e MI_LICENSE="...license-token..." \
       ....
   ```

2. Using license file:

   ```shell
   docker run \
       -v /path/to/mi.license:/opt/mixcr/mi.license:ro \
       ....
   ```

3. If it is hard to mount `mi.license` file into already populated folder `/opt/mixcr/` (i.e. in Kubernetes or with other container orchestration tools), you can tell MiXCR where to look for it:

   ```shell
   docker run \
       -v /path/to/folder_with_mi_license:/secrets:ro \
       -e MI_LICENSE_FILE="/secrets/milicense.txt" \
       ....
   ```

## Migration from the previous docker images

New docker images define `mixcr` startup script as an entrypoint of the image, compared to the previous docker repo where `bash` was used instead. So, what previously was executed this way:

```shell
docker run ... old/mixcr/image/address:with_tag mixcr align ...
```

now will be

```shell
docker run ... new/mixcr/image/address:with_tag align ...
```

For those who rely on other tools inside the image, beware, new build relies on a different base image and has slightly different layout.

`mixcr` startup script is added to `PATH` environment variable, so even if you specify custom entrypoint, there is no need in using of full path to run `mixcr`.

## License notice for IMGT images

Images with IMGT reference library contain data imported from IMGT and is subject to terms of use listed on http://www.imgt.org site.

Data coming from IMGT server may be used for academic research only, provided that it is referred to IMGT&reg;, and cited as "IMGT&reg;, the international ImMunoGeneTics information system&reg; http://www.imgt.org (founder and director: Marie-Paule Lefranc, Montpellier, France)."

References to cite: Lefranc, M.-P. et al., Nucleic Acids Research, 27, 209-212 (1999) Cover of NAR; Ruiz, M. et al., Nucleic Acids Research, 28, 219-221 (2000); Lefranc, M.-P., Nucleic Acids Research, 29, 207-209 (2001); Lefranc, M.-P., Nucleic Acids Res., 31, 307-310 (2003); Lefranc, M.-P. et al., In Silico Biol., 5, 0006 (2004) [Epub], 5, 45-60 (2005); Lefranc, M.-P. et al., Nucleic Acids Res., 33, D593-D597 (2005) Full text, Lefranc, M.-P. et al., Nucleic Acids Research 2009 37(Database issue): D1006-D1012; doi:10.1093/nar/gkn838 Full text.
