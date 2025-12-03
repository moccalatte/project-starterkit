# 02. Development Protocol

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose
Standards for building and shipping a production-grade mobile app (iOS + Android). Covers repo hygiene, app architecture, integrations, testing, and release management.

---

## 1) Source Control & Branching
- **Branching:** Trunk-based with short-lived `feat/*`, `fix/*`, `chore/*`. Protect `main` (release) and `develop` (beta) if used.
- **Commits:** Conventional Commits with platform tags when useful (`feat: ios add push prompt`, `fix: android handle back navigation`).
- **Reviews:** At least one reviewer; store-release changes require two reviewers and a QA sign-off.

## 2) Environment & Tooling
- **SDK Pinning:** Lock runtimes via `.nvmrc` + `package-lock` (React Native) or `.fvmrc`/`pubspec.lock` (Flutter). Document Xcode/Android Gradle Plugin versions.
- **Secrets:** Use `.env` (React Native) or `.env.dart` (Flutter) for local; use secure config for CI and store builds. Never commit signing keys.
- **Devices:** Minimum support: Android 10+, iOS 15+. Maintain device matrix (small/large phones, one tablet).

## 3) Architecture & Code Standards
- **Structure:** `app/` or `src/` organized by feature. Keep UI (screens/components), state (hooks/BLoC), data (API clients, storage) separated.
- **State Management:** React Query/Zustand/Redux (RN) or Riverpod/BLoC (Flutter). Avoid global state for ephemeral UI.
- **Networking:** Single API client with interceptors (auth, retry, logging). Typed models generated from OpenAPI/GraphQL schema.
- **Offline:** Cache reads; queue writes for retry. Clear queues on auth change. Document conflict resolution in `05-api_integration.md`.
- **UI/UX:** Use design tokens; support dark mode if in scope. Enforce accessibility (font scaling, hit slop, screen reader labels).
- **Assets:** Prefer vector (SVG/Lottie). Provide `@2x/@3x` and mipmaps as needed.

## 4) API Integration & Data
- **Contracts:** Mirror backend contracts from `05-api_integration.md`. Do not ship undocumented endpoints.
- **Auth:** Token storage in secure storage/Keychain. Refresh tokens rotated and revoked on logout.
- **Errors:** Normalize errors to a single shape; surface friendly messages; log trace IDs for backend correlation.
- **Analytics:** Track key events with privacy in mind (no PII). Document events and properties.

## 5) Testing Strategy
- **Unit:** Pure functions, formatters, state reducers/providers.
- **Component/UI:** Snapshot + interaction tests for critical screens.
- **Integration:** API client tests using mock server; offline/online transitions.
- **Device Testing:** Run smoke tests on Android emulator + iOS simulator per PR; nightly on at least one physical device.
- **Performance:** Budget for cold start, bundle size, and memory. Track with CI metrics where possible.

## 6) CI/CD & Releases
- **CI Checks:** lint, typecheck, tests, bundle size guardrail, Android lint, iOS warnings fail build.
- **Build Artifacts:** Generate signed builds via CI; keep keystores/provisioning profiles in secure storage with access controls.
- **Versioning:** Semantic app versions; increment build numbers automatically.
- **Release Channels:** Internal → Beta/TestFlight → Production. Maintain release checklist in `06-store_release.md` with rollback steps.
- **Feature Flags:** Gate risky features; default off until validated in beta.

## 7) Definition of Done
- [ ] Implemented against `03-product_requirements.md` and design mocks
- [ ] Works on Android emulator + iOS simulator; spot-checked on one physical device
- [ ] No critical logs/warnings; handled offline/online transitions
- [ ] Tests pass (unit/UI/integration); CI green; bundle size within budget
- [ ] Release notes, screenshots, and migration steps captured; docs updated

## 8) AI Collaboration Notes
- Provide platform, tooling, and target screen/feature in prompts.
- Ask for platform-specific edge cases (permissions, background tasks, navigation back-stack).
- Request minimal diffs; refactor for readability after generation.

---

> Cross-reference: `04-mobile_architecture.md` for patterns, `05-api_integration.md` for backend contracts and sync rules, `06-store_release.md` for release checklist and store assets.
