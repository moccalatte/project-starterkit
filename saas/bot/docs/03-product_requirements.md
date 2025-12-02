# 03. Product Requirements (PRD)

## 3.1 Functional Requirements (Commands)
- **CMD-1**: `/start` - Welcome message and onboarding.
- **CMD-2**: `/help` - List available commands.
- **CMD-3**: `/add <amount> <category>` - Add expense manually.
- **CMD-4**: `/stats` - Show monthly spending chart.

## 3.2 Conversational Flows (User Stories)
- **Flow 1 (Expense Entry)**:
  1. User sends: "Bought coffee for $5".
  2. Bot (NLP): Detects Intent=Expense, Item=Coffee, Amount=5, Currency=USD.
  3. Bot replies: "Recorded: Coffee - $5. Category?".
  4. User taps: "Food & Drink".
  5. Bot saves and confirms.

## 3.3 Non-Functional Requirements
- **Response Time**: < 1s for simple text replies.
- **Availability**: 24/7 uptime (Bot must restart automatically on crash).
- **Concurrency**: Handle 50 concurrent conversations.

## 3.4 Persona & Tone
- **Name**: "BudgetBuddy".
- **Tone**: Encouraging, concise, emoji-friendly. 🤖💰
