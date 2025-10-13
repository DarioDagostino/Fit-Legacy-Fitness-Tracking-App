# Fit Legacy — Fitness Tracking App

Minimal starter README for the Fit Legacy project.

## What this is
A placeholder README and .gitignore to initialize the repository. Replace this with your project description and development instructions when ready.

## Files created
- `README.md` — this file
- `.gitignore` — common ignores for Node, Python, editors, and OS files

## Quick instructions (PowerShell)
Run the following in the project root to initialize git and push the first commit to GitHub. Replace the remote URL with your SSH URL if preferred.

```powershell
# initialize git, add files and commit
git init
git add README.md .gitignore
git commit -m "chore: initial commit"

# set main branch and add remote (replace URL if you use SSH)
git branch -M main
git remote add origin https://github.com/DarioDagostino/Fit-Legacy-Fitness-Tracking-App.git

git push -u origin main
```

If you already have files to add, include them with `git add .` before committing.

## Next suggestions
- Add a short project description and development setup steps (dependencies, run commands).
- If this is a Node/React project, create `package.json` next with `npm init` and add a basic `README` section about scripts.
- Consider adding a LICENSE file when you decide on a license.

## Repository maintenance

This project includes design assets and generated files that may be large. The following guidance helps keep the repository healthy on GitHub.

- Git LFS (Large File Storage): For large binary assets (PDFs, PSDs, high-resolution images, Figma exports) enable Git LFS locally and track large file patterns. Example commands (PowerShell):

```powershell
# install Git LFS (one-time)
# choco install git-lfs -y ; git lfs install

# track common large assets (run once in repo root)
git lfs track "assets/**/*.psd"
git lfs track "assets/**/*.pdf"
git lfs track "assets/**/*.png"
git lfs track "assets/**/*.jpg"
git lfs track "assets/**/*.zip"

# commit .gitattributes file created by git-lfs
git add .gitattributes
git commit -m "chore: add Git LFS tracking for large assets"
```

- Continuous Integration (GitHub Actions): This repo includes a simple Flutter CI workflow that runs on push and pull request to `main`. It performs `flutter pub get`, `dart analyze`, runs unit tests and attempts a debug build for the current platform. See `.github/workflows/flutter-ci.yml` for details.

- Pull Request template: A lightweight PR template is included to make reviews quicker. Use the template when opening PRs.

If you'd like, I can enable/adjust GitHub Actions matrixes (Windows/macOS/Linux), add code signing steps, or wire the workflow to upload artifacts.

## Security and Performance Best Practices

### 🔒 Security Features

#### Dependabot Configuration
This repository is configured with Dependabot to automatically check for dependency updates:
- **Dart/Flutter packages**: Weekly checks every Monday at 9:00 AM
- **GitHub Actions**: Weekly checks for workflow dependencies
- Automatic PR creation for security and version updates
- Grouped minor and patch updates to reduce PR noise

Configuration file: `.github/dependabot.yml`

#### Sensitive Files Protection
The `.gitignore` file is configured to exclude sensitive files from version control:
- Environment files (`.env`, `.env.*`)
- API keys and secrets (`key.properties`, `secrets.yaml`)
- Firebase configuration files (when not needed in VCS)
- Android signing keys (`*.jks`, `*.keystore`)
- iOS certificates and provisioning profiles

**Important**: Never commit:
- API keys or tokens
- Firebase service account keys
- Signing certificates or keystores
- Environment-specific configurations with credentials

#### GitHub Secrets Management
Use GitHub Secrets for sensitive data in CI/CD:

```bash
# Set secrets via GitHub CLI
gh secret set FIREBASE_TOKEN --body "your-firebase-token"
gh secret set ANDROID_KEYSTORE_PASSWORD --body "your-password"
```

Or via GitHub UI: `Settings > Secrets and variables > Actions > New repository secret`

Access secrets in workflows:
```yaml
- name: Deploy to Firebase
  env:
    FIREBASE_TOKEN: ${{ secrets.FIREBASE_TOKEN }}
  run: firebase deploy --token $FIREBASE_TOKEN
```

### 🚀 Performance Features

#### Dependency Caching
The CI workflow uses caching strategies to improve build times:
- Flutter SDK caching via `subosito/flutter-action@v2`
- Pub dependencies caching with `actions/cache@v3`
- Typical time savings: 30-60 seconds per build

#### Static Security Analysis
Automated security scanning on every push/PR:
- **Dart Analyzer**: Built-in Flutter code analysis
- **Dependency Vulnerability Scanning**: Checks for outdated/vulnerable packages
- **Secret Detection**: Scans code for potential hardcoded secrets
- **Trivy Scanner**: Filesystem vulnerability scanning
- **TruffleHog**: Advanced secret detection in commit history

### 📋 Development Guidelines

#### Managing Dependencies Securely

1. **Review Dependabot PRs promptly**: Security updates should be merged quickly
2. **Test dependency updates**: Run full test suite before merging
3. **Pin critical dependencies**: Use exact versions for production dependencies
4. **Audit new dependencies**: Review package reputation and maintainership

```yaml
# Example: Pin specific versions for critical packages
dependencies:
  firebase_core: 2.10.0  # Pinned version
  firebase_auth: ^4.4.0   # Allows minor updates
```

#### Environment Configuration

Create environment-specific configuration files:

```dart
// lib/config/env_config.dart
class EnvConfig {
  static String get apiKey => 
    const String.fromEnvironment('API_KEY', defaultValue: '');
  
  static String get firebaseProjectId => 
    const String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: '');
}
```

Pass environment variables at build time:
```bash
flutter build apk --dart-define=API_KEY=your_key_here
```

#### Secret Management in Development

1. **Use a `.env` file for local development** (never commit it):
```env
API_KEY=your_development_api_key
FIREBASE_PROJECT_ID=your_project_id
```

2. **Load environment variables** using a package like `flutter_dotenv`:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}
```

3. **Use GitHub Secrets for CI/CD** (as shown above)

#### Code Quality Standards

- Run `flutter analyze` before committing
- Maintain test coverage above 70%
- Use `dart format` for consistent code style
- Follow Flutter's [style guide](https://dart.dev/guides/language/effective-dart/style)

### 🔍 Security Scanning Reports

CI/CD includes multiple security scanning tools:

1. **Code Analysis**: `flutter analyze` catches common issues
2. **Dependency Scanning**: Checks for known vulnerabilities via `flutter pub outdated`
3. **Secret Scanning**: Detects hardcoded credentials
4. **SARIF Reports**: Uploaded to GitHub Security tab for tracking

View security reports: `Repository > Security > Code scanning alerts`

### 📊 Monitoring and Alerts

Enable GitHub security features:
- **Dependabot alerts**: Automatic notifications for vulnerable dependencies
- **Code scanning alerts**: Static analysis findings from CI
- **Secret scanning**: Detects accidentally committed secrets (requires GitHub Advanced Security for private repos)

Configure notifications: `Settings > Notifications > Security alerts`

### 🛠️ Troubleshooting

**Dependabot not creating PRs?**
- Check `.github/dependabot.yml` syntax
- Verify repository settings allow Dependabot
- Review Dependabot logs in Security tab

**CI builds failing after dependency update?**
- Review breaking changes in package changelog
- Update code to match new API
- Consider pinning to previous version temporarily

**Secret detected in code?**
- Immediately rotate the exposed secret
- Remove from git history: `git filter-branch` or `BFG Repo-Cleaner`
- Update all environments with new credentials
