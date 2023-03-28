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


## Offline use

MiXCR requires internet access to periodically validate license key. For running MiXCR in the environment with restricted internet access, please add the following MiXCR IPs to the whitelist in the firewall settings:

```shell
IPv4:
75.2.96.100
99.83.215.63

IPv6:
2600:9000:a403:55e8:f9c1:f443:773b:4192
2600:9000:a51b:2483:639d:d5a9:270f:6439
```