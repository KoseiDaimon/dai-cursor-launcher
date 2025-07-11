@echo off
setlocal enabledelayedexpansion

:: Check admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell Start-Process "%~f0" -Verb RunAs
    exit /b
)

echo Installing CursorRight...

:: Search for Cursor.exe in common locations
set "CURSOR_PATH="

:: Check user-specific installation
if exist "%LOCALAPPDATA%\Programs\Cursor\Cursor.exe" (
    set "CURSOR_PATH=%LOCALAPPDATA%\Programs\Cursor\Cursor.exe"
) else if exist "%APPDATA%\Programs\Cursor\Cursor.exe" (
    set "CURSOR_PATH=%APPDATA%\Programs\Cursor\Cursor.exe"
) else if exist "%PROGRAMFILES%\Cursor\Cursor.exe" (
    set "CURSOR_PATH=%PROGRAMFILES%\Cursor\Cursor.exe"
) else if exist "%PROGRAMFILES(X86)%\Cursor\Cursor.exe" (
    set "CURSOR_PATH=%PROGRAMFILES(X86)%\Cursor\Cursor.exe"
) else (
    :: Try to find it using where command
    for /f "delims=" %%i in ('where cursor.exe 2^>nul') do (
        if "%%~xi"==".exe" set "CURSOR_PATH=%%i"
    )
)

:: If still not found, search in common paths
if "%CURSOR_PATH%"=="" (
    for %%p in (
        "%USERPROFILE%\AppData\Local\Programs\Cursor\Cursor.exe"
        "%USERPROFILE%\scoop\apps\cursor\current\Cursor.exe"
        "C:\tools\Cursor\Cursor.exe"
    ) do (
        if exist "%%~p" set "CURSOR_PATH=%%~p"
    )
)

if "%CURSOR_PATH%"=="" (
    echo ERROR: Cursor.exe not found!
    echo.
    echo Please choose an option:
    echo.
    echo 1. Manually specify Cursor.exe location
    echo 2. Download and install Cursor
    echo 3. Exit
    echo.
    
    set /p choice="Enter your choice (1-3): "
    
    if "%choice%"=="1" (
        echo.
        echo Please enter the full path to Cursor.exe
        echo Example: C:\Program Files\Cursor\Cursor.exe
        echo.
        set /p CURSOR_PATH="Path: "
        
        if not exist "!CURSOR_PATH!" (
            echo ERROR: File not found at specified path!
            pause
            exit /b 1
        )
    ) else if "%choice%"=="2" (
        echo.
        echo Opening Cursor download page in your browser...
        start https://cursor.sh/
        echo.
        echo Please install Cursor and run this installer again.
        pause
        exit /b
    ) else (
        exit /b
    )
)

echo Found Cursor at: %CURSOR_PATH%
echo.

:: Add to registry
reg add "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL" /ve /t REG_SZ /d "Cursor ‚ÅŠJ‚­(WSL)" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL" /v Icon /t REG_SZ /d "%CURSOR_PATH%,0" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\CursorWSL\command" /ve /t REG_SZ /d "wsl cursor \"%%V\"" /f

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL" /ve /t REG_SZ /d "Cursor ‚ÅŠJ‚­(WSL)" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL" /v Icon /t REG_SZ /d "%CURSOR_PATH%,0" /f
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\CursorWSL\command" /ve /t REG_SZ /d "wsl cursor ." /f

echo.
echo Installation complete!
echo.
pause