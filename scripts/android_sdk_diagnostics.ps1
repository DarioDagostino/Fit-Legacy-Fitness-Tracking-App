<#
Android SDK diagnostics helper (PowerShell)

What it does:
- Checks if `sdkmanager` is on PATH
- Searches common SDK locations (LOCALAPPDATA, Program Files, C:\Android)
- Prints commands you can run to set ANDROID_SDK_ROOT and add cmdline-tools to PATH
- Optionally attempts to run `flutter doctor --android-licenses` (interactive)

Usage:
  Open PowerShell as your normal dev user and run:
    .\scripts\android_sdk_diagnostics.ps1

  To auto-run license acceptance (interactive required):
    .\scripts\android_sdk_diagnostics.ps1 -TryAcceptLicenses

Note: This script does not install anything. Use Android Studio or download the command-line tools manually.
#>

param(
    [switch]$TryAcceptLicenses
)

function Write-Info($m){ Write-Host $m -ForegroundColor Cyan }
function Write-Warn($m){ Write-Host $m -ForegroundColor Yellow }
function Write-Err($m){ Write-Host $m -ForegroundColor Red }

Write-Info "Android SDK diagnostics helper"

# 1) Is sdkmanager available on PATH?
$sdkCmd = Get-Command sdkmanager -ErrorAction SilentlyContinue
if ($null -ne $sdkCmd) {
    Write-Info "Found sdkmanager at: $($sdkCmd.Path)"
} else {
    Write-Warn "sdkmanager not found on PATH. Searching common SDK locations..."

    $candidates = @()
    if ($env:LOCALAPPDATA) { $candidates += Join-Path $env:LOCALAPPDATA 'Android\sdk' }
    $candidates += 'C:\Android'
    $candidates += 'C:\Program Files\Android\android-sdk'
    $candidates += 'C:\Program Files (x86)\Android\android-sdk'

    $found = @()
    foreach ($c in $candidates) {
        if (Test-Path $c) {
            # check cmdline-tools/latest/bin and tools/bin
            $p1 = Join-Path $c 'cmdline-tools\latest\bin\sdkmanager.bat'
            $p2 = Join-Path $c 'tools\bin\sdkmanager.bat'
            if (Test-Path $p1) { $found += $p1 }
            if (Test-Path $p2) { $found += $p2 }
        }
    }

    if ($found.Count -gt 0) {
        Write-Info "Found sdkmanager at these locations:"
        $found | ForEach-Object { Write-Host "  $_" }

        $first = $found[0]
        $sdkRoot = Split-Path (Split-Path $first -Parent) -Parent
        Write-Info "Suggested ANDROID_SDK_ROOT: $sdkRoot"
        Write-Info "To use it in this session run (PowerShell):"
        Write-Host "`$env:ANDROID_SDK_ROOT = '$sdkRoot'" -ForegroundColor Green
        Write-Host "`$env:Path = '$($first -replace '\\cmdline-tools\\.+$','\\cmdline-tools\\latest\\bin')' + ';' + `$env:Path" -ForegroundColor Green
    } else {
        Write-Warn "No sdkmanager found in common SDK locations. If you have Android Studio, open its SDK Manager and install 'Android SDK Command-line Tools (latest)'."
        Write-Host "Manual download: https://developer.android.com/studio#cmdline-tools" -ForegroundColor Cyan
    }
}

# Print current environment hints
Write-Info "Current environment variables (ANDROID_SDK_ROOT / ANDROID_HOME):"
Get-ChildItem Env:ANDROID* | ForEach-Object { Write-Host "  $($_.Name) = $($_.Value)" }

Write-Info "Checking flutter availability..."
$flutter = Get-Command flutter -ErrorAction SilentlyContinue
if ($null -ne $flutter) {
    Write-Info "Found flutter at: $($flutter.Path)"
} else {
    Write-Warn "Flutter CLI not found on PATH. Install Flutter and ensure 'flutter' is available." 
}

if ($TryAcceptLicenses) {
    if ($null -eq $flutter) {
        Write-Err "Cannot run 'flutter doctor --android-licenses' because 'flutter' is not on PATH. Aborting."
        exit 2
    }

    Write-Info "Running: flutter doctor --android-licenses"
    Write-Info "You will be prompted to accept licenses. Reply 'y' to accept each." 
    # Run interactively - do not try to auto-answer here since licenses interaction varies
    & $flutter.Path 'doctor' '--android-licenses'
    $rc = $LASTEXITCODE
    if ($rc -eq 0) { Write-Info "License flow exited with code 0" } else { Write-Warn "License flow exited with code $rc" }
}

Write-Info "Diagnostics complete. If you need, run this script with -TryAcceptLicenses after ensuring sdkmanager is reachable."
