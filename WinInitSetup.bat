@echo off

set version=1.0.0
set tzname="Pakistan Standard Time"

echo WinInitSetup %version%
echo:

net session >nul 2>&1
if %errorLevel% == 0 (
  echo Administrator previledges acquired!
) else (
  echo It is recommended to run this script with administrative previledges.
)

echo|set /p="Setting Initial Keyboard State to numlock on... "
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /t REG_SZ /v InitialKeyboardIndicators /d 2 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Setting Default StartMenu alignment to left... "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v TaskbarAl /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Removing Taskbar widgets (step 1)... "
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" /t REG_DWORD /v value /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Removing Taskbar widgets (step 2)... "
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Dsh" /t REG_DWORD /v AllowNewsAndInterests /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Removing Taskview button... "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v ShowTaskViewButton /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Removing Taskbar chat... "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v TaskbarMn /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Removing Taskbar search box... "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /t REG_DWORD /v SearchboxTaskbarMode /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Setting timezone... "
tzutil /s %tzname% >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Setting power options (turn off display - on battery)... "
powercfg /change monitor-timeout-dc 30 >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Setting power options (turn off display - on ac)... "
powercfg /change monitor-timeout-ac 30 >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Setting power options (go to sleep - on battery)... "
powercfg /change standby-timeout-dc 120 >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Setting power options (go to sleep - on ac)... "
powercfg /change standby-timeout-ac 120 >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Turning on hibernation... "
powercfg /hibernate on >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Setting date format to dd/MM/yyyy... "
reg add "HKCU\Control Panel\International" /t REG_SZ /v sShortDate /d "dd/MM/yyyy" /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Setting small desktop icons... "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Bags\1\Desktop" /t REG_DWORD /v IconSize /d 32 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )
rem taskkill /IM explorer.exe /f /FI "USERNAME eq %USERNAME%"
rem start explorer.exe

echo|set /p="Adding Divehi language... "
powershell -c "$ll=Get-WinUserLanguageList; $ll.add('dv-MV'); Set-WinUserLanguageList $ll -force;" >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Disabling Windows Update... "
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /t REG_DWORD /v NoAutoUpdate /d 1 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Stopping Windows Update Service... "
sc config wuauserv start=disabled >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Disabling Windows Update Service... "
sc stop wuauserv >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo:
echo All tasks completed!
