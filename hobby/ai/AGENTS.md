# Hobby AI/ML - AI Collaboration Guide

Docs guide the work. Start there.

---

## Quick Navigation
1. [01-context.md](docs/01-context.md) — problem, audience, scope
2. [02-dev_protocol.md](docs/02-dev_protocol.md) — setup, workflow, safety rules
3. [03-product_requirements.md](docs/03-product_requirements.md) — features, flows, acceptance criteria

---

## What AIs Should Know
- Hobby-scale: CPU-first, free/cheap tiers, small files (<20MB).
- Typical flow: notebook → `src/` utilities → small UI (Streamlit/Gradio/API).
- Guardrails matter: validate inputs, handle rate limits, avoid logging PII.

---

## How to Ask for Help
- Share model choice (OpenAI/HF/local), expected input/output, and latency budget.
- Ask for golden tests and error handling, not just the happy path.
- Provide sample inputs/outputs for clarity.

---

## Common Tasks
- Build inference endpoint or Streamlit view using contracts in doc 03.
- Add validation for file size/type and return friendly errors.
- Create golden tests to prevent regressions; document model name + params.

---

> 𝚊_𝚟𝚎𝚛𝚢_𝚍𝚎𝚜𝚌𝚛𝚒𝚙𝚝𝚒𝚟𝚎_𝚏𝚒𝚕𝚎_𝚗𝚊𝚖𝚎.𝚖𝚍
