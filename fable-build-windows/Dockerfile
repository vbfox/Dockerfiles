# escape=`

FROM microsoft/dotnet-framework:4.7.2-sdk-windowsservercore-1803

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#-----------------------------------------------------------------
# Updated .NET Core version (Sometimes unnecessary, depend on the version embeded with the main framework)

ENV DOTNET_SDK_VERSION 2.1.301
RUN Remove-Item -Force -Recurse $Env:ProgramFiles\dotnet; `
    Invoke-WebRequest -OutFile dotnet.zip https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$Env:DOTNET_SDK_VERSION/dotnet-sdk-$Env:DOTNET_SDK_VERSION-win-x64.zip; `
    $dotnet_sha512 = 'f2f6cc020f89dc4d4f8064cc914cffabde0ce422715138778a6bcbbb6803ca66d6fd967097a0209c47c89b85dd9e93db48486ac86999bd3a533e45b789fcea89'; `
    if ((Get-FileHash dotnet.zip -Algorithm sha512).Hash -ne $dotnet_sha512) { `
        Write-Host 'CHECKSUM VERIFICATION FAILED!'; `
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
ENV NODE_VERSION 10.5.0
RUN Invoke-WebRequest -OutFile nodejs.msi "https://nodejs.org/dist/v$Env:NODE_VERSION/node-v$Env:NODE_VERSION-x64.msi"; `
    `
    $expected = 'BAEE3A34ECBE9040C6DA8F01EB61BDE563A0458A94401A80DD87229FC938ADD4'; `
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
ENV YARN_VERSION 1.7.0
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -OutFile yarn.msi "https://github.com/yarnpkg/yarn/releases/download/v$Env:YARN_VERSION/yarn-$Env:YARN_VERSION.msi"; `
    $expected = '133EE49AC1000D5AC6DCB233D10E70B860F1A710CE257237A37CFEA32F5972AF'; `
    $actual = (Get-FileHash yarn.msi -Algorithm sha256).Hash; `
    if ($actual -ne $expected) { `
        Write-Host "CHECKSUM VERIFICATION FAILED! FOUND $actual expected $expected"; `
        exit 1; `
    }; `
    `
    Start-Process msiexec.exe -ArgumentList '/q /i yarn.msi' -Wait; `
    Remove-Item -Force yarn.msi
