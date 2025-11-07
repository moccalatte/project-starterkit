# Development Protocol: Craft & Ship

## Core Philosophy
Build systems that **solve real problems** while **protecting real assets**. Every line of code should either create value or prevent catastrophic failure.

## The 3 Fatal Gates

Before production, these 3 areas will kill your business if wrong:

### 1. **Fraud & Financial Integrity**
- **Authentication**: Who is this user? (Never trust, always verify)
- **Authorization**: What can they do? (Principle of least privilege)
- **Payment Security**: If handling money, webhook verification + amount validation mandatory
- **Rate Limiting**: Prevent automated attacks (100 req/min per IP, 1000/hour per user)
- **Fraud Detection**: Monitor for suspicious patterns (velocity, geo, behavior)
- **Audit Trail**: Immutable log of WHO did WHAT, WHEN, FROM WHERE
- **Data Integrity**: Financial/critical data ACID compliance

### 2. **Security & Privacy**
- **Input Validation**: Assume all input is malicious until proven otherwise
- **Encryption**: Sensitive data encrypted at rest and in transit (AES-256 minimum)
- **Error Handling**: Fail securely - never leak system internals
- **Access Controls**: Zero-trust architecture with time-limited tokens

### 3. **Operational Resilience**
- **Database Integrity**: ACID transactions, backup/restore tested, migration scripts
- **Containerization**: Docker with optimized images, health checks, resource limits
- **Simple Monitoring**: Basic health checks + platform alerts (NO Prometheus/Grafana for small projects)
- **Essential Logging**: Business events only (WHO did WHAT, WHEN) - avoid log noise
- **Recovery**: Tested disaster recovery and rollback procedures

## The Production Gates

### Gate 1: Security Review (BLOCKING - NO EXCEPTIONS)

#### For Bot Projects:
- [ ] **Webhook verification**: Platform requests verified (Telegram/WhatsApp/Discord)
- [ ] **Command authorization**: Admin commands restricted to authorized users
- [ ] **Input validation**: User messages/commands sanitized and validated
- [ ] **Rate limiting**: Bot commands limited (max per user per minute)
- [ ] **Token security**: Bot tokens in environment variables, NEVER in code
- [ ] **Error handling**: Bot doesn't crash on malformed input
- [ ] **Audit logs**: User ID, command, timestamp, response logged

#### For Web App Projects:
- [ ] **Authentication bypass testing**: Try to access protected resources without login
- [ ] **Authorization escalation testing**: Regular users cannot access admin functions
- [ ] **Input validation**: SQL injection, XSS, command injection tests PASS
- [ ] **Rate limiting**: API endpoints limited (100 req/min per IP minimum)
- [ ] **Error handling**: Stack traces/DB errors never exposed to users
- [ ] **Secret management**: NO hardcoded passwords, API keys, or tokens in code
- [ ] **Audit logs**: WHO did WHAT, WHEN, FROM WHERE (tamper-proof)

### Gate 2: Failure Testing
- [ ] System fails gracefully under load
- [ ] Data corruption scenarios tested
- [ ] Recovery procedures validated
- [ ] Simple monitoring alerts work (no enterprise tools required)

### Gate 3: Business Validation
- [ ] Solves the actual user problem
- [ ] Meets compliance requirements
- [ ] Performance acceptable under real load
- [ ] Can be supported in production
- [ ] Dockerized with optimized images and health checks

## AI Development Principles
- **State the real problem** - not your solution bias
- **Ask for threat analysis** - what could go wrong?
- **Demand working examples** - not theoretical code
- **Test edge cases** - AI is optimistic, reality isn't

## Emergency Procedures

### Security Breach
1. **Isolate immediately** - network, users, data
2. **Preserve evidence** - logs, traffic, state
3. **Assess impact** - what data/money is at risk?
4. **Communicate** - internal team, external if legally required

### System Failure
1. **Rollback if possible** - previous known good state
2. **Activate backup systems** - manual procedures if needed
3. **Preserve logs** - for post-mortem analysis
4. **Track financial impact** - revenue, costs, liability

## The Compliance Reality Check

Every feature must answer:
- **Audit Question**: Can we prove this happened and why?
- **Fraud Question**: How could someone steal money/data here?
- **Debug Question**: When this breaks at 3am, can we fix it?
- **Legal Question**: Are we liable if this goes wrong?

## Anti-Patterns That Kill Solo Projects

❌ **Enterprise monitoring** (Prometheus, Grafana, ELK stack) - overkill for small projects
✅ **Platform monitoring** (Railway metrics, Uptime Robot, simple health checks)

❌ **Logging everything** - creates noise, costs money, slows performance  
✅ **Log critical events** - auth failures, payments, errors, user actions

❌ **Complex architectures** - microservices, event sourcing, CQRS for simple apps
✅ **Monolith first** - single database, simple deployment, easy debugging

❌ **Enterprise security** - OAuth providers, complex RBAC, audit systems
✅ **Essential security** - bcrypt passwords, input validation, rate limiting

❌ **Perfect abstractions** - repositories, services, factories everywhere
✅ **Clean simplicity** - readable code, minimal layers, easy to change

❌ **Premature optimization** - caching, CDNs, load balancers before needed
✅ **Simple scaling** - start small, optimize when you have real traffic

---

**Remember**: You're building a business, not showcasing enterprise architecture. Keep it simple, keep it working, keep it profitable. Scale complexity only when revenue justifies it.

## Lightweight Architecture Principles

### Start Simple, Scale Smart
- **Database**: PostgreSQL/Supabase → Redis caching → Vector DB (Pinecone/Qdrant) if needed
- **Hosting**: Single server → Load balancer (only when needed)  
- **Monitoring**: Health checks → Platform metrics → Custom dashboards
- **Logging**: Console logs → Structured logs → Log aggregation

### No Enterprise Cosplay
- **DON'T** use Kubernetes for 10 users
- **DON'T** implement microservices before monolith pain
- **DON'T** add Prometheus/Grafana for simple monitoring needs
- **DON'T** build complex CI/CD before you have complexity to manage

### Clean & Simple Code Structure
```
/src
  /routes      # API endpoints (flat structure)
  /services    # Business logic (no deep abstractions)
  /models      # Database models (simple ORMs)
  /utils       # Helper functions
  /tests       # Essential tests only
/config        # Environment configurations
/scripts       # Setup, backup, deployment scripts
```

### Essential vs Enterprise

| Need | Simple Solution | Enterprise Overkill |
|------|----------------|-------------------|
| Monitoring | Uptime Robot + Platform metrics | Prometheus + Grafana |
| Logging | Structured console logs | ELK Stack |
| Database | PostgreSQL/Supabase | Multi-master clusters |
| Deployment | Git push to platform | Complex K8s manifests |
| Error Tracking | Simple error logs | Distributed tracing |
| Authentication | bcrypt + sessions | OAuth2 + JWT + RBAC |

**The Rule**: If it takes longer to set up than to build your core feature, you don't need it yet.

✅ Done
