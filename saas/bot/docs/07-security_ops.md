# 07. Security & Operations

## 7.1 Security
- **Webhook Security**: Verify `X-Telegram-Bot-Api-Secret-Token` header.
- **Input Sanitization**: Strip HTML/Markdown to prevent formatting injection.
- **Rate Limiting**: Ignore users sending > 5 msgs/sec.

## 7.2 Deployment
- **Method**: Docker Container.
- **Restart Policy**: `restart: always`.
- **Health Check**: Internal HTTP endpoint or checking last processed message timestamp.

## 7.3 Monitoring
- **Metrics**:
  - `messages_received_total`
  - `active_conversations`
  - `nlp_confidence_score`
