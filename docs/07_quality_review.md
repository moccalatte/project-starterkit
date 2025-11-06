# Quality Standards

**Quality is not about perfect code. It's about shipping software that doesn't kill your business.**

## Definition of Done

### A feature is complete when:
1. **It solves the user problem** - Tested with real user scenarios
2. **It won't kill the business** - Passes the 3 fatal gates (security, data, operations)
3. **It can be supported** - You can debug and fix it at 3am
4. **It delivers value** - Users actually use it

### Not required for "done":
- 100% test coverage
- Perfect documentation
- Zero technical debt
- Handling every edge case

---

## Testing Strategy

### Priority 1: Manual Testing
**Core User Flow**: The primary journey must work end-to-end
- Happy path works without crashes
- Common error scenarios handled gracefully
- Users understand what to do when things go wrong

**Security Boundaries**: Authentication and authorization work
- Unauthenticated users can't access protected resources
- Users can only access their own data
- Admin functions require admin privileges

**Data Integrity**: Critical data isn't corrupted
- User data persists correctly
- Financial transactions are atomic
- System state remains consistent

### Priority 2: Automated Testing (When Justified)
**Unit Tests**: Only for complex business logic
- Critical calculations
- Complex validation rules
- Edge cases that have caused bugs

**Integration Tests**: Only for critical user flows
- End-to-end user registration
- Payment processing (if applicable)
- Data import/export functionality

**Performance Tests**: Only for identified bottlenecks
- Database queries under load
- API endpoints with high traffic
- Resource-intensive operations

### What NOT to Test
- Trivial getters/setters
- Framework functionality
- Third-party library behavior
- Hypothetical edge cases

---

## Code Quality Principles

### Readable Code
**Code should explain what it does without comments**
```python
# Bad
def calc(u, p):  # Calculate user premium
    return u.age * p.rate * 0.1

# Good
def calculate_age_based_premium(user, policy):
    age_factor = 0.1
    return user.age * policy.rate * age_factor
```

### Simple Code
**Fewer lines, fewer dependencies, fewer abstractions**
- Choose the simplest solution that works
- Don't abstract until you have 3+ similar cases
- Avoid clever code that requires explanation

### Debuggable Code
**When things break (they will), you need to understand why**
```python
# Bad
try:
    process_payment(user, amount)
except:
    return error_response()

# Good
try:
    process_payment(user, amount)
except PaymentValidationError as e:
    logger.error(f"Payment validation failed: {e}", extra={
        'user_id': user.id,
        'amount': amount,
        'error_type': 'validation'
    })
    return {"error": "Invalid payment information"}
except PaymentProcessingError as e:
    logger.error(f"Payment processing failed: {e}", extra={
        'user_id': user.id,
        'amount': amount,
        'error_type': 'processing'
    })
    return {"error": "Payment could not be processed"}
```

### Recoverable Code
**Systems should degrade gracefully, not crash completely**
- Use circuit breakers for external dependencies
- Implement retry logic with backoff
- Provide fallback behaviors when possible

---

## Performance Standards

### User-Facing Requirements
- **Page loads**: < 2 seconds for primary user flows
- **API responses**: < 500ms for simple operations
- **Database queries**: < 100ms for common queries
- **File uploads**: Progress indication for > 1MB files

### System Requirements
- **Container Efficiency**: Images < 500MB, startup time < 30 seconds
- **Resource Management**: CPU/Memory limits enforced, no container restarts
- **Health Monitoring**: All services pass health checks consistently
- **Memory Usage**: No memory leaks in long-running processes
- **Database Connections**: Proper connection pooling and cleanup
- **Background Jobs**: Complete within business requirements

### Optimization Strategy
1. **Measure first**: Don't optimize without data
2. **Profile bottlenecks**: Focus on actual slow parts
3. **Database optimization**: Proper indexing and query optimization
4. **Caching**: Cache expensive operations, not everything
5. **CDN**: Static assets served from edge locations

---

### Security Quality Gates

### Container Security
- [ ] Application runs as non-root user
- [ ] Base images scanned for vulnerabilities (zero critical)
- [ ] Container resources limited (CPU/memory)
- [ ] Read-only filesystem where possible
- [ ] Minimal packages installed (Alpine base preferred)

### Input Validation
- [ ] All user inputs validated for type, length, format
- [ ] SQL injection prevented with parameterized queries
- [ ] XSS prevented with output encoding
- [ ] File uploads restricted by type and size

### Authentication & Authorization
- [ ] Passwords hashed with bcrypt or equivalent
- [ ] Session tokens cryptographically secure
- [ ] Authorization checked for every sensitive operation
- [ ] Failed authentication attempts logged and rate-limited

### Data Protection
- [ ] Sensitive data encrypted at rest
- [ ] All communications use HTTPS/TLS
- [ ] Error messages don't leak sensitive information
- [ ] Audit logs capture security-relevant events

---

## Code Review Checklist

### Functionality
- [ ] Does this solve the stated problem?
- [ ] Are the requirements clearly understood?
- [ ] Are error cases handled appropriately?
- [ ] Is the solution appropriately scoped?

### Security
- [ ] Are inputs properly validated?
- [ ] Are authentication/authorization checks in place?
- [ ] Could this introduce security vulnerabilities?
- [ ] Are sensitive operations properly logged?

### Maintainability
- [ ] Is the code readable and understandable?
- [ ] Are variable and function names descriptive?
- [ ] Is the solution appropriately simple?
- [ ] Are there sufficient comments for complex logic?

### Performance
- [ ] Are there obvious performance issues?
- [ ] Are database queries optimized?
- [ ] Is caching used appropriately?
- [ ] Are resources properly managed/cleaned up?

---

## Quality Metrics That Matter

### User-Centric Metrics
- **Error rate**: Percentage of user requests that fail
- **Response time**: Time to complete user actions
- **Uptime**: Percentage of time system is available
- **User satisfaction**: Actual feedback from real users

### Developer-Centric Metrics
- **Mean time to recovery**: How quickly you fix issues
- **Deployment frequency**: How often you ship improvements
- **Change failure rate**: Percentage of deployments that cause issues
- **Lead time**: Time from commit to production

### Business-Centric Metrics
- **Feature adoption**: Percentage of users using new features
- **User retention**: Percentage of users who return
- **Support ticket volume**: Number of user-reported issues
- **Revenue impact**: Business value delivered by quality improvements

---

## Anti-Patterns to Avoid

❌ **Perfectionism**: Spending weeks polishing code that works
✅ **Good Enough**: Ship working code, improve based on real usage

❌ **Over-Testing**: 100% test coverage as a goal
✅ **Smart Testing**: Test what breaks and costs money

❌ **Premature Optimization**: Optimizing before measuring
✅ **Informed Optimization**: Fix actual bottlenecks with data

❌ **Gold Plating**: Adding features users didn't ask for
✅ **User Focus**: Build what users actually need

---

**Remember**: Quality is about outcomes, not process. High-quality software solves real problems reliably and can be maintained by your team.