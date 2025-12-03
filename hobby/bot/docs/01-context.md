# 01. Bot Context

**Version:** v3  
**Last Updated:** 03 December 2025

---

## What Are We Building?

A simple bot for [Telegram/Discord/Slack] that helps users with [specific task].

**Example:** A Telegram bot that tracks daily habits and sends reminders.

---

## Why This Bot?

**Problem:** [What problem does it solve?]

**Example:** People forget to track their habits consistently and need simple reminders.

**Solution:** A bot that makes habit tracking frictionless - just send a message, no app switching.

---

## Who Is This For?

**Target Users:**
- [User type 1]
- [User type 2]

**Example:**
- Individuals building daily habits
- People who use messaging apps frequently
- Users who want simple, text-based tracking

---

## Core Features

**Must Have (MVP):**
1. [Feature 1]
2. [Feature 2]
3. [Feature 3]

**Example:**
1. Add habit via command `/track [habit]`
2. Mark habit complete: "did pushups"
3. Daily summary with streak count

**Nice to Have (Later):**
- [Future feature 1]
- [Future feature 2]

**Example:**
- Weekly progress charts
- Habit suggestions
- Social sharing

---

## Bot Persona

**Name:** [BotName]

**Example:** HabitBuddy

**Tone:**
- Encouraging and positive
- Casual and friendly
- Uses emojis sparingly

**Example Messages:**
- "Great job! 🎉 That's 5 days in a row!"
- "Ready to track today's habits?"
- "No worries, every day is a fresh start! 💪"

---

## Success Criteria

**We'll know it's working when:**
- [ ] 10+ active users
- [ ] Users track habits 3+ times per week
- [ ] Bot responds in < 2 seconds
- [ ] Zero downtime for 1 week

---

## Constraints

**Technical:**
- Free hosting (Railway/Render)
- Single developer
- Must work 24/7

**Time:**
- MVP in 2 weeks
- 1-2 hours per day development

**Budget:**
- $0-10 per month max

---

## Out of Scope (For Now)

**Not building:**
- Web dashboard
- Mobile app
- Multi-user teams
- Payment features
- AI-powered insights

**Keep it simple!**

---

## Notes

- Start with Telegram (easiest API)
- Use SQLite for data (upgrade later if needed)
- Deploy early, iterate based on feedback
- Focus on core loop: track → confirm → streak

---

> **Remember:** Ship a working bot fast, add features later based on real usage.
