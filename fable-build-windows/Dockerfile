# escape=`

FROM microsoft/dotnet-framework:4.7.2-sdk-20180814-windowsservercore-1803

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#-----------------------------------------------------------------
# Updated .NET Core version (Sometimes unnecessary, depend on the version embeded with the main framework)

ENV DOTNET_SDK_VERSION 2.1.401
RUN Remove-Item -Force -Recurse $Env:ProgramFiles\dotnet; `
    Invoke-WebRequest -OutFile dotnet.zip https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$Env:DOTNET_SDK_VERSION/dotnet-sdk-$Env:DOTNET_SDK_VERSION-win-x64.zip; `
    $expected = '7D017487C1A11AE4DB862B1EFA7BA9BEB0EABCF5D2467BC4055AA2227A548663A596682FF4ADBA4688930B22472587F29B83BCE9F689EFC5E9F4E37F7EDDA000'; `
    $actual = (Get-FileHash dotnet.zip -Algorithm sha512).Hash; `
    if ($actual -ne $expected) { `
        Write-Host "CHECKSUM VERIFICATION FAILED! FOUND $actual expected $expected"; `
        exit 1; `
    }; `
    `
    Expand-Archive dotnet.zip -DestinationPath $Env:ProgramFiles\dotnet; `
    Remove-Item -Force dotnet.zip

RUN setx /M PATH $($Env:PATH + ';' + $Env:ProgramFiles + '\dotnet')

# Configure Kestrel web server to bind to port 80 when present
ENV ASPNETCORE_URLS=http://+:80 `
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true `
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true `
    # Skip extraction of XML docs - generally not useful within an image/container - helps perfomance
    NUGET_XMLDOC_MODE=skip

# Trigger first run experience by running arbitrary cmd to populate local package cache
RUN dotnet help

#-----------------------------------------------------------------
# NodeJS
ENV NODE_VERSION 10.9.0
RUN Invoke-WebRequest -OutFile nodejs.msi "https://nodejs.org/dist/v$Env:NODE_VERSION/node-v$Env:NODE_VERSION-x64.msi"; `
    `
    $expected = '67B7DACA5E4C2B25B18024230AF5CA205717317CA1A561F4F087C2DA2E4D77F3'; `
    $actual = (Get-FileHash nodejs.msi -Algorithm sha256).Hash; `
    if ($actual -ne $expected) { `
        Write-Host "CHECKSUM VERIFICATION FAILED! FOUND $actual expected $expected"; `
        exit 1; `
    }; `
    `
    Start-Process msiexec.exe -ArgumentList '/q /i nodejs.msi' -Wait; `
    Remove-Item -Force nodejs.msi

#-----------------------------------------------------------------
# Yarn
ENV YARN_VERSION 1.9.4
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -OutFile yarn.msi "https://github.com/yarnpkg/yarn/releases/download/v$Env:YARN_VERSION/yarn-$Env:YARN_VERSION.msi"; `
    $expected = '5CA0ADB78D2F3A718D7A1FEEF0496D8EAD9BCA599367DFF0F98CD742D5A72FDD'; `
    $actual = (Get-FileHash yarn.msi -Algorithm sha256).Hash; `
    if ($actual -ne $expected) { `
        Write-Host "CHECKSUM VERIFICATION FAILED! FOUND $actual expected $expected"; `
        exit 1; `
    }; `
    `
    Start-Process msiexec.exe -ArgumentList '/q /i yarn.msi' -Wait; `
    Remove-Item -Force yarn.msi
