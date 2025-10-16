# 🏛️ Fit Legacy - Fitness Tracking App

A Flutter fitness tracking application that combines stoic philosophy with modern fitness tracking, featuring **Legacito**, your stoic training companion.

## 🎯 Features

- **Real-time Step Tracking**: Native pedometer integration
- **Streak System**: Track consecutive days of activity
- **AI-Powered Chat**: Conversational companion powered by Gemini AI
- **Gamification**: Achievements and badges based on stoic philosophy
- **Pixel-Perfect Design**: Responsive UI that works across all devices
- **Legacito Companion**: 8 different mood states with smooth animations

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0.0 or higher)
- **Dart SDK** (comes with Flutter)
- **Git**
- **Android Studio** or **Xcode** (for mobile development)
- **Firebase Account** (for backend services)

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/DarioDagostino/Fit-Legacy-Fitness-Tracking-App.git
cd Fit-Legacy-Fitness-Tracking-App
```

### 2. Install Flutter Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

This app uses Firebase for authentication, analytics, and cloud storage. Follow these steps to set up Firebase:

#### Install FlutterFire CLI

The FlutterFire CLI is a tool that helps you configure Firebase for your Flutter app.

```bash
dart pub global activate flutterfire_cli
```

#### 🪟 Windows Users: Configure PATH for FlutterFire CLI

**Important:** After installing the FlutterFire CLI on Windows, you need to add it to your system PATH to use it from the command line.

When you run the FlutterFire CLI for the first time, you may see a warning like:

```
Warning: Pub installs executables into C:\Users\<YourUsername>\AppData\Local\Pub\Cache\bin, which is not on your path.
```

**To fix this issue:**

1. **Copy the path** provided in the warning (it usually looks like `C:\Users\<YourUsername>\AppData\Local\Pub\Cache\bin`)

2. **Open Environment Variables:**
   - Press the **Windows Key**
   - Type `env`
   - Select **"Edit the system environment variables"**

3. **Edit System Variables:**
   - In the **System Properties** window, click the **"Environment Variables..."** button

4. **Add to PATH:**
   - In the top section (**"User variables for..."**), select the **Path** variable
   - Click **"Edit..."**
   - Click **"New"**
   - Paste the path you copied earlier (`C:\Users\<YourUsername>\AppData\Local\Pub\Cache\bin`)
   - Click **"OK"** on all windows to save your changes

5. **Restart your terminal/command prompt** for the changes to take effect

6. **Verify installation:**
   ```bash
   flutterfire --version
   ```

#### Configure Firebase for Your App

Once the FlutterFire CLI is installed and accessible:

```bash
# Login to Firebase
firebase login

# Configure your Flutter app with Firebase
flutterfire configure
```

This will:
- Create or select a Firebase project
- Register your app with Firebase
- Generate the necessary configuration files (`firebase_options.dart`)

### 4. Configure Gemini AI (Optional)

The app uses Google's Gemini AI for intelligent chat responses.

1. Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create or update `lib/core/config/app_config.dart`:

```dart
class AppConfig {
  static const String geminiApiKey = 'YOUR_API_KEY_HERE';
}
```

### 5. Platform-Specific Setup

#### Android

Update `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Add these permissions -->
    <uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.INTERNET" />
    
    <!-- Your existing application configuration -->
</manifest>
```

#### iOS

Update `ios/Runner/Info.plist`:

```xml
<dict>
    <!-- Add this key -->
    <key>NSMotionUsageDescription</key>
    <string>This app needs access to motion sensors to count your steps</string>
    
    <!-- Your existing configuration -->
</dict>
```

### 6. Run the App

```bash
# Run on connected device or emulator
flutter run

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release
```

## 🛠️ Development

### Generate Code

The app uses code generation for models and serialization:

```bash
# Generate code once
flutter packages pub run build_runner build

# Watch for changes and regenerate
flutter packages pub run build_runner watch

# Clean and regenerate (if you encounter conflicts)
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Run Tests

```bash
flutter test
```

### Code Analysis

```bash
flutter analyze
```

## 📱 App Structure

```
lib/
├── core/
│   ├── constants/          # Colors, typography, spacing
│   ├── theme/             # App themes
│   └── config/            # App configuration
├── models/                # Data models with Freezed
├── providers/             # State management with Riverpod
├── screens/               # App screens
├── widgets/               # Reusable widgets
└── main.dart             # App entry point
```

## 🔥 Common Issues & Troubleshooting

### FlutterFire CLI Not Found (Windows)

**Problem:** After installing FlutterFire CLI, the `flutterfire` command is not recognized.

**Solution:** Follow the [Windows PATH configuration steps](#-windows-users-configure-path-for-flutterfire-cli) above.

### Firebase Configuration Failed

**Problem:** `flutterfire configure` fails or can't find your project.

**Solution:**
1. Ensure you're logged in: `firebase login`
2. Verify your Firebase project exists in the [Firebase Console](https://console.firebase.google.com/)
3. Run `flutterfire configure` again and carefully select your project

### Step Counter Not Working

**Problem:** The pedometer doesn't count steps.

**Solution:**
1. Ensure permissions are granted in device settings
2. For Android API 29+, request ACTIVITY_RECOGNITION permission at runtime
3. Test on a physical device (emulators may not support pedometer)

### Build Errors After Firebase Setup

**Problem:** Build errors related to Firebase or Gradle.

**Solution:**
1. Clean the build: `flutter clean`
2. Get dependencies: `flutter pub get`
3. For Android, verify `android/app/build.gradle` has the correct Firebase configuration
4. Try rebuilding: `flutter run`

## 📚 Additional Documentation

- **[Legacito Implementation](LEGACITO_IMPLEMENTATION.md)** - Details about the Legacito companion feature
- **[Pixel Perfect Design](PIXEL_PERFECT_README.md)** - Design system and UI guidelines
- **[Legacito Features](README_LEGACITO.md)** - Comprehensive Legacito documentation (Spanish)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- **Stoic Philosophy**: Marcus Aurelius, Epictetus, and Seneca
- **Flutter Team**: For the amazing framework
- **Google AI**: For Gemini AI integration
- **Flutter Community**: For packages and support

---

**"Discipline is the bridge between goals and achievements."** - Legacito 🏛️
