# Anti-Fraud & Abuse Guide

**Stop fraud and abuse before it kills your business.**

---

## 1. Critical Fraud Vectors
- Account takeover (password, social engineering)
- Payment fraud (stolen cards, chargebacks)
- Spam & abuse (fake accounts, spam posts)
- Data scraping (API/content theft)

## 2. Prevention Techniques
- Strong password requirements
- Account lockout after failed logins
- Email/SMS verification for suspicious logins
- CAPTCHA on registration/sensitive actions
- Rate limiting (API, auth, posting)
- Device fingerprinting
- Content moderation (auto/manual)
- IP/user-agent filtering

## 3. Monitoring & Response
- Log all suspicious activity
- Automated blocking (IP, account)
- Manual review for edge cases
- Incident response plan (block, investigate, escalate)

## 4. Compliance
- GDPR/CCPA: data minimization, user rights
- PCI/AML/KYC: if handling payments

---

**Checklist:**
- [ ] Rate limiting everywhere
- [ ] CAPTCHA on critical flows
- [ ] Suspicious activity logging
- [ ] Automated blocking for abuse
- [ ] Manual review process for flagged events

---

**Remember:** Fraud prevention is like insurance—implement basics from day 1, not after your first attack.