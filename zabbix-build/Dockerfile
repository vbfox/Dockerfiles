# escape=`

# Use the latest Windows Server Core image with .NET Framework 4.7.1.
FROM microsoft/dotnet-framework:4.7.2-runtime

WORKDIR C:\Temp

# Download the Build Tools bootstrapper.
RUN powershell -Command (New-Object net.webclient).Downloadfile('https://aka.ms/vs/15/release/vs_buildtools.exe', 'C:\TEMP\vs_buildtools.exe')

# Install Build Tools
RUN vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Component.Windows10SDK.17134 `
    --add Microsoft.VisualStudio.Component.VC.140 `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

RUN powershell -Command (New-Object net.webclient).Downloadfile('https://slproweb.com/download/Win64OpenSSL-1_1_0h.exe', 'C:\TEMP\OpenSSL.exe')

RUN C:\TEMP\OpenSSL.exe /VERYSILENT /SUPPRESSMSGBOXES

RUN powershell -Command (New-Object net.webclient).Downloadfile('https://cmake.org/files/v3.11/cmake-3.11.3-win64-x64.msi', 'cmake.msi')
RUN msiexec /i cmake.msi /quiet /qn /norestart

WORKDIR C:\Build

ADD 7za.exe Build.ps1 C:\Build\

# Start x64 Native build command prompt with any other commands specified.
ENTRYPOINT C:\BuildTools\VC\Auxiliary\Build\vcvars64.bat &&

# Default to PowerShell if no other command specified.
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]