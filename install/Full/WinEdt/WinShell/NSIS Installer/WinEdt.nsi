;WinEdt NSIS Install Script
;--------------------------------
;Header Files

!include "x64.nsh"
!include "MUI2.nsh"
!include "FileFunc.nsh"

;--------------------------------
;Constants

!define MUI_PRODUCT "WinEdt 10"
!define MUI_VERSION "10.0"
!define MUI_BUILD "20160317"
!define MUI_COMPANY "WinEdt Team"

;--------------------------------
;Variables

Var StartMenuFolder
Var dialog
Var checkbox1
Var checkbox2
Var checkbox3
Var checkbox4
Var label1
Var label2
Var label3
Var label4
Var radiobutton1
Var radiobutton2
Var UserProfile
Var DesktopIcon
Var StartMenuIcon
Var AssociateFiles
Var UserProfileFolder
Var Registration
Var RegData
Var AccountType
Var RegAccountType
Var SystemAccountType
Var InstallAdmin
Var OldInstallLocation
Var OldStartMenuFolder
Var OldWinEdt

;--------------------------------
;Installer Attributes

VIProductVersion "${MUI_VERSION}.0.0"
VIAddVersionKey ProductName "${MUI_PRODUCT}"
VIAddVersionKey CompanyName "${MUI_COMPANY}"
VIAddVersionKey LegalCopyright "Copyright (C) 1993-2016 by Aleksander Simonic"
VIAddVersionKey FileDescription "${MUI_PRODUCT} Setup"
VIAddVersionKey FileVersion "${MUI_VERSION}.0.0"
VIAddVersionKey ProductVersion "${MUI_VERSION} Build: ${MUI_BUILD}"

;--------------------------------
;Configuration

SetCompressor /SOLID LZMA

Name "${MUI_PRODUCT}"
!ifndef WINEDT_32
      OutFile "winedt100-64.exe"
!else
      OutFile "winedt100-32.exe"
!endif

ShowInstDetails nevershow
ShowUninstDetails nevershow

RequestExecutionLevel highest
ManifestDPIAware true

;--------------------------------
;Interface

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING
!define MUI_ICON "install.ico"
!define MUI_UNICON "install.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "WinEdt.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "side.bmp"

BrandingText "${MUI_COMPANY}"

;--------------------------------
;Installer Pages

!insertmacro MUI_PAGE_WELCOME

!define MUI_LICENSEPAGE_CHECKBOX
!insertmacro MUI_PAGE_LICENSE "License.rtf"

!define MUI_PAGE_HEADER_TEXT "Information"
!define MUI_PAGE_HEADER_SUBTEXT "Please read the following information before continuing."
!define MUI_LICENSEPAGE_TEXT_TOP "Press Page Down to see the rest of the information."
!define MUI_LICENSEPAGE_TEXT_BOTTOM "When you are ready, click Next to continue."
!define MUI_LICENSEPAGE_BUTTON "Next >"
!insertmacro MUI_PAGE_LICENSE "Readme.rtf"

Page custom InstallType InstallTypeLeave

!insertmacro MUI_PAGE_DIRECTORY

!define MUI_STARTMENUPAGE_DEFAULTFOLDER "${MUI_PRODUCT}"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\${MUI_PRODUCT}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "StartMenuFolder"
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

Page custom AdditionalTasks AdditionalTasksLeave

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_RUN "$INSTDIR\WinEdt.exe"
!define MUI_FINISHPAGE_RUN_PARAMETERS ""
!define MUI_FINISHPAGE_RUN_TEXT "Launch WinEdt"
!insertmacro MUI_PAGE_FINISH

;--------------------------------
;Uninstaller Pages

UninstPage custom un.AdditionalTasks un.AdditionalTasksLeave

!insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages

!insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Full"

  ;Copy Files
  SetOutPath "$INSTDIR"
        File /r /x "WinEdt-Lock.*" /x "User.dic" /x "WinEdt-64.exe" /x "WinEdt-32.exe" "WinEdt\*.*"
        !ifndef WINEDT_32
              File /oname=WinEdt.exe "WinEdt\WinEdt-64.exe"
        !else
              File /oname=WinEdt.exe "WinEdt\WinEdt-32.exe"
        !endif
  ${If} ${FileExists} "$EXEDIR\WinEdt.skd"
        CopyFiles /SILENT /FILESONLY $EXEDIR\WinEdt.skd $INSTDIR
  ${EndIf}
  SetOverwrite off
        File "WinEdt\WinEdt-Lock.*"
  SetOutPath "$INSTDIR\Dict"
        File "WinEdt\Dict\User.dic"
  ${If} $UserProfile != 1
        SetOutPath "$INSTDIR\Local"
              File "WinEdt\WinEdt.dnt"
  ${EndIf}
  SetOverwrite on
  SetOutPath "$INSTDIR\WinShell\NSIS Installer"
        File "WinEdt.nsi"
        File "FileTypes.nsi"
        File "install.ico"
        File "WinEdt.bmp"
        File "side.bmp"
        File "License.rtf"
        File "Readme.rtf"
  ${If} $UserProfile == 1
        SetOutPath "$INSTDIR\WinShell"
              File "WinEdt\WinShell\Profiles\Create Startup User Profile.edt"
  ${EndIf}

  ;Create Uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ;Create Shortcuts
  SetOutPath "$INSTDIR"
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\WinEdt.lnk" "$INSTDIR\WinEdt.exe"
  CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall WinEdt.lnk" "$INSTDIR\Uninstall.exe"
  !insertmacro MUI_STARTMENU_WRITE_END

  ${If} $DesktopIcon == 1
        CreateShortCut "$DESKTOP\${MUI_PRODUCT}.lnk" "$INSTDIR\WinEdt.exe"
  ${EndIf}
  ${If} $StartMenuIcon == 1
        CreateShortCut "$SMPROGRAMS\${MUI_PRODUCT}.lnk" "$INSTDIR\WinEdt.exe"
  ${EndIf}

  ;Create Filetype Associations
  ${If} $AssociateFiles == 1
        ${If} $AccountType == "Admin"
              Call AssociateAdmin
        ${Else}
              Call AssociateUser
        ${EndIf}
  ${EndIf}

  ;WinEdt Registry Key (YAP uses this one!)
  WriteRegStr HKCU "Software\WinEdt" "Install Root" "$INSTDIR"

  ;Registry Keys
  WriteRegStr HKCU "Software\${MUI_PRODUCT}" "Install Root" "$INSTDIR"
  WriteRegStr HKCU "Software\${MUI_PRODUCT}" "AccountType" "$AccountType"

  ;Config Info
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "InstallLocation" "$INSTDIR"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "StartMenuFolder" "$StartMenuFolder"
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "UserProfile" "$UserProfile"
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "StartMenuIcon" "$StartMenuIcon"
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "DesktopIcon" "$DesktopIcon"
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "AssociateFiles" "$AssociateFiles"

  ;Uninstall Info
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "" "WinEdt ${MUI_VERSION} Build: ${MUI_BUILD}"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "DisplayName" "${MUI_PRODUCT}"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "DisplayIcon" "$INSTDIR\WinEdt.exe"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "DisplayVersion" "${MUI_VERSION}"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "Publisher" "${MUI_COMPANY}"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "UrlInfoAbout" "http://www.winedt.com"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "HelpLink" "http://www.winedt.com/support.html"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "Contact" "support@winedt.com"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "NoModify" "1"
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "NoRepair" "1"

SectionEnd

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;Remove Files
  RMDir /r "$INSTDIR\Bitmaps"
  RMDir /r "$INSTDIR\Config"
  RMDir /r "$INSTDIR\ConfigEx"
  RMDir /r "$INSTDIR\Dict"
  RMDir /r "$INSTDIR\Doc"
  RMDir /r "$INSTDIR\Exec"
  RMDir /r "$INSTDIR\Local"
  RMDir /r "$INSTDIR\Macros"
  RMDir /r "$INSTDIR\Menus"
  RMDir /r "$INSTDIR\MUI"
  RMDir /r "$INSTDIR\Samples"
  RMDir /r "$INSTDIR\Templates"
  RMDir /r "$INSTDIR\WinShell"
  Delete "$INSTDIR\*.*"
  RMDir "$INSTDIR"

  ${GetParent} "$INSTDIR" $0
  ${GetFileName} $0 $1
  ${If} $1 == "${MUI_COMPANY}"
        RMDir $0
  ${EndIf}

  ;Remove Shortcuts
  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
  RMDir /r "$SMPROGRAMS\$StartMenuFolder"

  ${If} $DesktopIcon == 1
        Delete "$DESKTOP\${MUI_PRODUCT}.lnk"
  ${EndIf}
  ${If} $StartMenuIcon == 1
        Delete "$SMPROGRAMS\${MUI_PRODUCT}.lnk"
  ${EndIf}

  ;Remove Filetype Associations
  ${If} $AssociateFiles == 1
        ${If} $AccountType == "Admin"
              Call un.AssociateAdmin
        ${Else}
              Call un.AssociateUser
        ${EndIf}
  ${EndIf}

  ;Remove WinEdt Registry Key
  ReadRegStr $OldWinEdt HKCU "Software\WinEdt" "ApplData"
  ${If} $OldWinEdt == ""
        DeleteRegKey HKCU "Software\WinEdt"
  ${EndIf}

  ;Remove Registry Keys
  DeleteRegValue HKCU "Software\${MUI_PRODUCT}" "Install Root"
  DeleteRegValue HKCU "Software\${MUI_PRODUCT}" "Inst"
  DeleteRegValue HKCU "Software\${MUI_PRODUCT}" "Install Build"
  DeleteRegValue HKCU "Software\${MUI_PRODUCT}" "AccountType"
  DeleteRegValue HKCU "Software\${MUI_PRODUCT}" "StartMenuFolder"

  ;Remove Uninstall Info
  DeleteRegKey SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}"

  ;Remove User Profile
  SetShellVarContext current

  ${If} $UserProfile == 1
        DeleteRegValue HKCU "Software\${MUI_PRODUCT}" "AppData"
        RMDir /r "$UserProfileFolder"
        RMDir /r "$APPDATA\${MUI_COMPANY}\${MUI_PRODUCT}"
        RMDir "$APPDATA\${MUI_COMPANY}"
  ${Else}
        ${If} $UserProfileFolder != "$APPDATA\${MUI_COMPANY}\${MUI_PRODUCT}"
              RMDir /r "$APPDATA\${MUI_COMPANY}\${MUI_PRODUCT}"
              RMDir "$APPDATA\${MUI_COMPANY}"
        ${EndIf}
  ${EndIf}

  ;Remove Registration Data
  ${If} $RegData == 1
        DeleteRegValue HKCU "Software\${MUI_PRODUCT}" "Code"
        DeleteRegValue HKCU "Software\${MUI_PRODUCT}" "Date"
        DeleteRegValue HKCU "Software\${MUI_PRODUCT}" "Name"
  ${EndIf}

  ;Clean Registry
  ${If} $UserProfileFolder == ""
        StrCpy $UserProfile "1"
  ${EndIf}
  ${If} $Registration == ""
        StrCpy $RegData "1"
  ${EndIf}
  ${If} $UserProfile == 1
  ${AndIf} $RegData == 1
        DeleteRegKey HKCU "Software\${MUI_PRODUCT}"
  ${EndIf}

SectionEnd

;--------------------------------
;Installer Functions

Function InstallType

  !insertmacro MUI_HEADER_TEXT "Select Installation Type" "Choose if you want an admin or a private installation."

  nsDialogs::Create 1018
        Pop $dialog
  ${NSD_CreateLabel} 0 0 100% 12% "Select 'Admin installation' to install ${MUI_PRODUCT} for all users or 'Private installation' to install ${MUI_PRODUCT} \
                                   only for current user. Click Next to continue."
        Pop $label1
  ${NSD_CreateLabel} 0 20% 100% 6% "Installation type"
        Pop $label2
  ${NSD_CreateRadioButton} 5% 30% 100% 6% "Admin installation"
        Pop $radiobutton1
  ${NSD_CreateRadioButton} 5% 40% 100% 6% "Private installation"
        Pop $radiobutton2
        ${If} $AccountType == "Admin"
              ${NSD_Check} $radiobutton1
        ${Else}
              ${NSD_Check} $radiobutton2
        ${EndIf}
  GetFunctionAddress $0 InstallTypeLeave
  nsDialogs::OnBack $0
  nsDialogs::Show

FunctionEnd

Function InstallTypeLeave

  ${NSD_GetState} $radiobutton1 $InstallAdmin

  ${If} $InstallAdmin == 1
  ${AndIf} $SystemAccountType != "Admin"
        MessageBox MB_ICONEXCLAMATION|MB_OK "You don't have Admin privileges!"
        ${NSD_Uncheck} $radiobutton1
        ${NSD_Check} $radiobutton2
        Abort
  ${EndIf}
  ${If} $InstallAdmin == 1
  ${AndIf} $RegAccountType == "User"
        MessageBox MB_ICONEXCLAMATION|MB_OK "You already have a Private installation.$\r\
                                             Please uninstall if you want to perform an Admin installation!"
        ${NSD_Uncheck} $radiobutton1
        ${NSD_Check} $radiobutton2
        Abort
  ${EndIf}
  ${If} $InstallAdmin == 0
  ${AndIf} $RegAccountType == "Admin"
        MessageBox MB_ICONEXCLAMATION|MB_OK "You already have an Admin installation.$\r\
                                             Please uninstall if you want to perform a Private installation!"
        ${NSD_Check} $radiobutton1
        ${NSD_Uncheck} $radiobutton2
        Abort
  ${EndIf}

  ${If} $InstallAdmin == 1
        StrCpy $AccountType "Admin"
        SetShellVarContext all
  ${Else}
        StrCpy $AccountType "User"
        SetShellVarContext current
  ${EndIf}

  ;Default Installation Folder
  ReadRegStr $OldInstallLocation SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "InstallLocation"
  ${If} $OldInstallLocation != ""
        StrCpy $INSTDIR $OldInstallLocation
  ${Else}
        ${If} $AccountType == "Admin"
              ${If} $INSTDIR == ""
                    !ifndef WINEDT_32
                          StrCpy $INSTDIR "$PROGRAMFILES64\${MUI_COMPANY}\${MUI_PRODUCT}"
                    !else
                          StrCpy $INSTDIR "$PROGRAMFILES\${MUI_COMPANY}\${MUI_PRODUCT}"
                    !endif
              ${EndIf}
        ${Else}
              ${If} $INSTDIR == ""
                    StrCpy $INSTDIR "$PROFILE\${MUI_COMPANY}\${MUI_PRODUCT}"
              ${EndIf}
        ${EndIf}
  ${EndIf}

  ;Default Start Menu Folder
  ReadRegStr $OldStartMenuFolder SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "StartMenuFolder"
  ${If} $OldStartMenuFolder != ""
        StrCpy $StartMenuFolder $OldStartMenuFolder
  ${EndIf}

  ReadRegDWORD $UserProfile SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "UserProfile"
  ReadRegDWORD $StartMenuIcon SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "StartMenuIcon"
  ReadRegDWORD $DesktopIcon SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "DesktopIcon"
  ReadRegDWORD $AssociateFiles SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "AssociateFiles"

FunctionEnd

Function AdditionalTasks

  !insertmacro MUI_HEADER_TEXT "Select Additional Tasks" "Select the additional tasks you would like to be performed."

  nsDialogs::Create 1018
        Pop $dialog
  ${NSD_CreateLabel} 0 0 100% 12% "Setup will perform selected additional tasks after installing ${MUI_PRODUCT}. Click Install to start the installation."
        Pop $label1
  ${NSD_CreateLabel} 0 20% 100% 6% "User Profiles"
        Pop $label2
  ${NSD_CreateCheckBox} 5% 30% 100% 6% "Enable User Profile creation"
        Pop $checkbox1
        ${If} $UserProfile != ""
              ${NSD_SetState} $checkbox1 $UserProfile
        ${Else}
              ${NSD_Check} $checkbox1
        ${EndIf}
  ${NSD_CreateLabel} 0 45% 100% 6% "Additional Shortcuts"
        Pop $label3
  ${NSD_CreateCheckBox} 5% 55% 100% 6% "Create a Start Menu icon"
        Pop $checkbox2
        ${If} $StartMenuIcon != ""
              ${NSD_SetState} $checkbox2 $StartMenuIcon
        ${Else}
              ${NSD_Check} $checkbox2
        ${EndIf}
  ${NSD_CreateCheckBox} 5% 65% 100% 6% "Create a Desktop icon"
        Pop $checkbox3
        ${If} $DesktopIcon != ""
              ${NSD_SetState} $checkbox3 $DesktopIcon
        ${Else}
              ${NSD_Check} $checkbox3
        ${EndIf}
  ${NSD_CreateLabel} 0 80% 100% 6% "Filetypes Association"
        Pop $label4
  ${NSD_CreateCheckBox} 5% 90% 100% 6% "Associate TeX Filetypes with WinEdt"
        Pop $checkbox4
        ${If} $AssociateFiles != ""
              ${NSD_SetState} $checkbox4 $AssociateFiles
        ${EndIf}
  GetFunctionAddress $0 AdditionalTasksLeave
  nsDialogs::OnBack $0
  nsDialogs::Show

FunctionEnd

Function AdditionalTasksLeave

  ${NSD_GetState} $checkbox1 $UserProfile
  ${NSD_GetState} $checkbox2 $StartMenuIcon
  ${NSD_GetState} $checkbox3 $DesktopIcon
  ${NSD_GetState} $checkbox4 $AssociateFiles

FunctionEnd

;--------------------------------
;Uninstaller Functions

Function un.AdditionalTasks

  !insertmacro MUI_HEADER_TEXT "Uninstall ${MUI_PRODUCT}" "Remove ${MUI_PRODUCT} from your computer."

  nsDialogs::Create 1018
        Pop $dialog
  ${NSD_CreateLabel} 0 0 100% 6% "Select things to be uninstalled. Click Uninstall to start the uninstallation."
        Pop $label1
  ${NSD_CreateCheckBox} 5% 20% 100% 6% "Remove Program"
        Pop $checkbox1
        ${NSD_Check} $checkbox1
        EnableWindow $checkbox1 0
  ${If} $UserProfileFolder != ""
        ${NSD_CreateCheckBox} 5% 30% 100% 6% "Remove User Profile"
        Pop $checkbox2
        ${NSD_Check} $checkbox2
  ${EndIf}
  ${If} $Registration != ""
        ${If} $UserProfileFolder != ""
              ${NSD_CreateCheckBox} 5% 40% 100% 6% "Remove Registration Data"
        ${Else}
              ${NSD_CreateCheckBox} 5% 30% 100% 6% "Remove Registration Data"
        ${EndIf}
        Pop $checkbox3
  ${EndIf}
  nsDialogs::Show

FunctionEnd

Function un.AdditionalTasksLeave

  ${NSD_GetState} $checkbox2 $UserProfile
  ${NSD_GetState} $checkbox3 $RegData

FunctionEnd

;--------------------------------
;Filetype Associations Functions

!include "FileTypes.nsi"

;--------------------------------
;Init Functions

Function .onInit

  !ifndef WINEDT_32
        ${IfNot} ${RunningX64}
              MessageBox MB_OK "64-bit WinEdt cannot be installed on a 32-bit platform" /SD IDOK
              Abort
        ${EndIf}
        SetRegView 64
  !endif

  ${GetParameters} $0
  ${GetOptions} $0 /USERPROFILE= $UserProfile
  ${If} $UserProfile == ""
        StrCpy $UserProfile "1"
  ${EndIf}
  ${GetOptions} $0 /STARTMENUICON= $StartMenuIcon
  ${If} $StartMenuIcon == ""
        StrCpy $StartMenuIcon "1"
  ${EndIf}
  ${GetOptions} $0 /DESKTOPICON= $DesktopIcon
  ${If} $DesktopIcon == ""
        StrCpy $DesktopIcon "1"
  ${EndIf}
  ${GetOptions} $0 /ASSOCIATEFILES= $AssociateFiles

  UserInfo::GetAccountType
        Pop $SystemAccountType
  ReadRegStr $RegAccountType HKCU "Software\${MUI_PRODUCT}" "AccountType"
  ${If} $SystemAccountType == "Admin"
        ${If} $RegAccountType == "Admin"
        ${OrIf} $RegAccountType == ""
              StrCpy $AccountType "Admin"
        ${Else}
              StrCpy $AccountType "User"
        ${EndIf}
  ${Else}
        StrCpy $AccountType "User"
  ${EndIf}

  ;Default Installation Folder for Silent Install
  ${If} ${Silent}
        ${If} $AccountType == "Admin"
              ${If} $INSTDIR == ""
                    !ifndef WINEDT_32
                          StrCpy $INSTDIR "$PROGRAMFILES64\${MUI_COMPANY}\${MUI_PRODUCT}"
                    !else
                          StrCpy $INSTDIR "$PROGRAMFILES\${MUI_COMPANY}\${MUI_PRODUCT}"
                    !endif
              ${EndIf}
              SetShellVarContext all
        ${Else}
              ${If} $INSTDIR == ""
                    StrCpy $INSTDIR "$PROFILE\${MUI_COMPANY}\${MUI_PRODUCT}"
              ${EndIf}
              SetShellVarContext current
        ${EndIf}
  ${EndIf}

FunctionEnd

Function un.onInit

  !ifndef WINEDT_32
        SetRegView 64
  !endif

  ${GetParameters} $0
  ${GetOptions} $0 /USERPROFILE= $UserProfile
  ${If} $UserProfile == ""
        StrCpy $UserProfile "1"
  ${EndIf}
  ${GetOptions} $0 /REGDATA= $RegData

  ReadRegStr $AccountType HKCU "Software\${MUI_PRODUCT}" "AccountType"
  ${If} $AccountType == "Admin"
        SetShellVarContext all
  ${Else}
        SetShellVarContext current
  ${EndIf}

  ReadRegStr $UserProfileFolder HKCU "Software\${MUI_PRODUCT}" "AppData"
  ReadRegStr $Registration HKCU "Software\${MUI_PRODUCT}" "Code"

  ReadRegDWORD $StartMenuIcon SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "StartMenuIcon"
  ReadRegDWORD $DesktopIcon SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "DesktopIcon"
  ReadRegDWORD $AssociateFiles SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${MUI_PRODUCT}" "AssociateFiles"

FunctionEnd
