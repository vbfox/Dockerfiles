Push-Location

# CLEANUP PREVIOUS RUNS IF ANY
Remove-Item 'src' -Force  -Recurse -ErrorAction SilentlyContinue
mkdir src

# BUILD PCRE
Push-Location
$pcreArchive = @(Get-ChildItem -Path 'zabbix' 'pcre-*.zip')[0].FullName
& .\7za.exe x -osrc $pcreArchive
Set-Location src
Set-Location @(Get-ChildItem 'pcre-*')[0]
$pcreSrc = (Get-Location).Path
$env:PATH += ';C:\Program Files\CMake\bin'
cmake -G "Visual Studio 14 2015 Win64" -DPCRE_SUPPORT_UNICODE_PROPERTIES=ON -DPCRE_SUPPORT_UTF=ON -DCMAKE_C_FLAGS_RELEASE:string="/MT"
& msbuild PCRE.sln /property:Configuration="Release"
Pop-Location

# UNZIP ZABBIX
$zabbixArchive = @(Get-ChildItem -Path 'zabbix' 'zabbix-*.tar.gz')[0].FullName
& cmd.exe "/C 7za.exe x -so $zabbixArchive | 7za.exe x -si -ttar -osrc"
Set-Location src
Set-Location @(Get-ChildItem 'zabbix-*')[0]
$src = (Get-Location).Path
Remove-Item 'bin\win64\*' -Force -Recurse -ErrorAction SilentlyContinue
mkdir 'bin\win64\dev'

# TWEAK
Set-Location build\win32\project
(Get-Content Makefile_sender_dll).replace('..\..\..\src\zabbix_sender\win32\zabbix_sender.o', '..\..\..\src\zabbix_sender\zabbix_sender.o') | Set-Content Makefile_sender_dll

# BUILD
& nmake CPU=AMD64 TLS=openssl TLSINCDIR="C:\OpenSSL-Win64\include" TLSLIBDIR="C:\OpenSSL-Win64\lib" "PCREINCDIR=$pcreSrc" "PCRELIBDIR=$pcreSrc\Release"

# MOVE BINARIES OUT OF CONTAINER
Pop-Location
mkdir 'zabbix\win64' -ErrorAction SilentlyContinue
Remove-Item 'zabbix\win64' -Force -Recurse -ErrorAction SilentlyContinue
Copy-Item "$src\bin\win64\*" 'zabbix\win64' -Recurse -Force

Copy-Item 'C:\OpenSSL-Win64\bin\msvcr*.dll' 'zabbix\win64'
Copy-Item 'C:\OpenSSL-Win64\bin\libcrypto*.dll' 'zabbix\win64'
Copy-Item 'C:\OpenSSL-Win64\bin\libssl*.dll' 'zabbix\win64'