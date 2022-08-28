# Obtaining and using license key

To run MiXCR one need a license file. MiXCR is free for academic users with no commercial funding. We are committed to support academic community and provide our software free of charge for scientists doing non-profit research.

Academic users can quickly get a license at [https://licensing.milaboratories.com](https://licensing.milaboratories.com).

Commercial trial license may be requested at [https://licensing.milaboratories.com](https://licensing.milaboratories.com) or by email to [licensing@milaboratories.com](mailto:licensing@milaboratories.com).


The easiest way to activate the license is to run `activate-license` command and paste the content of the license key therein:
```shell
> mixcr activate-license

  Please enter the license: ...
```

Another way to activate the license is to put `mi.license` file in the one of the following directories:

- ~/.mi.license 
- ~/mi.license 
- directory with `mixcr.jar` file 
- directory with MiXCR executable
  
Finally, one can use environment variables:

- `MI_LICENSE` env var with the content of `mi.license` file
- `MI_LICENSE_FILE` env var with the path to `mi.license` file
