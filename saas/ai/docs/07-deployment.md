# 07. Deployment

## 7.1 Serving Architecture
- **API**: FastAPI wrapper around model `predict()`.
- **Container**: Docker image with Python dependencies.

## 7.2 Scalability
- **Horizontal Scaling**: Kubernetes HPA based on CPU usage.
- **Batch Serving**: If real-time not needed, pre-compute recommendations to DB.

## 7.3 Monitoring
- **Drift Detection**: Monitor input data distribution changes (KL Divergence).
- **Performance**: Track API latency and Error rates.
