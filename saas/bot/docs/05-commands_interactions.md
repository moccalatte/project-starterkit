# 05. Commands & Interactions

## 5.1 Command Registry
| Command | Arguments | Description |
| :--- | :--- | :--- |
| `/start` | None | Reset state, welcome user. |
| `/cancel` | None | Cancel current operation. |
| `/report` | `[month]` | Generate PDF report. |

## 5.2 Menu System
- **Main Menu**: Persistent `ReplyKeyboardMarkup` with "Add Expense", "My Stats", "Settings".
- **Interaction**: `InlineKeyboardMarkup` for specific actions (e.g., Delete confirmation).

## 5.3 Error Handling
- **Unknown Command**: "Sorry, I didn't catch that. Try /help."
- **System Error**: "My brain is fuzzy. Try again later." (Notify Admin).
