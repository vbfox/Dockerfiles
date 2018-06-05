# escape=`

FROM microsoft/dotnet-framework:4.7.2-sdk

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

#-----------------------------------------------------------------
# Updated .NET Core version (Sometimes unnecessary, depend on the version embeded with the main framework)

RUN Remove-Item -Force -Recurse $Env:ProgramFiles\dotnet; `
    Invoke-WebRequest -OutFile dotnet.zip https://download.microsoft.com/download/8/8/5/88544F33-836A-49A5-8B67-451C24709A8F/dotnet-sdk-2.1.300-win-x64.zip; `
    $dotnet_sha512 = '4aa6ff6aa51e1d71733944e10fd9e37647a58df7efbc76f432b8c3ffa3f617f9da36f72532175a1e765dbaf4598a14350017342d5f776dfe8e25d5049696d003'; `
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

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#-----------------------------------------------------------------
# NodeJS
RUN Invoke-WebRequest -OutFile nodejs.msi 'https://nodejs.org/dist/v8.11.2/node-v8.11.2-x64.msi'; `
    `
    $nodejs_sha256 = '108DD9CCD131931E42B57DC1243DC28AACFEBE207DE48C420A576FE453D33ED7'; `
    if ((Get-FileHash nodejs.msi -Algorithm sha256).Hash -ne $nodejs_sha256) { `
        Write-Host 'CHECKSUM VERIFICATION FAILED!'; `
        exit 1; `
    }; `
    `
    Start-Process msiexec.exe -ArgumentList '/q /i nodejs.msi' -Wait; `
    Remove-Item -Force nodejs.msi

#-----------------------------------------------------------------
# Yarn
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -OutFile yarn.msi https://github.com/yarnpkg/yarn/releases/download/v1.7.0/yarn-1.7.0.msi; `
    $yarn_sha256 = '133EE49AC1000D5AC6DCB233D10E70B860F1A710CE257237A37CFEA32F5972AF'; `
    if ((Get-FileHash yarn.msi -Algorithm sha256).Hash -ne $yarn_sha256) { `
        Write-Host 'CHECKSUM VERIFICATION FAILED!'; `
        exit 1; `
    }; `
    `
    Start-Process msiexec.exe -ArgumentList '/q /i yarn.msi' -Wait; `
    Remove-Item -Force yarn.msi
