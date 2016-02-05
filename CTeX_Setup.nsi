Unicode true

; Use compression
!ifdef BUILD_FULL
	SetCompressor /FINAL LZMA
	SetCompressorDictSize 128
!else
	SetCompressor /FINAL /SOLID LZMA
	SetCompressorDictSize 64
!endif

!include "libs\CTeX_Version.nsh"

; Functions and Macros
!include "libs\CTeX_Macros.nsh"

; Variables
Var UN_CONFIG_ONLY

; Main Install settings
Name "${APP_NAME} ${APP_VERSION}"
BrandingText "${APP_NAME} ${APP_BUILD} (C) ${APP_COMPANY}"

!ifndef BUILD_REPAIR
	InstallDir "C:\CTEX"
!ifndef BUILD_FULL
	OutFile "CTeX_${APP_BUILD}.exe"
!else
	OutFile "CTeX_${APP_BUILD}_Full.exe"
!endif
!endif

!ifdef BUILD_REPAIR
	InstallDir "$EXEDIR"
	OutFile "Repair.exe"
!endif

; Other settings
RequestExecutionLevel admin

; Modern interface settings
!include "MUI2.nsh"

!define MUI_ABORTWARNING
!ifndef BUILD_REPAIR
!define MUI_ICON "icons\CTeX.ico"
!else
!define MUI_ICON "icons\CTeX_Repair.ico"
!endif
!define MUI_UNICON "icons\CTeX_Uninst.ico"
!define MUI_CUSTOMFUNCTION_GUIINIT onMUIInit

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE $(license)
!insertmacro MUI_PAGE_COMPONENTS
!ifndef BUILD_REPAIR
!define MUI_PAGE_CUSTOMFUNCTION_SHOW PageDirectoryShow
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

Section -InitSection

	Call SectionInit

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
	${Install_Files} "Addons\Packages\*.*" "install_packages.log"
!endif

	!insertmacro Install_Config_Addons

; Install Chinese fonts
!ifndef BUILD_REPAIR
	DetailPrint "Run FontSetup"
	nsExec::Exec '$INSTDIR\${Addons_Dir}\ctex\bin\FontSetup.exe /S /LANG=$LANGUAGE /CTEXSETUP="$INSTDIR\${Addons_Dir}"'
!endif
SectionEnd

Section "Ghostscript" Section_Ghostscript

	SetOverwrite on
	SetOutPath "$INSTDIR\${Ghostscript_Dir}"

!ifndef BUILD_REPAIR
	${Install_Files} "Ghostscript\*.*" "install_ghostscript.log"
!endif

	!insertmacro Install_Config_Ghostscript

SectionEnd

Section "GSview" Section_GSview

	SetOverwrite on
	SetOutPath "$INSTDIR\${GSview_Dir}"

!ifndef BUILD_REPAIR
	${Install_Files} "GSview\*.*" "install_gsview.log"
!endif

	!insertmacro Install_Config_GSview

SectionEnd

Section "WinEdt" Section_WinEdt

	SetOverwrite on
	SetOutPath "$INSTDIR\${WinEdt_Dir}"

!ifndef BUILD_REPAIR
	${Install_Files} "WinEdt\*.*" "install_winedt.log"
!endif

	!insertmacro Install_Config_WinEdt

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

	!insertmacro Install_Config_CTeX

	WriteUninstaller "$INSTDIR\Uninstall.exe"
	CreateDirectory "$SMCTEX"
	CreateShortCut "$SMCTEX\Uninstall CTeX.lnk" "$INSTDIR\Uninstall.exe"

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
	!insertmacro Uninstall_All_Configs "un."

	${If} $UN_CONFIG_ONLY != ""
		Return
	${EndIf}

	; Clean up CTeX
	!insertmacro Uninstall_All_Files "un."

	; Delete self
	Delete "$UN_INSTDIR\Uninstall.exe"

	; Remove remaining directories
	RMDir $UN_INSTDIR
	${If} ${FileExists} $UN_INSTDIR
		MessageBox MB_YESNO $(Msg_RemoveInstDir) /SD IDNO IDNO +2
			RMDir /r $UN_INSTDIR
	${EndIf}

SectionEnd

; On initialization
Function .onInit

	!insertmacro MUI_LANGDLL_DISPLAY

	!insertmacro Get_StartMenu_Dir
	!insertmacro Get_Uninstall_Information
	!insertmacro Restore_Install_Information
	!insertmacro Set_All_Sections_Selection
	
!ifdef BUILD_REPAIR
	!insertmacro Set_All_Sections_ReadOnly
!endif

	${If} ${Silent}
		Call onMUIInit
	${EndIf}

FunctionEnd

Function onMUIInit

	!insertmacro Check_Obsolete_Version
	!insertmacro Check_Update_Version
	!insertmacro Check_Admin_Rights

FunctionEnd

Function un.onInit
	${GetParameters} $R0
	${GetOptions} $R0 "/CONFIG_ONLY=" $UN_CONFIG_ONLY

	!insertmacro Get_StartMenu_Dir
	!insertmacro Get_Uninstall_Information
	!insertmacro Update_Uninstall_Information

FunctionEnd

Function SectionInit

!ifndef BUILD_REPAIR
	!insertmacro Update_Install_Information
!else
	!insertmacro Update_All_Logs
!endif

	DetailPrint "Remove old installation"
	${If} $UN_INSTDIR != ""
	${AndIf} ${FileExists} "$UN_INSTDIR\Uninstall.exe"
!ifdef BUILD_REPAIR
		StrCpy $R0 "/CONFIG_ONLY=yes"
!else
		StrCpy $R0 ""
!endif
		nsExec::Exec "$UN_INSTDIR\Uninstall.exe /S $R0 _?=$UN_INSTDIR"
	${Else}
		!insertmacro Uninstall_All_Configs ""
!ifndef BUILD_REPAIR
		!insertmacro Uninstall_All_Files ""
!endif
	${EndIf}

FunctionEnd

!ifndef BUILD_REPAIR
Function PageDirectoryShow

	${If} $UN_INSTDIR != ""
		FindWindow $R0 "#32770" "" $HWNDPARENT
		GetDlgItem $R1 $R0 1019
			SendMessage $R1 ${EM_SETREADONLY} 1 0
		GetDlgItem $R1 $R0 1001
			EnableWindow $R1 0
	${EndIf}

FunctionEnd
!endif

!insertmacro Set_Version_Information

; Language strings
LicenseLangString license ${LANG_SIMPCHINESE} "license\zh.txt"
LicenseLangString license ${LANG_ENGLISH} "license\en.txt"

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

LangString Msg_AdminRequired ${LANG_SIMPCHINESE} "安装本程序需要管理员权限！"
LangString Msg_AdminRequired ${LANG_ENGLISH} "Adminstrator rights are required to install the program!"
LangString Msg_ObsoleteVersion ${LANG_SIMPCHINESE} "在系统中发现旧版的CTeX，请先卸载！"
LangString Msg_ObsoleteVersion ${LANG_ENGLISH} "Found obsolete version of CTeX installed in the system, please uninstall first!"
LangString Msg_WrongVersion ${LANG_SIMPCHINESE} "系统中安装了其他版本的CTeX，是否继续？"
LangString Msg_WrongVersion ${LANG_ENGLISH} "Another version of CTeX is installed in the system, continue?"
LangString Msg_Downgrade ${LANG_SIMPCHINESE} "系统中安装了更高版本的CTeX，是否继续进行降级安装？"
LangString Msg_Downgrade ${LANG_ENGLISH} "Newer version of CTeX is installed in the system, continue to downgrade setup?"
LangString Msg_RemoveInstDir ${LANG_SIMPCHINESE} "是否完全删除安装目录？"
LangString Msg_RemoveInstDir ${LANG_ENGLISH} "Remove all files in the installed diretory?"
LangString Msg_FontSetup ${LANG_SIMPCHINESE} "是否运行中文字体安装程序？"
LangString Msg_FontSetup ${LANG_ENGLISH} "Run the Chinese font setup program?"

; eof