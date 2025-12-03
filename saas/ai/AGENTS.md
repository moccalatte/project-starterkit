# AI/ML Project - Agent Instructions

The `docs/` folder is your knowledge base.

- **Missing info?** Search there first.
- **Found something useful?** Document it with a descriptive filename.

---

## Quick Navigation

### Start Here
1. **[01-context.md](docs/01-context.md)** - Problem definition and business objectives
2. **[02-dev_protocol.md](docs/02-dev_protocol.md)** - Development workflow and standards

### Building
3. **[03-product_requirements.md](docs/03-product_requirements.md)** - Model requirements and success criteria
4. **[04-data_pipeline.md](docs/04-data_pipeline.md)** - Data ingestion, processing, and features
5. **[05-model_architecture.md](docs/05-model_architecture.md)** - Model design and training

### Quality & Deployment
6. **[06-evaluation_safety.md](docs/06-evaluation_safety.md)** - Metrics, validation, and bias detection
7. **[07-deployment.md](docs/07-deployment.md)** - Serving, monitoring, and scaling

---

## Key Concepts

- **Data Pipeline** - ETL, preprocessing, feature engineering - see doc 04
- **Model Training** - Architecture, hyperparameters, experiments - see doc 05
- **Evaluation** - Metrics, validation strategies - see doc 06
- **Bias & Fairness** - Detecting and mitigating bias - see doc 06
- **MLOps** - Experiment tracking, versioning - see doc 02 & 07
- **Deployment** - API serving, batch inference - see doc 07
- **Monitoring** - Drift detection, performance tracking - see doc 07

---

## ML Workflow

```
1. Define Problem → doc 01, 03
2. Collect & Process Data → doc 04
3. Build Baseline → doc 05
4. Experiment & Track → doc 02, 05
5. Evaluate & Validate → doc 06
6. Deploy & Monitor → doc 07
```

---

## Tech Stack Overview

**Data:** Python + Pandas/Polars + PySpark  
**Training:** PyTorch/TensorFlow + scikit-learn  
**Tracking:** MLflow + Weights & Biases  
**Serving:** FastAPI + Docker  
**Monitoring:** Evidently AI + Prometheus

---

## When You're Stuck

1. Check the relevant doc first
2. Look at cross-references in each doc
3. Search the entire `/docs` folder
4. Ask specific questions with context

---

## Common Tasks

### Setting up data pipeline
1. Define data sources in `04-data_pipeline.md`
2. Implement ingestion in `src/pipeline/ingest.py`
3. Add preprocessing steps
4. Validate data quality
5. Track with DVC

### Training a model
1. Define architecture in `05-model_architecture.md`
2. Set up experiment tracking (MLflow)
3. Implement training loop
4. Log metrics and artifacts
5. Compare experiments

### Deploying to production
1. Follow deployment guide in `07-deployment.md`
2. Package model with dependencies
3. Create FastAPI endpoint
4. Test locally with Docker
5. Deploy and monitor

---

## Best Practices

- **Always start with a baseline** - Simple model to beat
- **Track everything** - Use MLflow/WandB from day one
- **Version your data** - Use DVC or similar
- **Validate thoroughly** - Multiple metrics, not just accuracy
- **Check for bias** - Test across different groups
- **Monitor in production** - Drift detection and alerts

---

> 𝚊_𝚟𝚎𝚛𝚢_𝚍𝚎𝚜𝚌𝚛𝚒𝚙𝚝𝚒𝚟𝚎_𝚏𝚒𝚕𝚎_𝚗𝚊𝚖𝚎.𝚖𝚍