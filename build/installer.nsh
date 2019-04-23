!include nsDialogs.nsh

Var Dialog
Var RoR2Dir
Var DirText
Var BrowseButton


Page custom RoR2InstallDirSelect LeaveCallback

Function RoR2InstallDirSelect

  StrCpy $DirText "C:\Program Files(x86)\Steam\steamapps\common\Risk of Rain 2"

  nsDialogs::Create 1018
  Pop $Dialog

  ${If} $Dialog == error
    abort
  ${EndIf}

  ${NSD_CreateLabel} 0 0 100% 12u "Risk of Rain 2 Install Directory"

  ${NSD_CreateDirRequest} 0 13u 84% 12u $DirText
  Pop $RoR2Dir
  ${NSD_CreateBrowseButton} 85% 13u 15% 12u "Browse"
  Pop $BrowseButton
  ${NSD_OnClick} $BrowseButton OnBrowseForDir

  nsDialogs::Show

FunctionEnd

Function OnBrowseForDir
  nsDialogs::SelectFolderDialog /NOUNLOAD "Directory"
  Pop $0
  ${If} $0 == error
  ${Else}
    StrCpy $DirText $0
    ${NSD_SetText} $RoR2Dir $DirText
  ${EndIf}
FunctionEnd

Function LeaveCallback
  ${NSD_GetText} $RoR2Dir $DirText

  WriteRegStr HKCU "Software\${PRODUCT_NAME}" "RoR2Dir" $DirText
FunctionEnd

Section
SectionEnd