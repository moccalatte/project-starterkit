# 04. Bot Architecture

## 4.1 High-Level Design
```mermaid
sequenceDiagram
    User->>Telegram: Sends Message
    Telegram->>Webhook: HTTP POST /webhook
    Webhook->>BotServer: Enqueue Task
    BotServer->>NLP_Service: Analyze Intent
    NLP_Service-->>BotServer: {intent: "add_expense"}
    BotServer->>Database: Save Record
    BotServer->>Telegram: Send Reply
    Telegram->>User: Displays Reply
```

## 4.2 Technology Stack
- **Language**: Python (python-telegram-bot) or Node.js (Telegraf).
- **Queue**: Redis + Celery/Bull (for handling heavy tasks without blocking).
- **DB**: SQLite (Dev) / PostgreSQL (Prod).

## 4.3 State Management (FSM)
- Uses a Finite State Machine to track conversation progress.
- States: `IDLE`, `AWAITING_CATEGORY`, `AWAITING_CONFIRMATION`.
- Storage: Redis keys `user:{id}:state`.
