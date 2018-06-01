Push-Location

#Cleanup previous runs
Remove-Item 'src' -Force  -Recurse -ErrorAction SilentlyContinue

# UNZIP
mkdir src
$archive = @(Get-ChildItem -Path 'zabbix' '*.tar.gz')[0].FullName
& cmd.exe "/C 7za.exe x -so $archive | 7za.exe x -si -ttar -osrc"
cd src
cd @(Get-ChildItem *)[0]
$src = (Get-Location).Path
Remove-Item 'bin\win64\*' -Force -Recurse -ErrorAction SilentlyContinue
mkdir 'bin\win64\dev'

# TWEAK
cd build\win32\project
(Get-Content Makefile_sender_dll).replace('..\..\..\src\zabbix_sender\win32\zabbix_sender.o', '..\..\..\src\zabbix_sender\zabbix_sender.o') | Set-Content Makefile_sender_dll

# BUILD
& nmake CPU=AMD64 TLS=openssl TLSINCDIR="C:\OpenSSL-Win64\include" TLSLIBDIR="C:\OpenSSL-Win64\lib"

# Extract result
Pop-Location
mkdir 'zabbix\win64' -ErrorAction SilentlyContinue
Remove-Item 'zabbix\win64' -Force -Recurse -ErrorAction SilentlyContinue
Copy-Item "$src\bin\win64\*" 'zabbix\win64' -Recurse -Force