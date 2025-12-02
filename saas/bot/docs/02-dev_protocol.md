# 02. Development Protocol

## 2.1 Version Control
- **Branching**: Feature-branch workflow (`feature/add-command-x`).

## 2.2 Bot Development Workflow
1.  **Local Dev**: Use `polling` mode for ease of use.
2.  **Testing Webhooks**: Use `ngrok` to expose local port 8000.
3.  **Environment Variables**:
    - `BOT_TOKEN`: Never commit this! Use `.env`.
    - `WEBHOOK_URL`: Set dynamically or in env.

## 2.3 Code Standards
- **Handlers**: Separate logic for each command into `handlers/` folder.
- **Middleware**: Use middleware for logging and auth checks.
- **Typing**: Python type hints or TypeScript interfaces are mandatory.

## 2.4 Definition of Done
- [ ] Command works in private chat.
- [ ] Command works in group chat (if applicable).
- [ ] Error messages are user-friendly.
