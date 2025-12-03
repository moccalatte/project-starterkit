# 01. Mobile App Context

**Version:** v3  
**Last Updated:** 03 December 2025

---

## What Are We Building?
A lightweight cross-platform mobile app for [specific purpose], built with React Native or Flutter. Keep scope small, ship to friends/TestFlight/closed testing fast.

**Example:** A simple field-notes app that lets users capture notes with photos offline and syncs when online.

---

## Why This App?
- **Problem:** [What pain are we solving?] (e.g., people lose context when they cannot save notes offline)
- **Solution:** A focused mobile experience with offline capture, simple sync, and zero-friction onboarding.

---

## Who Is This For?
- [User group 1] (e.g., students taking quick study notes)
- [User group 2] (e.g., hikers wanting offline capture)

**Usage settings:** Short, frequent sessions; unstable connectivity; limited attention.

---

## Core Features (MVP)
1. Create/edit core item (e.g., note/log/entry) with text + optional photo.
2. Offline-first storage with background sync when online.
3. Simple browsing list with search/filter.

### Nice to Have (Later)
- Basic auth (email/OTP or passcode lock)
- Push reminders
- Share/export to email/Drive

---

## Success Criteria
- [ ] Users can add an item in <2 taps
- [ ] Works offline and syncs within 10s after reconnection
- [ ] App cold start <3s on low-end device
- [ ] No crashes during a 1-day dogfood test

---

## Constraints
- **Time:** MVP in 1–2 weekends; solo or pair.
- **Budget:** Free tiers only (Supabase/Firebase/Expo EAS free builds).
- **Devices:** Android 10+ and iOS 15+; design for small phones first.

---

## Out of Scope (v1)
- Payments/subscriptions
- Complex sharing/teams
- Heavy analytics or A/B tests
- Tablet-optimized layouts

---

## Notes
- Prefer managed backend (Supabase/Firebase) to avoid server maintenance.
- Start with Expo/Flutter stable channel; avoid custom native modules unless necessary.
- Release early to a small group; collect feedback via a single in-app link.

---

> Build the smallest mobile experience that proves the core loop. Polish after usage feedback.
