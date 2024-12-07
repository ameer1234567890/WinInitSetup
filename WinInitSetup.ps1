$version = "1.0.0"
$tzName = "Pakistan Standard Time"

Write-Host "WinInitSetup $version"
Write-Host

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  [bool] $isAdmin = 1
  Write-Host "Administrator previledges detected. Running with elevated permissions!"
} else {
  Write-Host "Administrator previledges not detected. Running with limited permissions!"
}
Write-Host

if ($isAdmin) {
  Write-Host -NoNewline "Setting Initial Keyboard State to numlock on... "
  New-ItemProperty -Path "registry::HKEY_USERS\.DEFAULT\Control Panel\Keyboard" -PropertyType String -Name InitialKeyboardIndicators -Value 2 -Force | out-null
  if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}
}

Write-Host -NoNewline "Setting Default StartMenu alignment to left... "
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -PropertyType DWord -Name TaskbarAl -Value 0 -Force | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

if ($isAdmin) {
  Write-Host -NoNewline "Removing Taskbar widgets (step 1)... "
  New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" -PropertyType DWord -Name value -Value 0 -Force | out-null
  if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}
}

if ($isAdmin) {
  Write-Host -NoNewline "Removing Taskbar widgets (step 2)... "
  New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -PropertyType DWord -Name AllowNewsAndInterests -Value 0 -Force | out-null
  if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}
}

Write-Host -NoNewline "Removing Taskview button... "
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -PropertyType DWord -Name ShowTaskViewButton -Value 0 -Force | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

Write-Host -NoNewline "Removing Taskbar chat... "
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -PropertyType DWord -Name TaskbarMn -Value 0 -Force | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

Write-Host -NoNewline "Removing Taskbar search box... "
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -PropertyType DWord -Name SearchboxTaskbarMode -Value 0 -Force | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

Write-Host -NoNewline "Setting timezone... "
Set-TimeZone -Id "$tzName" | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

Write-Host -NoNewline "Setting power options (turn off display - on battery)... "
powercfg /change monitor-timeout-dc 30 | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

Write-Host -NoNewline "Setting power options (turn off display - on ac)... "
powercfg /change monitor-timeout-ac 30 | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

Write-Host -NoNewline "Setting power options (go to sleep - on battery)... "
powercfg /change standby-timeout-dc 120 | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

Write-Host -NoNewline "Setting power options (go to sleep - on ac)... "
powercfg /change standby-timeout-ac 120 | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

if ($isAdmin) {
  Write-Host -NoNewline "Turning on hibernation... "
  powercfg /hibernate on | out-null
  if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}
}

Write-Host -NoNewline "Setting date format to dd/MM/yyyy... "
New-ItemProperty -Path "HKCU:\Control Panel\International" -PropertyType String -Name sShortDate -Value "dd/MM/yyyy" -Force | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

Write-Host -NoNewline "Setting small desktop icons... "
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop" -PropertyType DWord -Name IconSize -Value 32 -Force | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}
# taskkill /IM explorer.exe /f /FI "USERNAME eq %USERNAME%"
# start explorer.exe

Write-Host -NoNewline "Adding Divehi language... "
$ll = Get-WinUserLanguageList
$ll.add('dv-MV')
Set-WinUserLanguageList -LanguageList $ll -Force -WarningAction:SilentlyContinue | out-null
if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}

if ($isAdmin) {
  Write-Host -NoNewline "Disabling Windows Update... "
  New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -PropertyType DWord -Name NoAutoUpdate -Value 1 -Force | out-null
  if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}
}

if ($isAdmin) {
  Write-Host -NoNewline "Stopping Windows Update Service... "
  Set-Service -StartupType Disabled wuauserv | out-null
  if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}
}

if ($isAdmin) {
  Write-Host -NoNewline "Disabling Windows Update Service... "
  Stop-Service wuauserv | out-null
  if ($? -eq 'True') {Write-Host -ForegroundColor White -BackgroundColor Green "DONE"} else {Write-Host -ForegroundColor White -BackgroundColor Red "FAILED"}
}

Write-Host
Write-Host "All tasks completed!"
