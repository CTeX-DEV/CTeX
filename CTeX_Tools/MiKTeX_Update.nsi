
!include "LogicLib.nsh"
!include "WinMessages.nsh"

Name "MiKTeX Update"
OutFile "MiKTeX_Update.exe"

ShowInstDetails show

!include "MUI2.nsh"

!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL


!define VERSION "2.7"

Var MIKTEXDIR

Section -Begin
	ReadRegStr $R0 HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path"

	ReadRegStr $0 HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Install"
	ReadRegStr $1 HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "SharedSetup"
	ReadRegStr $2 HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "AutoInstall"
	ReadRegStr $3 HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RemoteRepository"
	ReadRegStr $4 HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RepositoryType"

	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "SharedSetup" "1"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "AutoInstall" "2"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RemoteRepository" "ftp://ftp.ctex.org/CTAN/systems/win32/miktex/tm/packages/"
	WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RepositoryType" "remote"
SectionEnd

Section "Update MiKTeX.basic"
	StrCpy $MIKTEXDIR "$EXEDIR\MiKTeX.basic"
	WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path" "$MIKTEXDIR\miktex\bin;$R0"
	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Install" "$MIKTEXDIR"
	CopyFiles "$MIKTEXDIR\miktex\config\update.dat" "$EXEDIR\Update_MiKTeX.basic.exe"
	ExecWait "$EXEDIR\Update_MiKTeX.basic.exe"
	Delete "$EXEDIR\Update_MiKTeX.basic.exe"
	ExecWait "$MIKTEXDIR\miktex\bin\mpm_mfc.exe"
SectionEnd

Section "Update MiKTeX.full"
	StrCpy $MIKTEXDIR "$EXEDIR\MiKTeX.full"
	WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path" "$MIKTEXDIR\miktex\bin;$R0"
	WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Install" "$MIKTEXDIR"
	CopyFiles "$MIKTEXDIR\miktex\config\update.dat" "$EXEDIR\Update_MiKTeX.full.exe"
	ExecWait "$EXEDIR\Update_MiKTeX.full.exe"
	Delete "$EXEDIR\Update_MiKTeX.full.exe"
	ExecWait "$MIKTEXDIR\miktex\bin\mpm_mfc.exe"
SectionEnd

Section -Finish
	WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "Path" "$R0"

	${If} $0 != ""
		WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "Install" "$0"
		WriteRegStr HKLM "Software\MiKTeX.org\MiKTeX\${VERSION}\Core" "SharedSetup" "$1"
		WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "AutoInstall" "$2"
		WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RemoteRepository" "$3"
		WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\${VERSION}\MPM" "RepositoryType" "$4"
	${Else}
		DeleteRegKey HKLM "Software\MiKTeX.org"
		DeleteRegKey HKCU "Software\MiKTeX.org"
	${EndIf}
SectionEnd
