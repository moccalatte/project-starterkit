# 02. Development Protocol

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Setup
- **Environment:** Python 3.11 recommended. Use `venv` + `requirements.txt` or `poetry.lock`.
- **Hardware:** Assume CPU; optionally enable GPU on Colab/Spaces. Keep a CPU path for predictability.
- **Folders:** `notebooks/` for exploration, `src/` for reusable code, `data/` (gitignored) for local assets, `app/` for UI (Streamlit/Gradio).
- **Secrets:** `.env` for API keys (OpenAI/HF). Never commit. Mirror required vars in `.env.example`.

---

## Workflow
1. **Explore:** Prototype in a notebook on a small sample. Keep it short (<150 lines).
2. **Promote:** Move stable logic into `src/` (utils, pipelines, prompts). Add type hints.
3. **Track:** Log model name, prompt, parameters, and sample input/output for each experiment (simple CSV/Markdown is fine).
4. **Ship:** Wrap inference behind a small app/CLI/API. Cache models to avoid repeat downloads.

---

## Data & Safety
- Keep inputs small (<20MB). Strip metadata; avoid storing PII. If you must persist, use Supabase/SQLite with minimal columns.
- Validate inputs early (file type/size, length). Sanitize text before sending to APIs.
- Add guardrails: max tokens, stop words, and simple content filters for generative outputs.

---

## Quality Checks
- **Unit tests:** Core functions (parsers, scoring, prompt builders).
- **Golden tests:** A tiny golden set of inputs with expected outputs/thresholds; re-run after changes.
- **Performance:** Measure latency for 10 consecutive calls; note average and p95. Stay within free-tier rate limits.
- **Cost:** Estimate per-run cost if using paid APIs; keep a budget note in README.

---

## Deployment (pick one)
- **Streamlit/Gradio:** Push to Hugging Face Spaces or Render free tier.
- **API:** FastAPI/Flask with a single `/predict` endpoint; CORS enabled for your frontend only.
- **Notebook:** If sharing as notebook, add a quickstart section and pin dependencies.

---

## Definition of Done
- [ ] Core flow works end-to-end on CPU
- [ ] Golden tests pass; latency acceptable
- [ ] `.env.example` updated; no secrets committed
- [ ] README documents model choice, limits, and how to run
- [ ] Friendly errors for bad input/API failures

---

## AI Collaboration
- Share input/output examples and model constraints in prompts.
- Ask for both inference code and error handling (rate limits, retries).
- Keep generated snippets small; refactor to `src/` modules after.

---

> Prioritize reliability and clarity over model cleverness. A simple, predictable tool wins for hobby projects.
