# 03. Model Requirements (PRD)

## 3.1 Prediction Target
- **Input**: User ID, Product ID, Context (Time, Device).
- **Output**: Probability of Purchase (0.0 - 1.0).

## 3.2 Performance Metrics
- **Offline**: AUC-ROC > 0.75, NDCG@10 > 0.4.
- **Online**: A/B Test Lift > 5%.

## 3.3 Data Requirements
- **History Depth**: Last 6 months of clickstream data.
- **Features**: User Demographics, Product Metadata, Interaction Counts.

## 3.4 Operational Requirements
- **Retraining Frequency**: Weekly.
- **Model Size**: < 2GB (RAM constraint).
