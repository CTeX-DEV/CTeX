
!ifndef StrLoc_INCLUDED
	${StrLoc}
!endif
!ifndef UnStrLoc_INCLUDED
	${UnStrLoc}
!endif
!define un.StrLoc "${UnStrLoc}"


!macro _Uninstall_Files Log_File
	Push ${Log_File}
	Call UninstallByLog
	Delete ${Log_File}
!macroend
!define Uninstall_Files "!insertmacro _Uninstall_Files"

!macro _unUninstall_Files Log_File
	Push ${Log_File}
	Call un.UninstallByLog
	Delete ${Log_File}
!macroend
!define un.Uninstall_Files "!insertmacro _unUninstall_Files"


!macro Define_Func_UninstallByLog UN

Function ${UN}UninstallByLog
	Exch $R0 ; log file
	Push $R1
	Push $R2
	Push $R3
	Push $R4
	Push $R5
	Push $R6
	Push $R7
	Push $R8
	Push $R9
	Push $0
	Push $1
	Push $2
	Push $3
	Push $4
	Push $5
	Push $6
	Push $7
	Push $8
	Push $9

	GetTempFileName $R1
	GetTempFileName $R2
	FileOpen $0 "$R0" "r"
	FileOpen $1 "$R1" "w"
	${Do}
		FileRead $0 $9
		${If} $9 == ""
			${ExitDo}
		${EndIf}
		StrCpy $8 $9 11
		${If} $8 == "File: wrote"
			${${UN}StrLoc} $7 $9 '"' ">"
			${If} $7 != ""
				IntOp $7 $7 + 1
				StrCpy $6 $9 "" $7
				${${UN}StrLoc} $5 $6 '"' ">"
				${If} $5 != ""
					StrCpy $4 $6 $5
					Delete $4
				${EndIf}
			${EndIf}
		${ElseIf} $8 == "CreateDirec"
			${${UN}StrLoc} $7 $9 '"' ">"
			${If} $7 != ""
				IntOp $7 $7 + 1
				StrCpy $6 $9 "" $7
				${${UN}StrLoc} $5 $6 '" (1)' ">"
				${If} $5 != ""
					StrCpy $4 $6 $5
					FileWrite $1 "$4$\r$\n"
				${EndIf}
			${EndIf}
		${EndIf}
	${Loop}
	FileClose $1
	FileClose $0

	FileOpen $R9 "$R2" "w"
	${${UN}FileReadFromEnd} "$R1" "${UN}UninstallByLogReversal"
	FileClose $R9

	FileOpen $0 "$R2" "r"
	${Do}
		FileRead $0 $9
		${If} $9 == ""
			${ExitDo}
		${EndIf}
		StrCpy $9 $9 -2
		RMDir $9
	${Loop}
	FileClose $0

	Delete "$R2"
	Delete "$R1"

	Pop $9
	Pop $8
	Pop $7
	Pop $6
	Pop $5
	Pop $4
	Pop $3
	Pop $2
	Pop $1
	Pop $0
	Pop $R9
	Pop $R8
	Pop $R7
	Pop $R6
	Pop $R5
	Pop $R4
	Pop $R3
	Pop $R2
	Pop $R1
	Pop $R0
FunctionEnd

Function ${UN}UninstallByLogReversal
	FileWrite $R9 "$9"
	Push $0
FunctionEnd

!macroend

!insertmacro Define_Func_UninstallByLog ""
!insertmacro Define_Func_UninstallByLog "un."
