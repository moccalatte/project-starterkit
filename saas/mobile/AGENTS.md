# Mobile Application - Agent Instructions

The `docs/` folder is your knowledge base.

- **Missing info?** Search there first.
- **Found something useful?** Document it with a descriptive filename.

---

## Quick Navigation

### Start Here
1. **[01-context.md](docs/01-context.md)** - App goals, target users, and market
2. **[02-dev_protocol.md](docs/02-dev_protocol.md)** - Setup, standards, and workflow

### Building
3. **[03-product_requirements.md](docs/03-product_requirements.md)** - Features and specifications
4. **[04-mobile_architecture.md](docs/04-mobile_architecture.md)** - Code structure and patterns
5. **[05-api_integration.md](docs/05-api_integration.md)** - Backend integration and sync

### Release
6. **[06-store_release.md](docs/06-store_release.md)** - App Store and Play Store publishing

---

## Key Concepts

- **Offline-First** - Local storage with background sync - see doc 04 & 05
- **Navigation** - Stack, tab, drawer patterns - see doc 04
- **Authentication** - Biometric, JWT tokens - see doc 04 & 05
- **Push Notifications** - FCM setup and handling - see doc 04
- **Deep Linking** - Universal links, app schemes - see doc 04
- **Store Release** - Build, test, submit process - see doc 06

---

## Framework Choice

**React Native:** JavaScript/TypeScript, large ecosystem, web code sharing  
**Flutter:** Dart, near-native performance, beautiful UI  
**Native:** Swift/Kotlin, best performance, separate codebases

Choose based on team expertise and project requirements.

---

## Platform-Specific Notes

### iOS
- Requires macOS for development
- Xcode for builds and simulators
- CocoaPods for dependencies
- TestFlight for beta testing
- Apple Developer account required ($99/year)

### Android
- Works on any OS (macOS/Windows/Linux)
- Android Studio for builds and emulators
- Gradle for dependency management
- Google Play Console for releases
- Google Play Developer account ($25 one-time)

---

## When You're Stuck

1. Check the relevant doc first
2. Look at cross-references in each doc
3. Search the entire `/docs` folder
4. Ask specific questions with context

---

## Common Tasks

### Adding a new screen
1. Define in `03-product_requirements.md`
2. Create component in `src/screens/`
3. Add to navigation config
4. Implement API integration
5. Test on both platforms

### Implementing offline sync
1. Design sync strategy in `05-api_integration.md`
2. Set up local database (SQLite/Realm)
3. Create sync queue
4. Handle conflicts
5. Test offline scenarios

### Preparing for release
1. Follow checklist in `06-store_release.md`
2. Test on real devices
3. Create app store assets
4. Submit for review
5. Monitor crash reports

---

> 𝚊_𝚟𝚎𝚛𝚢_𝚍𝚎𝚜𝚌𝚛𝚒𝚙𝚝𝚒𝚟𝚎_𝚏𝚒𝚕𝚎_𝚗𝚊𝚖𝚎.𝚖𝚍