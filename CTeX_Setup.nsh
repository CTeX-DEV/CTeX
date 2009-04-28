!include "EnvVarUpdate.nsh"
!include "FileAssoc.nsh"

!macro _CreateURLShortCut URLFile URLSite
	WriteINIStr "${URLFile}.URL" "InternetShortcut" "URL" "${URLSite}"
!macroend
!define CreateURLShortCut "!insertmacro _CreateURLShortCut"

Function _AddPath
	ClearErrors
	${EnvVarUpdate} $R1 "PATH" "P" "HKLM" "$R0"
	IfErrors 0 done
		${EnvVarUpdate} $R1 "PATH" "P" "HKCU" "$R0"
done:
FunctionEnd

!macro _AddPath DIR
	StrCpy $R0 "${DIR}"
	Call _AddPath
!macroend
!define AddPath "!insertmacro _AddPath"

!macro _unRemovePath DIR
	${un.EnvVarUpdate} $R1 "PATH" "R" "HKLM" "${DIR}"
	${un.EnvVarUpdate} $R1 "PATH" "R" "HKCU" "${DIR}"
!macroend
!define un.RemovePath "!insertmacro _unRemovePath"



!macro Install_Reg_MiKTeX DIR VERSION
	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Install" "${DIR}"
	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "SharedSetup" "1"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "AutoInstall" "2"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RemoteRepository" "ftp://ftp.ctex.org/CTAN/systems/win32/miktex/tm/packages/"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RepositoryType" "remote"

	${AddPath} "${DIR}\miktex\bin"
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
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Known Issues.lnk" "http://miktex.org/2.7/issues"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\MiKTeX Project Page.lnk" "http://miktex.org/"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Support.lnk" "http://miktex.org/support"
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
