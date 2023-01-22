#!/usr/bin/pwsh -File

$sshd_svc = Get-CimInstance -ClassName Win32_Service -Filter "Name='sshd'";
if (-not $sshd_svc) {
  throw "The sshd service does not exist.";
}

$true;