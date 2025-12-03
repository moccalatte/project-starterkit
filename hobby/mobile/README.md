# Hobby Mobile App Template

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

A lightweight template for building simple mobile apps for hobby projects and MVPs. Perfect for solo developers who want to ship fast without complex infrastructure.

---

## Quick Start

```bash
# 1. Read the context
cat docs/01-context.md

# 2. Set up development
cat docs/02-dev_protocol.md

# 3. Understand features
cat docs/03-product_requirements.md

# 4. Start coding!
```

---

## Stack Recommendations

### React Native (Easier to start)
- **Framework:** React Native + Expo
- **Backend:** Firebase/Supabase (free tier)
- **Hosting:** Expo Application Services (free tier)
- **Best for:** Web developers, quick prototyping

### Flutter (Better performance)
- **Framework:** Flutter
- **Backend:** Firebase/Supabase
- **Best for:** Beautiful UI, near-native performance

---

## What You Get

- **Minimal setup** - Expo for zero config
- **Free backend** - Firebase/Supabase
- **Quick deployment** - Build and share instantly
- **Cross-platform** - iOS & Android from one codebase

---

## Example: Habit Tracker App

### Features
1. Track daily habits
2. View streak counts
3. Simple dashboard
4. Local storage (upgrade to cloud later)

### Setup (5 minutes)
```bash
# React Native with Expo
npx create-expo-app my-app
cd my-app
npx expo start

# Scan QR code with Expo Go app
# Start building!
```

---

## Project Structure

```
my-app/
├── docs/
│   ├── 01-context.md
│   ├── 02-dev_protocol.md
│   └── 03-product_requirements.md
├── src/
│   ├── screens/
│   ├── components/
│   └── App.js
├── app.json
└── package.json
```

---

## Free Stack

### Backend as a Service
- **Firebase** - Auth + Database + Storage (free tier)
- **Supabase** - PostgreSQL + Auth + Storage (free tier)
- **Appwrite** - Open source Firebase alternative

### Development
- **Expo** - Zero config React Native
- **Expo Go** - Test on real devices instantly
- **EAS Build** - Free cloud builds (limited)

---

## Deployment

### Testing (Instant)
```bash
# Start development server
npx expo start

# Share with QR code
# Users scan with Expo Go app
# No app store needed for testing!
```

### Production Build (When Ready)
```bash
# Build APK (Android)
eas build --platform android

# Build IPA (iOS - requires Apple Developer account)
eas build --platform ios
```

---

## Common Patterns

### Screen Navigation
```jsx
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

const Stack = createNativeStackNavigator();

function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Details" component={DetailsScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```

### Local Storage
```jsx
import AsyncStorage from '@react-native-async-storage/async-storage';

// Save data
await AsyncStorage.setItem('key', JSON.stringify(data));

// Load data
const value = await AsyncStorage.getItem('key');
const data = JSON.parse(value);
```

### Firebase Integration
```jsx
import { initializeApp } from 'firebase/app';
import { getFirestore, collection, addDoc } from 'firebase/firestore';

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

// Add document
await addDoc(collection(db, 'tasks'), {
  title: 'New task',
  completed: false
});
```

---

## Documentation

- **[01-context.md](docs/01-context.md)** - What you're building
- **[02-dev_protocol.md](docs/02-dev_protocol.md)** - Setup guide
- **[03-product_requirements.md](docs/03-product_requirements.md)** - Features
- **[AGENTS.md](AGENTS.md)** - AI collaboration guide

---

## Upgrade Path

1. **Start:** Expo + Local storage
2. **Add:** Firebase for sync
3. **Grow:** Custom backend when needed
4. **Scale:** Migrate to SaaS template

---

## Tips for Success

1. **Use Expo** - Avoid native setup complexity
2. **Start with Firebase** - Free backend, no server needed
3. **Test on real devices** - Use Expo Go app
4. **Ship to friends first** - Get feedback before app stores
5. **Add features slowly** - Based on real usage

---

## Common Issues

**Can't run on iOS?**
- Need macOS for iOS simulator
- Use Expo Go on real iPhone for testing
- Build with EAS (no Mac needed)

**App too slow?**
- Profile with React DevTools
- Optimize images
- Use FlatList for long lists
- Consider Flutter if performance critical

**Need native features?**
- Check Expo SDK first (has 100+ modules)
- Create custom native module if needed
- Or eject from Expo (last resort)

---

## Next Steps

1. Read [01-context.md](docs/01-context.md) to define your app
2. Follow [02-dev_protocol.md](docs/02-dev_protocol.md) to set up
3. Build features from [03-product_requirements.md](docs/03-product_requirements.md)
4. Test with Expo Go
5. Share with users and iterate!

---

> **Remember:** Use Expo and Firebase to avoid complexity. Build on real devices from day one. Ship fast! 🚀
