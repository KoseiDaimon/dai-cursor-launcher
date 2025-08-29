@echo off

:: Check admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell Start-Process "%~f0" -Verb RunAs
    exit /b
)

echo Uninstalling CursorRight...

:: Remove from registry
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL" /f 2>nul

echo.
echo Uninstall complete!
echo.
pause