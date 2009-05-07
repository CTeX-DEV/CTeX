
!include "CTeX_Version.nsh"

; Functions and Macros
!include "CTeX_Macros.nsh"

; Variables
Var OLD_INSTDIR
Var OLD_VERSION
Var OLD_MiKTeX_Version
Var OLD_Ghostscript_Version
Var OLD_GSview_Version
Var OLD_WinEdt_Version

; Main Install settings
Name "${APP_NAME} ${APP_VERSION}"
BrandingText "${APP_NAME} ${APP_BUILD} (C) ${APP_COMPANY}"
!ifndef BUILD_REPAIR
	InstallDir "C:\CTEX"
!ifndef BUILD_FULL
	OutFile "CTeX ${APP_BUILD}.exe"
!else
	OutFile "CTeX ${APP_BUILD} Full.exe"
!endif
!else
	InstallDir "$EXEDIR"
  OutFile "Repair.exe"
!endif

; Other settings
ShowInstDetails nevershow
ShowUninstDetails nevershow
RequestExecutionLevel admin

; Use compression
SetCompressor /SOLID LZMA
SetCompressorDictSize 128

; Modern interface settings
!include "MUI2.nsh"

!define MUI_ABORTWARNING
!define MUI_ICON "CTeX.ico"
!define MUI_CUSTOMFUNCTION_GUIINIT OnGUIInit

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE $(license)
!insertmacro MUI_PAGE_COMPONENTS
!ifndef BUILD_REPAIR
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ShowPageDirectory
!endif
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

Section -UpdateSection

!ifndef BUILD_REPAIR
	${If} $OLD_INSTDIR != ""
		!insertmacro UninstallAllFiles ""
	${EndIf}
!endif

SectionEnd	

Section "MiKTeX" Section_MiKTeX

	SetOverwrite on
	SetOutPath "$INSTDIR\${MiKTeX_Dir}"

!ifndef BUILD_REPAIR
!ifndef BUILD_FULL
	${Install_Files} "MiKTeX.basic\*.*" "install_miktex.log"
!else
	${Install_Files} "MiKTeX.full\*.*" "install_miktex.log"
!endif
!endif

	!insertmacro Reset_Config_MiKTeX

	!insertmacro Install_Config_MiKTeX

SectionEnd

Section "CTeX Addons" Section_Addons

	SetOverwrite On
	SetOutPath "$INSTDIR\${Addons_Dir}"

!ifndef BUILD_REPAIR
	${Install_Files} "Addons\CTeX\*.*" "install_ctex.log"
	${Install_Files} "Addons\CJK\*.*" "install_cjk.log"
	${Install_Files} "Addons\CCT\*.*" "install_cct.log"
	${Install_Files} "Addons\TY\*.*" "install_ty.log"
!endif

	!insertmacro Reset_Config_Addons

	!insertmacro Install_Config_Addons

SectionEnd

Section "Ghostscript" Section_Ghostscript

	SetOverwrite on
	SetOutPath "$INSTDIR\${Ghostscript_Dir}"

!ifndef BUILD_REPAIR
	${Install_Files} "Ghostscript\*.*" "install_ghostscript.log"
!endif

	!insertmacro Reset_Config_Ghostscript

	!insertmacro Install_Config_Ghostscript

SectionEnd

Section "GSview" Section_GSview

	SetOverwrite on
	SetOutPath "$INSTDIR\${GSview_Dir}"

!ifndef BUILD_REPAIR
	${Install_Files} "GSview\*.*" "install_gsview.log"
!endif

	!insertmacro Reset_Config_GSview

	!insertmacro Install_Config_GSview

SectionEnd

Section "WinEdt" Section_WinEdt

	SetOverwrite on
	SetOutPath "$INSTDIR\${WinEdt_Dir}"

!ifndef BUILD_REPAIR
	${Install_Files} "WinEdt\*.*" "install_winedt.log"
!endif

	!insertmacro Reset_Config_WinEdt

	!insertmacro Install_Config_WinEdt

	SectionGetFlags ${Section_MiKTeX} $R0
	IntOp $R0 $R0 & ${SF_SELECTED}
	${If} $R0 == ${SF_SELECTED}
		!insertmacro Associate_WinEdt_MiKTeX
	${EndIf}

SectionEnd

Section -FinishSection

	SetOverwrite on
	SetOutPath $INSTDIR

!ifndef BUILD_REPAIR
	${Begin_Install_Files}
	File Readme.txt
	File Changes.txt
	File Repair.exe
	${End_Install_Files} "install.log"
!endif

	!insertmacro Reset_Config_CTeX
	
	!insertmacro Install_Config_CTeX

	WriteUninstaller "$INSTDIR\Uninstall.exe"
	CreateDirectory "$SMPROGRAMS\CTeX"
	CreateShortCut "$SMPROGRAMS\CTeX\Uninstall CTeX.lnk" "$INSTDIR\Uninstall.exe"

	!insertmacro UPDATEFILEASSOC

	StrCpy $0 "$INSTDIR\${MiKTeX_Dir}\miktex\bin"
	ExecWait "$0\mpm.exe --register-components --quiet"
	ExecWait "$0\initexmf.exe --force --mklinks --quiet"
	ExecWait "$0\initexmf.exe --update-fndb --quiet"
	ExecWait "$0\initexmf.exe --mkmaps --quiet"

SectionEnd

; Modern install component descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_MiKTeX} $(Desc_MiKTeX)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_Addons} $(Desc_Addons)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_Ghostscript} $(Desc_Ghostscript)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_GSview} $(Desc_GSview)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_WinEdt} $(Desc_WinEdt)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;Uninstall section
Section Uninstall

	;Remove configs...
	ExecWait "$INSTDIR\${MiKTeX_Dir}\miktex\bin\mpm.exe --unregister-components --quiet"

	!insertmacro Uninstall_Config_CTeX

	!insertmacro Uninstall_Config_MiKTeX
	!insertmacro Uninstall_Config_Addons
	!insertmacro Uninstall_Config_Ghostscript
	!insertmacro Uninstall_Config_GSview
	!insertmacro Uninstall_Config_WinEdt

	; Delete self
	Delete "$INSTDIR\Uninstall.exe"

	; Delete Shortcuts
	RMDir /r "$SMPROGRAMS\CTeX"

	; Clean up CTeX
	!insertmacro UninstallAllFiles "un."

	; Remove remaining directories
	RMDir /r "$INSTDIR\${Logs_Dir}"
	MessageBox MB_YESNO $(Msg_RemoveInstDir) /SD IDNO IDNO +2
		RMDir /r $INSTDIR

	!insertmacro UPDATEFILEASSOC

SectionEnd

; On initialization
Function .onInit

	!insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

Function OnGUIInit

	ReadRegStr $0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\{7AB19E08-582F-4996-BB5D-7287222D25ED}" "UninstallString"
	${If} $0 != ""
		MessageBox MB_OK|MB_ICONSTOP "$(Msg_ObsoleteVersion)"
		Abort
	${EndIf}

	ReadRegStr $OLD_INSTDIR HKLM "Software\${APP_NAME}" "Install"
	ReadRegStr $OLD_VERSION HKLM "Software\${APP_NAME}" "Version"
	${If} $OLD_INSTDIR != ""
!ifdef BUILD_REPAIR
		${If} $OLD_VERSION != ${APP_BUILD}
			MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(Msg_WrongVersion)" /SD IDYES IDYES wrongversion
			Abort
wrongversion:
		${EndIf}
!else
		${If} $OLD_VERSION != ""
			${VersionCompare} $OLD_VERSION ${Obsolete_Version} $1
			${If} $1 == "2"
				MessageBox MB_OK|MB_ICONSTOP "$(Msg_ObsoleteVersion)"
				Abort
			${EndIf}
			${VersionCompare} $OLD_VERSION ${APP_BUILD} $1
			${If} $1 == "1"
				MessageBox MB_OK|MB_ICONEXCLAMATION "$(Msg_Downgrade)" /SD IDNO IDYES downgrade
				Abort
downgrade:
			${EndIf}
		${EndIf}
		StrCpy $INSTDIR $OLD_INSTDIR
!endif
	${EndIf}

	!insertmacro Get_Old_Version

FunctionEnd

!ifndef BUILD_REPAIR
Function ShowPageDirectory
	
  FindWindow $R0 "#32770" "" $HWNDPARENT
  GetDlgItem $R1 $R0 1019
    SendMessage $R1 ${EM_SETREADONLY} 1 0
  GetDlgItem $R1 $R0 1001
    EnableWindow $R1 0

FunctionEnd
!endif

!insertmacro Set_Version_Information

; Language strings
LicenseLangString license ${LANG_SIMPCHINESE} License-zh.txt
LicenseLangString license ${LANG_ENGLISH} License-en.txt

LangString Desc_MiKTeX ${LANG_SIMPCHINESE} "Windows下最好用的TeX系统之一，它带有一个很优秀的DVI预览器Yap。"
LangString Desc_MiKTeX ${LANG_ENGLISH} "One of the best TeX system on Windows platform, with an excellent DVI previewer Yap."
LangString Desc_Addons ${LANG_SIMPCHINESE} "中文TeX组件，包括CJK/CCT/TY和相应的字体设置，以及一些中文LaTeX宏包。"
LangString Desc_Addons ${LANG_ENGLISH} "Chinese TeX addons, including CJK/CCT/TY and their Chinese font settings, and several Chinese LaTeX packages."
LangString Desc_Ghostscript ${LANG_SIMPCHINESE} "PS (PostScript)语言和PDF文件的解释器，可在非PS打印机上打印它们。可以将PS文件和PDF文件相互转换。"
LangString Desc_Ghostscript ${LANG_ENGLISH} "PS (PostScript) and PDF interpreter."
LangString Desc_GSview ${LANG_SIMPCHINESE} "GSview是Ghostscript的图形界面程序，通过Ghostscript的支持，可以很方便地浏览和修改PS文件。"
LangString Desc_GSview ${LANG_ENGLISH} "GSview is the frontend GUI of Ghostscript, used with Ghostscript to view and edit PS (PostScript) file."
LangString Desc_WinEdt ${LANG_SIMPCHINESE} "WinEdt是一个编辑器，它内置了对TeX的良好支持。在它的菜单上和按钮上可以直接调用TeX程序，包括编译、预览等。WinEdt还能帮助你迅速输入各种TeX命令和符号，省去你记忆大量命令的烦恼。"
LangString Desc_WinEdt ${LANG_ENGLISH} "WinEdt a well designed text editor with full support to edit and compile TeX file."

LangString Desc_File ${LANG_SIMPCHINESE} "文档"
LangString Desc_File ${LANG_ENGLISH} "File"

LangString Msg_ObsoleteVersion ${LANG_SIMPCHINESE} "在系统中发现旧版的CTeX，请先卸载！"
LangString Msg_ObsoleteVersion ${LANG_ENGLISH} "Found obsolete version of CTeX installed in the system, please uninstall first!"
LangString Msg_WrongVersion ${LANG_SIMPCHINESE} "系统中安装了其他版本的CTeX，是否继续？"
LangString Msg_WrongVersion ${LANG_ENGLISH} "Another version of CTeX is installed in the system, continue?"
LangString Msg_Downgrade ${LANG_SIMPCHINESE} "系统中安装了更高版本的CTeX，是否继续进行降级安装？"
LangString Msg_Downgrade ${LANG_ENGLISH} "Newer version of CTeX is installed in the system, continue to downgrade setup?"
LangString Msg_RemoveInstDir ${LANG_SIMPCHINESE} "是否完全删除安装目录？"
LangString Msg_RemoveInstDir ${LANG_ENGLISH} "Remove all files in the installed diretory?"

; eof