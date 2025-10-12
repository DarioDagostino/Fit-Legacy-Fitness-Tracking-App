# Android SDK Setup Guide

This guide helps you configure the Android SDK for the Fit Legacy app development.

## Prerequisites

- **Windows 10/11** (for PowerShell scripts)
- **Java Development Kit (JDK)** 8 or later
  - Download: https://www.oracle.com/java/technologies/downloads/
  - Or install via: `choco install openjdk`
- **Flutter SDK** installed and on PATH
- **Android Studio** (recommended) or Android command-line tools

## Quick Start

### Step 1: Run the Diagnostics Script

Open PowerShell in the project root and run:

```powershell
.\scripts\android_sdk_diagnostics.ps1
```

This will check your current Android SDK configuration and provide guidance on any issues.

### Step 2: Install Android SDK (if needed)

If the diagnostics script indicates that Android SDK is not found:

**Option A: Via Android Studio (Recommended)**
1. Download and install [Android Studio](https://developer.android.com/studio)
2. Open Android Studio → Tools → SDK Manager
3. Install:
   - Android SDK Platform (latest stable version)
   - Android SDK Command-line Tools (latest)
   - Android SDK Build-Tools (latest)
   - Android Emulator (optional, for testing)

**Option B: Command-line tools only**
1. Download command-line tools from https://developer.android.com/studio#cmdline-tools
2. Extract to a location like `C:\Android\sdk`
3. Run the diagnostics script again to get configuration commands

### Step 3: Configure Environment Variables

After the diagnostics script detects your SDK location, it will suggest commands like:

```powershell
$env:ANDROID_SDK_ROOT = 'C:\Users\YourName\AppData\Local\Android\sdk'
$env:Path = 'C:\Users\YourName\AppData\Local\Android\sdk\cmdline-tools\latest\bin' + ';' + $env:Path
```

**To make these permanent (recommended):**

```powershell
# Set environment variables permanently (requires admin privileges)
[System.Environment]::SetEnvironmentVariable('ANDROID_SDK_ROOT', 'C:\Path\To\Your\Android\sdk', 'User')

# Or use Windows Settings:
# 1. Search "Environment Variables" in Windows Search
# 2. Click "Edit the system environment variables"
# 3. Click "Environment Variables" button
# 4. Add ANDROID_SDK_ROOT under "User variables"
# 5. Edit PATH to add: %ANDROID_SDK_ROOT%\cmdline-tools\latest\bin
```

### Step 4: Accept Android Licenses

Run the diagnostics script with the license acceptance flag:

```powershell
.\scripts\android_sdk_diagnostics.ps1 -TryAcceptLicenses
```

This will run `flutter doctor --android-licenses` interactively. Type `y` to accept each license.

## Troubleshooting

### Error: "flutter doctor --android-licenses" exits with negative error code

This typically indicates a crash or access violation. Common causes:

1. **Java not installed or not on PATH**
   - Solution: Install JDK and ensure `java -version` works in PowerShell
   
2. **ANDROID_SDK_ROOT not set correctly**
   - Solution: Verify the path exists and contains `cmdline-tools` or `tools` directory
   
3. **sdkmanager not accessible or corrupted**
   - Solution: Reinstall Android SDK Command-line Tools via Android Studio
   
4. **Missing Android SDK cmdline-tools**
   - Solution: Open Android Studio → SDK Manager → Install "Android SDK Command-line Tools (latest)"

### sdkmanager not found

If the diagnostics script cannot find sdkmanager:

1. Ensure Android Studio is installed
2. Open Android Studio → Tools → SDK Manager
3. In "SDK Tools" tab, check "Android SDK Command-line Tools (latest)"
4. Click "Apply" to install
5. Run the diagnostics script again

### Wrong SDK root path detected

If the script suggests an incorrect SDK root:

1. Manually find your Android SDK location:
   - Default: `%LOCALAPPDATA%\Android\sdk`
   - Android Studio shows it in: File → Settings → Appearance & Behavior → System Settings → Android SDK
   
2. Set ANDROID_SDK_ROOT manually:
   ```powershell
   $env:ANDROID_SDK_ROOT = 'C:\Your\Actual\Path\To\sdk'
   ```

3. Run the diagnostics script again to verify

## Verifying Your Setup

After completing the setup, verify everything works:

```powershell
# Check Flutter configuration
flutter doctor -v

# Check Android SDK
sdkmanager --list

# Check Java
java -version
```

All commands should run without errors.

## CI/CD Configuration

For continuous integration, you may need to:

1. Install Android SDK in CI environment
2. Set ANDROID_SDK_ROOT environment variable
3. Accept licenses non-interactively:
   ```bash
   yes | flutter doctor --android-licenses
   ```

See `.github/workflows/flutter-ci.yml` for the project's CI configuration.

## Additional Resources

- [Flutter Android Setup](https://docs.flutter.dev/get-started/install/windows#android-setup)
- [Android Command Line Tools](https://developer.android.com/studio/command-line)
- [Android Studio Download](https://developer.android.com/studio)
- [Firebase Setup Guide](FIREBASE_SETUP.md) (for this project)

## Support

If you encounter issues not covered in this guide, please:
1. Run the diagnostics script and save the output
2. Check existing GitHub issues
3. Open a new issue with the diagnostics output and error details
