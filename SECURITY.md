# Security Policy

## Supported Versions

This project is currently in active development. Security updates are provided for the latest version.

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability in Fit Legacy, please report it responsibly:

1. **DO NOT** open a public issue
2. Email the security concern to the repository owner
3. Include detailed information:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

We aim to respond to security reports within 48 hours.

## Security Features

### Automated Dependency Scanning
- **Dependabot**: Monitors dependencies for known vulnerabilities
- **Weekly updates**: Automatic PRs for security patches
- **Configuration**: `.github/dependabot.yml`

### CI/CD Security
- **Static analysis**: Flutter analyzer catches common security issues
- **Secret scanning**: Automated detection of hardcoded credentials
- **Vulnerability scanning**: Trivy and TruffleHog integration
- **SARIF reporting**: Results visible in GitHub Security tab

### Protected Files
The following sensitive files are excluded from version control:
- Environment files (`.env`, `.env.*`)
- Firebase configuration files
- API keys and secrets
- Signing keys and certificates
- Credentials and tokens

## Security Best Practices for Contributors

### 1. Never Commit Secrets
❌ **BAD**:
```dart
const String API_KEY = "sk_live_123456789";
const String SECRET = "my-secret-token";
```

✅ **GOOD**:
```dart
final String apiKey = const String.fromEnvironment('API_KEY');
final String secret = Platform.environment['SECRET'] ?? '';
```

### 2. Use GitHub Secrets for CI/CD
```yaml
env:
  API_KEY: ${{ secrets.API_KEY }}
  FIREBASE_TOKEN: ${{ secrets.FIREBASE_TOKEN }}
```

### 3. Validate User Input
```dart
// Always validate and sanitize user input
String sanitizeInput(String input) {
  return input.trim().replaceAll(RegExp(r'[^\w\s]'), '');
}
```

### 4. Use HTTPS Only
```dart
// Always use secure connections
const String apiUrl = 'https://api.example.com';  // ✅
// const String apiUrl = 'http://api.example.com';  // ❌
```

### 5. Implement Proper Authentication
- Use Firebase Authentication for user management
- Implement proper session handling
- Never store passwords in plain text
- Use secure token storage (e.g., Flutter Secure Storage)

### 6. Keep Dependencies Updated
```bash
# Regularly check for updates
flutter pub outdated

# Update dependencies
flutter pub upgrade

# Review Dependabot PRs promptly
```

### 7. Code Review Security Checklist
Before merging code, verify:
- [ ] No hardcoded secrets or API keys
- [ ] Input validation implemented
- [ ] Secure communication (HTTPS)
- [ ] Proper error handling (no sensitive info in errors)
- [ ] Authentication/authorization checks
- [ ] Dependencies are up to date
- [ ] Tests cover security-critical paths

## Firebase Security Rules

Ensure Firebase Security Rules are properly configured:

```javascript
// Firestore Security Rules Example
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Require authentication for all operations
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
    
    // User data should only be accessible by the user
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Data Privacy

### Personal Data Handling
- Collect only necessary user data
- Implement data encryption at rest and in transit
- Provide clear privacy policy
- Allow users to export/delete their data
- Comply with GDPR, CCPA, and local regulations

### Analytics and Tracking
- Use privacy-focused analytics
- Obtain user consent before tracking
- Provide opt-out mechanisms
- Anonymize sensitive data

## Secure Development Lifecycle

### 1. Development Phase
- Use `.env` files for local secrets (never commit)
- Enable debug logging only in development mode
- Use development Firebase projects

### 2. Testing Phase
- Test authentication flows
- Test authorization rules
- Perform security regression tests
- Test with invalid/malicious input

### 3. Deployment Phase
- Use GitHub Secrets for production credentials
- Enable Firebase App Check
- Configure proper security rules
- Use signed releases only
- Enable crash reporting (with anonymization)

### 4. Monitoring Phase
- Monitor security alerts in GitHub
- Review Firebase console for anomalies
- Check crash reports for security issues
- Audit access logs regularly

## Incident Response Plan

If a security incident occurs:

1. **Contain**: Immediately rotate compromised credentials
2. **Assess**: Determine the scope and impact
3. **Notify**: Inform affected users if necessary
4. **Remediate**: Fix the vulnerability
5. **Review**: Conduct post-incident analysis
6. **Improve**: Update security practices

## Security Resources

- [OWASP Mobile Security Testing Guide](https://owasp.org/www-project-mobile-security-testing-guide/)
- [Flutter Security Best Practices](https://docs.flutter.dev/security)
- [Firebase Security Documentation](https://firebase.google.com/docs/rules)
- [Dart Security Guidelines](https://dart.dev/guides/libraries/secure-programming)

## Contact

For security concerns, contact the repository maintainer through GitHub or email.

---

**Last Updated**: October 2025
