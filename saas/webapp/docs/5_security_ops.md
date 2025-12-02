# 5. Security & Operations

## 5.1 Security Manifest
*   **Authentication**: Strong password policies, MFA support.
*   **Data Protection**: Encrypted at rest (DB) and in transit (TLS).
*   **Input Validation**: All inputs sanitized on backend.

## 5.2 Infrastructure
*   **Hosting**: [e.g., AWS, Vercel, DigitalOcean]
*   **CI/CD**: GitHub Actions pipeline details.

## 5.3 Deployment Strategy
*   **Staging**: Auto-deploy from `develop`.
*   **Production**: Manual approval from `main`.

## 5.4 Monitoring & Observability
*   **Logs**: Centralized logging (e.g., ELK, CloudWatch).
*   **Metrics**: Prometheus/Grafana or Datadog.

## 5.5 Disaster Recovery
*   **Backups**: Daily DB snapshots, retained for 30 days.
*   **Recovery RTO/RPO**: Goal < 4 hours.
