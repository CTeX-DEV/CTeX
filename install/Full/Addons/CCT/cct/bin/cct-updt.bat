@echo on

@rem --- Run cctinit
@echo "Running cctinit.exe ..."
echo -H"%localtexmf%\tex\latex\cct" -T"%localtexmf%\fonts\tfm\cct" > "%localtexmf%\cct\bin\cctinit.ini"
@if exist "%localtexmf%\cct\bin\cct.dat" goto cctinit1
@echo Creating default "%localtexmf%\cct\bin\cct.dat".
@copy "%localtexmf%\tex\latex\cct\cct.dat-dist" "%localtexmf%\cct\bin\cct.dat"
:cctinit1
"%localtexmf%\cct\bin\cctinit"
@if errorlevel 1 pause

@rem --- Create cmap files
REM if not "%texmf%A"=="A" cd "%texmf%"


copy/y "%localtexmf%\tex\latex\ccmap\makecmap.tex" . >nul
@if not exist "%texmf%\ttf2tfm\base\UGBK.sfd" goto cmap3
copy/y "%texmf%\ttf2tfm\base\UGBK.sfd" . >nul
goto cmap4
:cmap3
@if not exist "%texmf%\tex\latex\ccmap\UGBK.sfd" goto cmap1
copy/y "%texmf%\tex\latex\ccmap\UGBK.sfd" . >nul
:cmap4
@echo "Generating %localtexmf%\tex\latex\ccmap\c19\c19*.cmap ..."
del "%localtexmf%\tex\latex\ccmap\c19??.cmap" >nul
latex \def\cmapEnc{GBK} \input{makecmap.tex}
mkdir "%localtexmf%\tex\latex\ccmap\c19" >nul
move/y c19??.cmap "%localtexmf%\tex\latex\ccmap\c19\." >nul
del ugbk.sfd
:cmap1
@if not exist "%texmf%\ttf2tfm\base\UGB.sfd" goto cmap5
copy/y "%texmf%\ttf2tfm\base\UGB.sfd" . >nul
goto cmap6
:cmap5
@if not exist "%texmf%\tex\latex\ccmap\UGB.sfd" goto cmap2
copy/y "%texmf%\tex\latex\ccmap\UGB.sfd" . >nul
:cmap6
@echo "Generating %localtexmf%\tex\latex\ccmap\c10\c10*.cmap ..."
del "%localtexmf%\tex\latex\ccmap\c10??.cmap" >nul
latex \def\cmapEnc{GB} \input{makecmap.tex}
mkdir "%localtexmf%\tex\latex\ccmap\c10" >nul
move/y c10??.cmap "%localtexmf%\tex\latex\ccmap\c10\." >nul
del ugb.sfd
:cmap2
del makecmap.*

@rem --- Add corners.pfb to configuration files
@rem if exist "%localtexmf%\web2c\updmap.cfg" goto ???
@echo "Installing font corners.pfb ..."
"%localtexmf%\cct\bin\addtocfg" "%localtexmf%\miktex\config\updmap.cfg" "# For everb.sty" "Map corners.map"
@if errorlevel 1 pause

@rem --- Update map files and filenames database
@echo "Updating filenames database ..."
"%texmf%\miktex\bin\initexmf" --update-fndb >nul
@if errorlevel 1 pause
@echo "Updating map files ..."
"%texmf%\miktex\bin\initexmf" --mkmaps >nul
@if errorlevel 1 pause

@rem --- Create README.pdf and CCTLaTeX.pdf
set path=%localtexmf%\cct\bin;%path%
copy/y "%localtexmf%\cct\doc\README.tex" .
copy/y "%localtexmf%\cct\doc\cctdiag.eps" .
@echo \let\dvipdfm=1\input README.tex >tmp.tex
"%localtexmf%\cct\bin\ctex" -dvipdfmx tmp.tex
del "%localtexmf%\cct\doc\README.pdf" >nul
move tmp.pdf "%localtexmf%\cct\doc\README.pdf"
del tmp.* >nul
del README.tex >nul
del cctdiag.eps >nul
copy/y "%localtexmf%\cct\doc\CCTLaTeX.tex" .
@echo \let\dvipdfm=1\input CCTLaTeX.tex >tmp.tex
"%localtexmf%\cct\bin\ctex" -dvipdfmx tmp.tex
del "%localtexmf%\cct\doc\CCTLaTeX.pdf" >nul
move tmp.pdf "%localtexmf%\cct\doc\CCTLaTeX.pdf"
del tmp.* >nul
del CCTLaTeX.tex >nul
"%localtexmf%\cct\bin\ctex" -clean >nul
