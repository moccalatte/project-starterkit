# Copy-Paste AI Prompts

**Tested prompts that actually work. Copy exactly, replace [bracketed] parts.**

## 🤖 Bot Development

### Telegram Bot
```
Build a Telegram bot for [YOUR SPECIFIC PROBLEM].

Requirements:
- Users: [WHO WILL USE THIS]
- Main feature: [WHAT IT DOES]
- Follow docs/01_dev_protocol.md safety rules
- Use webhook verification from docs/06_bot_security.md
- Include rate limiting (20 commands/minute per user)
- Use Railway hosting from docs/09_free_alternatives.md

Provide:
1. Complete bot.js file with all imports
2. package.json with exact dependencies
3. .env template with all variables needed
4. Database schema (SQLite or PostgreSQL)
5. setup.sh script that installs and runs everything
6. Railway deployment commands
7. Webhook security implementation
8. Error handling for all edge cases

Test with real Telegram API - provide step-by-step setup instructions.
```

### WhatsApp Bot (WAHA)
```
Build a WhatsApp bot using WAHA API for [YOUR SPECIFIC PROBLEM].

Requirements:
- Users: [WHO WILL USE THIS]
- Main feature: [WHAT IT DOES]
- Follow docs/01_dev_protocol.md safety rules
- Use WAHA security patterns from docs/06_bot_security.md
- Include rate limiting and spam prevention
- Use Railway hosting from docs/09_free_alternatives.md

Provide:
1. Complete app.js file with WAHA integration
2. package.json with exact dependencies
3. .env template with WAHA API configuration
4. Database schema for user data
5. setup.sh script for complete setup
6. Railway deployment guide
7. Webhook verification implementation
8. Message validation and rate limiting

Include real WAHA API examples and testing instructions.
```

## 🌐 Web App Development

### Full-Stack Web App
```
Build a web app for [YOUR SPECIFIC PROBLEM].

Requirements:
- Users: [WHO WILL USE THIS]
- Main feature: [WHAT IT DOES]
- Follow docs/01_dev_protocol.md security gates
- Use authentication and authorization
- Include payment processing if needed
- Use free stack from docs/09_free_alternatives.md

Provide:
1. Frontend (React/Next.js) with complete pages
2. Backend API with all endpoints
3. Database schema with proper relations
4. Authentication system (login/register)
5. Payment integration if needed (Stripe)
6. .env template with all variables
7. setup.sh script for local development
8. Deployment guide for Vercel + Supabase
9. Security implementation (rate limiting, input validation)
10. Error handling and user feedback

Include real working examples and test data.
```

## 💳 Payment Integration

### Payment Integration (Indonesian)
```
Add payments to my [bot/web app] for Indonesian users.

Current setup: [YOUR APP DESCRIPTION]
Payment needs: [SUBSCRIPTION/ONE-TIME]

Requirements:
- Use Midtrans or Xendit (Indonesian gateway)
- Support DANA, OVO, GoPay, Bank Transfer
- Webhook verification for security
- Payment confirmations in Indonesian

Provide complete working code:
1. Payment gateway integration (Midtrans/Xendit)
2. Webhook verification (security)
3. Database schema for payments
4. Bot/web payment flow
5. Indonesian payment methods
6. Testing with sandbox

Include step-by-step setup guide.
```

## 🚨 Emergency Fixes

### Fix Database Relations
```
Fix database relation issues in my project.

Current problem: [DESCRIBE WHAT'S BROKEN]
Current schema: [PASTE YOUR SCHEMA]

Requirements:
- Follow docs/08_ai_collaboration.md database patterns
- Fix foreign key relationships
- Add proper indexes
- Provide migration scripts
- Test data integrity

Provide:
1. Corrected database schema
2. Migration script to fix existing data
3. Updated query examples
4. Data integrity tests
5. Backup procedure before migration

Test all changes with sample data.
```

### Fix Security Issues
```
Secure my [bot/web app] for production.

Current code: [PASTE RELEVANT SECTIONS]
Identified issues: [WHAT'S WRONG]

Requirements:
- Follow docs/01_dev_protocol.md fatal gates
- Fix authentication/authorization
- Add input validation
- Implement rate limiting
- Secure error handling

Provide:
1. Security fixes for identified issues
2. Input validation middleware
3. Rate limiting implementation
4. Error handling that doesn't leak info
5. Authentication/authorization fixes
6. Security testing procedures

Include before/after examples and testing steps.
```

## 🚨 Disaster Recovery

### VPS Suspension Recovery
```
My VPS got suspended and my business is down.

Current situation: [DESCRIBE WHAT HAPPENED]
Provider: [DigitalOcean/Contabo/OVHcloud/etc]
Backup status: [WHAT BACKUPS DO YOU HAVE]

Requirements:
- Follow docs/10_disaster_recovery.md patterns
- Set up backup server immediately
- Restore from latest backup
- Switch DNS to backup server
- Prevent future suspensions

Provide:
1. Emergency activation script for backup server
2. DNS switching commands (Cloudflare API)
3. Database restoration procedure
4. Application deployment on backup server
5. User notification templates
6. Provider appeal letter template
7. Monitoring setup to prevent recurrence

Include step-by-step recovery timeline and prevention strategy.
```

### Multi-Provider Setup
```
Set up disaster recovery across multiple VPS providers.

Current setup: [DESCRIBE YOUR CURRENT INFRASTRUCTURE]
Preferred providers: [DigitalOcean, Contabo, OVHcloud, Indonesian providers]

Requirements:
- Follow docs/10_disaster_recovery.md multi-provider strategy
- Primary server + backup server different providers
- Automated backup sync between servers
- Health monitoring with DNS failover
- Cost-effective ($5-15/month total)

Provide:
1. Multi-provider infrastructure design
2. Automated backup sync scripts
3. Health check with DNS switching
4. Emergency activation procedures
5. Cost breakdown per provider
6. Monitoring and alerting setup

Include provider diversification strategy and failover testing.
```

## 🚀 Deployment

### Deploy to Production
```
Deploy my [bot/web app] to production.

Current setup: [DESCRIBE YOUR APP]
Preferred hosting: [Railway/Vercel/VPS]

Requirements:
- Follow docs/04_deployment.md guidelines
- Use free services from docs/09_free_alternatives.md
- Include monitoring and health checks
- Set up automated backups
- Configure environment variables

Provide:
1. Deployment configuration files
2. Environment variable templates
3. Deployment commands/scripts
4. Health check endpoints
5. Monitoring setup
6. Backup configuration
7. Rollback procedures
8. Domain and SSL setup

Include step-by-step deployment guide and troubleshooting.
```

---

## 💡 Pro Tips

### Make Prompts Better
- **Be specific**: Instead of "chat bot", say "customer support bot for e-commerce"
- **Include context**: Paste your current code when asking for fixes
- **Demand completeness**: Always ask for "complete implementation with testing"
- **Reference docs**: Always mention relevant docs/XX_name.md files

### When AI Gives Incomplete Answers
```
The previous response was incomplete. Provide the COMPLETE implementation including:
1. All necessary imports and dependencies
2. Full database schema with relationships
3. Complete error handling
4. Working examples with test data
5. Step-by-step setup instructions

Do not give partial implementations or pseudocode.
```

### Force Working Examples
```
Include working examples that I can copy-paste and run immediately:
- Real API calls with sample responses
- Test data that demonstrates all features
- Command-line instructions that work
- Environment setup that doesn't require guessing
```

---

**Remember**: These prompts are tested. Copy exactly, fill in your specifics, and you'll get working code, not theoretical examples.
