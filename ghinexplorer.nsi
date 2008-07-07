; GoenExplorer.nsi
;
; This script is based on example1.nsi, but it remember the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install GoenDB.nsi into a directory that the user selects,

LicenseText "License Agreement"
LicenseData "LICENSE.txt"
;--------------------------------

; The name of the installer
Name "GoenGalery"

; The file to write
OutFile "GhinExplorerSetup.exe"

; The default installation directory
InstallDir $PROGRAMFILES\GhinExplorer

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\GhinExplorer" "Install_Dir"

;--------------------------------

; Pages
page license
Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles


;--------------------------------

; The stuff to install
Section "GhinExplorer (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File "ghinexplorer.bat"
  File "ghinexplorer.sh"
  File "GhinExplorer.jar"
  File "README.txt"
  File "LICENSE.txt"
  File "logo.ico"
  File "logo.gif"
   
  CreateDirectory "lib" 
  SetOutPath $INSTDIR\lib
  File "lib\*.*"
  
 
  SetOutPath $INSTDIR

    
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\GhinExplorer "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GhinExplorer" "DisplayName" "GhinExplorer"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GhinExplorer" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GhinExplorer" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GhinExplorer" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\GhinExplorer"
  CreateShortCut "$SMPROGRAMS\GhinExplorer\GhinExplorer.lnk" "$SYSDIR\javaw.exe" "-jar GhinExplorer.jar GhinExplorer" "$INSTDIR\logo.ico"
  CreateShortCut "$SMPROGRAMS\GhinExplorer\Readme.lnk" "$WINDIR\notepad.exe" "README.txt" "$WINDIR\notepad.exe"
  CreateShortCut "$SMPROGRAMS\GhinExplorer\GhinExplorer Directory.lnk" "$INSTDIR\" "" "$INSTDIR\" 0
  CreateShortCut "$SMPROGRAMS\GhinExplorer\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0

  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\GhinExplorer"
  DeleteRegKey HKLM SOFTWARE\GhinExplorer

  ; Remove files and uninstaller
  Delete "$INSTDIR\*.*"
  
  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\GhinExplorer\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\GhinExplorer"
  RMDir "$INSTDIR"

SectionEnd
