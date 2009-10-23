; ----------------------------
;       LogicLib_Ext.nsh
; ----------------------------
;
; Library to extend the 'LogicLib' library's existing functions.
;
 
 
!ifndef ___LOGICLIB_EXT__NSH___
!define ___LOGICLIB_EXT__NSH___
 
!include 'LogicLib.nsh'
 
; -----------------------
;       UserIsAdmin
; -----------------------
;
;   Example:
;       ${If} ${UserIsAdmin}
;           DetailPrint "Current user security context has local administrative rights."
;       ${Else}
;           DetailPrint "Current user security context dose NOT have local administrative rights."
;       ${EndIf}
;
    !macro _UserIsAdmin _a _b _t _f
        System::Store 'p0 p1 p2 p3'
        System::Call '*(&i1 0,&i4 0,&i1 5)i.r0'
        System::Call 'advapi32::AllocateAndInitializeSid(i r0,i 2,i 32,i 544,i 0,i 0,i 0,i 0,i 0,i 0,*i .r1)i.r2'
        System::Free $0
        System::Call 'advapi32::CheckTokenMembership(i n,i r1,*i .r2)i.r3'
        System::Call 'advapi32::FreeSid(i r1)i.r2'
 
        StrCmp $3 0 0 +3
        ## User is an Admin
            System::Store 'r0 r1 r2 r3'
            Goto `${_f}`
 
        ## User is not an Admin
            System::Store 'r0 r1 r2 r3'
            Goto `${_t}`
 
    !macroend
    !define UserIsAdmin `"" UserIsAdmin ""`
 
!endif
