
; Use compression
SetCompressor /FINAL /SOLID LZMA
SetCompressorDictSize 32

!include "CTeX_Version.nsh"

; Functions and Macros
!include "CTeX_Macros.nsh"

!define Base_Version "2.8.0.125"

; Variables
Var Version
Var MiKTeX
Var Addons
Var Ghostscript
Var GSview
Var WinEdt

; Main Install settings
Name "${APP_NAME} ${APP_VERSION} Update"
BrandingText "${APP_NAME} ${APP_BUILD} (C) ${APP_COMPANY}"
InstallDir "C:\CTEX"
OutFile "CTeX_${APP_BUILD}_Update.exe"

; Other settings
RequestExecutionLevel admin

; Modern interface settings
!include "MUI2.nsh"

!define MUI_ABORTWARNING
!define MUI_ICON "CTeX.ico"
!define MUI_CUSTOMFUNCTION_GUIINIT onMUIInit

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Set languages (first is default language)
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL

Section

	SetOverwrite on

	${If} $Addons != ""
		SetOutPath $INSTDIR\${Addons_Dir}\ctex\bin
		File Addons\CTeX\ctex\bin\SumatraPDF.exe

		SetOverwrite On
		SetOutPath "$INSTDIR\${Addons_Dir}"
		${Uninstall_Files} "$INSTDIR\${Logs_Dir}\install_packages.log"
		${Install_Files} "Addons\Packages\*.*" "install_packages.log"

;		SetOutPath $INSTDIR\${Addons_Dir}
;		File /r Addons\CCT\*.*

;		SetOutPath $INSTDIR\${Addons_Dir}\tex\latex\ctex
;		File /r Addons\Packages\tex\latex\ctex\*.*
;		SetOutPath $INSTDIR\${Addons_Dir}\doc\latex\ctex
;		File /r Addons\Packages\doc\latex\ctex\*.*
	${EndIf}
	
	${If} $Ghostscript != ""
		SetOverwrite on
		SetOutPath "$INSTDIR\${Ghostscript_Dir}"
		${Uninstall_Files} "$INSTDIR\${Logs_Dir}\install_ghostscript.log"
		${Install_Files} "Ghostscript\*.*" "install_ghostscript.log"
	${EndIf}

; Always do update
	SetOutPath $INSTDIR
	File Readme.txt
	File Changes.txt
	File Repair.exe

; Update configs
	DetailPrint "Update configs"
	StrCpy $Version ${APP_BUILD}
	${If} $MiKTeX != ""
		StrCpy $MiKTeX ${MiKTeX_Version}
	${EndIf}
	${If} $Addons != ""
		StrCpy $Addons ${MiKTeX_Version}
	${EndIf}
	${If} $Ghostscript != ""
		StrCpy $Ghostscript ${Ghostscript_Version}
	${EndIf}
	${If} $GSview != ""
		StrCpy $GSview ${GSview_Version}
	${EndIf}
	${If} $WinEdt != ""
		StrCpy $WinEdt ${WinEdt_Version}
	${EndIf}

	!insertmacro Save_Install_Information
	
	nsExec::Exec "$INSTDIR\Repair.exe /S"

; Update MiKTeX
	DetailPrint "Update MiKTeX"
	${If} $MiKTeX != ""
		MessageBox MB_YESNO|MB_ICONQUESTION "$(Msg_UpdateMiKTeX)" /SD IDNO IDNO +2
		nsExec::Exec '"$INSTDIR\${MiKTeX_Dir}\miktex\bin\internal\copystart_admin.exe" "$INSTDIR\${MiKTeX_Dir}\miktex\bin\internal\miktex-update_admin.exe"'
	${EndIf}
SectionEnd

; On initialization
Function .onInit

	!insertmacro MUI_LANGDLL_DISPLAY

	ReadRegStr $INSTDIR HKLM "Software\${APP_NAME}" "Install"
	ReadRegStr $Version HKLM "Software\${APP_NAME}" "Version"

	${If} ${Silent}
		Call onMUIInit
	${EndIf}

FunctionEnd

Function onMUIInit

	${If} $INSTDIR != ""
	${AndIf} $Version != ""
		${VersionCompare} $Version ${APP_BUILD} $1
		${If} $1 == "1"
			MessageBox MB_OK|MB_ICONSTOP "$(Msg_NewVer)"
			Abort
		${ElseIf} $1 == "0"
			MessageBox MB_OK|MB_ICONSTOP "$(Msg_SameVer)"
			Abort
		${EndIf}

		${VersionCompare} $Version ${Base_Version} $1
		${If} $1 == "2"
			MessageBox MB_OK|MB_ICONSTOP "$(Msg_OldVer) ${Base_Version}"
			Abort
		${EndIf}
	${Else}
		MessageBox MB_OK|MB_ICONSTOP "$(Msg_NotInst)"
		Abort
	${EndIf}
	
	!insertmacro Restore_Install_Information

FunctionEnd

!insertmacro Set_Version_Information

; Language strings

LangString Msg_NewVer ${LANG_SIMPCHINESE} "系统中安装了更高版本的CTeX！"
LangString Msg_NewVer ${LANG_ENGLISH} "Newer version of CTeX is found in the system!"
LangString Msg_SameVer ${LANG_SIMPCHINESE} "系统中已经安装了最新版本的CTeX！"
LangString Msg_SameVer ${LANG_ENGLISH} "Latest version of CTeX is found in the system!"
LangString Msg_OldVer ${LANG_SIMPCHINESE} "系统中安装的CTeX版本太旧，请先更新到版本："
LangString Msg_OldVer ${LANG_ENGLISH} "The installed CTeX is too old, please update to version: "
LangString Msg_NotInst ${LANG_SIMPCHINESE} "系统中没有安装CTeX！"
LangString Msg_NotInst ${LANG_ENGLISH} "Not found CTeX in the system!"
LangString Msg_FontSetup ${LANG_SIMPCHINESE} "必须重新生成中文Type1字库！运行FontSetup？"
LangString Msg_FontSetup ${LANG_ENGLISH} "Must re-generate Chinese Type1 fonts! Run FontSetup?"
LangString Msg_UpdateMiKTeX ${LANG_SIMPCHINESE} "是否在线更新MiKTeX？"
LangString Msg_UpdateMiKTeX ${LANG_ENGLISH} "Update MiKTeX through Internet?"

; eof