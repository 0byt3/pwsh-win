#!/usr/bin/pwsh -File

## Find the powershell shortcut in the StartMenu and use that to determine the dir of pwsh.exe
$pwsh_links = Get-ChildItem -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs" -Filter Powershell*.lnk -Recurse |
  Where-Object -FilterScript { $_.Name -notmatch 'Windows' } |
  Select-Object -ExpandProperty FullName
if (-not $pwsh_links) {
  throw "Could not find PowerShell Core StartMenu shortcut. The shortcut is used to determine the location of pwsh.exe";
}

$pwsh_exe_file = $pwsh_links | Foreach-Object -Process { (New-Object -ComObject WScript.Shell).CreateShortcut($_).TargetPath } |
  Get-Item -ErrorAction Continue | Select-Object -Property *,@{ n='FileVer'; e={ [Version]$_.VersionInfo.FileVersion }} |
  Sort-Object -Property FileVer -Descending |
  Select-Object -First 1
if (-not $pwsh_exe_file) {
  throw "Could determine pwsh.exe path"
}


(New-Object -ComObject Scripting.FileSystemObject).GetFile($pwsh_exe_file.FullName).shortpath;
$pwsh_exe_file.FullName;