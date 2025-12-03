# 02. Development Protocol
**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose
Operational standards for a production-grade messaging bot (Telegram/Discord/Slack). Keep security tight, flows predictable, and latency low while enabling fast iteration.

---

## 1) Environments & Secrets
- **Environments:** `dev` (polling), `staging` (webhook), `prod` (webhook). Keep tokens separate per environment.
- **Secrets:** Use `.env` locally; use a secrets manager in CI and production. Never log tokens, chat IDs, or PII.
- **Required vars:**
```bash
BOT_TOKEN= # platform token
BOT_SIGNING_SECRET= # if applicable (Slack)
DATABASE_URL=postgresql://user:pass@host:5432/db
REDIS_URL=redis://host:6379 # sessions/rate limit
WEBHOOK_URL=https://api.example.com/webhook
NODE_ENV=development|staging|production
```

## 2) Local & Webhook Workflow
- **Local (polling):** Default for speed. `npm run dev` (with nodemon). No public URL needed.
- **Webhook:** Required for staging/prod. Use ngrok for local webhook tests; set webhook before running. Protect webhook path with a secret.
- **Health:** Add `/health` endpoint for uptime monitors; include build info and git SHA.

## 3) Project Structure & Standards
```
src/
  commands/      # discrete commands (/start, /help)
  flows/         # multi-turn conversations and FSM/state machine
  middleware/    # auth, rate limiting, logging
  services/      # business logic, integrations
  adapters/      # platform adapters, HTTP clients
  storage/       # repositories, migrations
  index.ts       # bootstrap
tests/
```
- **Language & Quality:** TypeScript, ESLint + Prettier. Strict types; no implicit `any`.
- **Validation:** Validate and sanitize all user inputs. Enforce rate limits per user/chat.
- **Idempotency:** Commands should be idempotent; deduplicate by message/command ID.
- **State:** Prefer Redis for session/state; expire stale sessions. Keep long-running tasks async via queue/webhook ack.
- **Logging:** Structured logs with trace IDs and command/context metadata.

## 4) Git & Reviews
- **Branching:** Trunk with `feat/*`, `fix/*`, `chore/*`. `main` is deployable.
- **Commits:** Conventional Commits (`feat: add /stats`, `fix: throttle webhook retries`).
- **PR Checks:** lint, typecheck, unit + integration tests, secret scan. Require one review; security-sensitive changes need two.

## 5) Testing
- **Unit:** Parsers, validators, services, and message formatters.
- **Integration:** Command/flow tests with mocked platform API and database.
- **Manual Smoke:** `/start`, `/help`, one complex flow, error path. Test in both private chat and group (if supported).
- **Load:** Basic burst test for rate limits on staging before major releases.

## 6) Deployment & Operations
- **Pre-deploy:** Apply migrations; verify webhook URL and certificate; feature flags default safe.
- **Deploy:** Build minimal Docker image; run health checks and warm caches where needed.
- **Post-deploy:** Verify `/start` response, check logs for errors, confirm alerts wired (uptime + error rate).
- **Rollback:** Keep last good image tag; provide migration rollback or data repair script when risky.

## 7) Security
- Principle of least privilege for bot tokens and DB users. Rotate tokens quarterly or on incident.
- Strip PII from logs; redact user identifiers. Validate file uploads (size/type) before processing.
- Rate limit commands and API calls; captcha/allowlist for admin commands.

## 8) Definition of Done
- [ ] Feature mapped to `03-product_requirements.md` and flow diagrams updated
- [ ] Tests passing (unit + integration); manual smoke in dev/staging
- [ ] Observability in place (logs/metrics/alerts) for new paths
- [ ] Webhook/polling configuration documented; migrations reviewed
- [ ] Security review done for commands touching auth, payments, or files

## 9) AI Collaboration Notes
- Provide platform, command/flow, and edge cases when asking for code.
- Request rate-limit, error, and retry handling alongside happy paths.
- Keep generated handlers small; factor shared logic into services after generation.

---

> Cross-reference: `04-bot_architecture.md` for platform choices and flow patterns, `05-commands_interactions.md` for command registry, `06-data_state.md` for storage rules, and `07-security_ops.md` for deployment and monitoring.
