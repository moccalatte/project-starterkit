# 05. Model Architecture

## 5.1 Model Selection
- **Algorithm**: XGBoost / LightGBM / Neural Network (PyTorch).
- **Reasoning**: Gradient boosting handles tabular data best.

## 5.2 Training Configuration
- **Objective Function**: Binary Cross Entropy / Log Loss.
- **Optimization**: Grid Search / Bayesian Optimization for Hyperparams.

## 5.3 Validation Strategy
- **K-Fold Cross Validation** (if not time-series).
- **Hold-out Set** strictly separated from training.
