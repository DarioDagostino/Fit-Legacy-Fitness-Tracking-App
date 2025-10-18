# Docker Environment Issue Note

## Issue Description

During development, the following error was observed in VS Code logs:

```
2025-10-12 02:43:23.947 [info] Starting server github
2025-10-12 02:43:23.952 [info] Connection state: Starting
2025-10-12 02:43:23.961 [info] Starting server from LocalProcess extension host
2025-10-12 02:43:24.172 [info] Connection state: Starting
2025-10-12 02:43:24.192 [info] Connection state: Error spawn docker ENOENT
```

## Root Cause

The error `Error spawn docker ENOENT` indicates that:
- The system cannot find the Docker executable
- VS Code is attempting to start a server in a Docker container
- Docker is either not installed or not in the system PATH

**Important**: This is an **environmental issue** related to the development setup, **NOT** a code issue in the Fit Legacy app itself.

## Understanding ENOENT

`ENOENT` is a system error code that means "Error NO ENTry" - the system cannot find the specified file or command. In this case, it cannot find the `docker` command.

## Solutions

### Option 1: Install Docker (If you need Docker for development)

#### Windows
1. Download Docker Desktop from https://www.docker.com/products/docker-desktop
2. Install Docker Desktop
3. Restart your computer
4. Verify installation: Open PowerShell and run `docker --version`

#### macOS
1. Download Docker Desktop from https://www.docker.com/products/docker-desktop
2. Install Docker Desktop
3. Start Docker from Applications
4. Verify installation: Open Terminal and run `docker --version`

#### Linux (Ubuntu/Debian)
```bash
# Install Docker
sudo apt-get update
sudo apt-get install docker.io

# Add your user to docker group
sudo usermod -aG docker $USER

# Restart or log out and log back in
# Verify installation
docker --version
```

### Option 2: Disable Docker Integration in VS Code (If you don't need Docker)

If you don't need Docker for this Flutter project:

1. Open VS Code Settings (Ctrl+, or Cmd+,)
2. Search for "docker"
3. Disable any Docker-related extensions or features
4. Restart VS Code

### Option 3: Configure PATH (If Docker is installed but not found)

If Docker is installed but VS Code can't find it:

#### Windows
1. Open System Properties > Environment Variables
2. Edit the PATH variable
3. Add Docker installation path (typically `C:\Program Files\Docker\Docker\resources\bin`)
4. Restart VS Code

#### macOS/Linux
1. Check Docker installation: `which docker`
2. Add to your shell profile (~/.bashrc, ~/.zshrc):
   ```bash
   export PATH="/usr/local/bin:$PATH"
   ```
3. Restart your terminal and VS Code

## For Fit Legacy Development

**Good News**: The Fit Legacy app is a Flutter application and **does not require Docker** for normal development, building, or testing.

You only need:
- Flutter SDK (https://flutter.dev/docs/get-started/install)
- Android Studio (for Android development)
- Xcode (for iOS development on macOS)
- Firebase CLI (for Firebase features)

### Recommended Development Setup (Without Docker)

```powershell
# Install Flutter (Windows - using Chocolatey)
choco install flutter

# Or download manually from https://flutter.dev

# Verify Flutter installation
flutter doctor

# Get dependencies
flutter pub get

# Run the app (connects to emulator/device)
flutter run
```

## CI/CD Note

If you're using GitHub Actions or other CI/CD systems that show this error, ensure:
1. Docker is installed in the CI environment (if needed)
2. Or disable Docker-related workflows if not required
3. The Fit Legacy CI workflow (`.github/workflows/flutter-ci.yml`) does NOT require Docker

## Conclusion

This Docker error **does not affect** the Fit Legacy app functionality. It's a VS Code development environment issue that can be safely ignored if you're not using Docker features, or resolved by installing Docker if you need it for other purposes.

The app will work perfectly fine with just the Flutter SDK installed.
