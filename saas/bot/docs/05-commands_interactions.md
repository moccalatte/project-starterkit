# 05. Commands & Interactions
**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose
Define the complete command registry, interaction patterns, and UI elements for the bot.

---

## Command Registry

### Essential Commands

| Command | Arguments | Description | Access Level |
|---------|-----------|-------------|--------------|
| `/start` | None | Welcome message, onboarding | All users |
| `/help` | None | List all commands | All users |
| `/add` | `[amount] [category] [note]` | Add expense | All users |
| `/stats` | `[period]` | View spending summary | All users |
| `/export` | `[format]` | Export data | All users |
| `/settings` | None | Open settings menu | All users |
| `/cancel` | None | Cancel current operation | All users |

### Optional Commands

| Command | Arguments | Description | Access Level |
|---------|-----------|-------------|--------------|
| `/budget` | `[amount]` | Set monthly budget | All users |
| `/categories` | None | Manage categories | All users |
| `/currency` | `[code]` | Set currency | All users |
| `/delete` | `[id]` | Delete expense | All users |
| `/feedback` | `[message]` | Send feedback | All users |

### Admin Commands

| Command | Arguments | Description | Access Level |
|---------|-----------|-------------|--------------|
| `/broadcast` | `[message]` | Send to all users | Admin only |
| `/stats_admin` | None | System statistics | Admin only |
| `/users` | None | User count | Admin only |

---

## Command Details

### `/start`

**Purpose:** Welcome new users and initialize their account.

**Behavior:**
1. Check if user exists in database
2. Create user record if new
3. Send welcome message with quick tutorial
4. Show main menu

**Response:**
```
👋 Welcome to BudgetBuddy!

I help you track expenses quickly and easily.

🚀 Quick Start:
• Type "coffee $5" for quick entry
• Use /add for structured input
• Check /stats for summaries

Ready to start? Try adding your first expense!

Use /help anytime for all commands.
```

**Edge Cases:**
- Returning user: "Welcome back! Use /help to see what's new."
- Group chat: "Hi everyone! Please DM me to get started."

---

### `/help`

**Purpose:** Display all available commands with examples.

**Response:**
```
📚 BudgetBuddy Commands

💰 Expense Tracking
/add [amount] [category] [note] - Add expense
  Example: /add 15 food lunch

📊 Reports & Analysis
/stats [period] - View spending summary
  Options: today, week, month, year
/export [format] - Download data
  Formats: csv, json, pdf

⚙️ Settings
/settings - Configure preferences
/currency [code] - Set currency (USD, EUR, etc.)
/categories - Manage expense categories
/budget [amount] - Set monthly budget

🛠 Utilities
/cancel - Cancel current operation
/feedback [message] - Send us feedback
/help - Show this message

💡 Tip: You can also type naturally!
Try: "spent $20 on groceries"
```

---

### `/add`

**Purpose:** Add expense with structured command.

**Syntax:**
```
/add <amount> [category] [note]
/add <amount>
```

**Examples:**
```
/add 50 food dinner with friends
/add 100 transport
/add 25
```

**Flow:**

**Case 1: Complete input**
```
User: /add 50 food lunch
Bot: ✅ Expense saved!
     
     💰 $50.00
     📁 Food
     📝 lunch
     
     Total today: $125.00
```

**Case 2: Missing category**
```
User: /add 50
Bot: Got it! $50.00
     
     What category?
     [🍔 Food] [🚗 Transport]
     [🎬 Fun] [🏠 Bills] [➕ Other]
```

**Case 3: Invalid amount**
```
User: /add abc
Bot: ❌ Please enter a valid amount.
     
     Examples:
     /add 50
     /add 25.50
     /add 100 food
```

---

### `/stats`

**Purpose:** Show spending analytics.

**Syntax:**
```
/stats [period]
```

**Periods:**
- `today` - Last 24 hours
- `week` - Last 7 days (default)
- `month` - Last 30 days
- `year` - Last 12 months

**Response Example:**
```
📊 Your Stats - Last 7 Days

💰 Total Spent: $245.50

By Category:
🍔 Food          $120.00 (49%)
🚗 Transport     $65.50  (27%)
🎬 Entertainment $60.00  (24%)

📈 vs. Previous Week: +12%
📅 Daily Average: $35.07

Top Expense: $50 (Dinner, Dec 10)
```

**Empty State:**
```
📊 Your Stats - Last 7 Days

No expenses recorded yet.

Start tracking with /add or just type:
"coffee $5"
```

---

### `/settings`

**Purpose:** Configure bot preferences.

**Response:**
```
⚙️ Settings

Current Configuration:
💱 Currency: USD
🗓 Week Start: Monday
🔔 Notifications: On

What would you like to change?

[💱 Currency]
[🗓 Week Start]
[🔔 Notifications]
[📁 Categories]
[❌ Close]
```

---

### `/cancel`

**Purpose:** Exit current conversation flow.

**Usage:**
```
User: /add 50
Bot: What category?
User: /cancel
Bot: ✅ Cancelled. No changes made.
```

---

## Interaction Patterns

### 1. Reply Keyboards

**Main Menu (Persistent):**
```javascript
{
  keyboard: [
    ['💰 Add Expense', '📊 View Stats'],
    ['⚙️ Settings', '📤 Export'],
    ['❓ Help']
  ],
  resize_keyboard: true,
  one_time_keyboard: false
}
```

**Usage:** Always visible for quick access to main features.

---

### 2. Inline Keyboards

**Category Selection:**
```javascript
{
  inline_keyboard: [
    [
      { text: '🍔 Food', callback_data: 'cat_food' },
      { text: '🚗 Transport', callback_data: 'cat_transport' }
    ],
    [
      { text: '🎬 Entertainment', callback_data: 'cat_entertainment' },
      { text: '🏠 Bills', callback_data: 'cat_bills' }
    ],
    [
      { text: '➕ Other', callback_data: 'cat_other' }
    ]
  ]
}
```

**Confirmation Dialog:**
```javascript
{
  inline_keyboard: [
    [
      { text: '✅ Confirm', callback_data: 'confirm_yes' },
      { text: '❌ Cancel', callback_data: 'confirm_no' }
    ],
    [
      { text: '✏️ Edit', callback_data: 'edit' }
    ]
  ]
}
```

---

### 3. Callback Query Handling

**Pattern:**
```javascript
bot.on('callback_query', async (ctx) => {
  const action = ctx.callbackQuery.data;
  
  switch (action) {
    case 'cat_food':
      await handleCategorySelection(ctx, 'Food');
      break;
    
    case 'confirm_yes':
      await saveExpense(ctx);
      break;
    
    case 'confirm_no':
      await cancelOperation(ctx);
      break;
  }
  
  // Always answer callback query
  await ctx.answerCbQuery();
});
```

---

## Natural Language Interactions

### Pattern Recognition

**Expense Entry:**
```
Input: "bought coffee for $5"
Regex: /(\w+)\s+for\s+\$?(\d+\.?\d*)/

Extracted:
- Item: "coffee"
- Amount: 5.00
```

**Common Patterns:**
```
"coffee $5" → {item: "coffee", amount: 5}
"$20 on groceries" → {amount: 20, item: "groceries"}
"spent 50 for dinner" → {amount: 50, item: "dinner"}
"taxi 15" → {item: "taxi", amount: 15}
```

---

## Error Handling

### Unknown Command

**Trigger:** User sends unrecognized command.

**Response:**
```
❓ I didn't understand that command.

Try /help to see what I can do.
```

---

### Invalid Input

**Trigger:** User provides malformed data.

**Response:**
```
❌ Invalid format.

Expected: /add <amount> [category] [note]
Example: /add 50 food lunch

Use /help for more info.
```

---

### System Error

**Trigger:** Database or API failure.

**Response to User:**
```
😵 Something went wrong on my end.
Please try again in a moment.

If this persists, contact support.
```

**Internal Action:**
- Log error with full stack trace
- Alert admin via monitoring system
- Retry operation if appropriate

---

## Menu System

### Main Menu Structure

```
BudgetBuddy Bot
├── 💰 Add Expense → /add flow
├── 📊 View Stats → /stats menu
│   ├── Today
│   ├── This Week
│   ├── This Month
│   └── This Year
├── ⚙️ Settings → /settings menu
│   ├── Currency
│   ├── Categories
│   ├── Notifications
│   └── Week Start
├── 📤 Export → /export menu
│   ├── CSV
│   ├── JSON
│   └── PDF
└── ❓ Help → /help
```

---

## Conversation Flows

### Flow 1: Quick Add

```
User: /add
Bot: How much did you spend?

User: 50
Bot: Got it! $50.00
     
     What was it for?

User: dinner
Bot: Perfect! What category?
     [Buttons: Food, Transport, Fun, Other]

User: [Taps Food]
Bot: ✅ Saved!
     Dinner - $50.00 (Food)
     
     Total today: $125.00
```

---

### Flow 2: Natural Language

```
User: coffee $5
Bot: ✅ Got it!
     
     Expense: Coffee - $5.00
     Category: Food
     
     Is this correct?
     [✓ Yes] [✗ No] [Edit]

User: [Taps Yes]
Bot: ✅ Saved! Total today: $30.00
```

---

### Flow 3: Stats Review

```
User: /stats month
Bot: 📊 Your Stats - Last 30 Days
     [Stats content...]
     
     What next?
     [📥 Export] [📊 Another Period] [❌ Close]

User: [Taps Export]
Bot: What format?
     [CSV] [JSON] [PDF]

User: [Taps CSV]
Bot: 📎 Here's your expense report!
     [File attachment]
```

---

## Response Templates

### Success Messages
```
✅ Expense saved!
✅ Settings updated!
✅ Export ready!
✅ Category added!
```

### Error Messages
```
❌ Please enter a valid amount
❌ Category not found
❌ Export failed - please try again
❌ Invalid date format
```

### Info Messages
```
💡 Tip: Type naturally! Example: "coffee $5"
ℹ️ No expenses found for this period
⚠️ You're approaching your monthly budget
📊 Generated your report
```

---

## Accessibility

### Screen Reader Support
- Use descriptive emojis
- Include text alternatives
- Clear button labels

### Keyboard Navigation
- Numbered options for keyboard users
- Support text-based selection

**Example:**
```
Select category:
1️⃣ Food
2️⃣ Transport
3️⃣ Entertainment

Reply with number or tap button.
```

---

## Cross-References
- See [03-product_requirements.md](03-product_requirements.md) for feature specs
- See [04-bot_architecture.md](04-bot_architecture.md) for implementation
- See [06-data_state.md](06-data_state.md) for session management

---

> **Note for AI builders:** These interaction patterns ensure consistency and good UX. Always provide clear feedback and actionable next steps.
