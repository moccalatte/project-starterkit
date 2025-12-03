# 02. Development Protocol

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Setup (Pick One Stack)
- **React Native + Expo:** Easiest build pipeline, great for hobby. Requires Node 18+ and Expo CLI.
- **Flutter:** Great performance; requires Flutter SDK + Android Studio/Xcode.
- Use `.nvmrc`/`.tool-versions`/`.fvmrc` to keep versions aligned.

### Quick Start (Expo)
```bash
npm install -g expo-cli
npx create-expo-app my-app
cd my-app
cp .env.example .env   # keep secrets local
npm start              # run on simulator/device
```

### Quick Start (Flutter)
```bash
flutter create my_app
cd my_app
flutter run
```

---

## Project Basics
```
mobile/
  app/ or src/
    screens/     # pages
    components/  # shared UI
    hooks/       # state/data
    services/    # API clients
    store/       # optional global state
    assets/
  .env.example   # never commit real secrets
  README.md
```
- Keep it flat until you have a reason to add folders.
- Document every required env var in `.env.example` (API URL, anon key, etc.).

---

## Coding Standards
- **Language:** TypeScript (RN) or Dart (Flutter).
- **Lint/Format:** ESLint + Prettier (RN) or `flutter format` + `analysis_options.yaml`.
- **Architecture:** Feature-first folders; keep network logic in one place; avoid passing props deeply—use hooks or context.
- **State:** Start with local state; add React Query/Provider/Riverpod only when needed.
- **UI:** Use design tokens, consistent spacing, and accessible touch targets (44px). Test dark/light if supported.
- **Offline:** Cache reads (AsyncStorage/SecureStore/SharedPreferences); queue writes and retry when online.

---

## Workflow
- **Branches:** `main` for releases, short-lived `feat/*`. Solo? Commit to `main` but keep commits small.
- **Commits:** `<verb>: <what>` (e.g., `add: offline cache for notes`).
- **Pull Requests:** Optional for solo, but still run lint/tests before merge.
- **Testing:** Manual smoke per change: add/edit/delete core item, offline then online sync, navigation back/forward.

---

## Integrations & Data
- Prefer hosted backend (Supabase/Firebase) to avoid server ops.
- Keep API client in one module; handle auth headers centrally.
- Never hardcode secrets—use env vars or platform config.
- Log errors to console only in dev; surface friendly messages to users.

---

## Release & Delivery
- **Pre-flight:** `npm run lint` / `flutter analyze`, build once locally (`expo prebuild` optional), and verify on one Android + one iOS simulator.
- **Assets:** Keep app icon, splash, and store descriptions in `assets/` and document steps in `README.md`.
- **Channels:** Expo EAS builds or Flutter build → upload to TestFlight/Play Console internal testing.
- **Rollback:** Keep previous build number handy; be ready to resubmit.

---

## Definition of Done
- [ ] Feature matches `03-product_requirements.md`
- [ ] Runs on Android emulator + iOS simulator without red errors
- [ ] Works offline (if applicable) and syncs after reconnect
- [ ] Lint/format clean; no obvious perf regressions
- [ ] README/config updated; .env.example still valid

---

## AI Collaboration
- Provide platform (RN/Flutter), target screen, and API shape in prompts.
- Ask for offline + error states, not just happy path.
- Keep generated code small; refactor for clarity right after.

---

> Ship a small build first, then polish. Fast feedback beats perfect architecture for hobby apps.
