@echo off
setlocal
set "ROOT=%~dp0.."
cd /d "%ROOT%"
echo Starting PK DTS frontend without npm...
"%ROOT%\runtime\node.exe" "%ROOT%\tools\static-server.js" "%ROOT%\frontend" 4200
