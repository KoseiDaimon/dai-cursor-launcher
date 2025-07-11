@echo off

:: Check admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell Start-Process "%~f0" -Verb RunAs
    exit /b
)

echo Installing CursorRight...

:: Set variables
set "CURSOR_PATH=%LOCALAPPDATA%\Programs\Cursor\Cursor.exe"

:: Add to registry
reg add "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL" /ve /t REG_SZ /d "Cursor で開く(WSL)" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL" /v Icon /t REG_SZ /d "%CURSOR_PATH%,0" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL\command" /ve /t REG_SZ /d "wsl cursor \"%%V\"" /f

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL" /ve /t REG_SZ /d "Cursor で開く(WSL)" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL" /v Icon /t REG_SZ /d "%CURSOR_PATH%,0" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL\command" /ve /t REG_SZ /d "wsl cursor ." /f

echo.
echo Installation complete!
echo.
pause