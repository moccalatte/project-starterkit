# 02. Development Protocol

## 2.1 Version Control
- **Repo**: Single repo for cross-platform (Flutter/RN) or separate for Native.
- **Branches**: `main` (Store Release), `develop` (Beta), `feat/*`.

## 2.2 Dev Environment
- **Tools**: VS Code / Android Studio / XCode.
- **SDKs**: Ensure `.fvmrc` (Flutter) or `Gemfile` (iOS) match team versions.
- **Emulators**: Test on minimal supported OS version.

## 2.3 Code Standards
- **Architecture**: BLoC / Riverpod / Redux.
- **Style**: Dart format / Prettier.
- **Assets**: Use vector (SVG) where possible. `@2x`, `@3x` for rasters.

## 2.4 Definition of Done
- [ ] Works on Android Emulator.
- [ ] Works on iOS Simulator.
- [ ] Tested on one physical device.
- [ ] No layout overflows on small screens.
