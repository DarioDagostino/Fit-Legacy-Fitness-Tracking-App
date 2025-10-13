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

## New: FigmaWidget Component 🎨

A flexible, highly customizable widget component for implementing Figma designs quickly and consistently!

**Features:**
- ✅ 25+ configurable properties (colors, gradients, icons, animations)
- ✅ 7 ready-to-use presets (info, success, warning, achievement, progress, action, compact)
- ✅ Interactive demo screen accessible from the app
- ✅ Comprehensive documentation with 10+ real-world examples

**Quick Start:**
```dart
import 'package:fit_legacy_app/widgets/figma_widget.dart';

// Use a preset
FigmaWidgetPresets.successCard(
  title: '¡Completado!',
  description: 'Has logrado tu objetivo',
  onTap: () {},
)

// Or customize
FigmaWidget(
  title: 'My Widget',
  icon: Icons.star,
  backgroundGradient: LinearGradient(...),
  animated: true,
)
```

**Documentation:**
- 📘 **Quick Start:** `assets/docs/QUICK_START.md`
- 📗 **Complete Guide:** `assets/docs/figma_widget_guide.md`
- 📙 **Examples:** `assets/docs/figma_widget_examples.md`
- 📕 **Visual Guide:** `assets/docs/figma_widget_visual_guide.md`
- 📄 **Summary:** `FIGMA_WIDGET_SUMMARY.md`

**Try the Demo:**
- Run the app and tap the "Widgets Demo" button on the main screen
- Or navigate to: `Navigator.pushNamed(context, AppRoutes.figmaWidgetDemo)`

---

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
