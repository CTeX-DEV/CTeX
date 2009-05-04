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

!macro _unRemovePath DIR
	${un.EnvVarUpdate} $R1 "PATH" "R" "HKLM" "${DIR}"
	${un.EnvVarUpdate} $R1 "PATH" "R" "HKCU" "${DIR}"
!macroend
!define un.RemovePath "!insertmacro _unRemovePath"

!macro _unRemoveEnvVar NAME
	DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "${NAME}"
	DeleteRegValue HKCU "Environment" "${NAME}"
!macroend
!define un.RemoveEnvVar "!insertmacro _unRemoveEnvVar"


!macro Install_Reg_MiKTeX DIR VERSION
	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Install" "${DIR}"
	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "SharedSetup" "1"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "AutoInstall" "2"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RemoteRepository" "ftp://ftp.ctex.org/CTAN/systems/win32/miktex/tm/packages/"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RepositoryType" "remote"

	${AddPath} "${DIR}\miktex\bin"

	!insertmacro APP_ASSOCIATE "dvi" "CTeX.DVI" "DVI $(Desc_File)" "${DIR}\miktex\bin\yap.exe,0" "Open with Yap" '${DIR}\miktex\bin\yap.exe "%1"'
!macroend

!macro Uninstall_Reg_MiKTeX DIR VERSION
	DeleteRegKey HKLM "Software\MiKTeX.org"
	DeleteRegKey HKCU "Software\MiKTeX.org"

	${un.RemovePath} "${DIR}\miktex\bin"
!macroend

!macro Install_Link_MiKTeX DIR VERSION
	CreateDirectory "$SMPROGRAMS\CTeX\MiKTeX"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Browse Packages.lnk" "${DIR}\miktex\bin\mpm_mfc.exe"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Previewer.lnk" "${DIR}\miktex\bin\yap.exe"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Settings.lnk" "${DIR}\miktex\bin\mo.exe"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Update.lnk" "${DIR}\miktex\bin\copystart_admin.exe" '"${DIR}\miktex\config\update.dat"'
	CreateDirectory "$SMPROGRAMS\CTeX\MiKTeX\Help"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Help\FAQ.lnk" "${DIR}\doc\miktex\faq.chm"
	CreateShortCut "$SMPROGRAMS\CTeX\MiKTeX\Help\Manual.lnk" "${DIR}\doc\miktex\miktex.chm"
	CreateDirectory "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Give back" "http://miktex.org/giveback"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Known Issues" "http://miktex.org/2.7/issues"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\MiKTeX Project Page" "http://miktex.org/"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Support" "http://miktex.org/support"
!macroend

!macro Install_Reg_Addons DIR VERSION
	ReadRegStr $R0 HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Roots"
	${If} $R0 == ""
		ReadRegStr $R1 HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Install"
		WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Roots" "${DIR};$R1"
	${Else}
		StrCpy $R1 0
		StrCpy $R9 ""
		${Do}
			${StrTok} $R2 $R0 ";" $R1 "1"
			${If} $R2 == ""
				${ExitDo}
			${EndIf}
			${Do}
				StrCpy $R3 $R2 1
				${If} $R3 != " "
					${ExitDo}
				${EndIf}
				StrCpy $R2 $R2 "" 1                ;  Remove leading space
      ${Loop}
      ${Do}
				StrCpy $R3 $R2 1 -1
				${If} $R3 != " "
					${ExitDo}
				${EndIf}
				StrCpy $R2 $R2 -1                  ;  Remove trailing space
      ${Loop}
			${If} $R2 != ${DIR}                  ;  Remove existing target
			${AndIf} $R2 != ""
				${If} $R9 != ""
					StrCpy $R9 "$R9;$R2"
				${Else}
					StrCpy $R9 "$R2"
				${EndIf}
			${EndIf}
			IntOp $R1 $R1 + 1
		${Loop}
		WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Roots" "${DIR};$R9"
	${EndIf}

	!insertmacro Install_CCT "${DIR}"
	!insertmacro Install_TY "${DIR}"
	!insertmacro Install_Fonts "${DIR}"
!macroend

!macro Uninstall_Reg_Addons DIR
	!insertmacro Uninstall_CCT "${DIR}"
	!insertmacro Uninstall_TY "${DIR}"
!macroend

!macro Uninstall_Addons DIR
	!insertmacro Uninstall_CCT "${DIR}"
	!insertmacro Uninstall_TY "${DIR}"
	!insertmacro Uninstall_Fonts "${DIR}"
!macroend

!macro Install_CCT DIR
	${AddPath} "${DIR}\cct\bin"
	${AddEnvVar} "CCHZPATH" "${DIR}\cct\fonts"
	${AddEnvVar} "CCPKPATH" "${DIR}\fonts\pk\modeless\cct\dpi$$d"
	
	FileOpen $R0 "${DIR}\cct\bin\cctinit.ini" "w"
	FileWrite $R0 "-T${DIR}\fonts\tfm\cct$\n"
	FileWrite $R0 "-H${DIR}\tex\latex\cct$\n"
	FileClose $R0
	
	ExecWait "${DIR}\cct\bin\cctinit.exe"
!macroend

!macro Uninstall_CCT DIR
	${un.RemovePath} "${DIR}\cct\bin"
	${un.RemoveEnvVar} "CCHZPATH"
	${un.RemoveEnvVar} "CCPKPATH"
!macroend

!macro Install_TY DIR
	${AddPath} "${DIR}\ty\bin"

	FileOpen $R0 "${DIR}\ty\bin\ty.cfg" "w"
	FileWrite $R0 "${DIR}\fonts\tfm\ty\$\r$\n"
	FileWrite $R0 "${DIR}\fonts\pk\modeless\ty\DPI@Rr\$\r$\n"
	FileWrite $R0 ".\$\r$\n"
	FileWrite $R0 "${DIR}\ty\bin\$\r$\n"
	FileWrite $R0 "$FONTS\$\r$\n"
	FileWrite $R0 "600$\r$\n1095$\r$\n"
	FileWrite $R0 "simsun.ttc$\r$\nsimkai.ttf$\r$\nsimfang.ttf$\r$\nsimhei.ttf$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\n"
	FileWrite $R0 "simsun.ttc$\r$\nsimyou.ttf$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\nsimli.ttf$\r$\nsimsun.ttc$\r$\nsimsun.ttc$\r$\n"
	FileWrite $R0 "0$\r$\n0$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n$\r$\n0$\r$\n0$\r$\n0$\r$\n0$\r$\n0$\r$\n"
	FileClose $R0
!macroend

!macro Uninstall_TY DIR
	${un.RemovePath} "${DIR}\ty\bin"
!macroend

!macro Install_Fonts DIR
!ifndef BUILD_REPAIR
	ExecWait '${DIR}\ctex\bin\BREAKTTC.exe "$FONTS\simsun.ttc"'
	CreateDirectory "${DIR}\fonts\truetype\chinese"
	Rename "FONT00.TTF" "${DIR}\fonts\truetype\chinese\simsun.ttf"
	Delete "*.TTF"
!endif
!macroend

!macro Install_Reg_Ghostscript DIR VERSION
	WriteRegStr HKLM "Software\GPL Ghostscript\${VERSION}" "GS_DLL" "${DIR}\gs${VERSION}\bin\gsdll32.dll"
	WriteRegStr HKLM "Software\GPL Ghostscript\${VERSION}" "GS_LIB" "${DIR}\gs${VERSION}\lib;${DIR}\fonts;$FONTS"

	${AddPath} "${DIR}\gs${VERSION}\bin"
!macroend

!macro Uninstall_Reg_Ghostscript DIR VERSION
	DeleteRegKey HKLM "Software\GPL Ghostscript"

	${un.RemovePath} "${DIR}\gs${VERSION}\bin"
!macroend

!macro Install_Link_Ghostscript DIR VERSION
	CreateDirectory "$SMPROGRAMS\CTeX\Ghostcript"
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostcript\Ghostscript.lnk" "${DIR}\gs${VERSION}\bin\gswin32.exe" '"-I${DIR}\gs${VERSION}\lib;${DIR}\fonts;$FONTS"'
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostcript\Ghostscript Readme.lnk" "${DIR}\gs${VERSION}\doc\Readme.htm"
!macroend

!macro Install_Reg_GSview DIR VERSION
	WriteRegStr HKLM "Software\Ghostgum\GSview" "${VERSION}" "${DIR}"

	StrCpy $R0 "${DIR}\gsview\gsview32.ini"
	WriteINIStr $R0 "GSview-${VERSION}"	"Version" "${VERSION}"
	WriteINIStr $R0 "GSview-${VERSION}"	"GSversion" "864"
	ReadRegStr $R1 HKLM "Software\GPL Ghostscript\${VERSION}" "GS_DLL"
	WriteINIStr $R0 "GSview-${VERSION}"	"GhostscriptDLL" "$R1"
	ReadRegStr $R1 HKLM "Software\GPL Ghostscript\${VERSION}" "GS_LIB"
	WriteINIStr $R0 "GSview-${VERSION}"	"GhostscriptInclude" "$R1"
	WriteINIStr $R0 "GSview-${VERSION}"	"GhostscriptOther" '-dNOPLATFONTS -sFONTPATH="c:\psfonts"'
	WriteINIStr $R0 "GSview-${VERSION}"	"Configured" "0"

	${AddPath} "${DIR}\gsview"

	!insertmacro APP_ASSOCIATE "ps" "CTeX.PS" "PS $(Desc_File)" "${DIR}\gsview\gsview32.exe,0" "Open with GSview" '${DIR}\gsview\gsview32.exe "%1"'
	!insertmacro APP_ASSOCIATE "eps" "CTeX.EPS" "EPS $(Desc_File)" "${DIR}\gsview\gsview32.exe,0" "Open with GSview" '${DIR}\gsview\gsview32.exe "%1"'
!macroend

!macro Uninstall_Reg_GSview DIR VERSION
	DeleteRegKey HKLM "Software\Ghostgum"

	${un.RemovePath} "${DIR}\gsview"

	!insertmacro APP_UNASSOCIATE "ps" "CTeX.PS"
	!insertmacro APP_UNASSOCIATE "eps" "CTeX.EPS"
!macroend

!macro Install_Link_GSview DIR VERSION
	CreateDirectory "$SMPROGRAMS\CTeX\Ghostgum"
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostgum\GSview.lnk" "${DIR}\gsview\gsview32.exe"
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostgum\GSview Readme.lnk" "${DIR}\gsview\Readme.htm"
!macroend

!macro Install_Reg_WinEdt DIR VERSION
	WriteRegStr HKLM "Software\WinEdt" "Install Root" "${DIR}"

	${AddPath} "${DIR}"

	!insertmacro APP_ASSOCIATE "tex" "CTeX.TeX" "TeX $(Desc_File)" "${DIR}\WinEdt.exe,0" "Open with WinEdt" '${DIR}\WinEdt.exe "%1"'
!macroend

!macro Uninstall_Reg_WinEdt DIR VERSION
	DeleteRegKey HKLM "Software\WinEdt"

	${un.RemovePath} "${DIR}"

	!insertmacro APP_UNASSOCIATE "tex" "CTeX.TeX"
!macroend

!macro Install_Link_WinEdt DIR VERSION
	CreateDirectory "$SMPROGRAMS\CTeX"
	CreateShortCut "$SMPROGRAMS\CTeX\WinEdt.lnk" "${DIR}\WinEdt.exe"
!macroend

!macro Associate_WinEdt_MiKTeX DIR_WinEdt VERSION_MiKTeX
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION_MiKTeX}\Yap\Settings" "Editor" '${DIR_WinEdt}\winedt.exe "[Open(|%f|);SelPar(%l,8)]"'
!macroend
