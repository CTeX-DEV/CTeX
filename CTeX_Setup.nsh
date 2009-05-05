!include "WordFunc.nsh"
!include "EnvVarUpdate.nsh"
!include "FileAssoc.nsh"

!macro _CreateURLShortCut URLFile URLSite
	WriteINIStr "${URLFile}.URL" "InternetShortcut" "URL" "${URLSite}"
!macroend
!define CreateURLShortCut "!insertmacro _CreateURLShortCut"

!macro _AddPath DIR
	StrCpy $R0 0
	ClearErrors
	${EnvVarUpdate} $R1 "PATH" "P" "HKLM" "${DIR}"
	IfErrors 0 +2
		StrCpy $R0 1
	${If} $R0 == 1
		${EnvVarUpdate} $R1 "PATH" "P" "HKCU" "${DIR}"
	${EndIf}
!macroend
!define AddPath "!insertmacro _AddPath"

!macro _AddEnvVar NAME VALUE
	StrCpy $R0 0
	ClearErrors
	WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "${NAME}" "${VALUE}"
	IfErrors 0 +2
		StrCpy $R0 1
	${If} $R0 == 1
		WriteRegExpandStr HKCU "Environment" "${NAME}" "${VALUE}"
	${EndIf}
!macroend
!define AddEnvVar "!insertmacro _AddEnvVar"

!macro _RemovePath DIR
	${EnvVarUpdate} $R1 "PATH" "R" "HKLM" "${DIR}"
	${EnvVarUpdate} $R1 "PATH" "R" "HKCU" "${DIR}"
!macroend
!define RemovePath "!insertmacro _RemovePath"

!macro _unRemovePath DIR
	${un.EnvVarUpdate} $R1 "PATH" "R" "HKLM" "${DIR}"
	${un.EnvVarUpdate} $R1 "PATH" "R" "HKCU" "${DIR}"
!macroend
!define un.RemovePath "!insertmacro _unRemovePath"

!macro _RemoveEnvVar NAME
	DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "${NAME}"
	DeleteRegValue HKCU "Environment" "${NAME}"
!macroend
!define RemoveEnvVar "!insertmacro _RemoveEnvVar"

!macro _unRemoveEnvVar NAME
	DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "${NAME}"
	DeleteRegValue HKCU "Environment" "${NAME}"
!macroend
!define un.RemoveEnvVar "!insertmacro _unRemoveEnvVar"

Function RemoveToken
	StrCpy $R9 ""
	StrCpy $R8 0
	${Do}
		${StrTok} $R7 $R0 $R2 $R8 "1"
		${If} $R7 == ""
			${ExitDo}
		${EndIf}
		${Do}
			StrCpy $R6 $R7 1
			${If} $R6 != " "
				${ExitDo}
			${EndIf}
			StrCpy $R7 $R7 "" 1                ;  Remove leading space
		${Loop}
		${Do}
			StrCpy $R6 $R7 1 -1
			${If} $R6 != " "
				${ExitDo}
			${EndIf}
			StrCpy $R7 $R7 -1                  ;  Remove trailing space
     ${Loop}
		${If} $R7 != $R1                     ;  Remove existing target
		${AndIf} $R7 != ""
			${If} $R9 != ""
				StrCpy $R9 "$R9;$R7"
			${Else}
				StrCpy $R9 "$R7"
			${EndIf}
		${EndIf}
		IntOp $R8 $R8 + 1
	${Loop}
FunctionEnd

!macro Install_Reg_MiKTeX
	StrCpy $0 "$INSTDIR\${MiKTeX_Dir}"

	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\Core" "Install" "$0"
	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\Core" "SharedSetup" "1"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\MPM" "AutoInstall" "2"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\MPM" "RemoteRepository" "ftp://ftp.ctex.org/CTAN/systems/win32/miktex/tm/packages/"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\MPM" "RepositoryType" "remote"

	${AddPath} "$0\miktex\bin"

	StrCpy $1 "$0\miktex\bin\yap.exe"
	!insertmacro APP_ASSOCIATE "dvi" "MiKTeX.Yap.dvi.${MiKTeX_Version}" "DVI $(Desc_File)" "$1,1" "Open with Yap" '$1 "%1"'
!macroend

!macro Repair_Reg_MiKTeX
	${RemovePath} "$OLD_INSTDIR\${MiKTeX_Dir}\miktex\bin"
!macroend

!macro Uninstall_Reg_MiKTeX
	DeleteRegKey HKLM "Software\MiKTeX.org"
	DeleteRegKey HKCU "Software\MiKTeX.org"

	${un.RemovePath} "$INSTDIR\${MiKTeX_Dir}\miktex\bin"

	!insertmacro APP_UNASSOCIATE "dvi" "MiKTeX.Yap.dvi.${MiKTeX_Version}"
!macroend

!macro Install_Link_MiKTeX
	StrCpy $0 "$INSTDIR\${MiKTeX_Dir}"

	CreateDirectory "$SMPROGRAMS\CTeX\MiKTeX"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Browse Packages.lnk" "$0\miktex\bin\mpm_mfc.exe"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Previewer.lnk" "$0\miktex\bin\yap.exe"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Settings.lnk" "$0\miktex\bin\mo.exe"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Update.lnk" "$0\miktex\bin\copystart_admin.exe" '"$0\miktex\config\update.dat"'
	CreateDirectory "$SMPROGRAMS\CTeX\MiKTeX\Help"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Help\FAQ.lnk" "$0\doc\miktex\faq.chm"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Help\Manual.lnk" "$0\doc\miktex\miktex.chm"
	CreateDirectory "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web"

	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Give back" "http://miktex.org/giveback"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Known Issues" "http://miktex.org/2.7/issues"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\MiKTeX Project Page" "http://miktex.org/"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Support" "http://miktex.org/support"
!macroend

!macro Install_Reg_Addons
	StrCpy $0 "$INSTDIR\${Addons_Dir}"

	ReadRegStr $R0 HKLM "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\Core" "Roots"
	${If} $R0 == ""
		ReadRegStr $R1 HKLM "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\Core" "Install"
		WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\Core" "Roots" "$0;$R1"
	${Else}
		StrCpy $R1 "$0"
		StrCpy $R2 ";"
		Call RemoveToken
		WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\Core" "Roots" "$0;$R9"
	${EndIf}

; Install CCT
	${AddPath} "$0\cct\bin"
	${AddEnvVar} "CCHZPATH" "$0\cct\fonts"
	${AddEnvVar} "CCPKPATH" "$0\fonts\pk\modeless\cct\dpi$$d"
	
	FileOpen $R0 "$0\cct\bin\cctinit.ini" "w"
	FileWrite $R0 "-T$0\fonts\tfm\cct$\n"
	FileWrite $R0 "-H$0\tex\latex\cct$\n"
	FileClose $R0
	
	ExecWait "$0\cct\bin\cctinit.exe"

; Install TY
	${AddPath} "$0\ty\bin"

	FileOpen $R0 "$0\ty\bin\ty.cfg" "w"
	FileWrite $R0 "$0\fonts\tfm\ty\$\r$\n"
	FileWrite $R0 "$0\fonts\pk\modeless\ty\DPI@Rr\$\r$\n"
	FileWrite $R0 ".\$\r$\n"
	FileWrite $R0 "$0\ty\bin\$\r$\n"
	FileWrite $R0 "$FONTS\$\r$\n"
	FileWrite $R0 "600$\r$\n1095$\r$\n"
	FileWrite $R0 "simsun.ttc$\r$\nsimkai.ttf$\r$\nsimfang.ttf$\r$\nsimhei.ttf$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\n"
	FileWrite $R0 "simsun.ttc$\r$\nsimyou.ttf$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\nsimli.ttf$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\n"
	FileWrite $R0 "0$\r$\n0$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n0$\r$\n0$\r$\n0$\r$\n0$\r$\n0$\r$\n"
	FileClose $R0

; Install Fonts
!ifndef BUILD_REPAIR
	ExecWait '$0\ctex\bin\BREAKTTC.exe "$FONTS\simsun.ttc"'
	CreateDirectory "$0\fonts\truetype\chinese"
	Rename "FONT00.TTF" "$0\fonts\truetype\chinese\simsun.ttf"
	Delete "*.TTF"
!endif
!macroend

!macro Repair_Reg_Addons
	StrCpy $0 "$OLD_INSTDIR\${Addons_Dir}"
	
	ReadRegStr $R0 HKLM "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\Core" "Roots"
	${If} $R0 != ""
		StrCpy $R1 "$0"
		StrCpy $R2 ";"
		Call RemoveToken
		WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\Core" "Roots" "$R9"
	${EndIf}

; Uninstall CCT
	${RemovePath} "$0\cct\bin"
	${RemoveEnvVar} "CCHZPATH"
	${RemoveEnvVar} "CCPKPATH"

; Uninstall TY
	${RemovePath} "$0\ty\bin"
!macroend

!macro Uninstall_Reg_Addons
	StrCpy $0 "$INSTDIR\${Addons_Dir}"

; Uninstall CCT
	${un.RemovePath} "$0\cct\bin"
	${un.RemoveEnvVar} "CCHZPATH"
	${un.RemoveEnvVar} "CCPKPATH"

; Uninstall TY
	${un.RemovePath} "$0\ty\bin"
!macroend

!macro Install_Reg_Ghostscript
	StrCpy $0 "$INSTDIR\${Ghostscript_Dir}"
	StrCpy $1 "$0\gs${Ghostscript_Version}"
	WriteRegStr HKLM "Software\GPL Ghostscript\${Ghostscript_Version}" "GS_DLL" "$1\bin\gsdll32.dll"
	WriteRegStr HKLM "Software\GPL Ghostscript\${Ghostscript_Version}" "GS_LIB" "$1\lib;$0\fonts;$FONTS"

	${AddPath} "$1\bin"
!macroend

!macro Repair_Reg_Ghostscript
	${RemovePath} "$OLD_INSTDIR\${Ghostscript_Dir}\gs${Ghostscript_Version}\bin"
!macroend

!macro Uninstall_Reg_Ghostscript
	DeleteRegKey HKLM "Software\GPL Ghostscript"

	${un.RemovePath} "$INSTDIR\${Ghostscript_Dir}\gs${Ghostscript_Version}\bin"
!macroend

!macro Install_Link_Ghostscript
	StrCpy $0 "$INSTDIR\${Ghostscript_Dir}"
	StrCpy $1 "$0\gs${Ghostscript_Version}"
	CreateDirectory "$SMPROGRAMS\CTeX\Ghostcript"
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostcript\Ghostscript.lnk" "$1\bin\gswin32.exe" '"-I$1\lib;$0\fonts;$FONTS"'
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostcript\Ghostscript Readme.lnk" "$1\doc\Readme.htm"
!macroend

!macro Install_Reg_GSview
	StrCpy $0 "$INSTDIR\${GSview_Dir}"
	WriteRegStr HKLM "Software\Ghostgum\GSview" "${GSview_Version}" "$0"

	StrCpy $R0 "$0\gsview\gsview32.ini"
	WriteINIStr $R0 "GSview-${GSview_Version}"	"Version" "${GSview_Version}"
	WriteINIStr $R0 "GSview-${GSview_Version}"	"GSversion" "864"
	ReadRegStr $R1 HKLM "Software\GPL Ghostscript\${Ghostscript_Version}" "GS_DLL"
	WriteINIStr $R0 "GSview-${GSview_Version}"	"GhostscriptDLL" "$R1"
	ReadRegStr $R1 HKLM "Software\GPL Ghostscript\${Ghostscript_Version}" "GS_LIB"
	WriteINIStr $R0 "GSview-${GSview_Version}"	"GhostscriptInclude" "$R1"
	WriteINIStr $R0 "GSview-${GSview_Version}"	"GhostscriptOther" '-dNOPLATFONTS -sFONTPATH="c:\psfonts"'
	WriteINIStr $R0 "GSview-${GSview_Version}"	"Configured" "1"
	Delete "$PROFILE\gsview32.ini"

	${AddPath} "$0\gsview"

	StrCpy $1 "$0\gsview\gsview32.exe"
	!insertmacro APP_ASSOCIATE "ps" "CTeX.PS" "PS $(Desc_File)" "$1,3" "Open with GSview" '$1 "%1"'
	!insertmacro APP_ASSOCIATE "eps" "CTeX.EPS" "EPS $(Desc_File)" "$1,3" "Open with GSview" '$1 "%1"'
!macroend

!macro Repair_Reg_GSview
	${RemovePath} "$OLD_INSTDIR\${GSview_Dir}\gsview"
!macroend

!macro Uninstall_Reg_GSview
	DeleteRegKey HKLM "Software\Ghostgum"

	${un.RemovePath} "$INSTDIR\${GSview_Dir}\gsview"

	!insertmacro APP_UNASSOCIATE "ps" "CTeX.PS"
	!insertmacro APP_UNASSOCIATE "eps" "CTeX.EPS"
!macroend

!macro Install_Link_GSview
	StrCpy $0 "$INSTDIR\${GSview_Dir}"
	CreateDirectory "$SMPROGRAMS\CTeX\Ghostgum"
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostgum\GSview.lnk" "$0\gsview\gsview32.exe"
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostgum\GSview Readme.lnk" "$0\gsview\Readme.htm"
!macroend

!macro Install_Reg_WinEdt
	StrCpy $0 "$INSTDIR\${WinEdt_Dir}"
	WriteRegStr HKLM "Software\WinEdt" "Install Root" "$0"

	${AddPath} "$0"

	StrCpy $1 "$0\WinEdt.exe"
	!insertmacro APP_ASSOCIATE "tex" "CTeX.TeX" "TeX $(Desc_File)" "$1,0" "Open with WinEdt" '$1 "%1"'
!macroend

!macro Repair_Reg_WinEdt
	${RemovePath} "$OLD_INSTDIR\${WinEdt_Dir}"
!macroend

!macro Uninstall_Reg_WinEdt
	DeleteRegKey HKLM "Software\WinEdt"

	${un.RemovePath} "$INSTDIR\${WinEdt_Dir}"

	!insertmacro APP_UNASSOCIATE "tex" "CTeX.TeX"
!macroend

!macro Install_Link_WinEdt
	CreateDirectory "$SMPROGRAMS\CTeX"
	CreateShortCut "$SMPROGRAMS\CTeX\WinEdt.lnk" "$INSTDIR\${WinEdt_Dir}\WinEdt.exe"
!macroend

!macro Associate_WinEdt_MiKTeX
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${MiKTeX_Version}\Yap\Settings" "Editor" '$INSTDIR\${WinEdt_Dir}\winedt.exe "[Open(|%f|);SelPar(%l,8)]"'
!macroend
