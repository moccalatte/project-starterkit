# 04. Bot Architecture
**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose
Define the technical architecture, technology stack, and system design for the bot.

---

## System Overview

### Architecture Style
**Event-driven, stateful bot** with webhook-based message processing and persistent session storage.

### Key Components
- **Bot Server** - Message routing and business logic
- **Database** - User data and expense records
- **Session Store** - Conversation state (Redis)
- **NLP Service** - Natural language understanding (optional)
- **Queue System** - Async task processing (optional)

---

## High-Level Architecture

```
┌─────────────┐
│   User      │
│ (Telegram)  │
└──────┬──────┘
       │
       │ Sends message
       ▼
┌─────────────────┐
│  Telegram API   │
│   (Webhook)     │
└──────┬──────────┘
       │
       │ POST /webhook
       ▼
┌─────────────────────────────────────┐
│          Bot Server                 │
│  ┌──────────────────────────────┐  │
│  │  1. Parse Update             │  │
│  │  2. Route to Handler         │  │
│  │  3. Load Session State       │  │
│  │  4. Execute Business Logic   │  │
│  │  5. Save State & Data        │  │
│  │  6. Send Response            │  │
│  └──────────────────────────────┘  │
└────┬─────────────┬──────────────┬──┘
     │             │              │
     ▼             ▼              ▼
┌─────────┐  ┌──────────┐  ┌───────────┐
│  Redis  │  │PostgreSQL│  │ NLP API   │
│ Session │  │   Data   │  │ (Optional)│
└─────────┘  └──────────┘  └───────────┘
```

---

## Technology Stack

### Core Framework
**Option 1: Node.js**
- **Framework:** Telegraf / node-telegram-bot-api
- **Runtime:** Node.js 18+
- **Language:** TypeScript (recommended)

**Option 2: Python**
- **Framework:** python-telegram-bot
- **Runtime:** Python 3.10+
- **Type Hints:** Mandatory

### Database
- **Primary DB:** PostgreSQL 14+ (user data, expenses)
- **Session Store:** Redis 7+ (conversation state)
- **Development:** SQLite (optional, for quick testing)

### Optional Services
- **NLP:** OpenAI API / Dialogflow / Rasa
- **Queue:** Bull (Node) / Celery (Python) for async tasks
- **Monitoring:** Prometheus + Grafana
- **Logging:** Winston (Node) / Loguru (Python)

---

## Message Flow

### Webhook Mode (Production)

```
1. User sends message to bot
   ↓
2. Telegram API validates and forwards to webhook URL
   ↓
3. POST https://yourdomain.com/webhook
   ↓
4. Bot server receives update
   ↓
5. Parse message → Extract command/text
   ↓
6. Load user session from Redis
   ↓
7. Route to appropriate handler
   ↓
8. Execute business logic
   ↓
9. Update database if needed
   ↓
10. Save session state to Redis
    ↓
11. Send response via Telegram API
    ↓
12. Return 200 OK to Telegram
```

### Polling Mode (Development)

```
1. Bot server polls Telegram API every 1-2s
   ↓
2. Receives batch of new updates
   ↓
3. Process each update sequentially
   ↓
4. Same flow as webhook from step 5 onwards
```

---

## State Management (FSM)

### Finite State Machine
Track conversation progress across multiple messages.

### States
- `IDLE` - No active conversation
- `AWAITING_AMOUNT` - Bot asked for expense amount
- `AWAITING_CATEGORY` - Bot asked for category selection
- `AWAITING_NOTE` - Bot asked for optional note
- `AWAITING_CONFIRMATION` - Waiting for user to confirm entry

### State Storage
```javascript
// Redis key structure
user:{telegram_user_id}:state = "AWAITING_CATEGORY"
user:{telegram_user_id}:temp_data = {
  amount: 50,
  item: "dinner",
  timestamp: 1642345678
}
```

### State Transitions
```
IDLE → [user types "/add"] → AWAITING_AMOUNT
AWAITING_AMOUNT → [user enters amount] → AWAITING_CATEGORY
AWAITING_CATEGORY → [user selects category] → AWAITING_NOTE
AWAITING_NOTE → [user adds note or skips] → AWAITING_CONFIRMATION
AWAITING_CONFIRMATION → [user confirms] → IDLE (save to DB)
```

---

## Component Details

### 1. Bot Server

**Responsibilities:**
- Receive and parse incoming updates
- Route messages to command handlers
- Manage session state
- Send responses to users

**Key Modules:**
```
src/
├── index.js              # Entry point, bot initialization
├── commands/             # Command handlers
│   ├── start.js
│   ├── add.js
│   └── stats.js
├── flows/                # Multi-step conversations
│   └── expenseFlow.js
├── middleware/           # Cross-cutting concerns
│   ├── auth.js
│   ├── logging.js
│   └── rateLimit.js
└── services/             # Business logic
    ├── expenseService.js
    └── statsService.js
```

---

### 2. Database Schema

**Users Table:**
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  telegram_id BIGINT UNIQUE NOT NULL,
  username VARCHAR(255),
  first_name VARCHAR(255),
  created_at TIMESTAMP DEFAULT NOW(),
  last_active TIMESTAMP DEFAULT NOW()
);
```

**Expenses Table:**
```sql
CREATE TABLE expenses (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  amount DECIMAL(10, 2) NOT NULL,
  category VARCHAR(100) NOT NULL,
  note TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
```

**Categories Table:**
```sql
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  emoji VARCHAR(10),
  is_active BOOLEAN DEFAULT TRUE
);
```

---

### 3. Session Store (Redis)

**Purpose:** Store temporary conversation state.

**Data Structure:**
```javascript
// User state
SET user:12345:state "AWAITING_CATEGORY"
EXPIRE user:12345:state 300  // 5 min timeout

// Temporary data
HSET user:12345:temp_data amount "50"
HSET user:12345:temp_data item "dinner"
EXPIRE user:12345:temp_data 300
```

**Session Cleanup:**
- Auto-expire after 5 minutes of inactivity
- Clear on `/cancel` command
- Clear after successful completion

---

### 4. Command Router

**Implementation (Node.js/Telegraf):**
```javascript
const { Telegraf } = require('telegraf');
const bot = new Telegraf(process.env.BOT_TOKEN);

// Commands
bot.command('start', startHandler);
bot.command('help', helpHandler);
bot.command('add', addExpenseHandler);
bot.command('stats', statsHandler);

// Text messages (NLP)
bot.on('text', nlpHandler);

// Callbacks (inline buttons)
bot.on('callback_query', callbackHandler);

// Launch
bot.launch();
```

---

### 5. NLP Service (Optional)

**Purpose:** Parse natural language expense entries.

**Example:**
```javascript
Input: "bought coffee for $5"

NLP Output:
{
  intent: "add_expense",
  entities: {
    item: "coffee",
    amount: 5.00,
    currency: "USD"
  },
  confidence: 0.92
}
```

**Integration Options:**
- OpenAI GPT-4 (prompt-based)
- Dialogflow (Google)
- Rasa (self-hosted)
- Simple regex patterns (v1)

---

## Webhook Configuration

### Requirements
- **HTTPS:** Valid SSL certificate required
- **Port:** 443, 80, 88, or 8443
- **Response Time:** Must respond within 60 seconds
- **Status Code:** Return 200 OK even if processing fails

### Setup
```bash
# Set webhook URL
curl -X POST "https://api.telegram.org/bot<TOKEN>/setWebhook" \
  -d "url=https://yourdomain.com/webhook"

# Verify webhook
curl "https://api.telegram.org/bot<TOKEN>/getWebhookInfo"
```

### Express.js Example
```javascript
const express = require('express');
const app = express();

app.use(express.json());

app.post('/webhook', async (req, res) => {
  try {
    await bot.handleUpdate(req.body);
    res.sendStatus(200);
  } catch (error) {
    console.error('Webhook error:', error);
    res.sendStatus(500);
  }
});

app.listen(process.env.PORT || 8443);
```

---

## Error Handling

### Strategy
- **Graceful Degradation:** Bot stays online even if features fail
- **User-Friendly Messages:** Never show technical errors to users
- **Retry Logic:** Retry failed API calls with exponential backoff
- **Fallback:** Default to manual entry if NLP fails

### Error Types
```javascript
// Network errors
try {
  await ctx.reply(message);
} catch (error) {
  logger.error('Failed to send message:', error);
  // Retry up to 3 times
}

// Validation errors
if (!isValidAmount(amount)) {
  return ctx.reply('Please enter a valid amount (e.g., 50 or 50.00)');
}

// System errors
try {
  await saveExpense(data);
} catch (error) {
  logger.error('Database error:', error);
  await ctx.reply('Something went wrong. Please try again.');
  // Notify admin
}
```

---

## Scalability Considerations

### Horizontal Scaling
- **Stateless Bot Servers:** Multiple instances behind load balancer
- **Centralized Session Store:** Redis cluster for shared state
- **Database Read Replicas:** Scale reads independently

### Performance Optimization
- **Caching:** Cache user settings and categories
- **Batch Processing:** Group database writes
- **Async Tasks:** Use queue for heavy operations (report generation)

### Load Balancing
```
         ┌──────────────┐
         │ Load Balancer│
         └──────┬───────┘
                │
      ┌─────────┼─────────┐
      ▼         ▼         ▼
   [Bot 1]  [Bot 2]  [Bot 3]
      │         │         │
      └────┬────┴────┬────┘
           ▼         ▼
        [Redis]  [PostgreSQL]
```

---

## Security Architecture

### Authentication
- Verify `telegram_user_id` from webhook payload
- Validate webhook requests from Telegram (optional: secret token)

### Authorization
- Users can only access their own data
- Implement row-level security in database

### Data Protection
- Encrypt sensitive data at rest (database encryption)
- Use TLS for all API communications
- Never log user messages or personal data

---

## Cross-References
- See [02-dev_protocol.md](02-dev_protocol.md) for deployment workflow
- See [03-product_requirements.md](03-product_requirements.md) for features
- See [06-data_state.md](06-data_state.md) for detailed schema
- See [07-security_ops.md](07-security_ops.md) for security controls

---

> **Note for AI builders:** This architecture balances simplicity and scalability. Start with the basic setup and add complexity (NLP, queues) only when needed.
