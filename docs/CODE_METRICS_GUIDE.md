# Code Metrics and Quality Guide

This guide explains how to use static analysis tools and maintain code quality in the Fit Legacy project.

## Table of Contents
- [Static Analysis](#static-analysis)
- [Code Metrics](#code-metrics)
- [Dart Code Metrics (DCM)](#dart-code-metrics-dcm)
- [Quality Standards](#quality-standards)
- [CI/CD Integration](#cicd-integration)

## Static Analysis

### Built-in Flutter Analyzer

The project uses Flutter's built-in analyzer with enhanced rules defined in `analysis_options.yaml`.

#### Running the Analyzer

```bash
# Run analysis on the entire project
flutter analyze

# Run analysis with detailed output
flutter analyze --no-fatal-infos

# Check specific files
flutter analyze lib/main.dart
```

#### Analysis Configuration

The `analysis_options.yaml` file includes:
- **Strict type checking**: No implicit casts or dynamic types
- **Security-focused rules**: Detection of unsafe operations
- **Code style rules**: Consistent code formatting
- **Error promotion**: Warning-level issues that should be errors

### Common Issues and Fixes

#### 1. Implicit Casts
```dart
// ❌ BAD - implicit cast
dynamic value = getValue();
String text = value; // Error: implicit cast

// ✅ GOOD - explicit cast
dynamic value = getValue();
String text = value as String;
// Or better, avoid dynamic
String text = getValue() as String;
```

#### 2. Avoid Print
```dart
// ❌ BAD - using print
print('Debug message: $value');

// ✅ GOOD - use logging
import 'package:flutter/foundation.dart';
debugPrint('Debug message: $value');
```

#### 3. Close Sinks
```dart
// ❌ BAD - stream controller not closed
class MyClass {
  final _controller = StreamController<int>();
}

// ✅ GOOD - properly disposed
class MyClass {
  final _controller = StreamController<int>();
  
  void dispose() {
    _controller.close();
  }
}
```

## Code Metrics

### Dart Code Metrics (DCM)

Dart Code Metrics is a powerful static analysis tool for Flutter/Dart projects.

#### Installation

Add DCM to your dev dependencies:

```yaml
# pubspec.yaml
dev_dependencies:
  dart_code_metrics: ^5.7.6
```

```bash
flutter pub get
```

#### Configuration

Create or update `analysis_options.yaml`:

```yaml
dart_code_metrics:
  metrics:
    cyclomatic-complexity: 20
    maximum-nesting-level: 5
    number-of-parameters: 6
    source-lines-of-code: 50
  
  metrics-exclude:
    - test/**
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  
  rules:
    # Naming conventions
    - avoid-non-ascii-symbols
    - avoid-unnecessary-type-assertions
    - avoid-unnecessary-type-casts
    - avoid-unrelated-type-assertions
    
    # Code complexity
    - avoid-nested-conditional-expressions
    - binary-expression-operand-order
    - double-literal-format
    - newline-before-return
    - no-boolean-literal-compare
    - no-empty-block
    - no-equal-then-else
    - prefer-conditional-expressions
    - prefer-first
    - prefer-last
    - prefer-trailing-comma
    
    # Performance
    - avoid-unnecessary-setstate
    - prefer-const-border-radius
    - prefer-extracting-callbacks
    - prefer-single-widget-per-file
    
    # Security
    - avoid-throw-in-catch-block
    - avoid-unsafe-collection-methods
```

#### Running DCM

```bash
# Analyze with DCM
flutter pub run dart_code_metrics:metrics analyze lib

# Check for unused files
flutter pub run dart_code_metrics:metrics check-unused-files lib

# Check for unused code
flutter pub run dart_code_metrics:metrics check-unused-code lib

# Generate HTML report
flutter pub run dart_code_metrics:metrics analyze lib --reporter=html
```

### Metrics Explained

#### 1. Cyclomatic Complexity
- **What**: Measures the number of independent paths through code
- **Target**: < 20 per method
- **Why**: High complexity = hard to test and maintain

```dart
// High complexity - too many conditions
int calculateScore(int age, bool isPremium, String tier) {
  if (age < 18) {
    if (isPremium) {
      if (tier == 'gold') {
        return 100;
      } else if (tier == 'silver') {
        return 80;
      }
    }
  }
  // ... more conditions
}

// Better - extract methods
int calculateScore(int age, bool isPremium, String tier) {
  if (age < 18) return calculateJuniorScore(isPremium, tier);
  return calculateAdultScore(isPremium, tier);
}
```

#### 2. Maximum Nesting Level
- **What**: Deepest level of nested blocks
- **Target**: < 5 levels
- **Why**: Deep nesting is hard to read

```dart
// Too deep
void processData() {
  if (condition1) {
    if (condition2) {
      if (condition3) {
        if (condition4) {
          if (condition5) {
            // Hard to understand
          }
        }
      }
    }
  }
}

// Better - early returns
void processData() {
  if (!condition1) return;
  if (!condition2) return;
  if (!condition3) return;
  if (!condition4) return;
  if (!condition5) return;
  
  // Clear main logic
}
```

#### 3. Number of Parameters
- **What**: Count of parameters in a method
- **Target**: < 6 parameters
- **Why**: Too many parameters = complex interface

```dart
// Too many parameters
void createUser(
  String name,
  String email,
  int age,
  String address,
  String phone,
  String country,
  String zipCode,
) {
  // ...
}

// Better - use a class
class UserData {
  final String name;
  final String email;
  final int age;
  final Address address;
  
  UserData({...});
}

void createUser(UserData userData) {
  // ...
}
```

#### 4. Source Lines of Code (SLOC)
- **What**: Number of lines in a method/class
- **Target**: < 50 lines per method, < 300 per class
- **Why**: Long methods/classes are hard to maintain

## Quality Standards

### Code Coverage

Maintain at least 70% test coverage:

```bash
# Run tests with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Code Review Checklist

Before submitting a PR, verify:
- [ ] `flutter analyze` passes with no errors
- [ ] All tests pass: `flutter test`
- [ ] Code coverage maintained (≥70%)
- [ ] DCM metrics within acceptable ranges
- [ ] No hardcoded secrets or API keys
- [ ] Proper error handling implemented
- [ ] Documentation updated if needed
- [ ] No TODOs in production code

### Style Guide

Follow [Effective Dart](https://dart.dev/guides/language/effective-dart/style):

```dart
// Good naming
class UserProfile { }        // UpperCamelCase for classes
void fetchUserData() { }     // lowerCamelCase for functions
const maxRetries = 3;        // lowerCamelCase for constants
enum UserRole { admin, user } // lowerCamelCase for enum values

// Good formatting
final user = User(
  name: 'John',
  email: 'john@example.com',
); // Trailing comma for better diffs

// Good documentation
/// Fetches user data from the API.
///
/// Throws [NetworkException] if the request fails.
/// Returns [User] object on success.
Future<User> fetchUserData(String userId) async {
  // Implementation
}
```

## CI/CD Integration

### GitHub Actions Workflow

The project's CI workflow includes automated quality checks:

```yaml
# .github/workflows/flutter-ci.yml
- name: Analyze code quality
  run: flutter analyze --no-fatal-infos

- name: Run static security analysis
  run: |
    # Custom security checks
    grep -r "api[_-]key\|password" lib/ || true
```

### Local Pre-commit Hook

Set up a pre-commit hook to run checks automatically:

```bash
# .git/hooks/pre-commit
#!/bin/bash

echo "Running pre-commit checks..."

# Run analyzer
flutter analyze
if [ $? -ne 0 ]; then
  echo "❌ Flutter analyze failed"
  exit 1
fi

# Run tests
flutter test
if [ $? -ne 0 ]; then
  echo "❌ Tests failed"
  exit 1
fi

echo "✅ Pre-commit checks passed"
```

Make it executable:
```bash
chmod +x .git/hooks/pre-commit
```

### IDE Integration

#### VS Code

Install the Dart extension and configure:

```json
// .vscode/settings.json
{
  "dart.lineLength": 80,
  "dart.showTodos": true,
  "dart.previewFlutterUiGuides": true,
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  }
}
```

#### Android Studio / IntelliJ

1. Enable Dart analysis: `Preferences > Editor > Inspections > Dart`
2. Configure code style: `Preferences > Editor > Code Style > Dart`
3. Enable auto-format: `Preferences > Tools > Actions on Save`

## Best Practices

### 1. Write Testable Code

```dart
// ❌ Hard to test - tight coupling
class UserService {
  Future<User> getUser() async {
    final response = await http.get('https://api.example.com/user');
    return User.fromJson(response.body);
  }
}

// ✅ Easy to test - dependency injection
class UserService {
  final HttpClient client;
  
  UserService(this.client);
  
  Future<User> getUser() async {
    final response = await client.get('https://api.example.com/user');
    return User.fromJson(response.body);
  }
}
```

### 2. Use Immutable Data

```dart
// ✅ Immutable with Freezed
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
  }) = _User;
}
```

### 3. Handle Errors Gracefully

```dart
// ✅ Proper error handling
Future<Result<User>> getUser(String id) async {
  try {
    final user = await _repository.fetchUser(id);
    return Result.success(user);
  } on NetworkException catch (e) {
    return Result.failure(NetworkError(e.message));
  } on ValidationException catch (e) {
    return Result.failure(ValidationError(e.message));
  } catch (e) {
    return Result.failure(UnknownError(e.toString()));
  }
}
```

### 4. Optimize Performance

```dart
// ✅ Use const constructors
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Text('Hello'); // const widget
  }
}

// ✅ Avoid rebuilds with keys
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    final item = items[index];
    return MyListItem(
      key: ValueKey(item.id), // Preserve widget state
      item: item,
    );
  },
)
```

## Resources

- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Best Practices](https://docs.flutter.dev/perf/best-practices)
- [Dart Code Metrics Documentation](https://dartcodemetrics.dev/)
- [Flutter Lints Package](https://pub.dev/packages/flutter_lints)
- [OWASP Mobile Security](https://owasp.org/www-project-mobile-security-testing-guide/)

## Continuous Improvement

Quality is an ongoing process:
1. Review metrics regularly
2. Refactor complex code
3. Add tests for new features
4. Update documentation
5. Share knowledge with the team

---

**Last Updated**: October 2025
