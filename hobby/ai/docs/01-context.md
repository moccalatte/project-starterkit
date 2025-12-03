# 01. AI Project Context

**Version:** v3  
**Last Updated:** 03 December 2025

---

## What Are We Building?
A small AI/ML project that can ship quickly—either a notebook-to-app workflow or a simple model-backed tool.

**Example:** A Streamlit app that summarizes PDFs and extracts key dates using an open-source model.

---

## Why This Project?
- **Problem:** [What pain are we solving?] (e.g., people waste time skimming long PDFs)
- **Solution:** A lightweight tool that automates the repetitive analysis and is easy to share.

---

## Who Is This For?
- [Target audience] (e.g., students, researchers, indie hackers)
- Users are comfortable with web links, not CLI.
- Expect small-to-medium documents/datasets; no heavy GPU assumptions.

---

## Core Features (MVP)
1. Load small input (file/text/URL) and run a model/inference step.
2. Show clear results with minimal latency (ideally <5s).
3. Allow user to export/save/share the output (copy/download).

### Nice to Have
- Simple history for last N runs (local only or Supabase table)
- Basic prompt/templates library
- GPU/accelerated mode toggle if available

---

## Success Criteria
- [ ] User finishes one end-to-end task in <3 minutes
- [ ] No crashes on 10–20 consecutive runs
- [ ] Handles common failure: empty input, unsupported file, API error with a friendly message
- [ ] Costs stay near free tier (or <$10/month)

---

## Constraints
- **Time:** 1–2 weekends.
- **Budget:** Free/cheap (Hugging Face Spaces, Render free tier, Colab).
- **Data:** Small files only (<20MB) unless self-hosted; avoid storing PII.

---

## Out of Scope (v1)
- Multi-user teams/roles
- Payments/subscriptions
- Complex analytics dashboards
- Long-running training jobs

---

## Notes
- Prefer hosted inference (OpenAI/HF endpoints) or small local models if GPU not available.
- Keep prompts/model choices configurable via `.env.example`.
- Decide early: is this a one-off app or a reusable component? Document that choice.

---

> Ship a simple, reliable tool first; optimize models or UX only after users try it.
