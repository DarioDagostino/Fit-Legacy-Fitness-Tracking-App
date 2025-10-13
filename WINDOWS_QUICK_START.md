# Windows Quick Start Guide

Quick reference for building and running the Fit Legacy app on Windows.

## Prerequisites

1. **Flutter SDK** - [Download](https://docs.flutter.dev/get-started/install/windows)
2. **Visual Studio 2022** - Install with "Desktop development with C++" workload
3. **Git** - For version control
4. **Firebase Project** - Create at [Firebase Console](https://console.firebase.google.com)

## Installation Steps

### 1. Clone the Repository

**Important:** Clone to a simple path without spaces, NOT in OneDrive.

```powershell
# Good - Simple path
cd C:\
mkdir dev
cd dev
git clone https://github.com/DarioDagostino/Fit-Legacy-Fitness-Tracking-App.git fit-legacy
cd fit-legacy

# Bad - OneDrive path (will cause CMake errors)
# cd C:\Users\username\OneDrive\Documents\GitHub
```

### 2. Install Dependencies

```powershell
flutter pub get
```

### 3. Configure Firebase

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed instructions.

Quick steps:
```powershell
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Login to Firebase
flutterfire login

# Configure your project
flutterfire configure --project "<YOUR_FIREBASE_PROJECT_ID>"
```

### 4. Run the App

```powershell
# Check Flutter setup
flutter doctor -v

# Run on Windows
flutter run -d windows

# Or build release version
flutter build windows --release
```

## Common Commands

### Clean Build
```powershell
flutter clean
flutter pub get
flutter run -d windows
```

### Debug Build
```powershell
flutter build windows --debug
```

### Release Build
```powershell
flutter build windows --release
```

### Run Tests
```powershell
flutter test
```

### Code Analysis
```powershell
flutter analyze
```

## Troubleshooting

If you encounter build errors, see:
- **[Windows Build Troubleshooting Guide](WINDOWS_BUILD_TROUBLESHOOTING.md)** - CMake errors, path issues
- **[Firebase Setup Guide](FIREBASE_SETUP.md)** - Firebase configuration

### Quick Fixes

**CMake extraction errors:**
```powershell
# Move project to C:\dev\ if it's in OneDrive
flutter clean
flutter pub get
```

**"Unable to open check cache file":**
```powershell
# Run as Administrator
flutter clean
flutter run -d windows
```

**Build fails after dependency update:**
```powershell
flutter clean
flutter pub get
flutter pub upgrade
```

## Development Workflow

1. **Start Development Server** (hot reload)
   ```powershell
   flutter run -d windows
   ```

2. **Make Code Changes** - Save files for hot reload

3. **Run Tests**
   ```powershell
   flutter test
   ```

4. **Analyze Code**
   ```powershell
   flutter analyze
   ```

5. **Build Release**
   ```powershell
   flutter build windows --release
   ```

## Project Structure

```
fit-legacy/
├── lib/                  # Dart source code
│   ├── main.dart        # App entry point
│   ├── screens/         # UI screens
│   ├── providers/       # State management
│   ├── services/        # Business logic
│   └── widgets/         # Reusable components
├── windows/             # Windows platform code
├── test/                # Unit and widget tests
├── assets/              # Images, fonts, etc.
└── pubspec.yaml         # Dependencies
```

## Next Steps

1. Configure Firebase (see FIREBASE_SETUP.md)
2. Run the app: `flutter run -d windows`
3. Explore the codebase in `lib/`
4. Add features and tests
5. Build release: `flutter build windows --release`

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Desktop Windows](https://docs.flutter.dev/desktop#windows)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
