Function AssociateAdmin

  ; .aux
  WriteRegStr HKCR ".aux" "" "WinEdt.aux"
  WriteRegStr HKCR "WinEdt.aux" "" "LaTeX Auxiliaries"
  WriteRegStr HKCR "WinEdt.aux\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ltxaux.ico,0"
  WriteRegStr HKCR "WinEdt.aux\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .bbl
  WriteRegStr HKCR ".bbl" "" "WinEdt.bbl"
  WriteRegStr HKCR "WinEdt.bbl" "" "BibTeX Bibliography"
  WriteRegStr HKCR "WinEdt.bbl\DefaultIcon" "" "$INSTDIR\WinShell\Icons\bbl.ico,0"
  WriteRegStr HKCR "WinEdt.bbl\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .bib
  WriteRegStr HKCR ".bib" "" "WinEdt.bib"
  WriteRegStr HKCR "WinEdt.bib" "" "BibTeX Data Base"
  WriteRegStr HKCR "WinEdt.bib\DefaultIcon" "" "$INSTDIR\WinShell\Icons\bib.ico,0"
  WriteRegStr HKCR "WinEdt.bib\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .blg
  WriteRegStr HKCR ".blg" "" "WinEdt.blg"
  WriteRegStr HKCR "WinEdt.blg" "" "BibTeX Log"
  WriteRegStr HKCR "WinEdt.blg\DefaultIcon" "" "$INSTDIR\WinShell\Icons\blg.ico,0"
  WriteRegStr HKCR "WinEdt.blg\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .bst
  WriteRegStr HKCR ".bst" "" "WinEdt.bst"
  WriteRegStr HKCR "WinEdt.bst" "" "BibTeX Bibliography Style"
  WriteRegStr HKCR "WinEdt.bst\DefaultIcon" "" "$INSTDIR\WinShell\Icons\bst.ico,0"
  WriteRegStr HKCR "WinEdt.bst\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .clo
  WriteRegStr HKCR ".clo" "" "WinEdt.clo"
  WriteRegStr HKCR "WinEdt.clo" "" "LaTeX Class Option"
  WriteRegStr HKCR "WinEdt.clo\DefaultIcon" "" "$INSTDIR\WinShell\Icons\clo.ico,0"
  WriteRegStr HKCR "WinEdt.clo\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .cls
  WriteRegStr HKCR ".cls" "" "WinEdt.cls"
  WriteRegStr HKCR "WinEdt.cls" "" "LaTeX Class"
  WriteRegStr HKCR "WinEdt.cls\DefaultIcon" "" "$INSTDIR\WinShell\Icons\cls.ico,0"
  WriteRegStr HKCR "WinEdt.cls\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .def
  WriteRegStr HKCR ".def" "" "WinEdt.def"
  WriteRegStr HKCR "WinEdt.def" "" "LaTeX Encoding Definitions"
  WriteRegStr HKCR "WinEdt.def\DefaultIcon" "" "$INSTDIR\WinShell\Icons\def.ico,0"
  WriteRegStr HKCR "WinEdt.def\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .drv
  WriteRegStr HKCR ".drv" "" "WinEdt.drv"
  WriteRegStr HKCR "WinEdt.drv" "" "LaTeX Source Driver"
  WriteRegStr HKCR "WinEdt.drv\DefaultIcon" "" "$INSTDIR\WinShell\Icons\drv.ico,0"
  WriteRegStr HKCR "WinEdt.drv\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .dtx
  WriteRegStr HKCR ".dtx" "" "WinEdt.dtx"
  WriteRegStr HKCR "WinEdt.dtx" "" "LaTeX Package Source"
  WriteRegStr HKCR "WinEdt.dtx\DefaultIcon" "" "$INSTDIR\WinShell\Icons\dtx.ico,0"
  WriteRegStr HKCR "WinEdt.dtx\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .fd
  WriteRegStr HKCR ".fd" "" "WinEdt.fd"
  WriteRegStr HKCR "WinEdt.fd" "" "LaTeX Font Definitions"
  WriteRegStr HKCR "WinEdt.fd\DefaultIcon" "" "$INSTDIR\WinShell\Icons\fd.ico,0"
  WriteRegStr HKCR "WinEdt.fd\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .fdd
  WriteRegStr HKCR ".fdd" "" "WinEdt.fdd"
  WriteRegStr HKCR "WinEdt.fdd" "" "LaTeX Font Source"
  WriteRegStr HKCR "WinEdt.fdd\DefaultIcon" "" "$INSTDIR\WinShell\Icons\dtx.ico,0"
  WriteRegStr HKCR "WinEdt.fdd\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .glg
  WriteRegStr HKCR ".glg" "" "WinEdt.glg"
  WriteRegStr HKCR "WinEdt.glg" "" "MakeIndex Glossary Log"
  WriteRegStr HKCR "WinEdt.glg\DefaultIcon" "" "$INSTDIR\WinShell\Icons\glg.ico,0"
  WriteRegStr HKCR "WinEdt.glg\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .glo
  WriteRegStr HKCR ".glo" "" "WinEdt.glo"
  WriteRegStr HKCR "WinEdt.glo" "" "MakeIndex Glossary Entries"
  WriteRegStr HKCR "WinEdt.glo\DefaultIcon" "" "$INSTDIR\WinShell\Icons\glo.ico,0"
  WriteRegStr HKCR "WinEdt.glo\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .gls
  WriteRegStr HKCR ".gls" "" "WinEdt.gls"
  WriteRegStr HKCR "WinEdt.gls" "" "MakeIndex Glossary"
  WriteRegStr HKCR "WinEdt.gls\DefaultIcon" "" "$INSTDIR\WinShell\Icons\gls.ico,0"
  WriteRegStr HKCR "WinEdt.gls\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .idx
  WriteRegStr HKCR ".idx" "" "WinEdt.idx"
  WriteRegStr HKCR "WinEdt.idx" "" "MakeIndex Index Entries"
  WriteRegStr HKCR "WinEdt.idx\DefaultIcon" "" "$INSTDIR\WinShell\Icons\idx.ico,0"
  WriteRegStr HKCR "WinEdt.idx\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ilg
  WriteRegStr HKCR ".ilg" "" "WinEdt.ilg"
  WriteRegStr HKCR "WinEdt.ilg" "" "MakeIndex Log"
  WriteRegStr HKCR "WinEdt.ilg\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ilg.ico,0"
  WriteRegStr HKCR "WinEdt.ilg\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ind
  WriteRegStr HKCR ".ind" "" "WinEdt.ind"
  WriteRegStr HKCR "WinEdt.ind" "" "MakeIndex Index"
  WriteRegStr HKCR "WinEdt.ind\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ind.ico,0"
  WriteRegStr HKCR "WinEdt.ind\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ins
  WriteRegStr HKCR ".ins" "" "WinEdt.ins"
  WriteRegStr HKCR "WinEdt.ins" "" "LaTeX Source Installer"
  WriteRegStr HKCR "WinEdt.ins\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ins.ico,0"
  WriteRegStr HKCR "WinEdt.ins\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ist
  WriteRegStr HKCR ".ist" "" "WinEdt.ist"
  WriteRegStr HKCR "WinEdt.ist" "" "MakeIndex Index Style"
  WriteRegStr HKCR "WinEdt.ist\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ist.ico,0"
  WriteRegStr HKCR "WinEdt.ist\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .lof
  WriteRegStr HKCR ".lof" "" "WinEdt.lof"
  WriteRegStr HKCR "WinEdt.lof" "" "LaTeX List of Figures"
  WriteRegStr HKCR "WinEdt.lof\DefaultIcon" "" "$INSTDIR\WinShell\Icons\lof.ico,0"
  WriteRegStr HKCR "WinEdt.lof\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .log
  WriteRegStr HKCR ".log" "" "WinEdt.log"
  WriteRegStr HKCR "WinEdt.log" "" "Log File"
  WriteRegStr HKCR "WinEdt.log\DefaultIcon" "" "$INSTDIR\WinShell\Icons\log.ico,0"
  WriteRegStr HKCR "WinEdt.log\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .lot
  WriteRegStr HKCR ".lot" "" "WinEdt.lot"
  WriteRegStr HKCR "WinEdt.lot" "" "LaTeX List of Tables"
  WriteRegStr HKCR "WinEdt.lot\DefaultIcon" "" "$INSTDIR\WinShell\Icons\lot.ico,0"
  WriteRegStr HKCR "WinEdt.lot\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ltx
  WriteRegStr HKCR ".ltx" "" "WinEdt.ltx"
  WriteRegStr HKCR "WinEdt.ltx" "" "LaTeX Document"
  WriteRegStr HKCR "WinEdt.ltx\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ltx.ico,0"
  WriteRegStr HKCR "WinEdt.ltx\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .mf
  WriteRegStr HKCR ".mf" "" "WinEdt.mf"
  WriteRegStr HKCR "WinEdt.mf" "" "MetaFont File"
  WriteRegStr HKCR "WinEdt.mf\DefaultIcon" "" "$INSTDIR\WinShell\Icons\mf.ico,0"
  WriteRegStr HKCR "WinEdt.mf\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .mp
  WriteRegStr HKCR ".mp" "" "WinEdt.mp"
  WriteRegStr HKCR "WinEdt.mp" "" "MetaPost File"
  WriteRegStr HKCR "WinEdt.mp\DefaultIcon" "" "$INSTDIR\WinShell\Icons\mp.ico,0"
  WriteRegStr HKCR "WinEdt.mp\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .mpx
  WriteRegStr HKCR ".mpx" "" "WinEdt.mpx"
  WriteRegStr HKCR "WinEdt.mpx" "" "MetaPost Auxiliaries"
  WriteRegStr HKCR "WinEdt.mpx\DefaultIcon" "" "$INSTDIR\WinShell\Icons\mpx.ico,0"
  WriteRegStr HKCR "WinEdt.mpx\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .nlg
  WriteRegStr HKCR ".nlg" "" "WinEdt.nlg"
  WriteRegStr HKCR "WinEdt.nlg" "" "MakeIndex Nomenclature Log"
  WriteRegStr HKCR "WinEdt.nlg\DefaultIcon" "" "$INSTDIR\WinShell\Icons\nlg.ico,0"
  WriteRegStr HKCR "WinEdt.nlg\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .nlo
  WriteRegStr HKCR ".nlo" "" "WinEdt.nlo"
  WriteRegStr HKCR "WinEdt.nlo" "" "MakeIndex Nomenclature Entries"
  WriteRegStr HKCR "WinEdt.nlo\DefaultIcon" "" "$INSTDIR\WinShell\Icons\nlo.ico,0"
  WriteRegStr HKCR "WinEdt.nlo\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .nls
  WriteRegStr HKCR ".nls" "" "WinEdt.nls"
  WriteRegStr HKCR "WinEdt.nls" "" "MakeIndex Nomenclature"
  WriteRegStr HKCR "WinEdt.nls\DefaultIcon" "" "$INSTDIR\WinShell\Icons\nls.ico,0"
  WriteRegStr HKCR "WinEdt.nls\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .sty
  WriteRegStr HKCR ".sty" "" "WinEdt.sty"
  WriteRegStr HKCR "WinEdt.sty" "" "LaTeX Style/Package"
  WriteRegStr HKCR "WinEdt.sty\DefaultIcon" "" "$INSTDIR\WinShell\Icons\sty.ico,0"
  WriteRegStr HKCR "WinEdt.sty\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .tex
  WriteRegStr HKCR ".tex" "" "WinEdt.tex"
  WriteRegStr HKCR "WinEdt.tex" "" "TeX Document"
  WriteRegStr HKCR "WinEdt.tex\DefaultIcon" "" "$INSTDIR\WinShell\Icons\tex.ico,0"
  WriteRegStr HKCR "WinEdt.tex\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .toc
  WriteRegStr HKCR ".toc" "" "WinEdt.toc"
  WriteRegStr HKCR "WinEdt.toc" "" "LaTeX Table of Contents"
  WriteRegStr HKCR "WinEdt.toc\DefaultIcon" "" "$INSTDIR\WinShell\Icons\toc.ico,0"
  WriteRegStr HKCR "WinEdt.toc\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .pk
  WriteRegStr HKCR ".pk" "" "WinEdt.pk"
  WriteRegStr HKCR "WinEdt.pk" "" "TeX Packed Font"
  WriteRegStr HKCR "WinEdt.pk\DefaultIcon" "" "$INSTDIR\WinShell\Icons\pk.ico,0"
  ; .tfm
  WriteRegStr HKCR ".tfm" "" "WinEdt.tfm"
  WriteRegStr HKCR "WinEdt.tfm" "" "TeX Font Metric"
  WriteRegStr HKCR "WinEdt.tfm\DefaultIcon" "" "$INSTDIR\WinShell\Icons\tfm.ico,0"
  ; .vf
  WriteRegStr HKCR ".vf" "" "WinEdt.vf"
  WriteRegStr HKCR "WinEdt.vf" "" "TeX Virtual Font"
  WriteRegStr HKCR "WinEdt.vf\DefaultIcon" "" "$INSTDIR\WinShell\Icons\vf.ico,0"
  ; .synctex
  WriteRegStr HKCR ".synctex" "" "WinEdt.synctex"
  WriteRegStr HKCR "WinEdt.synctex" "" "TeX-PDF Synchronization File"
  WriteRegStr HKCR "WinEdt.synctex\DefaultIcon" "" "$INSTDIR\WinShell\Icons\synctex.ico,0"
  ; .edt
  WriteRegStr HKCR ".edt" "" "WinEdt.edt"
  WriteRegStr HKCR "WinEdt.edt" "" "WinEdt Macro File"
  WriteRegStr HKCR "WinEdt.edt\DefaultIcon" "" "$INSTDIR\WinShell\Icons\WinEdt-Edt.ico,0"
  WriteRegStr HKCR "WinEdt.edt\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  WriteRegStr HKCR "WinEdt.edt\shell\Run with WinEdt\command" "" '"$INSTDIR\WinEdt.exe" -V "[GetFilePath($\'%1$\', 0);Exe($\'%1$\',$\'%%!0$\');]"'
  ; .prj
  WriteRegStr HKCR ".prj" "" "WinEdt.prj"
  WriteRegStr HKCR "WinEdt.prj" "" "WinEdt Project File"
  WriteRegStr HKCR "WinEdt.prj\DefaultIcon" "" "$INSTDIR\WinShell\Icons\WinEdt-Prj.ico,0"
  WriteRegStr HKCR "WinEdt.prj\shell\open\command" "" '"$INSTDIR\WinEdt.exe" -V "[OpenPrj(|%1|);]"'

  ;Refresh Shell Icons
  ${RefreshShellIcons}

FunctionEnd

Function un.AssociateAdmin

  ; .aux
  WriteRegStr HKCR ".aux" "" ""
  DeleteRegKey HKCR "WinEdt.aux"
  ; .bbl
  WriteRegStr HKCR ".bbl" "" ""
  DeleteRegKey HKCR "WinEdt.bbl"
  ; .bib
  WriteRegStr HKCR ".bib" "" ""
  DeleteRegKey HKCR "WinEdt.bib"
  ; .blg
  WriteRegStr HKCR ".blg" "" ""
  DeleteRegKey HKCR "WinEdt.blg"
  ; .bst
  WriteRegStr HKCR ".bst" "" ""
  DeleteRegKey HKCR "WinEdt.bst"
  ; .clo
  WriteRegStr HKCR ".clo" "" ""
  DeleteRegKey HKCR "WinEdt.clo"
  ; .cls
  WriteRegStr HKCR ".cls" "" ""
  DeleteRegKey HKCR "WinEdt.cls"
  ; .def
  WriteRegStr HKCR ".def" "" ""
  DeleteRegKey HKCR "WinEdt.def"
  ; .drv
  WriteRegStr HKCR ".drv" "" ""
  DeleteRegKey HKCR "WinEdt.drv"
  ; .dtx
  WriteRegStr HKCR ".dtx" "" ""
  DeleteRegKey HKCR "WinEdt.dtx"
  ; .fd
  WriteRegStr HKCR ".fd" "" ""
  DeleteRegKey HKCR "WinEdt.fd"
  ; .fdd
  WriteRegStr HKCR ".fdd" "" ""
  DeleteRegKey HKCR "WinEdt.fdd"
  ; .glg
  WriteRegStr HKCR ".glg" "" ""
  DeleteRegKey HKCR "WinEdt.glg"
  ; .glo
  WriteRegStr HKCR ".glo" "" ""
  DeleteRegKey HKCR "WinEdt.glo"
  ; .gls
  WriteRegStr HKCR ".gls" "" ""
  DeleteRegKey HKCR "WinEdt.gls"
  ; .idx
  WriteRegStr HKCR ".idx" "" ""
  DeleteRegKey HKCR "WinEdt.idx"
  ; .ilg
  WriteRegStr HKCR ".ilg" "" ""
  DeleteRegKey HKCR "WinEdt.ilg"
  ; .ind
  WriteRegStr HKCR ".ind" "" ""
  DeleteRegKey HKCR "WinEdt.ind"
  ; .ins
  WriteRegStr HKCR ".ins" "" ""
  DeleteRegKey HKCR "WinEdt.ins"
  ; .ist
  WriteRegStr HKCR ".ist" "" ""
  DeleteRegKey HKCR "WinEdt.ist"
  ; .lof
  WriteRegStr HKCR ".lof" "" ""
  DeleteRegKey HKCR "WinEdt.lof"
  ; .log
  WriteRegStr HKCR ".log" "" ""
  DeleteRegKey HKCR "WinEdt.log"
  ; .lot
  WriteRegStr HKCR ".lot" "" ""
  DeleteRegKey HKCR "WinEdt.lot"
  ; .ltx
  WriteRegStr HKCR ".ltx" "" ""
  DeleteRegKey HKCR "WinEdt.ltx"
  ; .mf
  WriteRegStr HKCR ".mf" "" ""
  DeleteRegKey HKCR "WinEdt.mf"
  ; .mp
  WriteRegStr HKCR ".mp" "" ""
  DeleteRegKey HKCR "WinEdt.mp"
  ; .mpx
  WriteRegStr HKCR ".mpx" "" ""
  DeleteRegKey HKCR "WinEdt.mpx"
  ; .nlg
  WriteRegStr HKCR ".nlg" "" ""
  DeleteRegKey HKCR "WinEdt.nlg"
  ; .nlo
  WriteRegStr HKCR ".nlo" "" ""
  DeleteRegKey HKCR "WinEdt.nlo"
  ; .nls
  WriteRegStr HKCR ".nls" "" ""
  DeleteRegKey HKCR "WinEdt.nls"
  ; .sty
  WriteRegStr HKCR ".sty" "" ""
  DeleteRegKey HKCR "WinEdt.sty"
  ; .tex
  WriteRegStr HKCR ".tex" "" ""
  DeleteRegKey HKCR "WinEdt.tex"
  ; .toc
  WriteRegStr HKCR ".toc" "" ""
  DeleteRegKey HKCR "WinEdt.toc"
  ; .pk
  WriteRegStr HKCR ".pk" "" ""
  DeleteRegKey HKCR "WinEdt.pk"
  ; .tfm
  WriteRegStr HKCR ".tfm" "" ""
  DeleteRegKey HKCR "WinEdt.tfm"
  ; .vf
  WriteRegStr HKCR ".vf" "" ""
  DeleteRegKey HKCR "WinEdt.vf"
  ; .synctex
  WriteRegStr HKCR ".synctex" "" ""
  DeleteRegKey HKCR "WinEdt.synctex"
  ; .edt
  WriteRegStr HKCR ".edt" "" ""
  DeleteRegKey HKCR "WinEdt.edt"
  ; .prj
  WriteRegStr HKCR ".prj" "" ""
  DeleteRegKey HKCR "WinEdt.prj"

  ;Refresh Shell Icons
  ${RefreshShellIcons}

FunctionEnd

Function AssociateUser

  ; .aux
  WriteRegStr HKCU "Software\Classes\.aux" "" "WinEdt.aux"
  WriteRegStr HKCU "Software\Classes\WinEdt.aux" "" "LaTeX Auxiliaries"
  WriteRegStr HKCU "Software\Classes\WinEdt.aux\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ltxaux.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.aux\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .bbl
  WriteRegStr HKCU "Software\Classes\.bbl" "" "WinEdt.bbl"
  WriteRegStr HKCU "Software\Classes\WinEdt.bbl" "" "BibTeX Bibliography"
  WriteRegStr HKCU "Software\Classes\WinEdt.bbl\DefaultIcon" "" "$INSTDIR\WinShell\Icons\bbl.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.bbl\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .bib
  WriteRegStr HKCU "Software\Classes\.bib" "" "WinEdt.bib"
  WriteRegStr HKCU "Software\Classes\WinEdt.bib" "" "BibTeX Data Base"
  WriteRegStr HKCU "Software\Classes\WinEdt.bib\DefaultIcon" "" "$INSTDIR\WinShell\Icons\bib.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.bib\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .blg
  WriteRegStr HKCU "Software\Classes\.blg" "" "WinEdt.blg"
  WriteRegStr HKCU "Software\Classes\WinEdt.blg" "" "BibTeX Log"
  WriteRegStr HKCU "Software\Classes\WinEdt.blg\DefaultIcon" "" "$INSTDIR\WinShell\Icons\blg.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.blg\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .bst
  WriteRegStr HKCU "Software\Classes\.bst" "" "WinEdt.bst"
  WriteRegStr HKCU "Software\Classes\WinEdt.bst" "" "BibTeX Bibliography Style"
  WriteRegStr HKCU "Software\Classes\WinEdt.bst\DefaultIcon" "" "$INSTDIR\WinShell\Icons\bst.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.bst\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .clo
  WriteRegStr HKCU "Software\Classes\.clo" "" "WinEdt.clo"
  WriteRegStr HKCU "Software\Classes\WinEdt.clo" "" "LaTeX Class Option"
  WriteRegStr HKCU "Software\Classes\WinEdt.clo\DefaultIcon" "" "$INSTDIR\WinShell\Icons\clo.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.clo\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .cls
  WriteRegStr HKCU "Software\Classes\.cls" "" "WinEdt.cls"
  WriteRegStr HKCU "Software\Classes\WinEdt.cls" "" "LaTeX Class"
  WriteRegStr HKCU "Software\Classes\WinEdt.cls\DefaultIcon" "" "$INSTDIR\WinShell\Icons\cls.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.cls\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .def
  WriteRegStr HKCU "Software\Classes\.def" "" "WinEdt.def"
  WriteRegStr HKCU "Software\Classes\WinEdt.def" "" "LaTeX Encoding Definitions"
  WriteRegStr HKCU "Software\Classes\WinEdt.def\DefaultIcon" "" "$INSTDIR\WinShell\Icons\def.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.def\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .drv
  WriteRegStr HKCU "Software\Classes\.drv" "" "WinEdt.drv"
  WriteRegStr HKCU "Software\Classes\WinEdt.drv" "" "LaTeX Source Driver"
  WriteRegStr HKCU "Software\Classes\WinEdt.drv\DefaultIcon" "" "$INSTDIR\WinShell\Icons\drv.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.drv\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .dtx
  WriteRegStr HKCU "Software\Classes\.dtx" "" "WinEdt.dtx"
  WriteRegStr HKCU "Software\Classes\WinEdt.dtx" "" "LaTeX Package Source"
  WriteRegStr HKCU "Software\Classes\WinEdt.dtx\DefaultIcon" "" "$INSTDIR\WinShell\Icons\dtx.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.dtx\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .fd
  WriteRegStr HKCU "Software\Classes\.fd" "" "WinEdt.fd"
  WriteRegStr HKCU "Software\Classes\WinEdt.fd" "" "LaTeX Font Definitions"
  WriteRegStr HKCU "Software\Classes\WinEdt.fd\DefaultIcon" "" "$INSTDIR\WinShell\Icons\fd.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.fd\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .fdd
  WriteRegStr HKCU "Software\Classes\.fdd" "" "WinEdt.fdd"
  WriteRegStr HKCU "Software\Classes\WinEdt.fdd" "" "LaTeX Font Source"
  WriteRegStr HKCU "Software\Classes\WinEdt.fdd\DefaultIcon" "" "$INSTDIR\WinShell\Icons\dtx.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.fdd\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .glg
  WriteRegStr HKCU "Software\Classes\.glg" "" "WinEdt.glg"
  WriteRegStr HKCU "Software\Classes\WinEdt.glg" "" "MakeIndex Glossary Log"
  WriteRegStr HKCU "Software\Classes\WinEdt.glg\DefaultIcon" "" "$INSTDIR\WinShell\Icons\glg.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.glg\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .glo
  WriteRegStr HKCU "Software\Classes\.glo" "" "WinEdt.glo"
  WriteRegStr HKCU "Software\Classes\WinEdt.glo" "" "MakeIndex Glossary Entries"
  WriteRegStr HKCU "Software\Classes\WinEdt.glo\DefaultIcon" "" "$INSTDIR\WinShell\Icons\glo.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.glo\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .gls
  WriteRegStr HKCU "Software\Classes\.gls" "" "WinEdt.gls"
  WriteRegStr HKCU "Software\Classes\WinEdt.gls" "" "MakeIndex Glossary"
  WriteRegStr HKCU "Software\Classes\WinEdt.gls\DefaultIcon" "" "$INSTDIR\WinShell\Icons\gls.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.gls\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .idx
  WriteRegStr HKCU "Software\Classes\.idx" "" "WinEdt.idx"
  WriteRegStr HKCU "Software\Classes\WinEdt.idx" "" "MakeIndex Index Entries"
  WriteRegStr HKCU "Software\Classes\WinEdt.idx\DefaultIcon" "" "$INSTDIR\WinShell\Icons\idx.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.idx\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ilg
  WriteRegStr HKCU "Software\Classes\.ilg" "" "WinEdt.ilg"
  WriteRegStr HKCU "Software\Classes\WinEdt.ilg" "" "MakeIndex Log"
  WriteRegStr HKCU "Software\Classes\WinEdt.ilg\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ilg.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.ilg\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ind
  WriteRegStr HKCU "Software\Classes\.ind" "" "WinEdt.ind"
  WriteRegStr HKCU "Software\Classes\WinEdt.ind" "" "MakeIndex Index"
  WriteRegStr HKCU "Software\Classes\WinEdt.ind\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ind.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.ind\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ins
  WriteRegStr HKCU "Software\Classes\.ins" "" "WinEdt.ins"
  WriteRegStr HKCU "Software\Classes\WinEdt.ins" "" "LaTeX Source Installer"
  WriteRegStr HKCU "Software\Classes\WinEdt.ins\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ins.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.ins\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ist
  WriteRegStr HKCU "Software\Classes\.ist" "" "WinEdt.ist"
  WriteRegStr HKCU "Software\Classes\WinEdt.ist" "" "MakeIndex Index Style"
  WriteRegStr HKCU "Software\Classes\WinEdt.ist\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ist.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.ist\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .lof
  WriteRegStr HKCU "Software\Classes\.lof" "" "WinEdt.lof"
  WriteRegStr HKCU "Software\Classes\WinEdt.lof" "" "LaTeX List of Figures"
  WriteRegStr HKCU "Software\Classes\WinEdt.lof\DefaultIcon" "" "$INSTDIR\WinShell\Icons\lof.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.lof\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .log
  WriteRegStr HKCU "Software\Classes\.log" "" "WinEdt.log"
  WriteRegStr HKCU "Software\Classes\WinEdt.log" "" "Log File"
  WriteRegStr HKCU "Software\Classes\WinEdt.log\DefaultIcon" "" "$INSTDIR\WinShell\Icons\log.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.log\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .lot
  WriteRegStr HKCU "Software\Classes\.lot" "" "WinEdt.lot"
  WriteRegStr HKCU "Software\Classes\WinEdt.lot" "" "LaTeX List of Tables"
  WriteRegStr HKCU "Software\Classes\WinEdt.lot\DefaultIcon" "" "$INSTDIR\WinShell\Icons\lot.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.lot\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .ltx
  WriteRegStr HKCU "Software\Classes\.ltx" "" "WinEdt.ltx"
  WriteRegStr HKCU "Software\Classes\WinEdt.ltx" "" "LaTeX Document"
  WriteRegStr HKCU "Software\Classes\WinEdt.ltx\DefaultIcon" "" "$INSTDIR\WinShell\Icons\ltx.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.ltx\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .mf
  WriteRegStr HKCU "Software\Classes\.mf" "" "WinEdt.mf"
  WriteRegStr HKCU "Software\Classes\WinEdt.mf" "" "MetaFont File"
  WriteRegStr HKCU "Software\Classes\WinEdt.mf\DefaultIcon" "" "$INSTDIR\WinShell\Icons\mf.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.mf\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .mp
  WriteRegStr HKCU "Software\Classes\.mp" "" "WinEdt.mp"
  WriteRegStr HKCU "Software\Classes\WinEdt.mp" "" "MetaPost File"
  WriteRegStr HKCU "Software\Classes\WinEdt.mp\DefaultIcon" "" "$INSTDIR\WinShell\Icons\mp.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.mp\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .mpx
  WriteRegStr HKCU "Software\Classes\.mpx" "" "WinEdt.mpx"
  WriteRegStr HKCU "Software\Classes\WinEdt.mpx" "" "MetaPost Auxiliaries"
  WriteRegStr HKCU "Software\Classes\WinEdt.mpx\DefaultIcon" "" "$INSTDIR\WinShell\Icons\mpx.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.mpx\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .nlg
  WriteRegStr HKCU "Software\Classes\.nlg" "" "WinEdt.nlg"
  WriteRegStr HKCU "Software\Classes\WinEdt.nlg" "" "MakeIndex Nomenclature Log"
  WriteRegStr HKCU "Software\Classes\WinEdt.nlg\DefaultIcon" "" "$INSTDIR\WinShell\Icons\nlg.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.nlg\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .nlo
  WriteRegStr HKCU "Software\Classes\.nlo" "" "WinEdt.nlo"
  WriteRegStr HKCU "Software\Classes\WinEdt.nlo" "" "MakeIndex Nomenclature Entries"
  WriteRegStr HKCU "Software\Classes\WinEdt.nlo\DefaultIcon" "" "$INSTDIR\WinShell\Icons\nlo.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.nlo\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .nls
  WriteRegStr HKCU "Software\Classes\.nls" "" "WinEdt.nls"
  WriteRegStr HKCU "Software\Classes\WinEdt.nls" "" "MakeIndex Nomenclature"
  WriteRegStr HKCU "Software\Classes\WinEdt.nls\DefaultIcon" "" "$INSTDIR\WinShell\Icons\nls.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.nls\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .sty
  WriteRegStr HKCU "Software\Classes\.sty" "" "WinEdt.sty"
  WriteRegStr HKCU "Software\Classes\WinEdt.sty" "" "LaTeX Style/Package"
  WriteRegStr HKCU "Software\Classes\WinEdt.sty\DefaultIcon" "" "$INSTDIR\WinShell\Icons\sty.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.sty\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .tex
  WriteRegStr HKCU "Software\Classes\.tex" "" "WinEdt.tex"
  WriteRegStr HKCU "Software\Classes\WinEdt.tex" "" "TeX Document"
  WriteRegStr HKCU "Software\Classes\WinEdt.tex\DefaultIcon" "" "$INSTDIR\WinShell\Icons\tex.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.tex\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .toc
  WriteRegStr HKCU "Software\Classes\.toc" "" "WinEdt.toc"
  WriteRegStr HKCU "Software\Classes\WinEdt.toc" "" "LaTeX Table of Contents"
  WriteRegStr HKCU "Software\Classes\WinEdt.toc\DefaultIcon" "" "$INSTDIR\WinShell\Icons\toc.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.toc\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  ; .pk
  WriteRegStr HKCU "Software\Classes\.pk" "" "WinEdt.pk"
  WriteRegStr HKCU "Software\Classes\WinEdt.pk" "" "TeX Packed Font"
  WriteRegStr HKCU "Software\Classes\WinEdt.pk\DefaultIcon" "" "$INSTDIR\WinShell\Icons\pk.ico,0"
  ; .tfm
  WriteRegStr HKCU "Software\Classes\.tfm" "" "WinEdt.tfm"
  WriteRegStr HKCU "Software\Classes\WinEdt.tfm" "" "TeX Font Metric"
  WriteRegStr HKCU "Software\Classes\WinEdt.tfm\DefaultIcon" "" "$INSTDIR\WinShell\Icons\tfm.ico,0"
  ; .vf
  WriteRegStr HKCU "Software\Classes\.vf" "" "WinEdt.vf"
  WriteRegStr HKCU "Software\Classes\WinEdt.vf" "" "TeX Virtual Font"
  WriteRegStr HKCU "Software\Classes\WinEdt.vf\DefaultIcon" "" "$INSTDIR\WinShell\Icons\vf.ico,0"
  ; .synctex
  WriteRegStr HKCU "Software\Classes\.synctex" "" "WinEdt.synctex"
  WriteRegStr HKCU "Software\Classes\WinEdt.synctex" "" "TeX-PDF Synchronization File"
  WriteRegStr HKCU "Software\Classes\WinEdt.synctex\DefaultIcon" "" "$INSTDIR\WinShell\Icons\synctex.ico,0"
  ; .edt
  WriteRegStr HKCU "Software\Classes\.edt" "" "WinEdt.edt"
  WriteRegStr HKCU "Software\Classes\WinEdt.edt" "" "WinEdt Macro File"
  WriteRegStr HKCU "Software\Classes\WinEdt.edt\DefaultIcon" "" "$INSTDIR\WinShell\Icons\WinEdt-Edt.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.edt\shell\open\command" "" '"$INSTDIR\WinEdt.exe" "%1"'
  WriteRegStr HKCU "Software\Classes\WinEdt.edt\shell\Run with WinEdt\command" "" '"$INSTDIR\WinEdt.exe" -V "[GetFilePath($\'%1$\', 0);Exe($\'%1$\',$\'%%!0$\');]"'
  ; .prj
  WriteRegStr HKCU "Software\Classes\.prj" "" "WinEdt.prj"
  WriteRegStr HKCU "Software\Classes\WinEdt.prj" "" "WinEdt Project File"
  WriteRegStr HKCU "Software\Classes\WinEdt.prj\DefaultIcon" "" "$INSTDIR\WinShell\Icons\WinEdt-Prj.ico,0"
  WriteRegStr HKCU "Software\Classes\WinEdt.prj\shell\open\command" "" '"$INSTDIR\WinEdt.exe" -V "[OpenPrj(|%1|);]"'

  ;Refresh Shell Icons
  ${RefreshShellIcons}

FunctionEnd

Function un.AssociateUser

  ; .aux
  WriteRegStr HKCU "Software\Classes\.aux" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.aux"
  ; .bbl
  WriteRegStr HKCU "Software\Classes\.bbl" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.bbl"
  ; .bib
  WriteRegStr HKCU "Software\Classes\.bib" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.bib"
  ; .blg
  WriteRegStr HKCU "Software\Classes\.blg" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.blg"
  ; .bst
  WriteRegStr HKCU "Software\Classes\.bst" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.bst"
  ; .clo
  WriteRegStr HKCU "Software\Classes\.clo" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.clo"
  ; .cls
  WriteRegStr HKCU "Software\Classes\.cls" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.cls"
  ; .def
  WriteRegStr HKCU "Software\Classes\.def" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.def"
  ; .drv
  WriteRegStr HKCU "Software\Classes\.drv" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.drv"
  ; .dtx
  WriteRegStr HKCU "Software\Classes\.dtx" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.dtx"
  ; .fd
  WriteRegStr HKCU "Software\Classes\.fd" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.fd"
  ; .fdd
  WriteRegStr HKCU "Software\Classes\.fdd" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.fdd"
  ; .glg
  WriteRegStr HKCU "Software\Classes\.glg" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.glg"
  ; .glo
  WriteRegStr HKCU "Software\Classes\.glo" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.glo"
  ; .gls
  WriteRegStr HKCU "Software\Classes\.gls" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.gls"
  ; .idx
  WriteRegStr HKCU "Software\Classes\.idx" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.idx"
  ; .ilg
  WriteRegStr HKCU "Software\Classes\.ilg" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.ilg"
  ; .ind
  WriteRegStr HKCU "Software\Classes\.ind" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.ind"
  ; .ins
  WriteRegStr HKCU "Software\Classes\.ins" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.ins"
  ; .ist
  WriteRegStr HKCU "Software\Classes\.ist" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.ist"
  ; .lof
  WriteRegStr HKCU "Software\Classes\.lof" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.lof"
  ; .log
  WriteRegStr HKCU "Software\Classes\.log" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.log"
  ; .lot
  WriteRegStr HKCU "Software\Classes\.lot" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.lot"
  ; .ltx
  WriteRegStr HKCU "Software\Classes\.ltx" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.ltx"
  ; .mf
  WriteRegStr HKCU "Software\Classes\.mf" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.mf"
  ; .mp
  WriteRegStr HKCU "Software\Classes\.mp" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.mp"
  ; .mpx
  WriteRegStr HKCU "Software\Classes\.mpx" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.mpx"
  ; .nlg
  WriteRegStr HKCU "Software\Classes\.nlg" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.nlg"
  ; .nlo
  WriteRegStr HKCU "Software\Classes\.nlo" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.nlo"
  ; .nls
  WriteRegStr HKCU "Software\Classes\.nls" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.nls"
  ; .sty
  WriteRegStr HKCU "Software\Classes\.sty" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.sty"
  ; .tex
  WriteRegStr HKCU "Software\Classes\.tex" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.tex"
  ; .toc
  WriteRegStr HKCU "Software\Classes\.toc" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.toc"
  ; .pk
  WriteRegStr HKCU "Software\Classes\.pk" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.pk"
  ; .tfm
  WriteRegStr HKCU "Software\Classes\.tfm" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.tfm"
  ; .vf
  WriteRegStr HKCU "Software\Classes\.vf" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.vf"
  ; .synctex
  WriteRegStr HKCU "Software\Classes\.synctex" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.synctex"
  ; .edt
  WriteRegStr HKCU "Software\Classes\.edt" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.edt"
  ; .prj
  WriteRegStr HKCU "Software\Classes\.prj" "" ""
  DeleteRegKey HKCU "Software\Classes\WinEdt.prj"

  ;Refresh Shell Icons
  ${RefreshShellIcons}

FunctionEnd
