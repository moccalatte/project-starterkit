# Bot Project Template

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

A complete template for building conversational bots on messaging platforms (Telegram, Discord, Slack) with AI-friendly documentation and best practices.

---

## Quick Start

1. **Understand the context** → Read [01-context.md](docs/01-context.md)
2. **Set up development** → Follow [02-dev_protocol.md](docs/02-dev_protocol.md)
3. **Define requirements** → Review [03-product_requirements.md](docs/03-product_requirements.md)
4. **Build the bot** → Implement using [04-bot_architecture.md](docs/04-bot_architecture.md)

---

## Features

- **Command handlers** - Structured command registry and routing
- **Conversational flows** - State management for multi-step interactions
- **NLP integration** - Natural language understanding for user inputs
- **Session persistence** - User state and context across conversations
- **Security & rate limiting** - Protected endpoints and abuse prevention
- **Webhooks & polling** - Flexible connectivity options

---

## Documentation Index

### Foundation
- **[01. Context](docs/01-context.md)** - Bot purpose, persona, and scope
- **[02. Dev Protocol](docs/02-dev_protocol.md)** - Workflow, testing, deployment

### Product & Design
- **[03. Product Requirements](docs/03-product_requirements.md)** - Commands, flows, and specs
- **[04. Bot Architecture](docs/04-bot_architecture.md)** - Technical design and components
- **[05. Commands & Interactions](docs/05-commands_interactions.md)** - Command registry and menus

### Data & Operations
- **[06. Data & State](docs/06-data_state.md)** - Session handling and database schema
- **[07. Security & Ops](docs/07-security_ops.md)** - Security controls and maintenance

---

## Tech Stack

- **Platform:** Telegram Bot API / Discord API / Slack API
- **Backend:** Node.js (telegraf/discord.js) or Python (python-telegram-bot/discord.py)
- **Database:** PostgreSQL / MongoDB / Redis (for sessions)
- **NLP:** OpenAI API / Dialogflow / Rasa (optional)
- **Deployment:** Docker + Railway / Render / Fly.io

---

## Development Workflow

```bash
# 1. Install dependencies
npm install

# 2. Configure environment
cp .env.example .env
# Add your bot token and other secrets

# 3. Run in development (polling mode)
npm run dev

# 4. Test commands
# Send /start to your bot

# 5. Deploy (webhook mode)
npm run deploy
```

---

## Project Structure

```
bot/
├── docs/                    # Complete documentation
├── src/
│   ├── commands/           # Command handlers
│   ├── flows/              # Conversational flows
│   ├── middleware/         # Auth, logging, rate limiting
│   ├── services/           # Business logic
│   └── index.js            # Entry point
├── tests/                  # Unit and integration tests
├── AGENTS.md              # AI collaboration guide
├── README.md              # This file
└── package.json
```

---

## Common Bot Patterns

### Command Handler
```javascript
bot.command('start', async (ctx) => {
  await ctx.reply('Welcome! Use /help to see commands.');
});
```

### Conversational Flow
```javascript
// Multi-step interaction with state
bot.command('add', async (ctx) => {
  ctx.session.state = 'awaiting_amount';
  await ctx.reply('How much did you spend?');
});
```

### Inline Keyboards
```javascript
await ctx.reply('Choose a category:', {
  reply_markup: {
    inline_keyboard: [[
      { text: 'Food', callback_data: 'cat_food' },
      { text: 'Transport', callback_data: 'cat_transport' }
    ]]
  }
});
```

---

## Next Steps

1. Review all docs in the `/docs` folder sequentially
2. Customize the bot persona and commands for your use case
3. Implement core flows following the architecture guide
4. Test thoroughly before deploying to production
5. Monitor and iterate based on user feedback

---

> **For AI builders:** Check [AGENTS.md](AGENTS.md) for collaboration guidelines and the `/docs` folder for complete technical documentation.
