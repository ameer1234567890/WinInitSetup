@echo off

set version=1.0.0

echo WinInitSetup %version%
echo:

net session >nul 2>&1
if %errorLevel% == 0 (
  echo Administrator previledges acquired!
) else (
  echo This script requires administrative previledges. Please run as administrator!
  pause
  exit
)

echo|set /p="Setting Initial Keyboard State to numlock on... "
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /t REG_SZ /v InitialKeyboardIndicators /d 2 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Setting Default StartMenu alignment to left... "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v TaskbarAl /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Removing Taskbar widgets... "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v TaskbarDa /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Removing Taskbar chat... "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v TaskbarMn /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo|set /p="Removing Taskbar search box... "
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /t REG_DWORD /v SearchboxTaskbarMode /d 0 /f >nul 2>&1
if %errorLevel% == 0 ( echo [102m DONE [0m ) else ( echo [101;93m FAILED [0m )

echo:
echo All tasks completed!
pause
