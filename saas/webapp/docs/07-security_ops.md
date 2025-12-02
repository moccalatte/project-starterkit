# 07. Security & Operations

## 7.1 Security Measures
- **Authentication**: JWT with short expiration + Refresh Token rotation.
- **Authorization**: Role-Based Access Control (RBAC) - Admin vs User.
- **Data Protection**: TLS 1.2+ for transit, AES-256 for DB storage.
- **Input Validation**: Zod/Joi validation on all API inputs.
- **CORS**: Restrict to allowed domains only.

## 7.2 Infrastructure & Deployment
- **Environments**:
    - `dev`: Local development.
    - `staging`: Mirror of prod, auto-deployed from `develop`.
    - `prod`: Live environment, manual deploy from `main`.
- **Containerization**: Dockerfile provided for consistent builds.

## 7.3 Observability
- **Logging**: Structured JSON logs. Levels: Info, Warn, Error.
- **Monitoring**: Health check endpoint `/health`. Uptime monitoring.
- **Alerting**: Slack/Email alerts on 5xx error spikes.

## 7.4 Disaster Recovery
- **Backups**: Daily automated DB backups.
- **Rollback**: CI/CD pipeline supports easy rollback to previous tag.
