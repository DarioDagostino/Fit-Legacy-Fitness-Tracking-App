# Fit Legacy — Fitness Tracking App

Minimal starter README for the Fit Legacy project.

## What this is
A Flutter fitness tracking application with Firebase authentication and cloud storage.

## Getting Started

### Windows Users
**[📘 Windows Quick Start Guide](WINDOWS_QUICK_START.md)** - Complete setup instructions for Windows development.

**Important:** On Windows, clone this project to a simple path like `C:\dev\fit-legacy`, NOT in OneDrive-synced folders to avoid CMake build errors.

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

## Troubleshooting

### Windows Build Issues

If you encounter CMake build errors on Windows (especially file extraction or cache errors), see the comprehensive troubleshooting guide:

**[📖 Windows Build Troubleshooting Guide](WINDOWS_BUILD_TROUBLESHOOTING.md)**

Common issues include:
- Project located in OneDrive-synced folders
- Paths with spaces or special characters
- Path length exceeding Windows limits
- Antivirus interference

**Quick fix:** Move your project to a simple path like `C:\dev\fit-legacy` (outside OneDrive).

### Firebase Setup

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for instructions on configuring Firebase for this project.

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
