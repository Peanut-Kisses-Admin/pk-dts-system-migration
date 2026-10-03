@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%\backend"

if not exist ".env.dockerless" (
  copy /Y ".env.dockerless.example" ".env.dockerless" >nul
  echo Created backend\.env.dockerless from the example.
  echo Edit DATABASE_URL in that file if your PostgreSQL settings are different.
)

set "APP_ENV=dockerless"
set "NODE_ENV=development"
set "CACHE_DRIVER=memory"

echo Starting PK DTS backend without npm...
"%ROOT%\runtime\node.exe" dist\main.js
