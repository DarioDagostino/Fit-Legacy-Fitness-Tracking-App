# Dependency Management Guide

## Overview
This guide covers dependency management best practices for the Fit Legacy app, including using Dependabot, managing updates, and ensuring security.

## Automated Dependency Updates with Dependabot

### Configuration
The repository uses Dependabot to automatically check for dependency updates:

**Configuration File**: `.github/dependabot.yml`

**Schedule**:
- **Dart/Flutter packages**: Every Monday at 9:00 AM
- **GitHub Actions**: Every Monday at 9:00 AM

**Features**:
- Automatic PR creation for updates
- Security vulnerability alerts
- Grouped minor and patch updates
- Limited to 5 open PRs for packages, 3 for actions

### Reviewing Dependabot PRs

When Dependabot creates a PR:

1. **Check the PR Description**
   - Review the package version change
   - Look for breaking changes
   - Read the changelog link

2. **Review Test Results**
   - Ensure CI/CD passes
   - Check for any new warnings or errors
   - Verify coverage hasn't decreased

3. **Test Locally (for major updates)**
   ```bash
   # Checkout the Dependabot branch
   git fetch origin
   git checkout dependabot/pub/package_name-1.0.0
   
   # Install dependencies
   flutter pub get
   
   # Run tests
   flutter test
   
   # Build the app
   flutter build apk --debug
   ```

4. **Merge Strategy**
   - **Patch updates** (1.0.0 → 1.0.1): Merge immediately if tests pass
   - **Minor updates** (1.0.0 → 1.1.0): Review changelog, merge if compatible
   - **Major updates** (1.0.0 → 2.0.0): Careful review, test thoroughly

### Security Updates

Dependabot flags security vulnerabilities with a **security** label:

- **Critical/High**: Merge immediately after quick validation
- **Medium**: Merge within 1-2 days
- **Low**: Merge with next batch of updates

## Manual Dependency Management

### Checking for Updates

```bash
# Check all outdated packages
flutter pub outdated

# More detailed output
flutter pub outdated --mode=outdated
```

Output explanation:
- **Resolvable**: Can be updated with `flutter pub upgrade`
- **Latest**: Most recent stable version
- **Available**: Newer versions that may have breaking changes

### Updating Dependencies

```bash
# Update all dependencies to latest compatible versions
flutter pub upgrade

# Update a specific package
flutter pub upgrade package_name

# Update to latest (may break compatibility)
flutter pub upgrade --major-versions
```

### Adding New Dependencies

1. **Research the Package**
   - Check pub.dev for package details
   - Review package score and popularity
   - Check maintenance status (last updated)
   - Read the package's CHANGELOG
   - Review security advisories

2. **Add to pubspec.yaml**
   ```yaml
   dependencies:
     new_package: ^1.0.0  # Use caret for compatible updates
   ```

3. **Install**
   ```bash
   flutter pub get
   ```

4. **Test**
   ```bash
   flutter test
   flutter analyze
   ```

## Version Constraints

### Semantic Versioning

Flutter packages follow [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes (1.0.0 → 2.0.0)
- **MINOR**: New features, backwards-compatible (1.0.0 → 1.1.0)
- **PATCH**: Bug fixes, backwards-compatible (1.0.0 → 1.0.1)

### Version Constraint Syntax

```yaml
dependencies:
  # Caret (recommended) - allows compatible updates
  package1: ^1.0.0  # >=1.0.0 <2.0.0
  
  # Exact version - for critical stability
  package2: 1.0.0   # Only 1.0.0
  
  # Range - for specific compatibility
  package3: '>=1.0.0 <2.0.0'
  
  # Latest compatible
  package4: any     # Not recommended for production
```

### When to Pin Versions

**Pin exact versions** (no ^) for:
- Production critical packages
- Packages with known breaking changes
- Security-sensitive packages
- When debugging version-specific issues

**Use caret** (^) for:
- Most regular dependencies
- Well-maintained packages
- Development dependencies

## Security Best Practices

### 1. Regular Audits

Schedule regular dependency audits:

```bash
# Check for outdated packages
flutter pub outdated

# Review security advisories
# Visit: https://github.com/advisories
```

### 2. Dependency Review

Before adding a new dependency, check:
- [ ] Package has good pub.dev score (>100)
- [ ] Active maintenance (updated in last 6 months)
- [ ] Good documentation
- [ ] Reasonable number of dependencies
- [ ] No known security issues
- [ ] Compatible with current Flutter version

### 3. Minimize Dependencies

- Use built-in Flutter/Dart features when possible
- Avoid dependencies for simple functionality
- Prefer packages from verified publishers
- Remove unused dependencies

```bash
# Find unused dependencies (manual check)
# Review imports in your code
grep -r "import 'package:" lib/ | sort | uniq
```

### 4. Lock File Management

**pubspec.lock** should be committed to version control:
- Ensures consistent builds across environments
- Documents exact versions used
- Helps with debugging version-specific issues

## Troubleshooting

### Dependency Conflicts

When you encounter version conflicts:

```bash
# Try upgrading conflicting packages together
flutter pub upgrade package1 package2

# Check dependency tree
flutter pub deps

# Clear cache and retry
flutter pub cache repair
flutter pub get
```

### Breaking Changes

If an update breaks your app:

1. **Read the Migration Guide**
   - Check package CHANGELOG
   - Look for migration documentation

2. **Revert if Needed**
   ```bash
   # Revert pubspec.yaml changes
   git checkout HEAD -- pubspec.yaml pubspec.lock
   flutter pub get
   ```

3. **Update Incrementally**
   - Update one package at a time
   - Test after each update
   - Fix issues before next update

### Build Failures After Update

```bash
# Clean build cache
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter build apk --debug
```

## GitHub Secrets for Dependencies

Some packages require API keys or tokens. Use GitHub Secrets:

### Setting Secrets

```bash
# Via GitHub CLI
gh secret set MAPS_API_KEY --body "your-api-key"

# Via GitHub UI
# Settings > Secrets and variables > Actions > New repository secret
```

### Using in CI/CD

```yaml
# .github/workflows/flutter-ci.yml
env:
  MAPS_API_KEY: ${{ secrets.MAPS_API_KEY }}

steps:
  - name: Build with secret
    run: |
      flutter build apk --dart-define=MAPS_API_KEY=$MAPS_API_KEY
```

### Using in Development

```bash
# Local .env file (never commit)
MAPS_API_KEY=your_dev_api_key

# Use with flutter_dotenv package
flutter pub add flutter_dotenv
```

## Dependency Categories

### Production Dependencies

Critical packages that should be stable:
- firebase_core
- firebase_auth
- flutter_riverpod

**Strategy**: Pin major versions, allow minor updates

### Development Dependencies

Tools used during development:
- build_runner
- freezed
- json_serializable

**Strategy**: Keep updated, less critical

### Testing Dependencies

Packages used only in tests:
- mockito
- flutter_test

**Strategy**: Keep updated with latest features

## Monitoring and Alerts

### Enable GitHub Notifications

1. Repository Settings
2. Security & analysis
3. Enable:
   - Dependabot alerts
   - Dependabot security updates
   - Dependency graph

### Notification Settings

Personal Settings > Notifications:
- ✅ Dependabot alerts
- ✅ Security alerts
- ✅ PR reviews (for Dependabot PRs)

## Best Practices Checklist

- [ ] Dependabot is enabled and configured
- [ ] Review Dependabot PRs within 48 hours
- [ ] Run `flutter pub outdated` monthly
- [ ] Audit dependencies quarterly
- [ ] Pin critical production dependencies
- [ ] Keep pubspec.lock in version control
- [ ] Document API keys in README
- [ ] Use GitHub Secrets for CI/CD
- [ ] Test after every dependency update
- [ ] Review security advisories regularly

## Resources

- [Pub.dev](https://pub.dev/) - Dart package repository
- [Flutter Packages](https://flutter.dev/docs/development/packages-and-plugins)
- [Dependabot Documentation](https://docs.github.com/en/code-security/dependabot)
- [Semantic Versioning](https://semver.org/)
- [GitHub Security Advisories](https://github.com/advisories)

## Emergency Procedures

### Security Vulnerability Found

1. **Immediate Action**
   - Check if vulnerable package is in use
   - Review severity and impact
   - Create emergency PR for update

2. **Update Process**
   ```bash
   # Update vulnerable package
   flutter pub upgrade vulnerable_package
   
   # Test critical paths
   flutter test
   
   # Deploy if urgent
   ```

3. **Communication**
   - Notify team
   - Document in SECURITY.md
   - Update incident log

### Broken Dependency

1. **Identify Issue**
   ```bash
   # Check which package is causing issues
   flutter pub deps
   flutter analyze
   ```

2. **Quick Fix**
   ```bash
   # Option 1: Pin to working version
   # Edit pubspec.yaml with working version
   
   # Option 2: Clear cache
   flutter pub cache repair
   ```

3. **Long-term Solution**
   - Report issue to package maintainer
   - Consider alternative package
   - Document workaround

---

**Last Updated**: October 2025  
**Maintainer**: Development Team
