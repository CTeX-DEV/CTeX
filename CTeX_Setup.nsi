
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
!define MUI_CUSTOMFUNCTION_GUIINIT OnInit

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

Section "MiKTeX" Section_MiKTeX

	SetOverwrite on
	SetOutPath "$INSTDIR\${MiKTeX_Dir}"

!ifndef BUILD_REPAIR
!ifndef BUILD_FULL
	File /r MiKTeX.basic\*.*
!else
	File /r MiKTeX.full\*.*
!endif
!endif

	!insertmacro Reset_Reg_MiKTeX

	!insertmacro Install_Reg_MiKTeX
	!insertmacro Install_Link_MiKTeX

SectionEnd

Section "CTeX Addons" Section_Addons

	SetOverwrite On
	SetOutPath "$INSTDIR\${Addons_Dir}"

!ifndef BUILD_REPAIR
	File /r Addons\CTeX\*.*
	File /r Addons\CJK\*.*
	File /r Addons\CCT\*.*
	File /r Addons\TY\*.*
!endif

	!insertmacro Reset_Reg_Addons

	!insertmacro Install_Reg_Addons

SectionEnd

Section "Ghostscript" Section_Ghostscript

	SetOverwrite on
	SetOutPath "$INSTDIR\${Ghostscript_Dir}"

!ifndef BUILD_REPAIR
	File /r Ghostscript\*.*
!endif

	!insertmacro Reset_Reg_Ghostscript

	!insertmacro Install_Reg_Ghostscript
	!insertmacro Install_Link_Ghostscript

SectionEnd

Section "GSview" Section_GSview

	SetOverwrite on
	SetOutPath "$INSTDIR\${GSview_Dir}"

!ifndef BUILD_REPAIR
	File /r GSview\*.*
!endif

	!insertmacro Reset_Reg_GSview

	!insertmacro Install_Reg_GSview
	!insertmacro Install_Link_GSview

SectionEnd

Section "WinEdt" Section_WinEdt

	SetOverwrite on
	SetOutPath "$INSTDIR\${WinEdt_Dir}"

!ifndef BUILD_REPAIR
	File /r WinEdt\*.*
!endif

	!insertmacro Reset_Reg_WinEdt

	!insertmacro Install_Reg_WinEdt
	!insertmacro Install_Link_WinEdt

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
	File Readme.txt
	File Changes.txt
	File Repair.exe
!endif

	!insertmacro Reset_Reg_CTeX
	
	!insertmacro Install_Reg_CTeX

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

	;Remove from registry...
	!insertmacro Uninstall_Reg_CTeX

	ExecWait "$INSTDIR\${MiKTeX_Dir}\miktex\bin\mpm.exe --unregister-components --quiet"

	!insertmacro Uninstall_Reg_MiKTeX
	!insertmacro Uninstall_Reg_Addons
	!insertmacro Uninstall_Reg_Ghostscript
	!insertmacro Uninstall_Reg_GSview
	!insertmacro Uninstall_Reg_WinEdt

	; Delete self
	Delete "$INSTDIR\Uninstall.exe"

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

Function OnInit

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
!endif
	${Else}
		StrCpy $OLD_INSTDIR $INSTDIR
		StrCpy $OLD_VERSION ${APP_BUILD}
	${EndIf}
	
	!insertmacro Get_Old_Version

FunctionEnd

!insertmacro Set_Version_Information

; Language strings
LicenseLangString license ${LANG_SIMPCHINESE} License-zh.txt
LicenseLangString license ${LANG_ENGLISH} License-en.txt

LangString Desc_MiKTeX ${LANG_SIMPCHINESE} "Windows������õ�TeXϵͳ֮һ��������һ���������DVIԤ����Yap��"
LangString Desc_MiKTeX ${LANG_ENGLISH} "One of the best TeX system on Windows platform, with an excellent DVI previewer Yap."
LangString Desc_Addons ${LANG_SIMPCHINESE} "����TeX���������CJK/CCT/TY����Ӧ���������ã��Լ�һЩ����LaTeX�����"
LangString Desc_Addons ${LANG_ENGLISH} "Chinese TeX addons, including CJK/CCT/TY and their Chinese font settings, and several Chinese LaTeX packages."
LangString Desc_Ghostscript ${LANG_SIMPCHINESE} "PS (PostScript)���Ժ�PDF�ļ��Ľ����������ڷ�PS��ӡ���ϴ�ӡ���ǡ����Խ�PS�ļ���PDF�ļ��໥ת����"
LangString Desc_Ghostscript ${LANG_ENGLISH} "PS (PostScript) and PDF interpreter."
LangString Desc_GSview ${LANG_SIMPCHINESE} "GSview��Ghostscript��ͼ�ν������ͨ��Ghostscript��֧�֣����Ժܷ����������޸�PS�ļ���"
LangString Desc_GSview ${LANG_ENGLISH} "GSview is the frontend GUI of Ghostscript, used with Ghostscript to view and edit PS (PostScript) file."
LangString Desc_WinEdt ${LANG_SIMPCHINESE} "WinEdt��һ���༭�����������˶�TeX������֧�֡������Ĳ˵��ϺͰ�ť�Ͽ���ֱ�ӵ���TeX���򣬰������롢Ԥ���ȡ�WinEdt���ܰ�����Ѹ���������TeX����ͷ��ţ�ʡȥ������������ķ��ա�"
LangString Desc_WinEdt ${LANG_ENGLISH} "WinEdt a well designed text editor with full support to edit and compile TeX file."

LangString Desc_File ${LANG_SIMPCHINESE} "�ĵ�"
LangString Desc_File ${LANG_ENGLISH} "File"

LangString Msg_ObsoleteVersion ${LANG_SIMPCHINESE} "��ϵͳ�з��־ɰ��CTeX������ж�أ�"
LangString Msg_ObsoleteVersion ${LANG_ENGLISH} "Found obsolete version of CTeX installed in the system, please uninstall first!"
LangString Msg_WrongVersion ${LANG_SIMPCHINESE} "ϵͳ�а�װ�������汾��CTeX���Ƿ������"
LangString Msg_WrongVersion ${LANG_ENGLISH} "Another version of CTeX is installed in the system, continue?"
LangString Msg_Downgrade ${LANG_SIMPCHINESE} "ϵͳ�а�װ�˸��߰汾��CTeX���Ƿ�������н�����װ��"
LangString Msg_Downgrade ${LANG_ENGLISH} "Newer version of CTeX is installed in the system, continue to downgrade setup?"

; eof