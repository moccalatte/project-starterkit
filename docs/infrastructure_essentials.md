# Infrastructure Essentials

**Ship infrastructure that doesn't break at 2am.**

## Docker Fundamentals

### Container Philosophy
**Every application MUST be containerized. No exceptions.**

Why Docker is non-negotiable:
- **Consistency**: Same environment from development to production
- **Isolation**: Application failures don't crash the host
- **Portability**: Deploy anywhere containers run
- **Scalability**: Easy horizontal scaling
- **Recovery**: Fast restart and rollback capabilities

### Dockerfile Best Practices

#### Multi-Stage Builds (Required)
```dockerfile
# Example: Node.js application
FROM node:18-alpine AS dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine AS runtime
# Create non-root user
RUN addgroup -g 1001 -S appgroup && \
    adduser -S appuser -u 1001 -G appgroup

WORKDIR /app

# Copy only what's needed
COPY --from=dependencies --chown=appuser:appgroup /app/node_modules ./node_modules
COPY --from=builder --chown=appuser:appgroup /app/dist ./dist
COPY --from=builder --chown=appuser:appgroup /app/package.json ./

# Security hardening
USER appuser
EXPOSE 3000

# Health check (mandatory)
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

CMD ["node", "dist/index.js"]
```

#### Image Optimization Rules
1. **Size Target**: < 500MB final image
2. **Base Images**: Use Alpine Linux variants
3. **Layer Efficiency**: Minimize layers, combine RUN commands
4. **Security**: Non-root user, minimal packages
5. **Health Checks**: Always include health check endpoints

### Docker Compose for Development

```yaml
version: '3.8'
services:
  app:
    build: 
      context: .
      target: runtime
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://app:password@db:5432/appdb
      - REDIS_URL=redis://redis:6379
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
    volumes:
      - ./src:/app/src:ro  # Read-only source mounting
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    restart: unless-stopped

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: appdb
      POSTGRES_USER: app
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./scripts/init.sql:/docker-entrypoint-initdb.d/init.sql:ro
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U app -d appdb"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    command: redis-server --appendonly yes --requirepass redis_password
    volumes:
      - redis_data:/data
    ports:
      - "6379:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 3s
      retries: 3
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:

networks:
  default:
    driver: bridge
```

---

## Production Infrastructure

### Container Orchestration Strategy

#### Small Projects (< 10 containers)
**Docker Compose with Docker Swarm**
```yaml
version: '3.8'
services:
  app:
    image: myapp:latest
    deploy:
      replicas: 3
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

#### Medium Projects (10-50 containers)
**Managed Container Services**
- AWS ECS/Fargate
- Google Cloud Run
- Azure Container Instances

#### Large Projects (50+ containers)
**Kubernetes** (but only when complexity is justified)

### Resource Management

#### Container Resource Limits (Mandatory)
```yaml
# Development
resources:
  limits:
    cpus: '2.0'
    memory: 1G
  reservations:
    cpus: '0.5'
    memory: 256M

# Production
resources:
  limits:
    cpus: '1.0'
    memory: 512M
  reservations:
    cpus: '0.25'
    memory: 128M
```

#### Monitoring Resource Usage
```bash
# Check container resource usage
docker stats

# Check specific container
docker exec <container> cat /sys/fs/cgroup/memory/memory.usage_in_bytes
```

### Storage Strategy

#### Persistent Data
```yaml
# Use named volumes for database data
volumes:
  postgres_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /opt/app/data

# Use bind mounts for configuration
volumes:
  - ./config/nginx.conf:/etc/nginx/nginx.conf:ro
```

#### Backup Strategy
```bash
# Database backup with Docker
docker exec postgres pg_dump -U app appdb > backup_$(date +%Y%m%d_%H%M%S).sql

# Volume backup
docker run --rm -v postgres_data:/data -v $(pwd):/backup alpine \
  tar czf /backup/postgres_backup_$(date +%Y%m%d).tar.gz -C /data .
```

---

## Security Hardening

### Container Security Checklist
- [ ] **Non-root user**: Application runs as unprivileged user
- [ ] **Read-only filesystem**: Root filesystem mounted read-only where possible
- [ ] **Minimal base image**: Alpine Linux or distroless images
- [ ] **No secrets in images**: Use environment variables or secret management
- [ ] **Regular scanning**: Automated vulnerability scanning in CI/CD
- [ ] **Resource limits**: CPU and memory limits enforced
- [ ] **Network isolation**: Containers communicate through defined networks only

### Image Security Scanning
```bash
# Trivy security scanner
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  aquasec/trivy image myapp:latest

# Clair scanner (alternative)
docker run --rm -v $(pwd):/app \
  quay.io/coreos/clair-local-scan:latest myapp:latest
```

### Runtime Security
```dockerfile
# Security-hardened container
FROM alpine:3.18
RUN addgroup -g 1001 -S appgroup && \
    adduser -S appuser -u 1001 -G appgroup && \
    apk add --no-cache ca-certificates

WORKDIR /app
COPY --chown=appuser:appgroup app .

# Drop all capabilities except network binding
USER appuser
EXPOSE 3000

# Read-only root filesystem
VOLUME ["/tmp"]
CMD ["./app"]
```

---

## Monitoring and Logging

### Container Health Monitoring

#### Essential Health Checks
```bash
# Application health endpoint
curl -f http://localhost:3000/health || exit 1

# Database connectivity
pg_isready -h localhost -p 5432 -U app

# Redis connectivity  
redis-cli ping

# File system health
test -w /app/tmp || exit 1
```

#### Simple Monitoring Stack (No Prometheus/Grafana)
```yaml
# docker-compose.monitoring.yml
version: '3.8'
services:
  # Simple health checker
  healthcheck:
    image: alpine/curl
    command: |
      sh -c "
        while true; do
          curl -f http://app:3000/health || echo 'App unhealthy'
          curl -f http://db:5432 || echo 'DB unreachable'
          sleep 60
        done
      "
    depends_on:
      - app
      - db

  # Log aggregation with rsyslog
  logs:
    image: rsyslog/rsyslog_base_ubuntu
    volumes:
      - /var/log:/host/var/log:ro
      - ./rsyslog.conf:/etc/rsyslog.conf:ro
    ports:
      - "514:514/udp"
```

### Log Management

#### Structured Logging Format
```json
{
  "timestamp": "2024-01-15T10:30:00Z",
  "level": "info",
  "service": "api",
  "container_id": "a1b2c3d4e5f6",
  "user_id": "12345",
  "request_id": "req_abc123",
  "action": "user_login",
  "duration_ms": 150,
  "status": "success"
}
```

#### Log Rotation and Cleanup
```yaml
# docker-compose.yml logging configuration
services:
  app:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
        compress: "true"
```

---

## Performance Optimization

### Container Performance Tuning

#### Image Optimization
```dockerfile
# Use .dockerignore to reduce build context
# .dockerignore
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.nyc_output
coverage
```

#### Multi-Stage Build Optimization
```dockerfile
# Cache dependencies separately
FROM node:18-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build && npm prune --production

# Final stage - minimal runtime
FROM node:18-alpine AS runner
RUN apk add --no-cache dumb-init
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

USER node
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "dist/index.js"]
```

### Database Container Optimization

#### PostgreSQL Configuration
```yaml
# docker-compose.yml
services:
  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: appdb
      POSTGRES_USER: app
      POSTGRES_PASSWORD: password
    command: |
      postgres
      -c shared_preload_libraries=pg_stat_statements
      -c pg_stat_statements.track=all
      -c max_connections=100
      -c shared_buffers=256MB
      -c effective_cache_size=1GB
      -c work_mem=4MB
      -c maintenance_work_mem=64MB
    volumes:
      - postgres_data:/var/lib/postgresql/data
```

---

## CI/CD Integration

### Container Build Pipeline
```yaml
# .github/workflows/docker.yml
name: Docker Build and Push
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      
      - name: Login to Container Registry
        uses: docker/login-action@v2
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Build and push
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ghcr.io/${{ github.repository }}:latest
          cache-from: type=gha
          cache-to: type=gha,mode=max
      
      - name: Security scan
        run: |
          docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
            aquasec/trivy image ghcr.io/${{ github.repository }}:latest
```

---

## Disaster Recovery

### Container Backup Strategy
```bash
#!/bin/bash
# backup-containers.sh

# Backup container volumes
docker run --rm \
  -v postgres_data:/source:ro \
  -v $(pwd)/backups:/backup \
  alpine tar czf /backup/postgres_$(date +%Y%m%d_%H%M%S).tar.gz -C /source .

# Backup application configuration
docker run --rm \
  -v app_config:/source:ro \
  -v $(pwd)/backups:/backup \
  alpine tar czf /backup/config_$(date +%Y%m%d_%H%M%S).tar.gz -C /source .

# Export container images
docker save myapp:latest | gzip > backups/myapp_$(date +%Y%m%d_%H%M%S).tar.gz
```

### Recovery Procedures
```bash
#!/bin/bash
# restore-containers.sh

# Stop running containers
docker-compose down

# Restore volumes
docker run --rm \
  -v postgres_data:/target \
  -v $(pwd)/backups:/backup \
  alpine tar xzf /backup/postgres_latest.tar.gz -C /target

# Restore configuration
docker run --rm \
  -v app_config:/target \
  -v $(pwd)/backups:/backup \
  alpine tar xzf /backup/config_latest.tar.gz -C /target

# Start services
docker-compose up -d
```

---

**Remember**: Containers are not magic. They're tools that enforce good practices. Use them to make your infrastructure predictable, not complex.