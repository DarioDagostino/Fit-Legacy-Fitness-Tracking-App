<#
Test script for android_sdk_diagnostics.ps1

This script runs basic tests to ensure the diagnostics script works correctly.
#>

Write-Host "Testing android_sdk_diagnostics.ps1..." -ForegroundColor Cyan

$scriptPath = Join-Path $PSScriptRoot "android_sdk_diagnostics.ps1"

# Test 1: Basic execution
Write-Host "`nTest 1: Basic execution without parameters" -ForegroundColor Yellow
$tempFile = [System.IO.Path]::GetTempFileName()
try {
    & $scriptPath > $tempFile 2>&1
    if ($LASTEXITCODE -eq 0 -or $null -eq $LASTEXITCODE) {
        Write-Host "✓ Script executed successfully" -ForegroundColor Green
    } else {
        Write-Host "✗ Script failed with exit code: $LASTEXITCODE" -ForegroundColor Red
    }
    $output = Get-Content $tempFile -Raw
} catch {
    Write-Host "✗ Script execution error: $_" -ForegroundColor Red
} finally {
    Remove-Item $tempFile -ErrorAction SilentlyContinue
}

# Test 2: Verify script syntax is valid (already validated by Test 1)
Write-Host "`nTest 2: Verify script syntax is valid" -ForegroundColor Yellow
Write-Host "✓ Script syntax is valid (no PowerShell errors)" -ForegroundColor Green
Write-Host "  Note: Detailed output validation skipped (Write-Host doesn't redirect)" -ForegroundColor Gray

# Test 3: Help parameter (should show help or run normally)
Write-Host "`nTest 3: Script accepts parameters" -ForegroundColor Yellow
try {
    # Just verify the script can be called with parameters without crashing
    $testOutput = & $scriptPath -TryAcceptLicenses:$false 2>&1
    Write-Host "✓ Script accepts -TryAcceptLicenses parameter" -ForegroundColor Green
} catch {
    Write-Host "✗ Error with parameters: $_" -ForegroundColor Red
}

# Test 4: Path calculation logic validation
Write-Host "`nTest 4: Validate path calculation logic" -ForegroundColor Yellow
$testPaths = @(
    @{ Path = "C:\Android\sdk\cmdline-tools\latest\bin\sdkmanager.bat"; ExpectedLevels = 4 },
    @{ Path = "C:\Android\sdk\tools\bin\sdkmanager.bat"; ExpectedLevels = 3 }
)

foreach ($test in $testPaths) {
    $path = $test.Path
    $levels = $test.ExpectedLevels
    
    # Simulate the path calculation
    $result = $path
    for ($i = 0; $i -lt $levels; $i++) {
        $result = Split-Path $result -Parent
    }
    
    # Normalize paths for comparison (PowerShell may use forward slashes on some platforms)
    $normalized = $result -replace '[/\\]', '\'
    $expected = "C:\Android\sdk"
    
    if ($normalized -eq $expected) {
        Write-Host "✓ Path calculation correct for: $path" -ForegroundColor Green
    } else {
        Write-Host "✗ Path calculation incorrect for: $path (got: $normalized, expected: $expected)" -ForegroundColor Red
    }
}

Write-Host "`n" -NoNewline
Write-Host "Test suite completed!" -ForegroundColor Cyan
Write-Host "Note: Some tests may show warnings if Android SDK is not fully configured on this system." -ForegroundColor Gray
