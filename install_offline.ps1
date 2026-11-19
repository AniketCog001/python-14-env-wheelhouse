# Python 3.14 Desktop Automation Offline Setup Script (PowerShell)
# Repository: AniketCog001/python-14-env-wheelhouse

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  Python 3.14 Desktop Automation Offline Setup" -ForegroundColor Cyan
Write-Host "  Repository: AniketCog001/python-14-env-wheelhouse" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

# 1. Determine wheel directory
$WheelDir = Join-Path $ScriptDir "wheelhouse"
if (-not (Test-Path $WheelDir)) {
    $WheelDir = Join-Path $ScriptDir "wheelbase"
}
if (-not (Test-Path $WheelDir)) {
    throw "Neither 'wheelhouse' nor 'wheelbase' directory found at $ScriptDir"
}

# 2. Check or extract Python 3.14 runtime
$PythonExe = Join-Path $ScriptDir "Python314\python.exe"
$ZipFile = Join-Path $ScriptDir "python-3.14.0-amd64.zip"

if (-not (Test-Path $PythonExe)) {
    if (Test-Path $ZipFile) {
        Write-Host "[INFO] Extracting Python 3.14 standalone archive..." -ForegroundColor Yellow
        $TargetDir = Join-Path $ScriptDir "Python314"
        if (-not (Test-Path $TargetDir)) { New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null }
        
        # Use tar if available, otherwise Expand-Archive
        if (Get-Command tar -ErrorAction SilentlyContinue) {
            tar -xf $ZipFile -C $TargetDir
        } else {
            Expand-Archive -Path $ZipFile -DestinationPath $TargetDir -Force
        }
    }
}

if (-not (Test-Path $PythonExe)) {
    $PythonExe = "python"
    Write-Host "[INFO] Using system python command" -ForegroundColor Gray
} else {
    Write-Host "[INFO] Using bundled Python 3.14 at: $PythonExe" -ForegroundColor Green
}

# 3. Install offline wheels
$ReqFile = Join-Path $ScriptDir "requirements.txt"
Write-Host "[INFO] Installing packages offline from $WheelDir..." -ForegroundColor Yellow
& $PythonExe -m pip install --no-index --find-links="$WheelDir" -r "$ReqFile"

# 4. Post-install
Write-Host "[INFO] Configuring pywin32 extensions..." -ForegroundColor Yellow
$PostInstall = Join-Path $ScriptDir "Python314\Scripts\pywin32_postinstall.py"
if (Test-Path $PostInstall) {
    & $PythonExe $PostInstall -install -silent
}

# 5. Verify
Write-Host "[INFO] Verifying desktop automation libraries..." -ForegroundColor Yellow
$TestScript = Join-Path $ScriptDir "test_automation.py"
& $PythonExe $TestScript

Write-Host "========================================================" -ForegroundColor Green
Write-Host "  Setup Complete! All Desktop Automation Packages Ready." -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
