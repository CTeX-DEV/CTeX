; Script generated with the Venis Install Wizard

!define BUILD_NUMBER "1"
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
InstallDir "C:\CTeX"
!ifndef BUILD_FULL
	OutFile "CTeX ${APP_BUILD}.exe"
!else
	OutFile "CTeX ${APP_BUILD} Full.exe"
!endif

; Use compression
SetCompressor /SOLID LZMA
SetCompressorDictSize 128

; Functions and Macros
!include "FileFunc.nsh"
!include "EnvVarUpdate.nsh"

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

!macro _AddPath Path
	StrCpy $R0 "${Path}"
	Call _AddPath
!macroend
!define AddPath "!insertmacro _AddPath"

!macro _unRemovePath Path
	${un.EnvVarUpdate} $R1 "PATH" "R" "HKLM" "${Path}"
	${un.EnvVarUpdate} $R1 "PATH" "R" "HKCU" "${Path}"
!macroend
!define un.RemovePath "!insertmacro _unRemovePath"

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

; Components information
!define dMiKTeX "MiKTeX"
!define vMiKTeX "2.7"
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

	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\$1\Core" "Install" "$0"
	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\$1\Core" "SharedSetup" "1"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\$1\MPM" "AutoInstall" "2"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\$1\MPM" "RemoteRepository" "ftp://ftp.ctex.org/CTAN/systems/win32/miktex/tm/packages/"
	
	${AddPath} "$0\miktex\bin"

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
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Known Issues.lnk" "http://miktex.org/2.7/issues"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\MiKTeX Project Page.lnk" "http://miktex.org/"
	${CreateURLShortCut} "$SMPROGRAMS\CTeX\MiKTeX\MiKTeX on the Web\Support.lnk" "http://miktex.org/support"
SectionEnd

Section "Ghostscript" Section_Ghostscript

	SetOverwrite on

	StrCpy $0 "$INSTDIR\${dGhostscript}"
	StrCpy $1 "${vGhostscript}"
	SetOutPath $0

!ifndef BUILD_DEBUG
	File /r Ghostscript\*.*
!endif

	WriteRegStr HKLM "Software\GPL Ghostscript\$1" "GS_DLL" "$0\gs$1\bin\gsdll32.dll"
	WriteRegStr HKLM "Software\GPL Ghostscript\$1" "GS_LIB" "$0\gs$1\lib;$0\fonts;$FONTS"

	${AddPath} "$0\gs$1\bin"

	CreateDirectory "$SMPROGRAMS\CTeX\Ghostcript"
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostcript\Ghostscript.lnk" "$0\gs$1\bin\gswin32.exe" '"-I$INSTDIR\gs\gs$1\lib;$INSTDIR\gs\fonts;$FONTS"'
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostcript\Ghostscript Readme.lnk" "$0\gs$1\doc\Readme.htm"

SectionEnd

Section "GSview" Section_GSview

	SetOverwrite on

	StrCpy $0 "$INSTDIR\${dGSview}"
	StrCpy $1 "${vGSview}"
	SetOutPath $0

!ifndef BUILD_DEBUG
	File /r GSview\*.*
!endif

	WriteRegStr HKLM "Software\Ghostgum\GSview" "$1" "$0"

	${AddPath} "$0\gsview"

	CreateDirectory "$SMPROGRAMS\CTeX\Ghostgum"
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostgum\GSview.lnk" "$0\gsview\gsview32.exe"
	CreateShortCut "$SMPROGRAMS\CTeX\Ghostgum\GSview Readme.lnk" "$0\gsview\Readme.htm"

SectionEnd

Section "WinEdt" Section_WinEdt

	SetOverwrite on

	StrCpy $0 "$INSTDIR\${dWinEdt}"
	SetOutPath $0

!ifndef BUILD_DEBUG
	File /r WinEdt\*.*
!endif

	WriteRegStr HKLM "Software\WinEdt" "Install Root" "$0"

	${AddPath} "$0"

	CreateDirectory "$SMPROGRAMS\CTeX"
	CreateShortCut "$SMPROGRAMS\CTeX\WinEdt.lnk" "$0\WinEdt.exe"

SectionEnd

Section -FinishSection

	WriteRegStr HKLM "Software\${APP_NAME}" "" "$INSTDIR"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\uninstall.exe"
	WriteUninstaller "$INSTDIR\uninstall.exe"
	CreateDirectory "$SMPROGRAMS\CTeX"
	CreateShortCut "$SMPROGRAMS\CTeX\Uninstall.lnk" "$INSTDIR\uninstall.exe"

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
	DeleteRegKey HKLM "Software\MiKTeX.org"
	DeleteRegKey HKCU "Software\MiKTeX.org"
	DeleteRegKey HKLM "Software\GPL Ghostscript"
	DeleteRegKey HKLM "Software\Ghostgum"
	DeleteRegKey HKLM "Software\WinEdt"

	${un.RemovePath} "$INSTDIR\${dMiKTeX}\miktex\bin"
	${un.RemovePath} "$INSTDIR\${dGhostscript}\gs${vGhostscript}\bin"
	${un.RemovePath} "$INSTDIR\${dGSview}\gsview"
	${un.RemovePath} "$INSTDIR\${dWinEdt}"

	; Delete self
	Delete "$INSTDIR\uninstall.exe"

	; Delete Shortcuts
	RMDir /r "$SMPROGRAMS\CTeX"

	; Clean up CTeX
	RMDir /r $INSTDIR

	; Remove remaining directories

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