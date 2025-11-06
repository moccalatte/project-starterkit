# System Architecture

**Design for failure. Everything else is wishful thinking.**

## Core Architectural Decision
**Monolith first.** Don't build microservices until monolith pain justifies the complexity cost.

## Failure-First Design

### What Kills Businesses
1. **Data Loss**: User data disappears or corrupts
2. **Security Breach**: Unauthorized access to sensitive information  
3. **System Unavailability**: Users can't access core functionality
4. **Performance Collapse**: System becomes unusably slow

### Defensive Architecture
```
Request → Input Validation → Authentication → Authorization → Business Logic → Database → Audit Log → Response
```

Each layer prevents specific failure modes.

## Essential Components

### Database Layer
**Assumption**: PostgreSQL until proven otherwise.

```sql
-- Core Business Entity (replace with your domain)
users (id, email, password_hash, created_at, verified_at)
sessions (token, user_id, expires_at, ip_address)
audit_logs (id, user_id, action, details, created_at, ip_address)

-- Your Domain Entity
[entity_name] (
  id, 
  [critical_business_fields],
  created_at, 
  updated_at,
  created_by
)
```

**Why These Tables**: Users prove identity, sessions manage access, audit logs enable debugging/compliance, domain entity solves your specific problem.

### Application Layer
- **Auth Service**: Who is this? What can they do?
- **Core Business Service**: Your actual value proposition
- **Audit Service**: Immutable logging for debugging/compliance
- **API Gateway**: Input validation, rate limiting, error handling

### Infrastructure Layer
- **Database**: Primary data store with automated backups
- **Cache**: Redis for sessions and frequently accessed data
- **Monitoring**: Application health, error rates, performance metrics
- **Logs**: Structured logging for debugging and compliance

## Data Flow

### Write Operations
```
User Input → Validation → Authentication → Authorization → Transaction Begin → 
Business Logic → Database Write → Audit Log → Transaction Commit → Response
```

**Failure Points**: Invalid input, expired session, insufficient permissions, database error, audit failure.

### Read Operations
```
User Request → Authentication → Authorization → Cache Check → Database Query → Response
```

**Optimization**: Cache frequently accessed data, but never cache sensitive information.

## Security Architecture

### Defense in Depth
1. **Input Validation**: Assume all input is malicious
2. **Authentication**: Verify user identity with secure tokens
3. **Authorization**: Check permissions for every operation
4. **Data Protection**: Encrypt sensitive data at rest and in transit
5. **Audit Logging**: Record who did what, when, from where

### Threat Mitigation
- **SQL Injection**: Parameterized queries only
- **XSS**: Output encoding, Content Security Policy
- **CSRF**: Same-origin validation, CSRF tokens
- **Session Hijacking**: Secure tokens, HTTPS only
- **Privilege Escalation**: Principle of least privilege

## Deployment Strategy

### Development
```
Docker Compose: App + Database + Redis
```

### Staging
```
Single server: App container + Managed database + Redis
```

### Production
```
Load Balancer → App Servers → Managed Database + Redis Cluster
```

**Scaling Plan**: Scale vertically first (bigger servers), then horizontally (more servers).

## Monitoring & Observability

### Critical Metrics
- **Availability**: Uptime percentage
- **Performance**: Response time percentiles
- **Errors**: Error rate and types
- **Business**: Core user actions completion rate

### Alerting
- **P0** (Immediate): System down, data corruption
- **P1** (1 hour): High error rate, performance degradation  
- **P2** (24 hours): Non-critical errors, capacity concerns

### Logging Strategy
```json
{
  "timestamp": "2024-01-15T10:30:00Z",
  "level": "info",
  "service": "auth",
  "user_id": "12345",
  "action": "login",
  "ip_address": "192.168.1.1",
  "user_agent": "Mozilla/5.0...",
  "result": "success"
}
```

**Why Structured**: Enables searching, filtering, and automated analysis.

## Technology Decisions

### Language/Framework
**Choice**: [Your choice based on team skills]
**Why**: Team expertise trumps theoretical performance

### Database
**Choice**: PostgreSQL
**Why**: ACID compliance, mature ecosystem, handles most use cases

### Deployment
**Choice**: Docker + [Cloud Provider]
**Why**: Consistency across environments, managed services reduce operational burden

### External Services
- **Email**: [Service] for transactional emails
- **Payments**: [Service] for payment processing (if applicable)
- **Monitoring**: [Service] for application monitoring

---

**Remember**: The best architecture is the one you can actually build, deploy, and maintain with your current team and constraints.