
!include "CTeX_Build.nsh"

; Application information
!define APP_NAME "CTeX"
!define APP_COMPANY "CTEX.ORG"
!define APP_COPYRIGHT "Copyright (C) 2009 ${APP_COMPANY}"
!define APP_VERSION "2.7.0"
!define APP_BUILD "${APP_VERSION}.${BUILD_NUMBER}"

; Components information
!define MiKTeX_Dir          "MiKTeX"
!define MiKTeX_Version      "2.7"
!define Addons_Dir          "CTeX"
!define Ghostscript_Dir     "Ghostscript"
!define Ghostscript_Version "8.64"
!define GSview_Dir          "GSview"
!define GSview_Version      "4.9"
!define WinEdt_Dir          "WinEdt"
!define WinEdt_Version      "5.5"
!define Logs_Dir            "Logs"

!define Obsolete_Version    "2.7.0.0"


!macro Set_Version_Information
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "ProductName" "${APP_NAME}"
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "CompanyName" "${APP_COMPANY}"
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileDescription" "ÖÐÎÄTeXÌ××°"
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileVersion" "${APP_BUILD}"
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "LegalCopyright" "${APP_COPYRIGHT}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${APP_NAME}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${APP_COMPANY}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Chinese TeX Suite"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${APP_BUILD}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "${APP_COPYRIGHT}"
	VIProductVersion "${APP_BUILD}"
!macroend

!macro Get_Old_Version
	${If} $OLD_INSTDIR != ""
		StrCpy $0 0

		${VersionCompare} $OLD_VERSION "2.7.1.0" $1
		${If} $1 == "2"
			StrCpy $OLD_MiKTeX_Version      "2.7"
			StrCpy $OLD_Ghostscript_Version "8.64"
			StrCpy $OLD_GSview_Version      "4.9"
			StrCpy $OLD_WinEdt_Version      "5.5"
			StrCpy $0 1
		${EndIf}

		${If} $0 == 0
			StrCpy $OLD_MiKTeX_Version      "${MiKTeX_Version}"
			StrCpy $OLD_Ghostscript_Version "${Ghostscript_Version}"
			StrCpy $OLD_GSview_Version      "${GSview_Version}"
			StrCpy $OLD_WinEdt_Version      "${WinEdt_Version}"
		${EndIf}
	${EndIf}
!macroend
