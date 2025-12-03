# Hobby Mobile App - AI Collaboration Guide

Docs drive decisions. Start in `docs/`.

---

## Quick Navigation
1. [01-context.md](docs/01-context.md) — app goal, users, constraints
2. [02-dev_protocol.md](docs/02-dev_protocol.md) — setup, standards, workflow
3. [03-product_requirements.md](docs/03-product_requirements.md) — features and acceptance criteria

---

## What AIs Should Know
- Stack: React Native (Expo) or Flutter — confirm which. Managed backend preferred (Supabase/Firebase).
- Target devices: Android 10+ and iOS 15+. Optimize for small screens first.
- Offline-first bias: cache reads, queue writes, and surface sync state.
- Keep secrets in env/secure storage; never hardcode keys in the app bundle.

---

## How to Ask for Help
- Mention platform (RN/Flutter), feature, and API contract if any.
- Request both offline and error handling states.
- Provide simulator/log output when debugging.

---

## Common Tasks
- New screen: add to navigation, wire data via a single service, and include empty/error/loading UI.
- Backend call: update typed client, handle retries, and respect rate limits.
- Release prep: run lint/analyze, test on one Android + one iOS simulator, confirm icons/splash.

---

> 𝚊_𝚟𝚎𝚛𝚢_𝚍𝚎𝚜𝚌𝚛𝚒𝚙𝚝𝚒𝚟𝚎_𝚏𝚒𝚕𝚎_𝚗𝚊𝚖𝚎.𝚖𝚍
