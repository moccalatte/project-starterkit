# 01. Bot Project Context

## 1.1 Executive Summary
*Overview of the Conversational Agent.*
> Example: A Telegram bot that helps users track personal expenses by parsing natural language messages.

## 1.2 Business Objectives
1.  **Engagement**: Daily Active Users (DAU) > 500.
2.  **Retention**: > 40% retention after week 1.
3.  **Accuracy**: NLP intent recognition accuracy > 90%.

## 1.3 Stakeholders
| Role | Name | Responsibilities |
| :--- | :--- | :--- |
| Product Owner | [Name] | Bot persona, feature set. |
| Bot Dev | [Name] | Logic, integrations. |

## 1.4 Scope & Boundaries
### In Scope
- Text message processing.
- Inline button interactions.
- Image receipt OCR (optional phase 2).

### Out of Scope
- Voice calls.
- Payment processing inside bot (redirect to web instead).

## 1.5 Constraints
- **Platform Limits**: Telegram API rate limits (30 msg/sec).
- **Privacy**: Must not store sensitive financial data in plain text.
