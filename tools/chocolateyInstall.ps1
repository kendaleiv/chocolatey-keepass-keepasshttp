﻿$packageName = "keepass-keepasshttp"
$url = "https://raw.github.com/pfn/keepasshttp/master/KeePassHttp.plgx"

$is64bit = Get-ProcessorBits 64
$programUninstallEntryName = "KeePass Password Safe 2."

if ($is64bit) {
  $installPath = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, InstallLocation | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).InstallLocation
}
else {
  $installPath = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, InstallLocation | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).InstallLocation
}

if (!$installPath) {
  Write-ChocolateyFailure $packageName "Could not locate KeePass Password Safe 2.x installation location."
  throw
}

$fileFullPath = $installPath + "KeePassHttp.plgx"

try {
  Get-ChocolateyWebFile $packageName $fileFullPath $url
  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
