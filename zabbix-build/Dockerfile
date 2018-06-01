# escape=`

# Use the latest Windows Server Core image with .NET Framework 4.7.1.
FROM microsoft/dotnet-framework:4.7.1

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

#(Get-Content c:\temp\test.txt).replace('[MYID]', 'MyValue') | Set-Content c:\temp\test.txt
#nmake CPU=AMD64 TLS=openssl TLSINCDIR="C:\OpenSSL-Win64\include" TLSLIBDIR="C:\OpenSSL-Win64\lib"
RUN powershell -Command (New-Object net.webclient).Downloadfile('https://slproweb.com/download/Win64OpenSSL-1_1_0h.exe', 'C:\TEMP\OpenSSL.exe')

# (New-Object net.webclient).Downloadfile('https://slproweb.com/download/Win64OpenSSL-1_1_0h.exe', 'OpenSSL.exe')
#ADD https://slproweb.com/download/Win64OpenSSL-1_1_0h.exe C:\TEMP\OpenSSL.exe

RUN C:\TEMP\OpenSSL.exe /VERYSILENT /SUPPRESSMSGBOXES

WORKDIR C:\Build

ADD 7za.exe Build.ps1 C:\Build\

# RUN powershell -Command &cmd.exe "/C C:\TEMP\7za.exe x -so $(@(gci *.tar.gz)[0].Name) | C:\TEMP\7za.exe x -si -ttar -oC:\temp\src"

#https://cmake.org/files/v3.11/cmake-3.11.3-win64-x64.msi
# msiexec /i cmake /quiet /qn /norestart

# Start developer command prompt with any other commands specified.
ENTRYPOINT C:\BuildTools\VC\Auxiliary\Build\vcvars64.bat &&

# Default to PowerShell if no other command specified.
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]