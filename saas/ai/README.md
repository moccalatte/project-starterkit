# AI/ML Project Template

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

A complete template for building production-ready machine learning and AI projects with AI-friendly documentation and best practices.

---

## Quick Start

1. **Understand the problem** → Read [01-context.md](docs/01-context.md)
2. **Set up development** → Follow [02-dev_protocol.md](docs/02-dev_protocol.md)
3. **Define requirements** → Review [03-product_requirements.md](docs/03-product_requirements.md)
4. **Build the pipeline** → Implement using [04-data_pipeline.md](docs/04-data_pipeline.md)

---

## Features

- **Data pipeline** - ETL, preprocessing, and feature engineering
- **Model architecture** - Deep learning and traditional ML models
- **Experiment tracking** - MLflow, Weights & Biases integration
- **Model versioning** - DVC, Git LFS for model artifacts
- **Evaluation framework** - Metrics, validation, and testing
- **Safety & bias detection** - Fairness checks and monitoring
- **Model deployment** - REST API, batch inference, edge deployment
- **Monitoring** - Performance tracking and drift detection

---

## Documentation Index

### Foundation
- **[01. Context](docs/01-context.md)** - Problem definition and business objectives
- **[02. Dev Protocol](docs/02-dev_protocol.md)** - Development workflow and standards

### Data & Modeling
- **[03. Product Requirements](docs/03-product_requirements.md)** - Model requirements and success criteria
- **[04. Data Pipeline](docs/04-data_pipeline.md)** - Data ingestion, processing, and features
- **[05. Model Architecture](docs/05-model_architecture.md)** - Model design and training

### Quality & Deployment
- **[06. Evaluation & Safety](docs/06-evaluation_safety.md)** - Metrics, validation, and bias detection
- **[07. Deployment](docs/07-deployment.md)** - Serving, monitoring, and scaling

---

## Tech Stack

### Data Processing
- **Python:** 3.10+
- **Data:** Pandas, Polars, Dask
- **Spark:** PySpark (for large-scale processing)
- **Storage:** S3, GCS, Azure Blob

### Machine Learning
- **Frameworks:** PyTorch, TensorFlow, scikit-learn
- **AutoML:** AutoGluon, H2O.ai (optional)
- **NLP:** Hugging Face Transformers, spaCy
- **Computer Vision:** OpenCV, torchvision, albumentations

### MLOps
- **Experiments:** MLflow, Weights & Biases
- **Versioning:** DVC, Git LFS
- **Orchestration:** Airflow, Prefect, Dagster
- **Feature Store:** Feast, Tecton (optional)

### Deployment
- **API:** FastAPI, Flask
- **Serving:** TorchServe, TensorFlow Serving, BentoML
- **Containers:** Docker, Kubernetes
- **Monitoring:** Prometheus, Grafana, Evidently AI

---

## Development Workflow

```bash
# 1. Set up environment
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 2. Configure data sources
cp .env.example .env
# Add your S3/GCS credentials

# 3. Run data pipeline
python src/pipeline/ingest.py
python src/pipeline/preprocess.py
python src/pipeline/features.py

# 4. Train model
python src/train.py --config configs/model.yaml

# 5. Evaluate model
python src/evaluate.py --model-path models/latest

# 6. Start inference API
python src/serve.py
```

---

## Project Structure

```
ai/
├── docs/                    # Complete documentation
├── data/
│   ├── raw/                # Original data
│   ├── processed/          # Cleaned data
│   └── features/           # Feature-engineered data
├── models/                 # Trained models
├── notebooks/              # Jupyter notebooks for exploration
├── src/
│   ├── pipeline/          # Data processing
│   │   ├── ingest.py
│   │   ├── preprocess.py
│   │   └── features.py
│   ├── models/            # Model definitions
│   │   ├── baseline.py
│   │   └── advanced.py
│   ├── train.py           # Training script
│   ├── evaluate.py        # Evaluation script
│   └── serve.py           # Inference API
├── tests/                 # Unit and integration tests
├── configs/               # Configuration files
├── AGENTS.md             # AI collaboration guide
├── requirements.txt      # Python dependencies
└── README.md             # This file
```

---

## Common Patterns

### Data Loading
```python
import pandas as pd
from pathlib import Path

def load_dataset(split='train'):
    path = Path(f'data/processed/{split}.parquet')
    df = pd.read_parquet(path)
    return df

# Usage
train_df = load_dataset('train')
val_df = load_dataset('val')
```

### Model Training
```python
import torch
import mlflow

def train_model(model, train_loader, val_loader, epochs=10):
    mlflow.start_run()
    
    for epoch in range(epochs):
        # Training loop
        train_loss = train_epoch(model, train_loader)
        val_loss = validate(model, val_loader)
        
        # Log metrics
        mlflow.log_metrics({
            'train_loss': train_loss,
            'val_loss': val_loss
        }, step=epoch)
    
    # Save model
    mlflow.pytorch.log_model(model, 'model')
    mlflow.end_run()
```

### Inference API
```python
from fastapi import FastAPI
import torch

app = FastAPI()
model = torch.load('models/latest.pt')

@app.post('/predict')
async def predict(data: dict):
    # Preprocess
    features = preprocess(data)
    
    # Inference
    with torch.no_grad():
        prediction = model(features)
    
    return {'prediction': prediction.tolist()}
```

---

## Key Workflows

### 1. Data Pipeline

```
Raw Data → Cleaning → Validation → Feature Engineering → Train/Val/Test Split
```

**Steps:**
- Ingest data from sources (S3, databases, APIs)
- Clean and handle missing values
- Validate data quality
- Engineer features
- Split into train/validation/test sets
- Save processed data

### 2. Model Development

```
Baseline → Experimentation → Validation → Selection → Production
```

**Steps:**
- Build simple baseline model
- Experiment with architectures
- Track experiments with MLflow
- Validate on hold-out set
- Select best model
- Prepare for deployment

### 3. Model Deployment

```
Training → Evaluation → Packaging → Serving → Monitoring
```

**Steps:**
- Train final model
- Evaluate against metrics
- Package with dependencies
- Deploy as API/batch
- Monitor performance and drift

---

## Experiment Tracking

### MLflow Setup
```python
import mlflow

# Set tracking URI
mlflow.set_tracking_uri('http://localhost:5000')

# Start experiment
mlflow.set_experiment('expense-classifier')

# Log parameters and metrics
with mlflow.start_run():
    mlflow.log_param('learning_rate', 0.001)
    mlflow.log_param('batch_size', 32)
    mlflow.log_metric('accuracy', 0.95)
    mlflow.log_artifact('model.pt')
```

### Weights & Biases
```python
import wandb

# Initialize
wandb.init(project='expense-classifier', config={
    'learning_rate': 0.001,
    'batch_size': 32
})

# Log metrics
wandb.log({'train_loss': loss, 'accuracy': acc})

# Save model
wandb.save('model.pt')
```

---

## Model Evaluation

### Metrics
```python
from sklearn.metrics import accuracy_score, precision_recall_fscore_support

def evaluate_model(y_true, y_pred):
    accuracy = accuracy_score(y_true, y_pred)
    precision, recall, f1, _ = precision_recall_fscore_support(
        y_true, y_pred, average='weighted'
    )
    
    return {
        'accuracy': accuracy,
        'precision': precision,
        'recall': recall,
        'f1': f1
    }
```

### Validation Strategy
- **K-Fold Cross-Validation** - For small datasets
- **Time-Series Split** - For temporal data
- **Stratified Split** - For imbalanced datasets
- **Hold-out Test Set** - Never touched until final eval

---

## Deployment Options

### 1. REST API (FastAPI)
```python
# Best for: Real-time predictions, web apps
# Latency: <100ms
# Scale: Horizontal with load balancer
```

### 2. Batch Inference
```python
# Best for: Large-scale processing
# Latency: Minutes to hours
# Scale: Parallel workers
```

### 3. Edge Deployment
```python
# Best for: Mobile, IoT devices
# Latency: <10ms
# Scale: Optimized models (ONNX, TFLite)
```

---

## Model Monitoring

### Performance Tracking
```python
from evidently import ColumnMapping
from evidently.report import Report
from evidently.metric_preset import DataDriftPreset

# Check for data drift
report = Report(metrics=[DataDriftPreset()])
report.run(reference_data=train_df, current_data=prod_df)
report.save_html('drift_report.html')
```

### Alerts
- **Performance degradation** - Accuracy drops below threshold
- **Data drift** - Input distribution changes
- **Prediction drift** - Output distribution changes
- **Latency spike** - Response time exceeds SLA

---

## Safety & Ethics

### Bias Detection
```python
from aif360.datasets import BinaryLabelDataset
from aif360.metrics import BinaryLabelDatasetMetric

# Check for bias
dataset = BinaryLabelDataset(df, ...)
metric = BinaryLabelDatasetMetric(
    dataset,
    privileged_groups=[{'gender': 1}],
    unprivileged_groups=[{'gender': 0}]
)

print(f"Disparate Impact: {metric.disparate_impact()}")
```

### Fairness Checks
- Equal opportunity across groups
- Demographic parity
- Equalized odds
- Individual fairness

---

## Testing

### Unit Tests
```bash
pytest tests/unit/
```

### Integration Tests
```bash
pytest tests/integration/
```

### Model Tests
```python
def test_model_output_shape():
    model = load_model()
    input_data = torch.randn(1, 10)
    output = model(input_data)
    assert output.shape == (1, 5)

def test_prediction_range():
    predictions = model.predict(test_data)
    assert all(0 <= p <= 1 for p in predictions)
```

---

## Performance Optimization

### Model Optimization
- **Quantization** - Reduce precision (FP32 → INT8)
- **Pruning** - Remove unnecessary weights
- **Distillation** - Train smaller student model
- **ONNX** - Runtime optimization

### Inference Optimization
- **Batching** - Process multiple samples together
- **Caching** - Cache frequent predictions
- **GPU acceleration** - Use CUDA/TensorRT
- **Async processing** - Non-blocking inference

---

## Common Issues & Solutions

### Out of Memory (OOM)
```python
# Solutions:
- Reduce batch size
- Use gradient accumulation
- Enable mixed precision training
- Use data generators instead of loading all data
```

### Slow Training
```python
# Solutions:
- Use GPU (CUDA)
- Enable data parallelism
- Use faster data loaders (num_workers)
- Profile with torch.profiler
```

### Poor Model Performance
```python
# Solutions:
- More/better quality data
- Feature engineering
- Hyperparameter tuning
- Try different architectures
- Ensemble methods
```

---

## Next Steps

1. Review all docs in the `/docs` folder sequentially
2. Define your ML problem clearly
3. Set up data pipeline and validate data quality
4. Build baseline model first
5. Experiment systematically with tracking
6. Evaluate thoroughly before deployment
7. Monitor and iterate in production

---

## Resources

### Learning
- [PyTorch Documentation](https://pytorch.org/docs/)
- [Hugging Face Course](https://huggingface.co/course/)
- [MLOps Guide](https://ml-ops.org/)
- [Made With ML](https://madewithml.com/)

### Tools
- [MLflow](https://mlflow.org/) - Experiment tracking
- [DVC](https://dvc.org/) - Data version control
- [Evidently AI](https://www.evidentlyai.com/) - Model monitoring
- [BentoML](https://www.bentoml.com/) - Model serving

---

> **For AI builders:** Check [AGENTS.md](AGENTS.md) for collaboration guidelines and the `/docs` folder for complete technical documentation.
