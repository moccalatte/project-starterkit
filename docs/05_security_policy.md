# Security Policy

**Security is about protecting assets, not following checklists.**

## Threat Model

### What Are You Actually Protecting?
**Critical Assets**:
- User credentials and personal data
- Business data and transactions
- System availability and integrity
- [Your specific valuable data]

**Threat Actors**:
- External attackers seeking data/money
- Malicious users exploiting features
- Accidental data exposure
- System failures causing data loss

### Attack Surface Analysis
**Entry Points**:
- Web application inputs
- API endpoints
- User authentication
- Administrative interfaces
- Database connections
- Third-party integrations

---

## Security Controls

### Authentication: Who Is This?
**Requirements**:
- Strong password policy (12+ chars, complexity)
- Secure session management (24hr timeout)
- Account lockout after failed attempts
- Optional 2FA for sensitive accounts

**Implementation**:
```python
# Password hashing - NEVER store plaintext
password_hash = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

# Session tokens - cryptographically secure
session_token = secrets.token_urlsafe(32)

# Session validation
if session_expired_or_invalid(token):
    return redirect_to_login()
```

### Authorization: What Can They Do?
**Principle of Least Privilege**: Users get minimum necessary access.

**Role-Based Access**:
- Regular users: Own data only
- Admin users: System management
- Service accounts: Specific integrations

**Implementation Pattern**:
```python
@require_permission('resource:action')
def sensitive_operation(user, resource):
    if not user.can_access(resource):
        raise PermissionDenied()
    # Proceed with operation
```

### Input Validation: Assume Malicious Intent
**All input is guilty until proven innocent.**

**Validation Rules**:
- Sanitize HTML content
- Validate data types and ranges
- Check business logic constraints
- Prevent SQL injection with parameterized queries

**Implementation**:
```python
# SQL injection prevention
cursor.execute(
    "SELECT * FROM users WHERE email = %s", 
    (user_email,)  # Parameterized query
)

# Input sanitization
clean_html = bleach.clean(user_input, tags=['p', 'br'], strip=True)
```

### Data Protection: Encrypt What Matters
**Encryption Strategy**:
- Sensitive data at rest: AES-256
- All data in transit: TLS 1.3
- Database connections: Encrypted
- Backup files: Encrypted

**What to Encrypt**:
- Personally identifiable information (PII)
- Financial/payment data
- Authentication credentials
- Business-sensitive information

### Error Handling: Fail Securely
**Error responses must not leak system information.**

**Secure Error Handling**:
```python
try:
    sensitive_operation()
except SpecificBusinessError as e:
    # Log detailed error for debugging
    logger.error(f"Operation failed: {e}", extra={'user_id': user.id})
    # Return generic error to user
    return {"error": "Operation failed. Please try again."}
except Exception as e:
    # Log unexpected errors
    logger.exception("Unexpected error", extra={'user_id': user.id})
    # Never expose internal errors
    return {"error": "Internal error. Support has been notified."}
```

---

## Monitoring & Detection

### Security Logging
**Log all security-relevant events**:
- Authentication attempts (success/failure)
- Authorization failures
- Sensitive data access
- Administrative actions
- System errors and exceptions

**Log Format**:
```json
{
  "timestamp": "2024-01-15T10:30:00Z",
  "event_type": "auth_failure",
  "user_id": "user123",
  "ip_address": "192.168.1.100",
  "user_agent": "Mozilla/5.0...",
  "details": {"reason": "invalid_password", "attempt_count": 3}
}
```

### Anomaly Detection
**Automated alerts for**:
- Multiple failed login attempts
- Unusual access patterns
- High-volume data exports
- Administrative actions outside business hours
- Database errors or performance issues

### Incident Response
**When security alerts trigger**:
1. **Assess**: Is this a real threat or false positive?
2. **Contain**: Isolate affected systems/accounts
3. **Investigate**: Determine scope and impact
4. **Recover**: Restore secure state
5. **Learn**: Update controls to prevent recurrence

---

## Compliance Requirements

### Data Protection (GDPR/CCPA)
- **Consent**: Clear opt-in for data collection
- **Access**: Users can view their data
- **Portability**: Users can export their data
- **Deletion**: Users can request account deletion
- **Breach Notification**: Report breaches within 72 hours

### Industry-Specific Requirements
- **Healthcare**: HIPAA compliance for health data
- **Finance**: PCI DSS for payment data
- **Government**: FedRAMP for federal contracts

### Audit Requirements
- **Immutable logs**: Cannot be modified after creation
- **Log retention**: [X] years for compliance
- **Access logs**: Who accessed what data when
- **Change logs**: All system modifications tracked

---

## Security Testing

### Regular Security Activities
- **Monthly**: Dependency vulnerability scans
- **Quarterly**: Penetration testing
- **Annually**: Security architecture review

### Code Security
- **Static analysis**: Automated code scanning
- **Dependency scanning**: Known vulnerability detection
- **Security code review**: Manual review of sensitive code

### Infrastructure Security
- **Container Security**: Non-root users, minimal base images, vulnerability scanning
- **Network Security**: Firewall rules, network segmentation, service mesh
- **Image Security**: Signed images, registry scanning, minimal attack surface
- **Runtime Security**: Read-only filesystems, resource constraints, capability dropping

---

**Remember**: Security is not a feature you add at the end. It's a constraint that shapes every design decision from day one.