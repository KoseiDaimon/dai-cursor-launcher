@echo off
cd /d %~dp0
chcp 65001 >nul 2>&1

:: Check admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo Uninstalling CursorRight...

:: Remove from registry
reg delete "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL" /f >nul 2>&1

echo.
echo SUCCESS: Uninstall complete!
echo.
echo Right-click menu entries have been removed.
echo.
pause