# 02. Development Protocol

## 2.1 Version Control
- **Code**: Git.
- **Data**: DVC (Data Version Control) or LakeFS.
- **Models**: MLflow or Weights & Biases registry.

## 2.2 Experimentation Workflow
1.  **Exploration**: Jupyter Notebooks (`notebooks/exploratory`).
2.  **Refactoring**: Move stable code to `src/`.
3.  **Tracking**: Log params and metrics for every run.

## 2.3 Code Standards
- **Modularization**: No monolithic notebooks in production.
- **Reproducibility**: `requirements.txt` or `conda.yaml` must be exact.
- **Seeds**: Fix random seeds for reproducible splits.

## 2.4 Definition of Done
- [ ] Model trained and saved.
- [ ] Metrics evaluated on Test Set.
- [ ] Inference script working.
- [ ] Code reviewed and merged.
