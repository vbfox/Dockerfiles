# Docker image for building Zabbix Windows-x64 binaries with OpenSSL

As Zabbix doesn't provide builds with TLS enabled here is an image that can produce the binaries.

**NOTE: This image isn't publically pushed as the VS Build Tools license might not allow it, you need to build it yoursef**

## Building the image

Docker should be in Windows container mode (Require a recent Windows 10 or server 2016 machine)

As the VS Build Tools are large the maximum size of docker containers need to be made larger, see [Microsoft documentation][large-container] for documentation on how to change that.

[large-container]: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container#step-4-expand-maximum-container-disk-size

```cmd
docker build -t vbfox/zabbix-build:latest -m 2GB .
```

## Usage

Create a directory like `C:\Downloads\zabbix` that contains the current `zabbix-*.tar.gz` source file for zabbix and corresponding `pcre-*.zip` source then run :

```cmd
docker run -it -v C:\Downloads\zabbix:C:\build\zabbix vbfox/zabbix-build powershell Build.ps1
```

It will put the result in `C:\Downloads\zabbix\win64`.

Tested with
- [Zabbix 3.4.9](https://sourceforge.net/projects/zabbix/files/ZABBIX%20Latest%20Stable/3.4.9/zabbix-3.4.9.tar.gz/download)
- [PCRE 8.41](ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.41.zip)