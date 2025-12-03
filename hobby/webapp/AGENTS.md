# Hobby Web App - AI Collaboration Guide

Use the `docs/` folder as the single source of truth.

---

## Quick Navigation
1. [01-context.md](docs/01-context.md) — problem, users, scope
2. [02-dev_protocol.md](docs/02-dev_protocol.md) — setup, workflow, standards
3. [03-product_requirements.md](docs/03-product_requirements.md) — features and acceptance criteria

---

## What AIs Should Know
- Frontend-first (React + Vite/Next); backend is optional/managed (Supabase/Firebase) unless stated in `02-dev_protocol.md`.
- Keep secrets out of code; use `.env.example` as the contract.
- Prefer simple patterns: feature folders, hooks for data fetching, minimal global state.
- Include error, loading, and empty states; budget for mobile-responsive layouts.

---

## How to Ask for Help
- Provide file paths, stack (React/Vite/Next), and the exact feature from doc 03.
- Request both client and API changes when applicable.
- Ask for validation, accessibility, and happy + failure paths.

---

## Common Tasks
- Add a feature: align with doc 03, update service/hook + component, and add a quick test.
- Wire a backend call: define the contract, add typed client, handle loading/error, and update `.env.example` if needed.
- Improve UX: confirm design constraints from doc 01, keep it fast and responsive.

---

> 𝚊_𝚟𝚎𝚛𝚢_𝚍𝚎𝚜𝚌𝚛𝚒𝚙𝚝𝚒𝚟𝚎_𝚏𝚒𝚕𝚎_𝚗𝚊𝚖𝚎.𝚖𝚍
