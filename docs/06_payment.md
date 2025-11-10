# Payment Security Guide

**Handle money safely—protect your business and your users.**

---

## 1. Payment Risks
- Payment fraud (stolen cards, chargebacks)
- Subscription abuse (trial abuse, account sharing)
- PCI compliance (never store card data)
- Webhook spoofing (always verify)

## 2. Platform-Specific Payment Integration
- Telegram, WhatsApp, Discord: use official APIs or trusted processors (Midtrans, Stripe, Xendit)
- Always verify payment on backend before granting access
- Never trust webhook data without signature verification
- Log all payment events for audit

## 3. Fraud Detection & Prevention
- Velocity checks (limit $/hour/user)
- Geographic anomaly detection
- Device fingerprinting
- Manual review for high-value/flagged transactions

## 4. Compliance & Legal
- Terms of Service: show before payment
- GDPR: allow users to request/delete payment data
- PCI DSS: use processor tokens, never store card data

---

**Checklist:**
- [ ] Never store card data
- [ ] Webhook signature verification for all payment events
- [ ] Amount/currency verification
- [ ] Audit log for all payment actions
- [ ] ToS shown before payment

---

**Remember:** Payment is the #1 way to kill your business if done wrong. Use established processors, verify everything, and monitor for fraud.