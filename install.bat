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

:: Check Cursor path
set "CURSOR_PATH=%LOCALAPPDATA%\Programs\Cursor\Cursor.exe"

if not exist "%CURSOR_PATH%" (
    echo.
    echo ERROR: Cursor.exe not found
    echo Path: %CURSOR_PATH%
    echo.
    echo Please install Cursor first.
    echo.
    pause
    exit /b 1
)

echo.
echo Installing CursorRight...

:: Add to registry - Folder right-click
reg add "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL" /ve /d "Cursorで開く（WSL）" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL" /v "Icon" /d "%CURSOR_PATH%,0" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL\command" /ve /d "cmd.exe /c \"cd /d \"%%V\" && wsl.exe --cd \"%%V\" cursor .\"" /f >nul

:: Add to registry - Folder background right-click  
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL" /ve /d "Cursorで開く（WSL）" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL" /v "Icon" /d "%CURSOR_PATH%,0" /f >nul
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL\command" /ve /d "cmd.exe /c \"cd /d \"%%V\" && wsl.exe --cd \"%%V\" cursor .\"" /f >nul

if %errorLevel% equ 0 (
    echo.
    echo SUCCESS: Installation complete!
    echo.
    echo You can now right-click folders to open with Cursor in WSL.
) else (
    echo.
    echo ERROR: Installation failed.
)

echo.
pause