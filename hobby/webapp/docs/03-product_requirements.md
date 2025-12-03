# 03. Product Requirements

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Core Features

### Feature 1: [Feature Name]

**What:** [Brief description]

**Why:** [Why users need this]

**How It Works:**
1. User does [action]
2. Bot responds with [response]
3. User sees [result]

**Acceptance Criteria:**
- [ ] [Specific testable requirement]
- [ ] [Specific testable requirement]
- [ ] [Specific testable requirement]

**Example:**
```
User: /track pushups
Bot: ✅ Tracked! That's day 5 of your streak! 🔥

User: done pushups
Bot: ✅ Marked complete! Keep it up! 💪
```

---

### Feature 2: [Feature Name]

**What:** [Brief description]

**Why:** [Why users need this]

**How It Works:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Acceptance Criteria:**
- [ ] [Requirement]
- [ ] [Requirement]
- [ ] [Requirement]

---

### Feature 3: [Feature Name]

**What:** [Brief description]

**Why:** [Why users need this]

**How It Works:**
1. [Step 1]
2. [Step 2]

**Acceptance Criteria:**
- [ ] [Requirement]
- [ ] [Requirement]

---

## Commands

| Command | What It Does | Example |
|---------|--------------|---------|
| `/start` | Welcome message | `/start` |
| `/help` | Show commands | `/help` |
| `/track [habit]` | Track new habit | `/track meditation` |
| `/list` | Show all habits | `/list` |
| `/stats` | Show streaks | `/stats` |

---

## User Flows

### Flow 1: First Time User

```
1. User adds bot
2. User sends /start
3. Bot: "Welcome! Track your first habit with /track [habit name]"
4. User: /track running
5. Bot: "✅ Added running! Mark complete anytime with 'done running'"
```

### Flow 2: Daily Check-in

```
1. Bot: "Good morning! Ready to track today's habits?"
2. User: done running
3. Bot: "✅ Running complete! That's 3 days in a row! 🔥"
```

### Flow 3: View Progress

```
1. User: /stats
2. Bot shows:
   📊 Your Streaks
   
   🏃 Running: 7 days
   🧘 Meditation: 3 days
   💪 Pushups: 1 day
   
   Keep going! 💪
```

---

## Success Metrics

**How we measure success:**

- **Engagement:** Users track habits 3+ times per week
- **Retention:** Users return for 7+ days
- **Performance:** Bot responds in < 2 seconds
- **Reliability:** 99% uptime

---

## User Experience Guidelines

### Response Times
- Simple commands: < 1 second
- Database queries: < 2 seconds
- Error messages: Immediate

### Tone & Voice
**Do:**
- ✅ "Great job! That's 5 days!"
- ✅ "Ready to track today?"
- ✅ "No worries, try again 😊"

**Don't:**
- ❌ "Your habit has been successfully stored in the database."
- ❌ "ERROR: Invalid input format."
- ❌ "Operation completed with status code 200."

### Error Messages
- "Hmm, I didn't understand that. Try /help"
- "That habit doesn't exist. Create it with /track"
- "Oops! Something went wrong. Try again?"

---

## Technical Requirements

### Must Have
- Works 24/7 (deployed)
- Stores user data persistently
- Handles 10+ concurrent users
- Basic error handling

### Performance
- Response time: < 2 seconds
- Can handle 100 messages/day
- Database size: < 100MB (SQLite)

### Security
- Don't expose bot token
- Validate user inputs
- Basic rate limiting (if needed)

---

## Out of Scope (v1)

**Not building:**
- Web dashboard
- Multi-user teams
- Payment/subscriptions
- Advanced analytics
- Social features
- Voice/audio messages
- File uploads

**Keep it simple!**

---

## MVP Checklist

### Week 1: Core Features
- [ ] `/start` command
- [ ] `/help` command
- [ ] `/track [habit]` - add habit
- [ ] Natural input: "done [habit]"
- [ ] Basic data storage (JSON/SQLite)

### Week 2: Polish & Deploy
- [ ] `/list` - show habits
- [ ] `/stats` - show streaks
- [ ] Error handling
- [ ] Deploy to Railway/Render
- [ ] Test with real users

---

## Example: Habit Tracker Bot

### Commands
```
/start → Welcome message + tutorial
/help → List all commands
/track meditation → Add new habit
/list → Show all habits
/stats → Show streak counts
done meditation → Mark habit complete
/delete meditation → Remove habit
```

### Data Structure
```json
{
  "users": {
    "12345": {
      "habits": {
        "meditation": {
          "streak": 7,
          "lastDone": "2025-01-15",
          "createdAt": "2025-01-08"
        },
        "running": {
          "streak": 3,
          "lastDone": "2025-01-15",
          "createdAt": "2025-01-12"
        }
      }
    }
  }
}
```

---

## Next Steps

1. Start with `/start` and `/help` commands
2. Add habit tracking (simplest version)
3. Test with yourself for 3 days
4. Add streak counter
5. Deploy and share with friends
6. Iterate based on feedback

---

> **Remember:** Ship the simplest version that works. Add features based on real usage, not imagination! 🚀
