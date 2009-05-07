
Name "CTeX Build"
OutFile "CTeX_Build.exe"

ShowInstDetails show

!include "MUI2.nsh"

!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL


!define Make "$PROGRAMFILES\NSIS\makensis.exe"
!define INI_File "$EXEDIR\CTeX_Build.ini"
!define INI_Sec "CTeX"
!define INI_Key "BuildNumber"


Var Build_Number

Section
	Call ReadBuildNumber
	Call WriteBuildNumber
SectionEnd

Section "Repair Tool" SectionRepair
	ExecWait "${Make} CTeX_Repair.nsi"
SectionEnd

Section "Update Tool" SectionUpdate
	ExecWait "${Make} CTeX_Update.nsi"
SectionEnd

Section "Basic Version" SectionBasic
	ExecWait "${Make} CTeX_Setup.nsi"
SectionEnd

Section "Full Version" SectionFull
	ExecWait "${Make} CTeX_Full.nsi"
SectionEnd

Section
	Call ReadBuildNumber
	Call UpdateBuildNumber
	Call WriteBuildNumber
SectionEnd

Function .onInit
  IntOp $0 ${SF_SELECTED} | ${SF_RO}
  SectionSetFlags ${SectionRepair} $0
  IntOp $0 ${SF_SELECTED} !
	SectionSetFlags ${SectionFull} $0
FunctionEnd

Function ReadBuildNumber
	ReadINIStr $Build_Number "${INI_File}" "${INI_Sec}" "${INI_Key}"
	${If} $Build_Number == ""
		StrCpy $Build_Number "0"
	${EndIf}
FunctionEnd

Function UpdateBuildNumber
	IntOp $Build_Number $Build_Number + 1
	WriteINIStr "${INI_File}" "${INI_Sec}" "${INI_Key}" $Build_Number
FunctionEnd

Function WriteBuildNumber
	FileOpen $0 "$EXEDIR\CTeX_Build.nsh" "w"
	FileWrite $0 '!define BUILD_NUMBER "$Build_Number"$\r$\n'
	FileClose $0
FunctionEnd
