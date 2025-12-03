# 02. Development Protocol

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose
Standards for end-to-end ML development: data, experiments, code, evaluation, deployment, and safety. Designed for production-grade pipelines, not throwaway notebooks.

---

## 1) Versioning & Reproducibility
- **Code:** Git with Conventional Commits. Protect `main`.
- **Data:** DVC/LakeFS for datasets; store data manifests and hashes. Never commit raw data to git.
- **Models:** MLflow/W&B registry with run metadata (params, metrics, data hash, git SHA).
- **Environments:** Pin dependencies (`poetry.lock`/`requirements.txt`) and runtime (Python 3.11). Use containers for training and serving.

## 2) Experiment Workflow
1. Explore in `notebooks/` (small, focused). No production logic here.
2. Promote to `src/` modules with tests; parameterize configs.
3. Track every run (config, seed, metrics, artifacts). Tag best candidate per metric.
4. Save evaluation reports (bias, performance, drift baseline) to `artifacts/`.

## 3) Data & Security
- **Contracts:** Define schemas in `03-product_requirements.md` and `04-data_pipeline.md`. Validate on load; fail fast on drift.
- **PII:** Minimize collection; mask/redact before logging. Encrypt data at rest/in transit. Access via least-privileged roles.
- **Quality:** Add data checks (nulls, ranges, duplicates) and monitor drift (PSI/KL) per feature. Keep a golden dataset for regression tests.

## 4) Modeling Standards
- **Determinism:** Set seeds, deterministic ops where possible. Log library versions and hardware.
- **Baselines:** Always compare against simple baselines; include no-model heuristic.
- **Evaluation:** Train/val/test split; use cross-validation when data is small. Report confidence intervals for key metrics.
- **Fairness & Safety:** Add guardrails for harmful outputs; document known limitations. Run adversarial prompts/tests for generative models.

## 5) Serving & Ops
- **Interfaces:** Standardize inference contract (input/output schema) and document in `05-model_architecture.md`.
- **Performance:** Measure latency, throughput, and cold start. Add timeouts and circuit breakers for upstream calls.
- **Monitoring:** Collect request rate, latency, error rate, model confidence, drift stats. Alert on SLA breaches.
- **Rollouts:** Shadow deploy first, then canary. Keep rollback toggle and previous model version ready.

## 6) Testing & CI/CD
- **Tests:** Unit (feature engineering, utils), integration (pipeline stages), inference regression (golden dataset), and contract tests for serving API.
- **CI:** lint, typecheck, tests, data-contract validation, and lightweight training smoke (subset). Block merges on failing quality gates.
- **CD:** Push approved models to registry with provenance. Automate container builds with model artifacts pinned by version.

## 7) Definition of Done
- [ ] Data contract validated; PII handled per policy
- [ ] Model metrics meet target vs baseline; evaluation report stored
- [ ] Reproducible run logged with code/data/model versions
- [ ] Serving contract documented; load/perf smoke tests pass
- [ ] Monitoring/alerts configured; rollback plan noted
- [ ] Docs updated (pipeline, model card, playbooks)

## 8) AI Collaboration Notes
- Provide task goal, dataset shape, target metric, and constraints (latency, cost).
- Request both training and serving considerations; ask for failure modes and mitigation.
- Keep generated code modular; re-run tests and add assertions after generation.

---

> Cross-reference: `04-data_pipeline.md` for ingestion/feature store, `05-model_architecture.md` for model choices, `06-evaluation_safety.md` for validation and safety tests, `07-deployment.md` for rollout playbook.
