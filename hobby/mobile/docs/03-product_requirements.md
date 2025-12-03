# 03. Product Requirements

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Core Features (Template)

### Feature 1: Capture & View
- **What:** Create/edit/delete the primary item (note/log/task) with text + optional photo.
- **Why:** Capturing quickly is the main job of the app.
- **Acceptance Criteria:**
  - [ ] Create/edit/delete works offline; syncs when online
  - [ ] Input validated (length, file size)
  - [ ] List shows newest first with search/filter

### Feature 2: Offline Sync
- **What:** Persist locally and sync deltas to backend when connectivity returns.
- **Why:** Hobby apps still need to feel reliable on the go.
- **Acceptance Criteria:**
  - [ ] Data saved locally instantly
  - [ ] Sync resumes automatically after reconnect
  - [ ] Conflicts resolved with "newest wins" or user prompt

### Feature 3: Lightweight Auth (Optional)
- **What:** Email OTP or device-local passcode lock.
- **Why:** Keep private data private without heavy auth flows.
- **Acceptance Criteria:**
  - [ ] Flow is optional and skippable for MVP
  - [ ] Secrets stored in secure storage/Keychain
  - [ ] Logout clears local cache

---

## User Flows

### Flow 1: First Run
```
1) User opens app → sees quick intro (1 screen)
2) Creates first item (text + optional photo)
3) Stays offline-friendly by default; sync toggle visible if backend configured
```

### Flow 2: Offline to Online
```
1) User creates/edits items offline
2) App queues changes locally
3) Connection restored → queued changes sync; user sees status banner
4) Errors show retry button and keep local data intact
```

### Flow 3: Share/Export (Optional)
```
1) User taps Share/Export on an item
2) App generates text/markdown/pdf and opens native share sheet
3) No backend required unless exporting via API
```

---

## Non-Functional Requirements
- **Performance:** Cold start <3s on low-end device; scrolling stays 60fps on list of 200 items.
- **Reliability:** No crashes during a 30-minute exploratory test; offline mode never loses edits.
- **Security:** No secrets in logs; API keys in env/secure storage; network calls use HTTPS.
- **Accessibility:** Font scaling works; tappable targets >=44px; labels for inputs/buttons.

---

## Release Checklist
- [ ] Screens match the intended core flow (no dead ends)
- [ ] Works on Android emulator + iOS simulator (one small device each)
- [ ] Offline create/edit/delete verified
- [ ] Sync path verified after reconnection
- [ ] App icon/splash set; app name correct
- [ ] README + `.env.example` updated with any new config

---

> Keep scope tiny. Ship, gather feedback, and only then add extras like push notifications or rich analytics.
