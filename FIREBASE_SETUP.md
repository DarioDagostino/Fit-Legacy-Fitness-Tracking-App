Goal: Generate `lib/firebase_options.dart` using the FlutterFire CLI and configure your local machine so the app runs with your Firebase project.

Prerequisites (local):
- Flutter SDK installed and on PATH
- Dart and Flutter configured
- An existing Firebase project (or create one at https://console.firebase.google.com)
- You may need Android SDK cmdline-tools installed for some Firebase features on Android

1) Install the FlutterFire CLI (if not already):

PowerShell (recommended):

```powershell
dart pub global activate flutterfire_cli
```

Make sure your `dart` pub global executables are on PATH. Example path to add to PATH (PowerShell):

```powershell
$env:Path += ";$HOME\AppData\Local\Pub\Cache\bin"
```

2) Authenticate with Google (opens browser):

```powershell
flutterfire login
```

3) Run the configure command from your project root (this will prompt you to select your Firebase project and platforms):

```powershell
flutterfire configure --project "<YOUR_FIREBASE_PROJECT_ID>"
```

This generates `lib/firebase_options.dart` and modifies your platform-specific files as needed.

4) Validate:

```powershell
flutter pub get
flutter run
```

Notes and troubleshooting:
- If `flutterfire configure` fails due to missing Android SDK cmdline-tools, install them via Android Studio SDK manager or follow Android docs to install command-line tools.
- If you want CI-friendly setup, commit the generated `lib/firebase_options.dart` to the repo (safe for client-only config) or store the values in secure env vars and inject during build.

If you'd like, I can try to run `flutterfire configure` from this session, but I can't authorize the Google sign-in flow interactively. It's recommended you run steps 1-3 locally on your machine.
