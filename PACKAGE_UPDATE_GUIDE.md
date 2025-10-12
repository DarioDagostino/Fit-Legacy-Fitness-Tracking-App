# Package Update Guide — Resolving Discontinued Package Warnings

## Issue
When running `flutter pub get` or `dart pub get`, you may see warnings about discontinued packages:
```
build_resolvers
    Package build_resolvers has been discontinued. See https://dart.dev/go/package-discontinue
build_runner_core
    Package build_runner_core has been discontinued. See https://dart.dev/go/package-discontinue
```

## Root Cause
These packages (`build_resolvers` and `build_runner_core`) were deprecated by the Dart team as part of their package consolidation effort. They were transitive dependencies pulled in by older versions of:
- `build_runner: ^2.4.6`
- `freezed: ^2.3.2`
- `json_serializable: ^6.6.1`

## Solution
Update to newer versions of these packages that no longer depend on the discontinued packages.

## Changes Applied

### In `pubspec.yaml`:

**Dependencies updated:**
- `freezed_annotation`: ^2.2.0 → **^2.4.0**

**Dev dependencies updated:**
- `build_runner`: ^2.4.6 → **^2.4.13**
- `freezed`: ^2.3.2 → **^2.5.0**
- `json_serializable`: ^6.6.1 → **^6.8.0**

## Steps to Apply Locally (Windows PowerShell)

1. **Pull the latest changes:**
   ```powershell
   git pull origin main
   ```

2. **Delete the lock file to force a clean resolution:**
   ```powershell
   Remove-Item pubspec.lock
   ```

3. **Get dependencies:**
   ```powershell
   flutter pub get
   ```

4. **Verify no warnings appear.** The output should no longer mention discontinued packages.

5. **Regenerate code files** (only if you see build errors):
   ```powershell
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

   Or use the shorter command:
   ```powershell
   dart run build_runner build --delete-conflicting-outputs
   ```

## Expected Outcome
- ✅ No warnings about discontinued packages when running `flutter pub get`
- ✅ All generated files (*.g.dart, *.freezed.dart) remain compatible
- ✅ App builds and runs without issues
- ✅ Existing features work as before

## Verification

Run these commands to verify everything is working:

```powershell
# Check for warnings
flutter pub get

# Analyze code for issues
flutter analyze

# Run tests
flutter test

# Build the app (optional)
flutter build apk --debug
```

## Troubleshooting

### Issue: Build errors after updating
**Solution:** Delete generated files and regenerate:
```powershell
# Delete all generated files
Get-ChildItem -Recurse -Filter "*.g.dart" | Remove-Item
Get-ChildItem -Recurse -Filter "*.freezed.dart" | Remove-Item

# Regenerate
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: Conflicts during code generation
**Solution:** Use the `--delete-conflicting-outputs` flag (already included above).

### Issue: Still seeing discontinued package warnings
**Solution:**
1. Ensure `pubspec.yaml` has the updated versions
2. Delete `pubspec.lock`
3. Delete `.dart_tool/` directory:
   ```powershell
   Remove-Item -Recurse -Force .dart_tool
   ```
4. Run `flutter pub get` again

## Additional Notes

- These updates are **backward compatible** — no code changes are required in your source files
- The generated files should remain the same, just generated with newer tooling
- These package versions are tested and stable
- If you have any custom build configurations, verify they still work after the update

## References
- [Dart Package Discontinuation Policy](https://dart.dev/go/package-discontinue)
- [build_runner package](https://pub.dev/packages/build_runner)
- [freezed package](https://pub.dev/packages/freezed)
- [json_serializable package](https://pub.dev/packages/json_serializable)
