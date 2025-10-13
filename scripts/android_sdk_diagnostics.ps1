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

# 0) Check if ANDROID_SDK_ROOT is already set
if ($env:ANDROID_SDK_ROOT) {
    Write-Info "ANDROID_SDK_ROOT is set to: $env:ANDROID_SDK_ROOT"
    $expectedSdkManager = Join-Path $env:ANDROID_SDK_ROOT 'cmdline-tools\latest\bin\sdkmanager.bat'
    $legacySdkManager = Join-Path $env:ANDROID_SDK_ROOT 'tools\bin\sdkmanager.bat'
    
    if (Test-Path $expectedSdkManager) {
        Write-Info "Found sdkmanager at: $expectedSdkManager"
    } elseif (Test-Path $legacySdkManager) {
        Write-Info "Found legacy sdkmanager at: $legacySdkManager"
    } else {
        Write-Warn "ANDROID_SDK_ROOT is set but sdkmanager not found in expected locations."
        Write-Warn "Expected: $expectedSdkManager"
    }
}

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
        # Determine SDK root based on path structure
        if ($first -match '[\\/]cmdline-tools[\\/]') {
            # Path like: sdk\cmdline-tools\latest\bin\sdkmanager.bat
            # Go up 4 levels: bin -> latest -> cmdline-tools -> sdk
            $sdkRoot = Split-Path (Split-Path (Split-Path (Split-Path $first -Parent) -Parent) -Parent) -Parent
        } elseif ($first -match '[\\/]tools[\\/]bin[\\/]') {
            # Path like: sdk\tools\bin\sdkmanager.bat
            # Go up 3 levels: bin -> tools -> sdk
            $sdkRoot = Split-Path (Split-Path (Split-Path $first -Parent) -Parent) -Parent
        } else {
            # Fallback: assume 2 levels up
            $sdkRoot = Split-Path (Split-Path $first -Parent) -Parent
        }
        
        if (Test-Path $sdkRoot) {
            Write-Info "Suggested ANDROID_SDK_ROOT: $sdkRoot"
            Write-Info "To use it in this session run (PowerShell):"
            Write-Host "`$env:ANDROID_SDK_ROOT = '$sdkRoot'" -ForegroundColor Green
            
            # Suggest adding the bin directory to PATH
            $binDir = Split-Path $first -Parent
            Write-Host "`$env:Path = '$binDir' + ';' + `$env:Path" -ForegroundColor Green
        } else {
            Write-Warn "Could not determine valid SDK root from: $first"
        }
    } else {
        Write-Warn "No sdkmanager found in common SDK locations. If you have Android Studio, open its SDK Manager and install 'Android SDK Command-line Tools (latest)'."
        Write-Host "Manual download: https://developer.android.com/studio#cmdline-tools" -ForegroundColor Cyan
    }
}

# Print current environment hints
Write-Info "Current environment variables (ANDROID_SDK_ROOT / ANDROID_HOME):"
Get-ChildItem Env:ANDROID* | ForEach-Object { Write-Host "  $($_.Name) = $($_.Value)" }

Write-Info "Checking Java availability..."
$java = Get-Command java -ErrorAction SilentlyContinue
if ($null -ne $java) {
    Write-Info "Found java at: $($java.Path)"
    try {
        $javaVersion = & java -version 2>&1 | Select-Object -First 1
        Write-Host "  Version: $javaVersion" -ForegroundColor Gray
    } catch {
        Write-Warn "Could not determine Java version"
    }
} else {
    Write-Warn "Java not found on PATH. Android development requires JDK 8 or later."
    Write-Host "Download: https://www.oracle.com/java/technologies/downloads/" -ForegroundColor Cyan
}

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

    if ($null -eq $sdkCmd -and -not $env:ANDROID_SDK_ROOT) {
        Write-Err "Cannot run 'flutter doctor --android-licenses' because Android SDK is not configured."
        Write-Err "Please set ANDROID_SDK_ROOT and ensure sdkmanager is accessible, then try again."
        exit 3
    }

    Write-Info "Running: flutter doctor --android-licenses"
    Write-Info "You will be prompted to accept licenses. Reply 'y' to accept each."
    Write-Info "Note: If this crashes, ensure Java is installed and ANDROID_SDK_ROOT is set correctly."
    Write-Info ""
    
    # Run interactively - do not try to auto-answer here since licenses interaction varies
    try {
        & $flutter.Path 'doctor' '--android-licenses'
        $rc = $LASTEXITCODE
        if ($rc -eq 0) { 
            Write-Info "License flow exited with code 0 - Success!" 
        } elseif ($rc -lt 0 -or $rc -gt 255) {
            Write-Err "License flow exited with code $rc (possible crash or access violation)"
            Write-Err "Common causes:"
            Write-Err "  - Java not installed or not on PATH"
            Write-Err "  - ANDROID_SDK_ROOT not set correctly"
            Write-Err "  - sdkmanager not accessible or corrupted"
            Write-Err "  - Missing Android SDK cmdline-tools"
        } else { 
            Write-Warn "License flow exited with code $rc"
            if ($rc -eq 1) {
                Write-Info "This may indicate licenses were not accepted or sdkmanager had an issue."
            }
        }
    } catch {
        Write-Err "Exception occurred while running flutter doctor: $_"
    }
}

Write-Info "Diagnostics complete. If you need, run this script with -TryAcceptLicenses after ensuring sdkmanager is reachable."
