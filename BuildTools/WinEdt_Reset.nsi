
Name "WinEdt Reset"
OutFile "WinEdt_Reset.exe"

ShowInstDetails nevershow

!include "MUI2.nsh"

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL


Section
	DeleteRegKey HKCU "Software\WinEdt"
	Delete "C:\CTEX\WinEdt\WinEdt.skd"
SectionEnd
