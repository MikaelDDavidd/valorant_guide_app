# Quickstart Guide

## Prerequisites

- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 3.0.0)
- Android Studio / Xcode (for mobile development)
- VS Code with Flutter extension (recommended)

## Setup

```bash
# Clone the repository
git clone https://github.com/MikaelDDavidd/valorant_guide_app.git
cd valorant_guide_app

# Install dependencies
flutter pub get

# Generate code (models, serialization)
flutter pub run build_runner build --delete-conflicting-outputs
```

## Running the App

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device_id>

# Run in debug mode (default)
flutter run

# Run in release mode
flutter run --release
```

## Development Commands

```bash
# Watch for changes and auto-generate code
flutter pub run build_runner watch

# Run tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Analyze code
flutter analyze

# Format code
dart format lib/
```

## Building

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## Project Structure Overview

```
lib/
├── main.dart                 # Entry point
└── app/
    ├── core/                 # Core utilities, constants, base classes
    ├── data/                 # Data layer (HTTP, repositories, services)
    ├── modules/              # Feature modules (Clean Architecture)
    ├── routes/               # Navigation configuration
    ├── utils/                # Theme, assets, strings
    └── widgets/              # Shared widgets
```

## Environment

- **API:** No API keys required - uses public Valorant API
- **Language:** Portuguese (pt-BR) by default
- **Storage:** GetStorage for local persistence
