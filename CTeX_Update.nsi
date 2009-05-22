
!include "CTeX_Version.nsh"

; Functions and Macros
!include "CTeX_Macros.nsh"

!define Base_Version "2.7.0.27"

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
ShowInstDetails nevershow
RequestExecutionLevel admin

; Use compression
SetCompressor /SOLID LZMA
SetCompressorDictSize 128

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
		SetOutPath $INSTDIR\${Addons_Dir}\miktex\config
		File Addons\CTeX\miktex\config\updmap.cfg
	
		SetOutPath $INSTDIR\${Addons_Dir}\ctex\bin
		File Addons\CTeX\ctex\bin\FontSetup.exe

		Delete $INSTDIR\${Addons_Dir}\fonts\map\chinese\cjk-song-ttf.map
		Delete $INSTDIR\${Addons_Dir}\fonts\map\chinese\cjk-fs-ttf.map
		Delete $INSTDIR\${Addons_Dir}\fonts\map\chinese\cjk-hei-ttf.map
		Delete $INSTDIR\${Addons_Dir}\fonts\map\chinese\cjk-kai-ttf.map
		Delete $INSTDIR\${Addons_Dir}\fonts\map\chinese\cjk-li-ttf.map
		Delete $INSTDIR\${Addons_Dir}\fonts\map\chinese\cjk-you-ttf.map
		
		SetOutPath $INSTDIR\${Addons_Dir}
		${Uninstall_Files} "$INSTDIR\${Logs_Dir}\install_cjk.log"
		${Install_Files} "Addons\CJK\*.*" "install_cjk.log"
		${Uninstall_Files} "$INSTDIR\${Logs_Dir}\install_packages.log"
		${Install_Files} "Addons\Packages\*.*" "install_packages.log"
	${EndIf}

; Delete Uninstall.exe older than 2.7.0.29
	${If} ${FileExists} "$INSTDIR\Uninstall.exe"
		${GetFileVersion} "$INSTDIR\Uninstall.exe" $0
		${VersionCompare} $0 "2.7.0.29" $1
		${If} $1 == "2"
			Delete "$INSTDIR\Uninstall.exe"
		${EndIf}
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

SectionEnd

; On initialization
Function .onInit

	!insertmacro MUI_LANGDLL_DISPLAY

	ReadRegStr $INSTDIR HKLM "Software\${APP_NAME}" "Install"
	ReadRegStr $Version HKLM "Software\${APP_NAME}" "Version"

	${If} ${Silent}
		Call onMUIInit
	${EndIf}
	
	!insertmacro Restore_Install_Information

FunctionEnd

Function onMUIInit

	${If} $INSTDIR != ""
	${AndIf} $Version != ""
		${VersionCompare} $Version ${APP_BUILD} $1
		${If} $1 == "1"
			MessageBox MB_OK|MB_ICONSTOP "$(Msg_Downgrade)"
			Abort
		${EndIf}

		${VersionCompare} $Version ${Base_Version} $1
		${If} $1 == "2"
			MessageBox MB_OK|MB_ICONSTOP "$(Msg_TooOld) ${Base_Version}"
			Abort
		${EndIf}
	${Else}
		MessageBox MB_OK|MB_ICONSTOP "$(Msg_NoInstall)"
		Abort
	${EndIf}

FunctionEnd

!insertmacro Set_Version_Information

; Language strings

LangString Msg_Downgrade ${LANG_SIMPCHINESE} "系统中安装了更高版本的CTeX！"
LangString Msg_Downgrade ${LANG_ENGLISH} "Newer version of CTeX is found in the system!"
LangString Msg_TooOld ${LANG_SIMPCHINESE} "系统中安装的CTeX版本太旧，请先更新到版本："
LangString Msg_TooOld ${LANG_ENGLISH} "The installed CTeX is too old, please update to version: "
LangString Msg_NoInstall ${LANG_SIMPCHINESE} "系统中没有安装CTeX！"
LangString Msg_NoInstall ${LANG_ENGLISH} "Not found CTeX in the system!"

; eof