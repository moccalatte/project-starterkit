# Hobby Bot Template

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

A lightweight template for building simple, functional bots for hobby projects and MVPs. Perfect for solo developers who want to ship fast without overengineering.

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

## What You Get

- **Minimal setup** - One file to start, expand as needed
- **Free deployment** - Railway, Render, or Replit
- **Simple patterns** - Commands, responses, basic storage
- **Quick iteration** - Ship in days, not weeks

---

## Stack Recommendations

### Node.js (Easier for web devs)
- **Framework:** Telegraf (Telegram) / Discord.js (Discord)
- **Database:** JSON file → SQLite → PostgreSQL (upgrade path)
- **Hosting:** Railway (free tier)

### Python (Better for data/AI)
- **Framework:** python-telegram-bot / discord.py
- **Database:** SQLite → PostgreSQL
- **Hosting:** Render (free tier)

---

## Example: Habit Tracker Bot

### Features
1. Track daily habits via `/track [habit]`
2. Mark complete with "done [habit]"
3. View streaks with `/stats`

### Setup (5 minutes)
```bash
# 1. Create project
mkdir habit-bot && cd habit-bot

# 2. Install dependencies
npm init -y
npm install telegraf dotenv

# 3. Get bot token from @BotFather
# 4. Create .env file
echo "BOT_TOKEN=your_token" > .env

# 5. Create index.js (see example below)
# 6. Run!
node index.js
```

### Code Example
```javascript
require('dotenv').config();
const { Telegraf } = require('telegraf');

const bot = new Telegraf(process.env.BOT_TOKEN);

// In-memory storage (upgrade to DB later)
const habits = {};

bot.command('start', (ctx) => {
  ctx.reply('Welcome! Track habits with /track [habit name]');
});

bot.command('track', (ctx) => {
  const habit = ctx.message.text.split(' ').slice(1).join(' ');
  const userId = ctx.from.id;
  
  if (!habits[userId]) habits[userId] = {};
  habits[userId][habit] = { streak: 0, lastDone: null };
  
  ctx.reply(`✅ Tracking ${habit}!`);
});

bot.hears(/done (.+)/, (ctx) => {
  const habit = ctx.match[1];
  const userId = ctx.from.id;
  
  if (habits[userId]?.[habit]) {
    habits[userId][habit].streak++;
    ctx.reply(`✅ ${habit} complete! Streak: ${habits[userId][habit].streak} days! 🔥`);
  }
});

bot.launch();
console.log('Bot running!');
```

---

## Deployment (Free)

### Railway (Recommended)
```bash
npm i -g @railway/cli
railway login
railway up
railway variables set BOT_TOKEN=your_token
```

### Render
1. Push code to GitHub
2. Connect repo to Render
3. Add environment variable: `BOT_TOKEN`
4. Deploy!

### Replit (Easiest)
1. Import GitHub repo
2. Add secret: `BOT_TOKEN`
3. Click Run
4. Keep alive with UptimeRobot

---

## Project Structure

```
habit-bot/
├── docs/
│   ├── 01-context.md           # What we're building
│   ├── 02-dev_protocol.md      # How to build it
│   └── 03-product_requirements.md  # Features
├── .env                        # Secrets (never commit!)
├── .gitignore
├── index.js                    # Main bot code
├── package.json
└── README.md
```

**Start simple, add complexity only when needed!**

---

## Common Patterns

### Command Handler
```javascript
bot.command('help', (ctx) => {
  ctx.reply('Commands:\n/track - Add habit\n/stats - View streaks');
});
```

### Text Matching
```javascript
bot.hears('hello', (ctx) => ctx.reply('Hi! 👋'));
bot.hears(/done (.+)/, (ctx) => {
  const habit = ctx.match[1];
  // Handle completion
});
```

### Inline Buttons
```javascript
bot.command('menu', (ctx) => {
  ctx.reply('Choose an option:', {
    reply_markup: {
      inline_keyboard: [
        [{ text: '✅ Track', callback_data: 'track' }],
        [{ text: '📊 Stats', callback_data: 'stats' }]
      ]
    }
  });
});

bot.on('callback_query', (ctx) => {
  if (ctx.callbackQuery.data === 'track') {
    ctx.reply('Enter habit name:');
  }
  ctx.answerCbQuery();
});
```

---

## Upgrade Path

### Start: In-Memory Storage
- Fast development
- Resets on restart
- Good for testing

### Next: JSON File
```javascript
const fs = require('fs');
const data = JSON.parse(fs.readFileSync('data.json'));
fs.writeFileSync('data.json', JSON.stringify(data));
```

### Later: SQLite
```bash
npm install better-sqlite3
```

### Production: PostgreSQL
Use Supabase/Neon free tier

---

## Documentation

- **[01-context.md](docs/01-context.md)** - What and why
- **[02-dev_protocol.md](docs/02-dev_protocol.md)** - Setup and workflow
- **[03-product_requirements.md](docs/03-product_requirements.md)** - Features and flows
- **[AGENTS.md](AGENTS.md)** - AI collaboration guide

---

## Tips for Success

1. **Start with one command** - `/start` and `/help` only
2. **Test immediately** - Send messages to your bot
3. **Deploy early** - Use Railway free tier
4. **Add features slowly** - One per day
5. **Get real users ASAP** - Share with friends

---

## Common Issues

**Bot not responding?**
- Check BOT_TOKEN is correct
- Make sure bot is running
- Did you /start the bot in Telegram?

**Need persistence?**
- Start with JSON file
- Upgrade to SQLite when you have 10+ users
- Move to PostgreSQL when you have 100+ users

**Bot crashes?**
- Add error handling: `bot.catch((err) => console.error(err))`
- Check Railway/Render logs
- Use `try/catch` for database operations

---

## Next Steps

1. Read [01-context.md](docs/01-context.md) to define your bot
2. Follow [02-dev_protocol.md](docs/02-dev_protocol.md) to set up
3. Build features from [03-product_requirements.md](docs/03-product_requirements.md)
4. Deploy to Railway
5. Share with users and iterate!

---

> **Remember:** Your first version will be simple and that's perfect! Ship it, learn, improve. 🚀
