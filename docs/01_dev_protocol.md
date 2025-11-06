# Development Protocol: Craft & Ship

## Core Philosophy
Build systems that **solve real problems** while **protecting real assets**. Every line of code should either create value or prevent catastrophic failure.

## The 3 Fatal Gates

Before production, these 3 areas will kill your business if wrong:

### 1. **Fraud & Financial Integrity**
- **Authentication**: Who is this user? (Never trust, always verify)
- **Authorization**: What can they do? (Principle of least privilege)
- **Audit Trail**: Immutable log of WHO did WHAT, WHEN, and FROM WHERE
- **Data Integrity**: Financial/critical data ACID compliance

### 2. **Security & Privacy**
- **Input Validation**: Assume all input is malicious until proven otherwise
- **Encryption**: Sensitive data encrypted at rest and in transit (AES-256 minimum)
- **Error Handling**: Fail securely - never leak system internals
- **Access Controls**: Zero-trust architecture with time-limited tokens

### 3. **Operational Resilience**
- **Database Integrity**: ACID transactions, backup/restore tested, migration scripts
- **Containerization**: Docker with optimized images, health checks, resource limits
- **Monitoring**: Real-time alerts for system health and security events
- **Logging**: Structured logs for debugging (JSON format, correlation IDs)
- **Recovery**: Tested disaster recovery and rollback procedures

## The Production Gates

### Gate 1: Security Review
- [ ] Authentication/authorization tested with edge cases
- [ ] All user inputs validated and sanitized
- [ ] Error messages reveal no system information
- [ ] Audit logs capture compliance requirements

### Gate 2: Failure Testing
- [ ] System fails gracefully under load
- [ ] Data corruption scenarios tested
- [ ] Recovery procedures validated
- [ ] Monitoring alerts trigger correctly

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

## Anti-Patterns That Kill Companies

❌ **Logging everything** - creates noise, misses signals
✅ **Log business events** - payments, access, changes

❌ **Complex security theater** - easy to bypass, hard to maintain  
✅ **Simple, tested controls** - authentication, authorization, audit

❌ **Perfect error handling** - over-engineered recovery
✅ **Graceful degradation** - fail safe, recover fast

❌ **Compliance checklists** - box-ticking without understanding
✅ **Risk-based controls** - protect what actually matters

---

**Remember**: You're not building software. You're building a business that software enables. Every technical decision should serve business survival and growth.

✅ Done
