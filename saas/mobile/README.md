# Mobile Application Project Template

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

A complete template for building production-ready mobile applications (iOS/Android) with AI-friendly documentation and best practices.

---

## Quick Start

1. **Understand the context** → Read [01-context.md](docs/01-context.md)
2. **Set up development** → Follow [02-dev_protocol.md](docs/02-dev_protocol.md)
3. **Define requirements** → Review [03-product_requirements.md](docs/03-product_requirements.md)
4. **Build the app** → Implement using [04-mobile_architecture.md](docs/04-mobile_architecture.md)

---

## Features

- **Cross-platform** - iOS and Android from single codebase
- **Offline-first** - Local storage with background sync
- **Push notifications** - Real-time user engagement
- **Biometric authentication** - Face ID / Touch ID / Fingerprint
- **Deep linking** - Seamless navigation from external sources
- **Camera & media** - Photo capture and gallery access
- **Maps & location** - Geolocation and mapping features
- **App store optimization** - Release and deployment guides

---

## Documentation Index

### Foundation
- **[01. Context](docs/01-context.md)** - App goals, target users, and market
- **[02. Dev Protocol](docs/02-dev_protocol.md)** - Setup, standards, and workflow

### Product & Design
- **[03. Product Requirements](docs/03-product_requirements.md)** - Features and specifications
- **[04. Mobile Architecture](docs/04-mobile_architecture.md)** - Code structure and patterns
- **[05. API Integration](docs/05-api_integration.md)** - Backend integration and sync

### Release & Operations
- **[06. Store Release](docs/06-store_release.md)** - App Store and Play Store publishing

---

## Tech Stack

### Framework Options

**React Native (Recommended for Web Developers)**
- **Language:** JavaScript/TypeScript
- **UI:** React Native components
- **Navigation:** React Navigation
- **State:** Redux Toolkit / Zustand
- **Pros:** Shared code with web, large ecosystem
- **Cons:** Performance for complex animations

**Flutter (Recommended for Performance)**
- **Language:** Dart
- **UI:** Material/Cupertino widgets
- **Navigation:** Navigator 2.0
- **State:** Provider / Riverpod / Bloc
- **Pros:** Near-native performance, beautiful UI
- **Cons:** Smaller ecosystem than RN

**Native (iOS/Android)**
- **iOS:** Swift + SwiftUI / UIKit
- **Android:** Kotlin + Jetpack Compose / XML
- **Pros:** Best performance, full platform access
- **Cons:** Maintain two codebases

---

## Development Setup

### Prerequisites
```bash
# React Native
- Node.js 18+
- Watchman (macOS)
- Xcode (iOS)
- Android Studio (Android)
- CocoaPods (iOS dependencies)

# Flutter
- Flutter SDK
- Xcode (iOS)
- Android Studio (Android)
```

### Installation

**React Native:**
```bash
# Install dependencies
npm install

# iOS setup
cd ios && pod install && cd ..

# Start Metro bundler
npm start

# Run on iOS
npm run ios

# Run on Android
npm run android
```

**Flutter:**
```bash
# Install dependencies
flutter pub get

# Run on iOS
flutter run -d ios

# Run on Android
flutter run -d android
```

---

## Project Structure

### React Native
```
mobile/
├── docs/                    # Complete documentation
├── src/
│   ├── components/         # Reusable UI components
│   ├── screens/            # Screen components
│   ├── navigation/         # Navigation setup
│   ├── services/           # API clients
│   ├── store/              # State management
│   ├── utils/              # Helpers
│   └── assets/             # Images, fonts
├── ios/                    # iOS native code
├── android/                # Android native code
├── AGENTS.md              # AI collaboration guide
└── README.md              # This file
```

### Flutter
```
mobile/
├── docs/
├── lib/
│   ├── widgets/           # Reusable widgets
│   ├── screens/           # Screen widgets
│   ├── models/            # Data models
│   ├── services/          # API clients
│   ├── providers/         # State management
│   └── utils/             # Helpers
├── ios/
├── android/
└── pubspec.yaml
```

---

## Common Patterns

### API Request (React Native)
```typescript
import { useQuery } from '@tanstack/react-query';
import { api } from '../services/api';

export function useUsers() {
  return useQuery({
    queryKey: ['users'],
    queryFn: () => api.get('/users'),
    staleTime: 60000
  });
}

// In component
const { data, isLoading, error } = useUsers();
```

### Local Storage (React Native)
```typescript
import AsyncStorage from '@react-native-async-storage/async-storage';

// Save data
await AsyncStorage.setItem('user', JSON.stringify(userData));

// Load data
const userJson = await AsyncStorage.getItem('user');
const user = userJson ? JSON.parse(userJson) : null;
```

### Push Notifications (React Native)
```typescript
import messaging from '@react-native-firebase/messaging';

// Request permission
await messaging().requestPermission();

// Get FCM token
const token = await messaging().getToken();

// Handle foreground messages
messaging().onMessage(async (remoteMessage) => {
  console.log('Notification:', remoteMessage);
});
```

---

## Key Features Implementation

### Offline-First Architecture
- Local SQLite/Realm database
- Background sync queue
- Conflict resolution strategy
- Network status detection
- Retry mechanism

### Authentication
- JWT token storage (secure)
- Biometric authentication
- Auto-refresh tokens
- Session management
- Logout and cleanup

### Navigation
- Stack navigation (screens)
- Tab navigation (bottom tabs)
- Drawer navigation (side menu)
- Deep linking support
- Navigation guards

### Performance
- Image optimization and caching
- List virtualization (FlatList)
- Memoization (React.memo)
- Code splitting
- Native modules for heavy tasks

---

## Build & Release

### iOS Build
```bash
# Development build
npm run ios

# Production build
cd ios
xcodebuild -workspace App.xcworkspace \
  -scheme App \
  -configuration Release \
  -archivePath build/App.xcarchive \
  archive
```

### Android Build
```bash
# Development build
npm run android

# Production build (APK)
cd android
./gradlew assembleRelease

# Production build (AAB)
./gradlew bundleRelease
```

### App Store Submission
See [06-store_release.md](docs/06-store_release.md) for complete guide.

---

## Testing

### Unit Tests
```bash
# React Native
npm test

# Flutter
flutter test
```

### E2E Tests
```bash
# Detox (React Native)
npm run test:e2e:ios
npm run test:e2e:android

# Integration tests (Flutter)
flutter test integration_test/
```

### Manual Testing Checklist
- [ ] Works on iOS (latest 2 versions)
- [ ] Works on Android (API 21+)
- [ ] Offline functionality
- [ ] Push notifications
- [ ] Deep links
- [ ] Biometric auth
- [ ] Camera/media access
- [ ] Different screen sizes
- [ ] Dark mode (if supported)
- [ ] Performance (60 FPS)

---

## Common Issues & Solutions

### iOS Build Fails
```bash
# Clean build
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
npm run ios
```

### Android Build Fails
```bash
# Clean build
cd android
./gradlew clean
cd ..
npm run android
```

### Metro Bundler Issues
```bash
# Reset cache
npm start -- --reset-cache
```

---

## Performance Optimization

### Bundle Size
- Code splitting
- Remove unused dependencies
- Use Hermes (React Native)
- Enable ProGuard (Android)
- Optimize images

### Runtime Performance
- Use FlatList for long lists
- Implement pagination
- Optimize re-renders
- Use native modules
- Profile with Flipper

---

## Security Checklist

- [ ] Secure token storage (Keychain/Keystore)
- [ ] HTTPS only for API calls
- [ ] Certificate pinning (optional)
- [ ] Obfuscate code (Android ProGuard)
- [ ] No sensitive data in logs
- [ ] Biometric authentication
- [ ] App integrity checks
- [ ] Secure local database

---

## App Store Requirements

### iOS App Store
- Valid Apple Developer account ($99/year)
- App icons (all sizes)
- Screenshots (all device sizes)
- Privacy policy URL
- App description and keywords
- TestFlight beta testing

### Google Play Store
- Google Play Developer account ($25 one-time)
- Feature graphic (1024x500)
- Screenshots (phone & tablet)
- Privacy policy URL
- App description
- Closed/Open testing tracks

---

## Monitoring & Analytics

### Crash Reporting
- **Sentry** - Error tracking
- **Firebase Crashlytics** - Crash analytics
- **Bugsnag** - Error monitoring

### Analytics
- **Firebase Analytics** - User behavior
- **Mixpanel** - Product analytics
- **Amplitude** - User insights

### Performance
- **Firebase Performance** - App performance
- **React Native Performance** - Custom metrics

---

## Next Steps

1. Review all docs in the `/docs` folder sequentially
2. Choose your framework (React Native vs Flutter vs Native)
3. Set up development environment
4. Implement authentication flow
5. Build core features with offline support
6. Test on real devices
7. Prepare app store assets
8. Submit for review

---

## Resources

### Learning
- [React Native Documentation](https://reactnative.dev/docs/getting-started)
- [Flutter Documentation](https://docs.flutter.dev/)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Android Material Design](https://material.io/design)

### Tools
- [Flipper](https://fbflipper.com/) - Debugging
- [Reactotron](https://github.com/infinitered/reactotron) - Inspector
- [Firebase](https://firebase.google.com/) - Backend services
- [Fastlane](https://fastlane.tools/) - Deployment automation

---

> **For AI builders:** Check [AGENTS.md](AGENTS.md) for collaboration guidelines and the `/docs` folder for complete technical documentation.
