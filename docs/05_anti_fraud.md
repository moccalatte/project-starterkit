# Anti-Fraud & Abuse Prevention

**Protect your business from users who want to exploit/abuse your system.**

## Critical Fraud Vectors (What Will Kill You)

### 1. **Account Takeover**
**Attack**: Bad actors steal user accounts
**Impact**: Identity theft, financial loss, reputation damage
**Prevention**:
- Strong password requirements (12+ chars, complexity)
- Account lockout after 5 failed login attempts
- Email/SMS verification for suspicious logins
- Monitor login patterns (new device/location alerts)

### 2. **Payment Fraud**
**Attack**: Stolen credit cards, chargebacks, fake transactions
**Impact**: Financial loss, payment processor penalties
**Prevention**:
- Velocity limits (max $X per hour/day per user)
- Geographic checks (flag transactions from new countries)
- Device fingerprinting (detect suspicious devices)
- Manual review for high-value transactions

### 3. **Spam & Abuse**
**Attack**: Automated bots creating fake accounts, posting spam
**Impact**: Platform degradation, user abandonment
**Prevention**:
- CAPTCHA on registration and sensitive actions
- Rate limiting (account creation, posting, messaging)
- Phone/email verification required
- Content moderation (automated + manual review)

### 4. **Data Scraping**
**Attack**: Automated harvesting of your data/content
**Impact**: Competitive intelligence theft, GDPR violations
**Prevention**:
- API rate limiting (strict limits for non-authenticated users)
- CAPTCHA after suspicious activity
- IP blocking for persistent scrapers
- User-agent filtering (block known scraping tools)

## Implementation for Small Projects

### Rate Limiting (MANDATORY)
```javascript
// Express.js example with rate limiting
const rateLimit = require('express-rate-limit');

// General API rate limit
const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Limit each IP to 100 requests per windowMs
  message: 'Too many requests, please try again later.',
  standardHeaders: true,
  legacyHeaders: false,
});

// Strict limits for authentication
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // Limit each IP to 5 login attempts per windowMs
  skipSuccessfulRequests: true,
});

app.use('/api/', apiLimiter);
app.use('/auth/', authLimiter);
```

### Suspicious Activity Detection
```javascript
// Basic fraud pattern detection
const suspiciousPatterns = {
  // Multiple failed logins
  checkFailedLogins: (ip, count) => count > 5,
  
  // Rapid account creation
  checkAccountCreation: (ip, accounts, timeWindow) => 
    accounts > 3 && timeWindow < 3600, // 3 accounts in 1 hour
  
  // Geographic anomaly
  checkGeolocation: (user, currentCountry, lastCountry) =>
    currentCountry !== lastCountry && timeSinceLastLogin < 3600,
    
  // High-value transaction
  checkTransactionValue: (amount, userHistory) =>
    amount > userHistory.averageTransaction * 10
};
```

### Essential Monitoring
```javascript
// Log suspicious events
const logSuspiciousActivity = (event, details) => {
  console.log(JSON.stringify({
    timestamp: new Date().toISOString(),
    event_type: 'suspicious_activity',
    event: event,
    ip_address: details.ip,
    user_id: details.userId || 'anonymous',
    details: details,
    severity: getSeverityLevel(event)
  }));
};

// Examples of what to log
logSuspiciousActivity('multiple_failed_logins', {
  ip: req.ip,
  attempts: 6,
  timeWindow: '15min'
});

logSuspiciousActivity('high_value_transaction', {
  userId: user.id,
  amount: 5000,
  average: user.averageTransaction
});
```

## Platform-Level Protection

### Use Free/Affordable Services (Solo Developer Friendly)
- **Cloudflare**: DDoS protection, WAF, rate limiting, bot detection (FREE plan)
- **Google reCAPTCHA**: Bot detection and CAPTCHA (FREE)
- **Stripe Radar**: Payment fraud detection (only pay per transaction)
- **Railway**: Built-in DDoS protection with hosting
- **Supabase**: Free authentication with built-in security features

### Database Protection
```sql
-- Prevent SQL injection with parameterized queries
-- BAD: Vulnerable to SQL injection
SELECT * FROM users WHERE email = '" + userInput + "'

-- GOOD: Parameterized query
SELECT * FROM users WHERE email = $1
```

### Input Validation
```javascript
// Validate and sanitize ALL inputs
const validator = require('validator');
const xss = require('xss');

const validateInput = (input, type) => {
  // Remove XSS attempts
  const cleaned = xss(input);
  
  switch(type) {
    case 'email':
      return validator.isEmail(cleaned) ? cleaned : null;
    case 'phone':
      return validator.isMobilePhone(cleaned) ? cleaned : null;
    case 'text':
      return validator.isLength(cleaned, {min: 1, max: 1000}) ? cleaned : null;
    default:
      throw new Error('Unknown validation type');
  }
};
```

## Incident Response Plan

### When Fraud is Detected:
1. **Immediate**: Block the suspicious account/IP
2. **Within 1 hour**: Investigate scope of attack
3. **Within 24 hours**: Implement additional protections
4. **Within 48 hours**: Report to authorities if required

### Escalation Triggers:
- **5+ failed login attempts** from same IP → Auto-block IP for 1 hour
- **Suspected payment fraud** → Hold transaction, manual review
- **Mass account creation** → CAPTCHA required, IP investigation
- **Data scraping detected** → Rate limit to 1 request/minute

## Compliance Considerations

### GDPR/CCPA:
- **Data minimization**: Only collect necessary data for fraud prevention
- **User rights**: Allow users to access fraud detection data about them
- **Retention limits**: Delete fraud logs after legitimate business need expires

### Financial Regulations:
- **PCI DSS**: If handling payments, follow PCI compliance requirements
- **AML**: Monitor for money laundering patterns in financial transactions
- **KYC**: Know Your Customer requirements for financial services

## Cost-Effective Implementation

### For Solo Developers:
1. **Use platform services** (Cloudflare, Auth0) instead of building from scratch
2. **Focus on the big 4**: Rate limiting, input validation, auth security, monitoring
3. **Start simple**: Basic rate limits and logging, expand based on actual threats
4. **Automate responses**: Block IPs automatically, manual review for edge cases

### Red Flags (Don't Do This):
❌ No rate limiting ("we'll add it later")
❌ Trusting user input without validation
❌ Logging passwords or sensitive data
❌ No monitoring or alerting
❌ Complex fraud detection for 0 users
❌ Building everything from scratch

---

**Remember**: Fraud prevention is like insurance - you need it before you need it. Implement basic protections from day 1, not after your first attack.