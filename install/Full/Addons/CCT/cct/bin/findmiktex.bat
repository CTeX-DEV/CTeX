REM  $Id: findmiktex.bat,v 1.2 2006/08/28 08:45:49 zlb Exp $
REM
REM   usage:  %systemroot%\system32\cmd.exe /V:ON /C  findmiktex.bat
REM
REM initexmf -u
texhash

REM initexmf --mkmaps
updmap

For /F "usebackq delims=" %%i IN (`kpsewhich psfonts_t1.map`) DO set tempa=%%~fi
set localtexmf=%tempa:\dvips\config\psfonts_t1.map=%

for /F "usebackq delims=" %%i in (`kpsewhich tex.exe`) do set tempa=%%~fi
set texmf=%tempa:\miktex\bin\tex.exe=%

echo set texmf=%texmf%> ttfsetenv.bat
echo set localtexmf=%localtexmf%>> ttfsetenv.bat

set texversion=
for /F "usebackq delims=" %%i in (`tex --version`) do set texversion=!texversion!%%i
set texversion=%texversion:~0,14%
echo set texversion=%texversion%>>ttfsetenv.bat
