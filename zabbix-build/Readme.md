# Docker image for building Zabbix Windows-x64 binaries with OpenSSL

As Zabbix doesn't provide builds with TLS enabled here is an image that can produce the binaries.

**NOTE: This image isn't publically pushed as the VS Build Tools license might not allow it, you need to build it yoursef**

## Usage

Create a directory like `C:\Downloads\zabbix` that contains only the current `.tar.gz` source file then run :

```
docker run -it -v C:\Downloads\zabbix:C:\build\zabbix vbfox/zabbix-build powershell Build.ps1
```

It will put the result in `C:\Downloads\zabbix\win64`.

## Building the image

As the VS Build Tools are large the size of the docker builder need to be made larger, see [Microsoft documentation][large-container].

[large-container]: https://docs.microsoft.com/en-us/visualstudio/install/build-tools-container#step-4-expand-maximum-container-disk-size

```
docker build -t vbfox/zabbix-build:latest -m 4GB .
```

