!include "WordFunc.nsh"
!include "Sections.nsh"
!include "TextReplace.nsh"
!include "EnvVarUpdate.nsh"
!include "FileAssoc.nsh"
!include "UninstByLog.nsh"


!macro _CreateURLShortCut URLFile URLSite
	WriteINIStr "${URLFile}.URL" "InternetShortcut" "URL" "${URLSite}"
!macroend
!define CreateURLShortCut "!insertmacro _CreateURLShortCut"

!macro _AddPath DIR
	SetDetailsPrint none
	ClearErrors
	${EnvVarUpdate} $R0 "PATH" "P" "HKLM" "${DIR}"
	${If} ${Errors}
		${EnvVarUpdate} $R0 "PATH" "P" "HKCU" "${DIR}"
	${EndIf}
	SetDetailsPrint lastused
!macroend
!define AddPath "!insertmacro _AddPath"

!macro _AddEnvVar NAME VALUE
	ClearErrors
	WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "${NAME}" "${VALUE}"
	${If} ${Errors}
		WriteRegExpandStr HKCU "Environment" "${NAME}" "${VALUE}"
	${EndIf}
!macroend
!define AddEnvVar "!insertmacro _AddEnvVar"

!macro _RemovePath UN DIR
	SetDetailsPrint none
	${${UN}EnvVarUpdate} $R1 "PATH" "R" "HKLM" "${DIR}"
	${${UN}EnvVarUpdate} $R1 "PATH" "R" "HKCU" "${DIR}"
	SetDetailsPrint lastused
!macroend
!define RemovePath '!insertmacro _RemovePath ""'
!define un.RemovePath '!insertmacro _RemovePath "un."'

!macro _RemoveEnvVar NAME
	DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "${NAME}"
	DeleteRegValue HKCU "Environment" "${NAME}"
!macroend
!define RemoveEnvVar "!insertmacro _RemoveEnvVar"

!macro Define_Func_RemoveToken UN
Function ${UN}RemoveToken
	StrCpy $R9 ""
	StrCpy $R8 0
	${Do}
		${${UN}StrTok} $R7 $R0 $R2 $R8 "1"
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
!macroend
!insertmacro Define_Func_RemoveToken ""
!insertmacro Define_Func_RemoveToken "un."


!macro Install_Config_MiKTeX
	${If} $MiKTeX != ""
		DetailPrint "Install MiKTeX configs"

		StrCpy $0 "$INSTDIR\${MiKTeX_Dir}"
		StrCpy $1 "$0\miktex\bin"

		StrCpy $9 "Software\MiKTeX.org\MiKTeX\$MiKTeX"
		WriteRegStr HKLM "$9\Core" "Install" "$0"
		WriteRegStr HKLM "$9\Core" "SharedSetup" "1"
		WriteRegStr HKCU "$9\MPM" "AutoInstall" "2"
		WriteRegStr HKCU "$9\MPM" "RemoteRepository" "ftp://ftp.ctex.org/CTAN/systems/win32/miktex/tm/packages/"
		WriteRegStr HKCU "$9\MPM" "RepositoryType" "remote"

		${AddPath} "$1"

		StrCpy $9 "$1\yap.exe"
		!insertmacro APP_ASSOCIATE "dvi" "MiKTeX.Yap.dvi.$MiKTeX" "DVI $(Desc_File)" "$9,1" "Open with Yap" '$9 "%1"'

; ShortCuts
		StrCpy $9 "$SMPROGRAMS\CTeX\MiKTeX"
		CreateDirectory "$9"
		CreateShortCut "$9\Browse Packages.lnk" "$1\mpm_mfc.exe"
		CreateShortCut "$9\Previewer.lnk" "$1\yap.exe"
		CreateShortCut "$9\Settings.lnk" "$1\mo.exe"
		CreateShortCut "$9\Update.lnk" "$1\copystart_admin.exe" '"$0\miktex\config\update.dat"'

		StrCpy $9 "$SMPROGRAMS\CTeX\MiKTeX\Help"
		CreateDirectory "$9"
		CreateShortCut "$9\FAQ.lnk" "$0\doc\miktex\faq.chm"
		CreateShortCut "$9\Manual.lnk" "$0\doc\miktex\miktex.chm"

		StrCpy $9 "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web"
		CreateDirectory "$9"
		${CreateURLShortCut} "$9\Give back" "http://miktex.org/giveback"
		${CreateURLShortCut} "$9\Known Issues" "http://miktex.org/2.7/issues"
		${CreateURLShortCut} "$9\MiKTeX Project Page" "http://miktex.org/"
		${CreateURLShortCut} "$9\Support" "http://miktex.org/support"

		ExecWait "$1\mpm.exe --register-components --quiet"
		ExecWait "$1\initexmf.exe --force --mklinks --quiet"
	${EndIf}
!macroend

!macro Uninstall_Config_MiKTeX UN
	${If} $UN_MiKTeX != ""
		DetailPrint "Uninstall MiKTeX configs"

		ExecWait "$UN_INSTDIR\${MiKTeX_Dir}\miktex\bin\mpm.exe --unregister-components --quiet"

		DeleteRegKey HKLM "Software\MiKTeX.org"
		DeleteRegKey HKCU "Software\MiKTeX.org"

		${${UN}RemovePath} "$UN_INSTDIR\${MiKTeX_Dir}\miktex\bin"

		!insertmacro APP_UNASSOCIATE "dvi" "MiKTeX.Yap.dvi.$UN_MiKTeX"
	${EndIf}
!macroend

!macro Install_Config_Addons
	${If} $Addons != ""
		DetailPrint "Install CTeX Addons configs"

		StrCpy $0 "$INSTDIR\${Addons_Dir}"

		StrCpy $9 "Software\MiKTeX.org\MiKTeX\$MiKTeX\Core"
		ReadRegStr $R0 HKLM "$9" "Roots"
		${If} $R0 == ""
			ReadRegStr $R1 HKLM "$9" "Install"
			WriteRegStr HKLM "$9" "Roots" "$0;$R1"
		${Else}
			StrCpy $R1 "$0"
			StrCpy $R2 ";"
			Call RemoveToken
			WriteRegStr HKLM "$9" "Roots" "$0;$R9"
		${EndIf}

		${AddPath} "$0\ctex\bin"

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

		FileOpen $R0 "$0\ty\bin\tywin.cfg" "w"
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

; ShortCuts
		CreateShortCut "$SMPROGRAMS\CTeX\Font Setup.lnk" "$0\ctex\bin\FontSetup.exe"

		StrCpy $9 "$SMPROGRAMS\CTeX\Help"
		StrCpy $8 "$0\ctex\doc"
		CreateDirectory "$9"
		CreateShortCut "$9\CTeX FAQ.lnk" "$8\ctex-faq.pdf"
		CreateShortCut "$9\Graphics.lnk" "$8\graphics.pdf"
		CreateShortCut "$9\Symbols.lnk" "$8\symbols.pdf"
		CreateShortCut "$9\Mathematics.lnk" "$8\ch8.pdf"
		CreateShortCut "$9\LaTeX Short.lnk" "$8\lshort-cn.pdf"
	${EndIf}
!macroend

!macro Uninstall_Config_Addons UN
	${If} $UN_Addons != ""
		DetailPrint "Uninstall CTeX Addons configs"

		StrCpy $0 "$UN_INSTDIR\${Addons_Dir}"
	
		StrCpy $9 "Software\MiKTeX.org\MiKTeX\$UN_MiKTeX\Core"
		ReadRegStr $R0 HKLM "$9" "Roots"
		${If} $R0 != ""
			StrCpy $R1 "$0"
			StrCpy $R2 ";"
			Call ${UN}RemoveToken
			WriteRegStr HKLM "$9" "Roots" "$R9"
		${EndIf}

		${${UN}RemovePath} "$0\ctex\bin"

; Uninstall CCT
		${${UN}RemovePath} "$0\cct\bin"
		${RemoveEnvVar} "CCHZPATH"
		${RemoveEnvVar} "CCPKPATH"

; Uninstall TY
		${${UN}RemovePath} "$0\ty\bin"
	${EndIf}

	Delete "$SMPROGRAMS\CTeX\Font Setup.lnk"
	RMDir /r "$SMPROGRAMS\CTeX\Help"
!macroend

!macro Install_Config_Ghostscript
	${If} $Ghostscript != ""
		DetailPrint "Install Ghostscript configs"

		StrCpy $0 "$INSTDIR\${Ghostscript_Dir}"
		StrCpy $1 "$0\gs$Ghostscript"
		
		StrCpy $9 "Software\GPL Ghostscript\$Ghostscript"
		WriteRegStr HKLM "$9" "GS_DLL" "$1\bin\gsdll32.dll"
		WriteRegStr HKLM "$9" "GS_LIB" "$1\lib;$0\fonts;$FONTS"
	
		${AddPath} "$1\bin"
	
; ShortCuts
		StrCpy $9 "$SMPROGRAMS\CTeX\Ghostcript"
		CreateDirectory "$9"
		CreateShortCut "$9\Ghostscript.lnk" "$1\bin\gswin32.exe" '"-I$1\lib;$0\fonts;$FONTS"'
		CreateShortCut "$9\Ghostscript Readme.lnk" "$1\doc\Readme.htm"
	${EndIf}
!macroend

!macro Uninstall_Config_Ghostscript UN
	${If} $UN_Ghostscript != ""
		DetailPrint "Uninstall Ghostscript configs"

		DeleteRegKey HKLM "Software\GPL Ghostscript"
	
		${${UN}RemovePath} "$UN_INSTDIR\${Ghostscript_Dir}\gs$UN_Ghostscript\bin"

		RMDir /r "$SMPROGRAMS\CTeX\Ghostscript"
	${EndIf}
!macroend

!macro Install_Config_GSview
	${If} $GSview != ""
		DetailPrint "Install GSview configs"

		StrCpy $0 "$INSTDIR\${GSview_Dir}"
		WriteRegStr HKLM "Software\Ghostgum\GSview" "$GSview" "$0"
	
		StrCpy $9 "$0\gsview\gsview32.ini"
		StrCpy $8 "GSview-$GSview"
		StrCpy $7 "$INSTDIR\${Ghostscript_Dir}"
		StrCpy $6 "$7\gs$Ghostscript"
		WriteINIStr $9 "$8"	"Version" "$GSview"
		WriteINIStr $9 "$8"	"GSversion" "864"
		WriteINIStr $9 "$8"	"GhostscriptDLL" "$6\bin\gsdll32.dll"
		WriteINIStr $9 "$8"	"GhostscriptInclude" "$6\lib;$7\fonts;$FONTS"
		WriteINIStr $9 "$8"	"GhostscriptOther" '-dNOPLATFONTS -sFONTPATH="c:\psfonts"'
		WriteINIStr $9 "$8"	"Configured" "1"
		Delete "$PROFILE\gsview32.ini"
	
		${AddPath} "$0\gsview"
	
		StrCpy $9 "$0\gsview\gsview32.exe"
		!insertmacro APP_ASSOCIATE "ps" "CTeX.PS" "PS $(Desc_File)" "$9,3" "Open with GSview" '$9 "%1"'
		!insertmacro APP_ASSOCIATE "eps" "CTeX.EPS" "EPS $(Desc_File)" "$9,3" "Open with GSview" '$9 "%1"'
	
; ShortCuts
		StrCpy $9 "$SMPROGRAMS\CTeX\Ghostgum"
		CreateDirectory "$9"
		CreateShortCut "$9\GSview.lnk" "$0\gsview\gsview32.exe"
		CreateShortCut "$9\GSview Readme.lnk" "$0\gsview\Readme.htm"
	${EndIf}
!macroend

!macro Uninstall_Config_GSview UN
	${If} $UN_GSview != ""
		DetailPrint "Uninstall GSview configs"

		DeleteRegKey HKLM "Software\Ghostgum"
	
		${${UN}RemovePath} "$UN_INSTDIR\${GSview_Dir}\gsview"
	
		!insertmacro APP_UNASSOCIATE "ps" "CTeX.PS"
		!insertmacro APP_UNASSOCIATE "eps" "CTeX.EPS"

		RMDir /r "$SMPROGRAMS\CTeX\Ghostgum"
	${EndIf}
!macroend

!macro Install_Config_WinEdt
	${If} $WinEdt != ""
		DetailPrint "Install WinEdt configs"

		StrCpy $0 "$INSTDIR\${WinEdt_Dir}"
		WriteRegStr HKLM "Software\WinEdt" "Install Root" "$0"
	
		${AddPath} "$0"
	
		StrCpy $9 "$0\WinEdt.exe"
		!insertmacro APP_ASSOCIATE "tex" "CTeX.TeX" "TeX $(Desc_File)" "$9,0" "Open with WinEdt" '$9 "%1"'
	
; ShortCuts
		StrCpy $9 "$SMPROGRAMS\CTeX"
		CreateDirectory "$9"
		CreateShortCut "$9\WinEdt.lnk" "$INSTDIR\${WinEdt_Dir}\WinEdt.exe"
	
		${If} $MiKTeX != ""
			WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\$MiKTeX\Yap\Settings" "Editor" '$INSTDIR\${WinEdt_Dir}\winedt.exe "[Open(|%f|);SelPar(%l,8)]"'
		${EndIf}
	${EndIf}
!macroend

!macro Uninstall_Config_WinEdt UN
	${If} $UN_WinEdt != ""
		DetailPrint "Uninstall WinEdt configs"

		DeleteRegKey HKLM "Software\WinEdt"
	
		${${UN}RemovePath} "$UN_INSTDIR\${WinEdt_Dir}"
	
		!insertmacro APP_UNASSOCIATE "tex" "CTeX.TeX"

		Delete "$SMPROGRAMS\CTeX\WinEdt.lnk"
	${EndIf}
!macroend

!macro Install_Config_CTeX
	DetailPrint "Install general configs"

	StrCpy $9 "Software\${APP_NAME}"
	WriteRegStr HKLM "$9" "" "${APP_NAME} ${APP_VERSION}"
	WriteRegStr HKLM "$9" "Install" "$INSTDIR"
	WriteRegStr HKLM "$9" "Version" "${APP_BUILD}"
	WriteRegStr HKLM "$9" "MiKTeX" "$MiKTeX"
	WriteRegStr HKLM "$9" "Addons" "$Addons"
	WriteRegStr HKLM "$9" "Ghostscript" "$Ghostscript"
	WriteRegStr HKLM "$9" "GSview" "$GSview"
	WriteRegStr HKLM "$9" "WinEdt" "$WinEdt"

	StrCpy $9 "$INSTDIR\${Logs_Dir}\install.ini"
	WriteINIStr "$9" "CTeX" "Install" "$INSTDIR"
	WriteINIStr "$9" "CTeX" "Version" "${APP_BUILD}"
	WriteINIStr "$9" "CTeX" "MiKTeX" "$MiKTeX"
	WriteINIStr "$9" "CTeX" "Addons" "$Addons"
	WriteINIStr "$9" "CTeX" "Ghostscript" "$Ghostscript"
	WriteINIStr "$9" "CTeX" "GSview" "$GSview"
	WriteINIStr "$9" "CTeX" "WinEdt" "$WinEdt"

	StrCpy $9 "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
	WriteRegStr HKLM "$9" "DisplayName" "${APP_NAME}"
	WriteRegStr HKLM "$9" "DisplayVersion" "${APP_BUILD}"
	WriteRegStr HKLM "$9" "DisplayIcon" "$INSTDIR\Uninstall.exe,0"
	WriteRegStr HKLM "$9" "Publisher" "${APP_COMPANY}"
	WriteRegStr HKLM "$9" "Readme" "$INSTDIR\Readme.txt"
	WriteRegStr HKLM "$9" "HelpLink" "http://bbs.ctex.org"
	WriteRegStr HKLM "$9" "URLInfoAbout" "http://www.ctex.org"
	WriteRegStr HKLM "$9" "UninstallString" "$INSTDIR\Uninstall.exe"

	StrCpy $9 "$INSTDIR\${MiKTeX_Dir}\miktex\bin"
	ExecWait "$9\initexmf.exe --update-fndb --quiet"
	ExecWait "$9\initexmf.exe --mkmaps --quiet"

	!insertmacro UPDATEFILEASSOC
!macroend

!macro Uninstall_Config_CTeX UN
	DetailPrint "Uninstall general configs"

	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
	DeleteRegKey HKLM "Software\${APP_NAME}"

	Delete "$UN_INSTDIR\${Logs_Dir}\install.ini"

	RMDir /r "$SMPROGRAMS\CTeX"

	!insertmacro UPDATEFILEASSOC
!macroend

!macro _Install_Files Files Log_File
	CreateDirectory "$INSTDIR\${Logs_Dir}"
	LogSet on
	File /r "${Files}"
	LogSet off
	Delete "$INSTDIR\${Logs_Dir}\${Log_File}"
	Rename "$INSTDIR\install.log" "$INSTDIR\${Logs_Dir}\${Log_File}"
!macroend
!define Install_Files "!insertmacro _Install_Files"

!macro _Begin_Install_Files
	CreateDirectory "$INSTDIR\${Logs_Dir}"
	LogSet on
!macroend
!define Begin_Install_Files "!insertmacro _Begin_Install_Files"

!macro _End_Install_Files Log_File
	LogSet off
	Delete "$INSTDIR\${Logs_Dir}\${Log_File}"
	Rename "$INSTDIR\install.log" "$INSTDIR\${Logs_Dir}\${Log_File}"
!macroend
!define End_Install_Files "!insertmacro _End_Install_Files"

!macro Uninstall_All_Configs UN
	${If} $UN_INSTDIR != ""
		!insertmacro Uninstall_Config_CTeX "${UN}"
		!insertmacro Uninstall_Config_WinEdt "${UN}"
		!insertmacro Uninstall_Config_GSview "${UN}"
		!insertmacro Uninstall_Config_Ghostscript "${UN}"
		!insertmacro Uninstall_Config_Addons "${UN}"
		!insertmacro Uninstall_Config_MiKTeX "${UN}"
	${EndIf}
!macroend

!macro Uninstall_All_Files UN
	${If} $UN_INSTDIR != ""
		DetailPrint "Uninstall old files"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install.log"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install_winedt.log"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install_gsview.log"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install_ghostscript.log"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install_packages.log"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install_ty.log"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install_cct.log"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install_cjk.log"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install_ctex.log"
		${${UN}Uninstall_Files} "$UN_INSTDIR\${Logs_Dir}\install_miktex.log"
		RMDir "$UN_INSTDIR\${Logs_Dir}"
		RMDir "$UN_INSTDIR\${WinEdt_Dir}"
		RMDir "$UN_INSTDIR\${GSview_Dir}"
		RMDir "$UN_INSTDIR\${Ghostscript_Dir}"
		RMDir "$UN_INSTDIR\${Addons_Dir}"
		RMDir "$UN_INSTDIR\${MiKTeX_Dir}"
	${EndIf}
!macroend

!macro Restore_Install_Information
	StrCpy $9 "$INSTDIR\${Logs_Dir}\install.ini"
	${If} ${FileExists} "$9"
		ReadINIStr $MiKTeX "$9" "CTeX" "MiKTeX"
		ReadINIStr $Addons "$9" "CTeX" "Addons"
		ReadINIStr $Ghostscript "$9" "CTeX" "Ghostscript"
		ReadINIStr $GSview "$9" "CTeX" "GSview"
		ReadINIStr $WinEdt "$9" "CTeX" "WinEdt"
	${Else}
		StrCpy $MiKTeX ${MiKTeX_Version}
		StrCpy $Addons ${MiKTeX_Version}
		StrCpy $Ghostscript ${Ghostscript_Version}
		StrCpy $GSview ${GSview_Version}
		StrCpy $WinEdt ${WinEdt_Version}
	${EndIf}
	${If} $MiKTeX != ""
		!insertmacro SelectSection ${Section_MiKTeX}
	${EndIf}
	${If} $Addons != ""
		!insertmacro SelectSection ${Section_Addons}
	${EndIf}
	${If} $Ghostscript != ""
		!insertmacro SelectSection ${Section_Ghostscript}
	${EndIf}
	${If} $GSview != ""
		!insertmacro SelectSection ${Section_GSview}
	${EndIf}
	${If} $WinEdt != ""
		!insertmacro SelectSection ${Section_WinEdt}
	${EndIf}
!macroend

!macro Set_All_Sections_ReadOnly
	!insertmacro SetSectionFlag ${Section_MiKTeX} ${SF_RO}
	!insertmacro SetSectionFlag ${Section_Addons} ${SF_RO}
	!insertmacro SetSectionFlag ${Section_Ghostscript} ${SF_RO}
	!insertmacro SetSectionFlag ${Section_GSview} ${SF_RO}
	!insertmacro SetSectionFlag ${Section_WinEdt} ${SF_RO}
!macroend

!macro Update_Install_Information
	${If} ${SectionIsSelected} ${Section_MiKTeX}
		StrCpy $MiKTeX ${MiKTeX_Version}
	${EndIf}
	${If} ${SectionIsSelected} ${Section_Addons}
		StrCpy $Addons ${MiKTeX_Version}
	${EndIf}
	${If} ${SectionIsSelected} ${Section_Ghostscript}
		StrCpy $Ghostscript ${Ghostscript_Version}
	${EndIf}
	${If} ${SectionIsSelected} ${Section_GSview}
		StrCpy $GSview ${GSview_Version}
	${EndIf}
	${If} ${SectionIsSelected} ${Section_WinEdt}
		StrCpy $WinEdt ${WinEdt_Version}
	${EndIf}
!macroend

!macro Get_Uninstall_Information
	ReadRegStr $UN_INSTDIR HKLM "Software\${APP_NAME}" "Install"
	ReadRegStr $UN_Version HKLM "Software\${APP_NAME}" "Version"
	ReadRegStr $UN_MiKTeX HKLM "Software\${APP_NAME}" "MiKTeX"
	ReadRegStr $UN_Addons HKLM "Software\${APP_NAME}" "Addons"
	ReadRegStr $UN_Ghostscript HKLM "Software\${APP_NAME}" "Ghostscript"
	ReadRegStr $UN_GSview HKLM "Software\${APP_NAME}" "GSview"
	ReadRegStr $UN_WinEdt HKLM "Software\${APP_NAME}" "WinEdt"
!macroend

!macro Update_Uninstall_Information
	${If} $UN_INSTDIR != ""
		StrCpy $INSTDIR $UN_INSTDIR
	${Else}
		StrCpy $UN_INSTDIR $INSTDIR
		StrCpy $UN_MiKTeX ${MiKTeX_Version}
		StrCpy $UN_Addons ${MiKTeX_Version}
		StrCpy $UN_Ghostscript ${Ghostscript_Version}
		StrCpy $UN_GSview ${GSview_Version}
		StrCpy $UN_WinEdt ${WinEdt_Version}
	${EndIf}
!macroend

!macro Update_Log LogFile
	${If} ${FileExists} ${LogFile}
		ReadINIStr $R0 "$INSTDIR\${Logs_Dir}\install.ini" "CTeX" "Install"
		${If} $R0 != ""
			DetailPrint "Update install log: ${LogFile}"
			${textreplace::ReplaceInFile} "${LogFile}" "${LogFile}.new" "$R0" "$INSTDIR" "/S=1" $R1
			${textreplace::Unload}
			Delete "${LogFile}"
			Rename "${LogFile}.new" "${LogFile}"
		${EndIf}
	${EndIf}
!macroend

!macro Update_All_Logs
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install.log"
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install_winedt.log"
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install_gsview.log"
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install_ghostscript.log"
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install_packages.log"
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install_ty.log"
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install_cct.log"
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install_cjk.log"
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install_ctex.log"
	!insertmacro Update_Log "$INSTDIR\${Logs_Dir}\install_miktex.log"
!macroend

!macro Compress_Log LogFile
	${If} ${FileExists} ${LogFile}
		DetailPrint "Compress install log: ${LogFile}"
		FileOpen $0 "${LogFile}" "r"
		FileOpen $1 "${LogFile}.new" "w"
		${Do}
			FileRead $0 $9
			${If} $9 == ""
				${ExitDo}
			${EndIf}
			StrCpy $8 $9 11
			${If} $8 == "File: overw"
				${Continue}
			${EndIf}
			StrCpy $7 $9 7 -9
			${If} $8 == "CreateDirec"
			${AndIf} $7 == "created"
				${Continue}
			${EndIf}
			FileWrite $1 "$9"
		${Loop}
		FileClose $1
		FileClose $0
		Delete "${LogFile}"
		Rename "${LogFile}.new" "${LogFile}"
	${EndIf}
!macroend

!macro Compress_All_Logs
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install.log"
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install_winedt.log"
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install_gsview.log"
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install_ghostscript.log"
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install_packages.log"
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install_ty.log"
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install_cct.log"
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install_cjk.log"
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install_ctex.log"
	!insertmacro Compress_Log "$INSTDIR\${Logs_Dir}\install_miktex.log"
!macroend
