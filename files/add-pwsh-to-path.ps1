#!/usr/bin/pwsh -File

## expecting pwsh_exe_path environment variable
$pwsh_exe_file = Get-Item -Path ($env:pwsh_exe_path) -ErrorAction Stop;

$pwsh_dir = $pwsh_exe_file.Directory;

$pwsh_dir_regex_safe = [Regex]::Escape($pwsh_dir);
$sys_path_var = (Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name Path).Path;
$path_array = @();
$path_array += $sys_path_var -split ';' | Where-Object -FilterScript { $_ -match '.+' }

if ( $path_array | Where-Object -FilterScript { $_ -match "^$pwsh_dir_regex_safe`$" } ) {
  Write-Output "PowerShell Core already in PATH";
} else {
  $path_array += "$pwsh_dir";
  $new_path_str = "$($path_array -join ';')"
  Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment' -Name Path -Value $new_path_str;
  Write-Output "Added PowerShell Core to PATH";
}
