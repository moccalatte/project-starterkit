# 02. Development Protocol

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

Development rules and best practices for building bot projects. Follow these guidelines to maintain code quality and enable smooth AI collaboration.

---

## 1. Project Setup

### Required Files
```
my-bot/
├── .env                 # Secrets (NEVER commit!)
├── .env.example         # Template for environment variables
├── .gitignore           # Git ignore rules
├── README.md            # Project overview
├── package.json         # Dependencies (Node.js)
│   or requirements.txt  # Dependencies (Python)
└── index.js or bot.py   # Main entry point
```

### .gitignore
```
# Environment
.env
.env.local

# Dependencies
node_modules/
venv/
__pycache__/

# Database
*.db
*.sqlite
*.sqlite3
data.json

# Logs
*.log
logs/

# OS
.DS_Store
Thumbs.db
```

### .env.example
```
# Bot Configuration
BOT_TOKEN=your_bot_token_here
BOT_USERNAME=your_bot_username

# Database (if needed)
DATABASE_URL=sqlite:///bot.db

# Environment
NODE_ENV=development
```

---

## 2. Coding Standards

### DO ✅
- **Use descriptive names**: `addHabit()` not `add()`
- **Comment complex logic**: Explain WHY, not WHAT
- **Keep functions small**: One function = one purpose
- **Use async/await**: Avoid callback hell
- **Validate user inputs**: Never trust user data
- **Handle errors gracefully**: User-friendly messages
- **Log important actions**: Debug easier
- **Use environment variables**: Never hardcode secrets

### DON'T ❌
- **Don't commit .env files**: Use .env.example instead
- **Don't hardcode tokens**: Always use process.env
- **Don't ignore errors**: At least log them
- **Don't use var**: Use const/let (JavaScript)
- **Don't skip validation**: Check inputs first
- **Don't expose stack traces**: Show friendly errors to users
- **Don't skip .gitignore**: Set it up first thing

---

## 3. Code Organization

### Start Simple (One File)
```javascript
// index.js
require('dotenv').config();
const { Telegraf } = require('telegraf');

const bot = new Telegraf(process.env.BOT_TOKEN);

// Commands
bot.command('start', handleStart);
bot.command('help', handleHelp);

// Handlers
function handleStart(ctx) {
  ctx.reply('Welcome!');
}

function handleHelp(ctx) {
  ctx.reply('Use /start to begin');
}

bot.launch();
```

### Expand When Needed (Multiple Files)
```
src/
├── commands/
│   ├── start.js
│   ├── help.js
│   └── track.js
├── utils/
│   └── database.js
└── index.js
```

**Rule:** Only create folders when you have 5+ related files.

---

## 4. Git Workflow

### Commit Messages
```bash
# Good commits
git commit -m "Add /track command for habits"
git commit -m "Fix rate limiting error"
git commit -m "Update help text with examples"

# Bad commits
git commit -m "update"
git commit -m "fix bug"
git commit -m "changes"
```

**Format:** `<verb> <what>` in present tense
- Add, Fix, Update, Remove, Refactor

### Branching (Optional for Solo)
```bash
# For solo projects - just use main
git add .
git commit -m "Add feature"
git push

# For teams - use feature branches
git checkout -b feature/add-stats
git commit -m "Add /stats command"
git push origin feature/add-stats
```

---

## 5. Environment Management

### Local Development
```bash
# Copy example
cp .env.example .env

# Edit with your values
# BOT_TOKEN=123456:ABC...

# Run locally
npm start
# or
python bot.py
```

### Production/Deployment
```bash
# Use platform's environment variables
# Railway: railway variables set BOT_TOKEN=...
# Render: Add in dashboard
# Never commit production .env!
```

---

## 6. Error Handling

### DO ✅
```javascript
// Catch errors gracefully
bot.catch((err, ctx) => {
  console.error('Error:', err);
  ctx.reply('Oops! Something went wrong. Try again?');
});

// Validate inputs
bot.command('track', (ctx) => {
  const habit = ctx.message.text.split(' ').slice(1).join(' ');
  
  if (!habit) {
    return ctx.reply('Please provide a habit name!\nExample: /track meditation');
  }
  
  // Process valid input
});
```

### DON'T ❌
```javascript
// Don't ignore errors
bot.command('track', (ctx) => {
  // No error handling - bad!
});

// Don't expose technical errors
bot.catch((err, ctx) => {
  ctx.reply(`ERROR: ${err.stack}`); // DON'T DO THIS!
});
```

---

## 7. Security Rules

### Secrets Management
✅ **DO:**
- Use .env for all secrets
- Add .env to .gitignore
- Provide .env.example template
- Use platform environment variables in production

❌ **DON'T:**
- Hardcode tokens in code
- Commit .env files
- Share tokens in screenshots
- Log sensitive data

### Input Validation
```javascript
// Always validate and sanitize
function sanitizeInput(text) {
  // Remove excessive whitespace
  text = text.trim();
  
  // Limit length
  if (text.length > 200) {
    text = text.substring(0, 200);
  }
  
  return text;
}
```

---

## 8. Database Guidelines

### Start Simple
```javascript
// JSON file for <100 users
const fs = require('fs');
const data = JSON.parse(fs.readFileSync('data.json'));
```

### Upgrade Path
```
1. JSON file (testing)
   ↓
2. SQLite (< 100 users)
   ↓
3. PostgreSQL (production)
```

### Always Backup
```bash
# Add to .gitignore
*.db

# Backup before major changes
cp bot.db bot.db.backup
```

---

## 9. Testing

### Manual Testing Checklist
Before every commit:
- [ ] Bot responds to /start
- [ ] All commands work
- [ ] Error messages are friendly
- [ ] No crashes on invalid input
- [ ] Secrets not exposed in logs

### Test Commands
```
/start
/help
invalid_command
/track
/track meditation
/track with very long name that exceeds limit
```

---

## 10. Deployment

### Pre-deployment Checklist
- [ ] .gitignore includes .env
- [ ] .env.example created
- [ ] All secrets use environment variables
- [ ] Error handling in place
- [ ] Tested locally
- [ ] README updated

### Environment Variables
```bash
# Always required
BOT_TOKEN=xxx

# Optional based on features
DATABASE_URL=xxx
WEBHOOK_URL=xxx
NODE_ENV=production
```

---

## 11. AI Collaboration Rules

### For AI Assistants
✅ **DO:**
- Follow this protocol strictly
- Use environment variables
- Add error handling
- Provide clear comments
- Suggest best practices
- Point out security issues

❌ **DON'T:**
- Hardcode secrets
- Skip validation
- Ignore error handling
- Create unnecessary complexity
- Suggest outdated patterns

### For Developers
✅ **DO:**
- Review AI-generated code
- Test before committing
- Ask AI to explain unclear code
- Request best practices
- Use AI for boilerplate

❌ **DON'T:**
- Blindly copy-paste
- Skip security review
- Deploy untested code

---

## 12. Documentation

### Code Comments
```javascript
// Good: Explain WHY
// Increment streak only if completed within 24 hours of last completion
if (isWithin24Hours(lastComplete, now)) {
  streak++;
}

// Bad: Explain WHAT (obvious from code)
// Add 1 to streak
streak++;
```

### README Updates
Update README when you:
- Add new commands
- Change deployment process
- Add new dependencies
- Change environment variables

---

## 13. Performance

### DO ✅
- Cache frequently accessed data
- Use database indexes (when scaling)
- Implement rate limiting if needed
- Clean up old data periodically

### DON'T ❌
- Load all data into memory
- Make unnecessary API calls
- Store large files in database
- Skip cleanup routines

---

## 14. Logging

### What to Log
```javascript
// Log important actions
console.log(`[${new Date().toISOString()}] User ${userId} tracked habit: ${habit}`);

// Log errors
console.error(`[ERROR] Failed to save habit:`, error.message);
```

### What NOT to Log
```javascript
// DON'T log secrets
console.log('Token:', process.env.BOT_TOKEN); // ❌

// DON'T log personal data
console.log('User message:', ctx.message.text); // ❌ (may contain sensitive info)

// DON'T log excessively
console.log('Function called'); // ❌ (creates noise)
```

---

## 15. Upgrade Path

### When to Refactor
- More than 300 lines in one file → Split into modules
- More than 100 users → Move to SQLite
- More than 1000 users → Move to PostgreSQL
- More than 3 commands → Organize in /commands folder

---

## Cross-References
- See [01-context.md](01-context.md) for project goals
- See [03-product_requirements.md](03-product_requirements.md) for features

---

> **Remember:** These rules exist to keep code clean, secure, and maintainable. Follow them from day one, not after problems appear! 🚀
