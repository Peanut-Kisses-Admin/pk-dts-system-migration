@echo off
setlocal
set "OUT=%~dp0npm-diagnostic.txt"

(
  echo PK DTS npm diagnostic
  echo =====================
  echo Date: %date% %time%
  echo.
  echo [where node]
  where node 2^>^&1
  echo.
  echo [where npm]
  where npm 2^>^&1
  echo.
  echo [node version]
  node --version 2^>^&1
  echo.
  echo [npm.cmd version]
  npm.cmd --version 2^>^&1
  echo.
  echo [PowerShell execution policies]
  powershell -NoProfile -Command "Get-ExecutionPolicy -List" 2^>^&1
  echo.
  echo [npm PowerShell shim]
  powershell -NoProfile -Command "Get-Command npm -ErrorAction SilentlyContinue | Format-List Name,Source,CommandType" 2^>^&1
) > "%OUT%"

type "%OUT%"
echo.
echo Saved diagnostic to:
echo %OUT%
echo.
echo NOTE:
echo If "npm" is blocked but "npm.cmd" works, PowerShell is usually blocking npm.ps1.
echo This portable DTS branch does not require npm on this PC.
pause
