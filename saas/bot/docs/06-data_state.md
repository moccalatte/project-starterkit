# 06. Data & State Management
**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose
Define database schema, session state management, and data persistence strategies for the bot.

---

## Database Schema

### Users Table

**Purpose:** Store user profiles and preferences.

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  telegram_id BIGINT UNIQUE NOT NULL,
  username VARCHAR(255),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  language_code VARCHAR(10) DEFAULT 'en',
  
  -- Preferences
  currency VARCHAR(3) DEFAULT 'USD',
  timezone VARCHAR(50) DEFAULT 'UTC',
  week_start INTEGER DEFAULT 1, -- 0=Sunday, 1=Monday
  notifications_enabled BOOLEAN DEFAULT TRUE,
  
  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  last_active TIMESTAMP DEFAULT NOW(),
  
  -- Indexes
  INDEX idx_telegram_id (telegram_id),
  INDEX idx_last_active (last_active)
);
```

---

### Expenses Table

**Purpose:** Store all expense transactions.

```sql
CREATE TABLE expenses (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  
  -- Expense details
  amount DECIMAL(10, 2) NOT NULL,
  currency VARCHAR(3) NOT NULL DEFAULT 'USD',
  category_id INTEGER REFERENCES categories(id),
  note TEXT,
  
  -- Metadata
  source VARCHAR(20) DEFAULT 'manual', -- 'manual', 'nlp', 'recurring'
  is_deleted BOOLEAN DEFAULT FALSE,
  
  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  expense_date DATE DEFAULT CURRENT_DATE,
  
  -- Indexes
  INDEX idx_user_id (user_id),
  INDEX idx_expense_date (expense_date),
  INDEX idx_category_id (category_id),
  INDEX idx_created_at (created_at),
  
  -- Constraints
  CHECK (amount > 0)
);
```

---

### Categories Table

**Purpose:** Predefined and user-custom expense categories.

```sql
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  emoji VARCHAR(10),
  color VARCHAR(7), -- Hex color code
  
  -- Type
  is_system BOOLEAN DEFAULT FALSE, -- System vs user-created
  user_id INTEGER REFERENCES users(id), -- NULL for system categories
  
  -- Status
  is_active BOOLEAN DEFAULT TRUE,
  sort_order INTEGER DEFAULT 0,
  
  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  
  -- Constraints
  UNIQUE (user_id, name),
  CHECK (is_system = TRUE OR user_id IS NOT NULL)
);
```

**Default Categories:**
```sql
INSERT INTO categories (name, emoji, is_system) VALUES
  ('Food', '🍔', TRUE),
  ('Transport', '🚗', TRUE),
  ('Entertainment', '🎬', TRUE),
  ('Bills', '🏠', TRUE),
  ('Shopping', '🛍️', TRUE),
  ('Health', '⚕️', TRUE),
  ('Other', '📌', TRUE);
```

---

### User Settings Table

**Purpose:** Extended user preferences and configuration.

```sql
CREATE TABLE user_settings (
  user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  
  -- Budget settings
  monthly_budget DECIMAL(10, 2),
  budget_alert_threshold INTEGER DEFAULT 80, -- Alert at 80%
  
  -- Display preferences
  date_format VARCHAR(20) DEFAULT 'YYYY-MM-DD',
  number_format VARCHAR(20) DEFAULT 'en-US',
  
  -- Features
  nlp_enabled BOOLEAN DEFAULT TRUE,
  auto_categorize BOOLEAN DEFAULT TRUE,
  
  -- Updated timestamp
  updated_at TIMESTAMP DEFAULT NOW()
);
```

---

## Session State Management

### Redis Schema

**Purpose:** Store temporary conversation state and context.

### State Keys

**User State:**
```
user:{telegram_id}:state → "AWAITING_CATEGORY"
TTL: 300 seconds (5 minutes)
```

**Temporary Data:**
```
user:{telegram_id}:temp_data → JSON object
{
  "amount": 50,
  "item": "dinner",
  "timestamp": 1642345678,
  "currency": "USD"
}
TTL: 300 seconds (5 minutes)
```

**Rate Limiting:**
```
ratelimit:{telegram_id}:messages → counter
TTL: 60 seconds
```

**Active Sessions:**
```
active_sessions → Set of telegram_ids
```

---

### State Machine

**Possible States:**

```javascript
const States = {
  IDLE: 'IDLE',
  AWAITING_AMOUNT: 'AWAITING_AMOUNT',
  AWAITING_CATEGORY: 'AWAITING_CATEGORY',
  AWAITING_NOTE: 'AWAITING_NOTE',
  AWAITING_CONFIRMATION: 'AWAITING_CONFIRMATION',
  EDITING_EXPENSE: 'EDITING_EXPENSE',
  SELECTING_PERIOD: 'SELECTING_PERIOD',
  CONFIGURING_SETTINGS: 'CONFIGURING_SETTINGS'
};
```

**State Transitions:**
```
IDLE → /add → AWAITING_AMOUNT
AWAITING_AMOUNT → [user enters amount] → AWAITING_CATEGORY
AWAITING_CATEGORY → [user selects category] → AWAITING_NOTE
AWAITING_NOTE → [user adds note/skips] → AWAITING_CONFIRMATION
AWAITING_CONFIRMATION → [confirm] → IDLE (save to DB)
AWAITING_CONFIRMATION → [edit] → EDITING_EXPENSE
ANY_STATE → /cancel → IDLE
```

---

### Session Management Code

**Store Session:**
```javascript
async function saveSession(userId, state, data) {
  const redis = getRedisClient();
  
  // Save state
  await redis.set(
    `user:${userId}:state`,
    state,
    'EX', 300 // 5 min expiry
  );
  
  // Save temporary data
  if (data) {
    await redis.set(
      `user:${userId}:temp_data`,
      JSON.stringify(data),
      'EX', 300
    );
  }
}
```

**Load Session:**
```javascript
async function loadSession(userId) {
  const redis = getRedisClient();
  
  const state = await redis.get(`user:${userId}:state`) || 'IDLE';
  const tempDataStr = await redis.get(`user:${userId}:temp_data`);
  const tempData = tempDataStr ? JSON.parse(tempDataStr) : {};
  
  return { state, tempData };
}
```

**Clear Session:**
```javascript
async function clearSession(userId) {
  const redis = getRedisClient();
  
  await redis.del(`user:${userId}:state`);
  await redis.del(`user:${userId}:temp_data`);
}
```

---

## Data Access Layer

### Service Pattern

**Expense Service:**
```javascript
class ExpenseService {
  async createExpense(userId, data) {
    const { amount, categoryId, note, expenseDate } = data;
    
    const result = await db.query(`
      INSERT INTO expenses (user_id, amount, category_id, note, expense_date)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
    `, [userId, amount, categoryId, note, expenseDate || new Date()]);
    
    return result.rows[0];
  }
  
  async getExpensesByPeriod(userId, startDate, endDate) {
    const result = await db.query(`
      SELECT e.*, c.name as category_name, c.emoji as category_emoji
      FROM expenses e
      LEFT JOIN categories c ON e.category_id = c.id
      WHERE e.user_id = $1 
        AND e.expense_date BETWEEN $2 AND $3
        AND e.is_deleted = FALSE
      ORDER BY e.expense_date DESC, e.created_at DESC
    `, [userId, startDate, endDate]);
    
    return result.rows;
  }
  
  async getStatsByCategory(userId, startDate, endDate) {
    const result = await db.query(`
      SELECT 
        c.name as category,
        c.emoji,
        SUM(e.amount) as total,
        COUNT(e.id) as count
      FROM expenses e
      JOIN categories c ON e.category_id = c.id
      WHERE e.user_id = $1 
        AND e.expense_date BETWEEN $2 AND $3
        AND e.is_deleted = FALSE
      GROUP BY c.id, c.name, c.emoji
      ORDER BY total DESC
    `, [userId, startDate, endDate]);
    
    return result.rows;
  }
  
  async deleteExpense(userId, expenseId) {
    await db.query(`
      UPDATE expenses 
      SET is_deleted = TRUE, updated_at = NOW()
      WHERE id = $1 AND user_id = $2
    `, [expenseId, userId]);
  }
}
```

---

## Audit Logging

### Audit Log Table

**Purpose:** Track all critical user actions for compliance and debugging.

```sql
CREATE TABLE audit_logs (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  telegram_id BIGINT,
  
  -- Action details
  action VARCHAR(50) NOT NULL, -- 'expense_added', 'expense_deleted', etc.
  entity_type VARCHAR(50), -- 'expense', 'category', 'settings'
  entity_id INTEGER,
  
  -- Context
  details JSONB, -- Additional context
  ip_address INET,
  user_agent TEXT,
  
  -- Timestamp
  created_at TIMESTAMP DEFAULT NOW(),
  
  -- Indexes
  INDEX idx_user_id (user_id),
  INDEX idx_action (action),
  INDEX idx_created_at (created_at)
);
```

**Example Audit Entry:**
```json
{
  "user_id": 123,
  "telegram_id": 987654321,
  "action": "expense_added",
  "entity_type": "expense",
  "entity_id": 456,
  "details": {
    "amount": 50.00,
    "category": "Food",
    "source": "nlp",
    "original_message": "coffee $5"
  },
  "created_at": "2025-01-15T10:30:00Z"
}
```

---

## Data Retention Policy

### User Data
- **Active users:** Retained indefinitely
- **Inactive users (90 days):** Send reminder
- **Inactive users (180 days):** Archive expenses, keep user profile
- **Inactive users (365 days):** Full deletion upon request

### Session Data
- **Temporary state:** Auto-expire after 5 minutes
- **Rate limit counters:** Auto-expire after 1 minute
- **Cache data:** Auto-expire after 1 hour

### Audit Logs
- **Retention period:** 12 months
- **After 12 months:** Archive to cold storage or delete

---

## Backup Strategy

### Database Backups
- **Frequency:** Daily at 2 AM UTC
- **Retention:** 
  - Daily backups: 7 days
  - Weekly backups: 4 weeks
  - Monthly backups: 12 months
- **Storage:** Encrypted cloud storage (S3/GCS)

### Redis Backups
- **Frequency:** Hourly snapshots (optional)
- **Retention:** 24 hours
- **Note:** Session data is ephemeral and can be recreated

---

## Data Migration

### Initial Setup
```sql
-- Run migrations in order
psql -d botdb -f migrations/001_create_users.sql
psql -d botdb -f migrations/002_create_categories.sql
psql -d botdb -f migrations/003_create_expenses.sql
psql -d botdb -f migrations/004_create_audit_logs.sql
```

### Schema Versioning
```sql
CREATE TABLE schema_version (
  version INTEGER PRIMARY KEY,
  description TEXT,
  applied_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO schema_version (version, description) 
VALUES (1, 'Initial schema');
```

---

## Performance Optimization

### Indexes
- User lookup by `telegram_id` (unique index)
- Expenses by `user_id` and `expense_date` (composite index)
- Expenses by `created_at` (for pagination)
- Categories by `user_id` and `is_active`

### Caching Strategy
```javascript
// Cache user preferences
const cacheKey = `user:${userId}:preferences`;
let preferences = await redis.get(cacheKey);

if (!preferences) {
  preferences = await db.getUserPreferences(userId);
  await redis.set(cacheKey, JSON.stringify(preferences), 'EX', 3600);
}
```

### Query Optimization
- Use `LIMIT` and `OFFSET` for pagination
- Avoid `SELECT *` - specify columns
- Use prepared statements to prevent SQL injection
- Implement connection pooling

---

## Cross-References
- See [04-bot_architecture.md](04-bot_architecture.md) for system design
- See [05-commands_interactions.md](05-commands_interactions.md) for session flows
- See [07-security_ops.md](07-security_ops.md) for data protection

---

> **Note for AI builders:** This schema is optimized for a single-currency, single-user expense tracking bot. Extend as needed for multi-currency or family account features.
