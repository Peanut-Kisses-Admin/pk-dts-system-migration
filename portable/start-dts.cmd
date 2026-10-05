@echo off
setlocal
set "ROOT=%~dp0"

if not exist "%ROOT%runtime\node.exe" (
  echo ERROR: runtime\node.exe is missing.
  echo Download the generated Windows bundle from GitHub Actions instead of the source ZIP.
  pause
  exit /b 1
)

if not exist "%ROOT%backend\dist\main.js" (
  echo ERROR: Prebuilt backend files are missing.
  echo Download the generated Windows bundle from GitHub Actions.
  pause
  exit /b 1
)

if not exist "%ROOT%frontend\index.html" (
  echo ERROR: Prebuilt frontend files are missing.
  echo Download the generated Windows bundle from GitHub Actions.
  pause
  exit /b 1
)

start "PK DTS Backend" "%ROOT%tools\run-backend.cmd"
start "PK DTS Frontend" "%ROOT%tools\run-frontend.cmd"

timeout /t 3 /nobreak >nul
start "" "http://localhost:4200"

echo PK DTS started.
echo Frontend: http://localhost:4200
echo Backend:  http://localhost:3000/api/v1
echo.
echo Close the two PK DTS command windows to stop the app.
