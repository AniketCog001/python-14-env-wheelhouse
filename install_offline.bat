@echo off
setlocal enabledelayedexpansion

echo ========================================================
echo   Python 3.14 Desktop Automation Offline Setup
echo   Repository: AniketCog001/python-14-env-wheelhouse
echo ========================================================

set SCRIPT_DIR=%~dp0
set WHEEL_DIR=%SCRIPT_DIR%wheelhouse

if not exist "%WHEEL_DIR%" (
    set WHEEL_DIR=%SCRIPT_DIR%wheelbase
)

if not exist "%WHEEL_DIR%" (
    echo [ERROR] Neither wheelhouse nor wheelbase directory found at: %SCRIPT_DIR%
    pause
    exit /b 1
)

:: Step 1: Check if Python314 folder exists, or extract from zip
if not exist "%SCRIPT_DIR%Python314\python.exe" (
    if exist "%SCRIPT_DIR%python-3.14.0-amd64.zip" (
        echo [INFO] Python314 folder not found. Extracting from python-3.14.0-amd64.zip ...
        if not exist "%SCRIPT_DIR%Python314" mkdir "%SCRIPT_DIR%Python314"
        tar -xf "%SCRIPT_DIR%python-3.14.0-amd64.zip" -C "%SCRIPT_DIR%Python314"
        if !ERRORLEVEL! neq 0 (
            echo [INFO] tar failed, falling back to PowerShell Expand-Archive ...
            powershell -NoProfile -Command "Expand-Archive -Path '%SCRIPT_DIR%python-3.14.0-amd64.zip' -DestinationPath '%SCRIPT_DIR%Python314' -Force"
        )
    )
)

:: Step 2: Determine Python executable
if exist "%SCRIPT_DIR%Python314\python.exe" (
    set PYTHON_EXE="%SCRIPT_DIR%Python314\python.exe"
    echo [INFO] Using bundled Python runtime: %PYTHON_EXE%
) else (
    set PYTHON_EXE=python
    echo [INFO] Using system python command
)

:: Step 3: Install all packages offline from wheelhouse
echo [INFO] Installing packages offline from %WHEEL_DIR% ...
%PYTHON_EXE% -m pip install --no-index --find-links="%WHEEL_DIR%" -r "%SCRIPT_DIR%requirements.txt"

if %ERRORLEVEL% neq 0 (
    echo [ERROR] Offline package installation failed with exit code %ERRORLEVEL%.
    pause
    exit /b %ERRORLEVEL%
)

:: Step 4: Run pywin32 post-install configuration
echo.
echo [INFO] Configuring pywin32 extensions ...
%PYTHON_EXE% -c "import os, sys, subprocess; script = os.path.join(sys.prefix, 'Scripts', 'pywin32_postinstall.py'); subprocess.run([sys.executable, script, '-install', '-silent']) if os.path.exists(script) else None"

:: Step 5: Verification
echo.
echo [INFO] Verifying desktop automation libraries ...
%PYTHON_EXE% "%SCRIPT_DIR%test_automation.py"

echo.
echo ========================================================
echo   Setup Complete! All Desktop Automation Packages Ready.
echo ========================================================
pause
