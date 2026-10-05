@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%\backend"

if not exist ".env.dockerless" (
  copy /Y ".env.dockerless.example" ".env.dockerless" >nul
  echo Created .env.dockerless.
  echo.
  echo IMPORTANT:
  echo Open backend\.env.dockerless and confirm DATABASE_URL first.
  echo Then run this file again.
  pause
  exit /b 0
)

set "APP_ENV=dockerless"
set "NODE_ENV=development"
set "CACHE_DRIVER=memory"

echo Preparing PostgreSQL database without npm...
"%ROOT%\runtime\node.exe" scripts\prisma-env.js --app-env dockerless db push
if errorlevel 1 (
  echo.
  echo Database setup failed. Check DATABASE_URL and make sure PostgreSQL is running.
  pause
  exit /b 1
)

echo Seeding database...
"%ROOT%\runtime\node.exe" node_modules\ts-node\dist\bin.js prisma\seed.ts
if errorlevel 1 (
  echo.
  echo Seed failed.
  pause
  exit /b 1
)

echo.
echo Database setup completed successfully.
pause
