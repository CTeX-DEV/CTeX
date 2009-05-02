; Script generated with the Venis Install Wizard

!define BUILD_NUMBER "6"
;!define BUILD_FULL
;!define BUILD_DEBUG

; Define your application name
!define APP_NAME "CTeX"
!define APP_COMPANY "CTEX.ORG"
!define APP_COPYRIGHT "Copyright (C) 2009 ${APP_COMPANY}"
!define APP_VERSION "2.7.0"
!define APP_BUILD "${APP_VERSION}.${BUILD_NUMBER}"

; Main Install settings
Name "${APP_NAME} ${APP_VERSION}"
InstallDir "C:\CTEX"
!ifndef BUILD_FULL
	OutFile "CTeX ${APP_BUILD}.exe"
!else
	OutFile "CTeX ${APP_BUILD} Full.exe"
!endif

; Use compression
SetCompressor /SOLID LZMA
SetCompressorDictSize 128

; Functions and Macros
!include "CTeX_Setup.nsh"

; Modern interface settings
!include "MUI2.nsh"

!define MUI_ABORTWARNING
!define MUI_ICON "CTeX.ico"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE $(license)
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Set languages (first is default language)
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL

; Language strings
LicenseLangString license ${LANG_SIMPCHINESE} License-zh.txt
LicenseLangString license ${LANG_ENGLISH} License-en.txt

LangString Desc_MiKTeX ${LANG_SIMPCHINESE} "Windows下最好用的TeX系统之一，它带有一个很优秀的DVI预览器Yap。"
LangString Desc_MiKTeX ${LANG_ENGLISH} "One of the best TeX system on Windows platform, with an excellent DVI previewer Yap."
LangString Desc_Ghostscript ${LANG_SIMPCHINESE} "PS (PostScript)语言和PDF文件的解释器，可在非PS打印机上打印它们。可以将PS文件和PDF文件相互转换。"
LangString Desc_Ghostscript ${LANG_ENGLISH} "PS (PostScript) and PDF interpreter."
LangString Desc_GSview ${LANG_SIMPCHINESE} "GSview是Ghostscript的图形界面程序，通过Ghostscript的支持，可以很方便地浏览和修改PS文件。"
LangString Desc_GSview ${LANG_ENGLISH} "GSview is the frontend GUI of Ghostscript, used with Ghostscript to view and edit PS (PostScript) file."
LangString Desc_WinEdt ${LANG_SIMPCHINESE} "WinEdt是一个编辑器，它内置了对TeX的良好支持。在它的菜单上和按钮上可以直接调用TeX程序，包括编译、预览等。WinEdt还能帮助你迅速输入各种TeX命令和符号，省去你记忆大量命令的烦恼。"
LangString Desc_WinEdt ${LANG_ENGLISH} "WinEdt a well designed text editor with full support to edit and compile TeX file."

LangString Desc_File ${LANG_SIMPCHINESE} "文档"
LangString Desc_File ${LANG_ENGLISH} "File"

; Components information
!define dMiKTeX "MiKTeX"
!define vMiKTeX "2.7"
!define dAddons "CTeX"
!define dGhostscript "Ghostscript"
!define vGhostscript "8.64"
!define dGSview "GSview"
!define vGSview "4.9"
!define dWinEdt "WinEdt"
!define vWinEdt "5.5"

Section "MiKTeX" Section_MiKTeX

	SetOverwrite on

	StrCpy $0 "$INSTDIR\${dMiKTeX}"
	StrCpy $1 "${vMiKTeX}"
	SetOutPath $0

!ifndef BUILD_DEBUG
!ifndef BUILD_FULL
	File /r MiKTeX.basic\*.*
!else
	File /r MiKTeX.full\*.*
!endif
!endif

	!insertmacro Install_Reg_MiKTeX "$0" "$1"
	!insertmacro Install_Link_MiKTeX "$0" "$1"

SectionEnd

Section "Addons" Section_Addons

	SetOverwrite On

	StrCpy $0 "$INSTDIR\${dAddons}"
	SetOutpath $0

!ifndef BUILD_DEBUG
	File /r Addons\CTeX\*.*
	File /r Addons\Packages\*.*
	File /r Addons\CJK\*.*
	File /r Addons\CCT\*.*
	File /r Addons\TY\*.*
!endif

	!insertmacro Install_Reg_Addons "$0" "${vMiKTeX}"

SectionEnd

Section "Ghostscript" Section_Ghostscript

	SetOverwrite on

	StrCpy $0 "$INSTDIR\${dGhostscript}"
	StrCpy $1 "${vGhostscript}"
	SetOutPath $0

!ifndef BUILD_DEBUG
	File /r Ghostscript\*.*
!endif

	!insertmacro Install_Reg_Ghostscript "$0" "$1"
	!insertmacro Install_Link_Ghostscript "$0" "$1"

SectionEnd

Section "GSview" Section_GSview

	SetOverwrite on

	StrCpy $0 "$INSTDIR\${dGSview}"
	StrCpy $1 "${vGSview}"
	SetOutPath $0

!ifndef BUILD_DEBUG
	File /r GSview\*.*
!endif

	!insertmacro Install_Reg_GSview "$0" "$1"
	!insertmacro Install_Link_GSview "$0" "$1"

SectionEnd

Section "WinEdt" Section_WinEdt

	SetOverwrite on

	StrCpy $0 "$INSTDIR\${dWinEdt}"
	SetOutPath $0

!ifndef BUILD_DEBUG
	File /r WinEdt\*.*
!endif

	!insertmacro Install_Reg_WinEdt "$0" "$1"
	!insertmacro Install_Link_WinEdt "$0" "$1"

	SectionGetFlags ${Section_MiKTeX} $R0
	IntOp $R0 $R0 & ${SF_SELECTED}
	${If} $R0 == ${SF_SELECTED}
		!insertmacro Associate_WinEdt_MiKTeX "$0" "${vMiKTeX}" 
	${EndIf}

SectionEnd

Section -FinishSection

	WriteRegStr HKLM "Software\${APP_NAME}" "" "$INSTDIR"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\uninstall.exe"
	WriteUninstaller "$INSTDIR\uninstall.exe"
	CreateDirectory "$SMPROGRAMS\CTeX"
	CreateShortCut "$SMPROGRAMS\CTeX\Uninstall.lnk" "$INSTDIR\uninstall.exe"

	!insertmacro UPDATEFILEASSOC

	ExecWait "$INSTDIR\${dMiKTeX}\miktex\bin\initexmf.exe --dump --update-fndb"

SectionEnd

; Modern install component descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_MiKTeX} $(Desc_MiKTeX)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_Ghostscript} $(Desc_Ghostscript)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_GSview} $(Desc_GSview)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_WinEdt} $(Desc_WinEdt)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;Uninstall section
Section Uninstall

	;Remove from registry...
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
	DeleteRegKey HKLM "Software\${APP_NAME}"

	!insertmacro Uninstall_Reg_MiKTeX "$INSTDIR\${dMiKTeX}" "${vMiKTeX}"
	!insertmacro Uninstall_Reg_Addons "$INSTDIR\${dAddons}"
	!insertmacro Uninstall_Reg_Ghostscript "$INSTDIR\${dGhostscript}" "${vGhostscript}"
	!insertmacro Uninstall_Reg_GSview "$INSTDIR\${dGSview}" "${vGSview}"
	!insertmacro Uninstall_Reg_WinEdt "$INSTDIR\${dWinEdt}" "${vWinEdt}"

	; Delete self
	Delete "$INSTDIR\uninstall.exe"

	; Delete Shortcuts
	RMDir /r "$SMPROGRAMS\CTeX"

	; Clean up CTeX
	RMDir /r $INSTDIR

	; Remove remaining directories

	!insertmacro UPDATEFILEASSOC

SectionEnd

; On initialization
Function .onInit

	!insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "ProductName" "${APP_NAME}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "CompanyName" "${APP_COMPANY}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileDescription" "中文TeX套装"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileVersion" "${APP_BUILD}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "LegalCopyright" "${APP_COPYRIGHT}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${APP_NAME}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${APP_COMPANY}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Chinese TeX Suite"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${APP_BUILD}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "${APP_COPYRIGHT}"
VIProductVersion "${APP_BUILD}"

; eof