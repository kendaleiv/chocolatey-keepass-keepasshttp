$packageName = "keepass-keepasshttp"
$url = "https://github.com/pfn/keepasshttp/raw/c2c4eb5388a02169400cba7a67be325caabdcc37/KeePassHttp.plgx"
$checksum = "4FD87213F4E71F11F0CD7A09B9F49BDA79BCA64AB3F6BF739C945D051FD175E9"
$checksumType = "sha256"

$is64bit = Get-ProcessorBits 64
$programUninstallEntryName = "KeePass Password Safe 2."

if ($is64bit) {
  $installPath = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, InstallLocation | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).InstallLocation
}
else {
  $installPath = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select DisplayName, InstallLocation | Where-Object {$_.DisplayName -like "$programUninstallEntryName*"}).InstallLocation
}

if (!$installPath) {
  throw "Could not locate KeePass Password Safe 2.x installation location."
}

# Cleanup plugin if exists at previous location
if (Test-Path "$installPath\KeePassHttp.plgx") {
  Remove-Item "$installPath\KeePassHttp.plgx"
}

$fileFullPath = "$installPath\Plugins\KeePassHttp.plgx"

Get-ChocolateyWebFile $packageName $fileFullPath $url -Checksum $checksum -ChecksumType $checksumType
