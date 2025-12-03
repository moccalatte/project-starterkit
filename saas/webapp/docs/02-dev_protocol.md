# 02. Development Protocol

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose
Guardrails and workflows for building a production-grade SaaS web application with separate frontend and backend stacks. Keep this concise but enforce the essentials for reliability, security, and velocity.

---

## 1) Source Control & Branching
- **Branching:** Trunk-based with short-lived branches (`feat/*`, `fix/*`, `chore/*`) or GitFlow if compliance requires `develop`. `main` is always deployable.
- **Commits:** Conventional Commits (`feat: add billing portal`, `fix: debounce search`). One logical change per commit.
- **Pull Requests:** Small (<400 lines), include screenshots for UI changes, and link to requirements in `03-product_requirements.md`.
- **Reviews:** At least one reviewer; critical flows (auth, payments) need two approvals. No self-merge on red checks.

## 2) Environment & Configuration
- **Environments:** `dev` → `staging` → `prod`; staging mirrors prod features and flags.
- **Secrets:** `.env` for local only; use secrets manager (e.g., SSM, Vault) for staging/prod. Never commit secrets.
- **Configuration:** Per-environment config files; keep feature flags in a single source of truth. Capture all required env vars in `.env.example`.
- **Data:** Seed data scripts per environment; migrations are forward-only with rollback scripts.

## 3) Frontend Standards (React/Next.js)
- **Language & Quality:** TypeScript, ESLint (Next/React rules), Prettier, strict mode on. No `any` unless documented.
- **Architecture:** App router + feature folders; shared UI in `components/`, business logic in `features/*`, data fetching via React Query/SWR with cached keys.
- **State:** Local via hooks; global via Zustand/Redux only when needed. Derive from server where possible.
- **Styling:** Tailwind or CSS Modules; enforce design tokens. Accessible components (aria labels, keyboard support).
- **API Access:** Typed clients generated from OpenAPI (`05-backend_api.md`). Handle errors with user-friendly toasts and logging hooks.
- **Testing:** Unit (Vitest/Jest) for logic, RTL for components, Playwright/Cypress for happy-path E2E.

## 4) Backend Standards (Node/Python/Go)
- **Architecture:** Layered approach—routes/controllers → services → repositories → database. Keep business logic out of controllers.
- **Validation & Errors:** Validate all inputs (Zod/DTOs). Standard error shape `{ code, message, traceId }`.
- **Database:** PostgreSQL with migrations (Prisma/TypeORM/SQLAlchemy). Enforce tenant scoping in queries. Add indexes before launch.
- **APIs:** REST-first with versioning (`/v1`). Pagination, filtering, idempotency keys for mutating endpoints. Async jobs go to queue (Bull/Celery/SQS).
- **Security:** Auth middleware everywhere, RBAC/ABAC for multi-tenant resources, rate limiting and IP allowlists for admin routes.
- **Observability:** Structured logs (JSON), trace IDs in requests, metrics for latency and error rates. Health and readiness probes.

## 5) CI/CD & Quality Gates
- **Required Checks:** lint, typecheck, unit tests, backend integration tests, E2E smoke (on main), dependency audit.
- **Builds:** Frontend build with static analysis; backend container image built from lockfiles.
- **Previews:** PR deploy previews for frontend; staging deployments on merge to `main` (or `develop` if GitFlow).
- **Releases:** Tag builds; promote artifacts between environments. Rollback via previous tag and database backup restore.

## 6) Security & Compliance
- **Secrets & Tokens:** Rotate quarterly; never log tokens or PII. Mask secrets in CI logs.
- **Data Protection:** TLS everywhere, HTTPS-only cookies, prepared statements. Encryption at rest for DB and object storage.
- **Dependency Hygiene:** Weekly `npm audit`/`pip audit`/`govulncheck`. Block known CVEs in CI.
- **Access Control:** Principle of least privilege for cloud roles, DB users, and CI runners. Separate service accounts per environment.

## 7) Definition of Done
- [ ] Requirements covered and demoed against `03-product_requirements.md`
- [ ] Tests pass (unit/integration/E2E) with meaningful assertions
- [ ] Observability hooks added (logs/metrics/trace IDs) and feature flags wired
- [ ] Security checks passed (lint, deps scan, secret scan) and migrations reviewed
- [ ] Docs updated (API contract, changelog, README snippets) and rollout plan noted

## 8) AI Collaboration Notes
- Provide file paths and acceptance criteria in prompts. Ask for both frontend and backend changes when relevant.
- Request threat-model and performance checks for risky features (auth, payments, bulk exports).
- Keep generated code small and focused; refactor manually after AI assists to ensure clarity.

---

> Cross-reference: `04-system_architecture.md` for design constraints, `05-backend_api.md` for contracts, `06-frontend_client.md` for UI patterns, `07-security_ops.md` for deployment, and `08-testing_qa.md` for detailed test plans.
