# Windows Build Troubleshooting Guide

This guide addresses common CMake build errors when developing Flutter apps with Firebase on Windows.

## Common Error: CMake Archive Extraction Failure

### Symptoms

```
cmake -E tar: warning: unknown warning
CMake Error: Problem with archive_write_finish_entry(): File size could not be restored
CMake Error at flutter/ephemeral/.plugin_symlinks/firebase_core/windows/CMakeLists.txt:46 (file):
  file failed to extract:
  C:/Users/.../build/windows/x64/firebase_cpp_sdk_windows_11.10.0.zip

CMake Error: Unable to open check cache file for write. C:/Users/.../build/windows/x64/CMakeFiles/cmake.check_cache
Error: Unable to generate build files
```

### Root Causes

1. **OneDrive Sync Interference**: Project located in OneDrive-synced folders (Documents, Desktop, etc.)
2. **Path Length Issues**: Windows has a 260-character path limit (MAX_PATH)
3. **Path with Spaces**: Special characters or spaces in the project path
4. **File Locking**: Antivirus or other software locking build files
5. **Permissions Issues**: Insufficient write permissions in the build directory

## Solutions

### Solution 1: Move Project Outside OneDrive (Recommended)

OneDrive sync can interfere with CMake's file operations during the build process.

**Steps:**

1. Move your project to a local directory not synced by OneDrive:
   ```powershell
   # Example: Move to C:\dev\
   mkdir C:\dev
   Move-Item "C:\Users\<username>\OneDrive\Documentos\GitHub\Fit-Legacy-Fitness-Tracking-App" "C:\dev\Fit-Legacy-Fitness-Tracking-App"
   ```

2. Update your Git remote if needed:
   ```powershell
   cd C:\dev\Fit-Legacy-Fitness-Tracking-App
   git remote -v
   ```

3. Clean and rebuild:
   ```powershell
   flutter clean
   flutter pub get
   flutter run -d windows
   ```

### Solution 2: Use Short Path Without Spaces

Keep your project path short and without spaces.

**Good paths:**
- `C:\dev\fit-legacy`
- `C:\projects\fit-legacy`
- `D:\code\fit-legacy`

**Problematic paths:**
- `C:\Users\username\OneDrive\Documentos\GitHub\...` (OneDrive + long path)
- `C:\My Projects\Fit Legacy App\...` (spaces)
- Very long nested paths exceeding Windows MAX_PATH

### Solution 3: Clean Build Directory

Sometimes cached build artifacts cause issues.

```powershell
# Navigate to project root
cd path\to\Fit-Legacy-Fitness-Tracking-App

# Remove build artifacts
flutter clean

# Remove the build directory entirely
Remove-Item -Recurse -Force .\build -ErrorAction SilentlyContinue

# Reinstall dependencies
flutter pub get

# Try building again
flutter run -d windows
```

### Solution 4: Run as Administrator

If you suspect permissions issues:

1. Open PowerShell or Command Prompt as Administrator
2. Navigate to your project directory
3. Run:
   ```powershell
   flutter clean
   flutter run -d windows
   ```

### Solution 5: Disable Antivirus Temporarily

Some antivirus software can lock files during the build process.

1. Temporarily disable real-time scanning
2. Add your project directory to the antivirus exclusion list
3. Try building again

### Solution 6: Enable Long Path Support (Windows 10+)

For path length issues:

1. Open Registry Editor (regedit) as Administrator
2. Navigate to: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`
3. Set `LongPathsEnabled` to `1`
4. Restart your computer
5. Or use PowerShell as Administrator:
   ```powershell
   New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force
   ```

### Solution 7: Use Developer Mode (Windows 10+)

Enable Developer Mode to avoid some permission issues:

1. Open Settings → Update & Security → For developers
2. Enable "Developer Mode"
3. Restart your computer

## Prevention Tips

1. **Project Location**: Always keep Flutter projects in simple paths like `C:\dev\` or `C:\projects\`
2. **Avoid OneDrive**: Don't sync development projects with OneDrive, Dropbox, or similar services
3. **Short Paths**: Keep project names and paths short
4. **No Spaces**: Avoid spaces in project paths
5. **Regular Cleaning**: Run `flutter clean` regularly when switching branches or updating dependencies

## Verification

After applying solutions, verify your setup:

```powershell
# Check Flutter doctor
flutter doctor -v

# Clean and get dependencies
flutter clean
flutter pub get

# Try building for Windows
flutter build windows --debug
```

## Additional Resources

- [Flutter Desktop Windows Setup](https://docs.flutter.dev/desktop#windows)
- [Firebase FlutterFire Windows Setup](https://firebase.flutter.dev/docs/overview)
- [Windows MAX_PATH Limitation](https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation)

## Still Having Issues?

If none of these solutions work:

1. Check the full error output with verbose logging:
   ```powershell
   flutter run -d windows -v
   ```

2. Verify CMake installation:
   ```powershell
   cmake --version
   ```

3. Check Visual Studio installation (required for Windows builds):
   ```powershell
   # Should include C++ desktop development tools
   ```

4. Report the issue with full logs to the Firebase FlutterFire repository:
   - [FlutterFire Issues](https://github.com/firebase/flutterfire/issues)
