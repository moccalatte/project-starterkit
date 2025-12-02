# 06. Data & State

## 6.1 User Profile
- `telegram_id` (Primary Key)
- `first_name`
- `username`
- `preferences` (JSON: language, currency)

## 6.2 Conversation Context
- Temporary data stored in Redis/Memory during multi-step flows.
- TTL (Time To Live): 30 minutes (session expiry).

## 6.3 Audit Logs
- Log every incoming message: `timestamp`, `user_id`, `message_text` (sanitized).
