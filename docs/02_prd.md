# Build Plan

**Everything you need to build and ship safely in 2 weeks.**

## Core Feature (The ONE Thing)
**What users actually need**: [Single most important feature]

**User workflow**:
1. User has [specific problem]
2. They use your app to [specific action]
3. They get [specific result]
4. Success = [how you measure it works]

## Simple Architecture

### Tech Stack (Keep It Simple)

#### For Bot Projects (Most Common)
- **Bot Framework**: [Telegram Bot API/WhatsApp API/Discord.js]
- **Backend**: [Node.js/Python for bot logic]
- **Database**: [SQLite for simple bots, PostgreSQL for complex]
- **Hosting**: [Digital Ocean, Railway/Render for always-on bots]
- **Setup**: Automated with script (see docs/08_ai_collaboration.md)

#### For Web App Projects
- **Frontend**: [React/Next.js or simple HTML]
- **Backend**: [Node.js/Python REST API]
- **Database**: [PostgreSQL or SQLite]
- **Hosting**: [Vercel/Netlify/Railway]
- **Setup**: Automated with script (see docs/08_ai_collaboration.md)

### Architecture

#### Bot Structure
```
Bot Script → Platform API → Database
(Simple, always-running)
```

#### Web App Structure
```
Frontend → Backend API → Database
(Request-based, can be serverless)
```

### Automation Script Integration
Include setup automation (reference docs/08_ai_collaboration.md section 4):
- Auto-detect project type
- Install dependencies
- Create .env template
- Run security checks
- Start application

## 2-Week Timeline

### Week 1: Build Core (Make It Work)
- **Day 1-2**: Database setup + basic API endpoints
- **Day 3-4**: Core business logic (the main feature)
- **Day 5-7**: Basic frontend that users can actually use

**Goal**: Working demo you can show someone

### Week 2: Ship Safely (Make It Safe)
- **Day 8-10**: Security basics (authentication, validation, error handling)
- **Day 11-12**: Deploy to production + test with real users
- **Day 13-14**: Fix critical bugs, add basic monitoring

**Goal**: Real users can use it without breaking

## Safety Requirements (Don't Skip These)

### Security Basics (Choose Based on Project Type)

#### Bot Security (For All Bot Types)
- **Platform verification**: Verify requests actually come from platform (webhook signatures)
- **Token protection**: Bot tokens in environment variables, NEVER in code
- **User input validation**: Sanitize all messages/commands from users
- **Rate limiting**: Prevent spam (max commands per user per minute)
- **Command authorization**: Admin commands only for authorized users
- **Payment security**: If handling subscriptions, use secure payment processors
- **Database security**: Encrypt sensitive user data
- **Error handling**: Don't crash bot on invalid input

#### Web App Security (For Traditional Web Applications)
- **Authentication**: Users must log in to access their data
- **Input validation**: ALL inputs validated/sanitized (prevent SQL injection, XSS)
- **Rate limiting**: Max 100 requests/minute per IP (prevent DDoS/spam)
- **Error handling**: Never show stack traces or DB errors to users
- **API security**: API keys required, validate on every request
- **HTTPS**: All data encrypted + HSTS headers enabled
- **WAF protection**: Web Application Firewall enabled (Cloudflare free plan)
- **Fraud monitoring**: Alert on suspicious user behavior patterns

### Data Protection
- **Backups**: Daily automated backups (hosting platforms provide this)
- **User data isolation**: Users only see their own data
- **Privacy**: Don't log passwords or sensitive info
- **Data validation**: Prevent data corruption with basic checks

### Production Readiness
- **Health checks**: Simple endpoint that says "app is running"
- **Basic monitoring**: Know when app goes down (hosting platforms provide alerts)
- **Error logging**: Save errors to debug later
- **Simple rollback**: Can deploy previous version if needed

## What NOT to Build

### Skip These (Add Later If Needed)
- **Admin dashboards** (use database tools for now)
- **Complex user roles** (start with logged-in vs not-logged-in)
- **Advanced features** (focus on core workflow)
- **Perfect UI** (functional is better than pretty)
- **Microservices** (one simple app is easier)
- **Complex deployment** (use simple hosting platforms)

### Red Flags (Stop If You're Doing This)
- Planning for more than 2 weeks
- Building features users haven't asked for
- Optimizing for 1M users when you have 0
- Creating complex architecture diagrams
- Writing extensive documentation before code exists

## Success Metrics

### Week 1 Success
- [ ] Core feature works end-to-end
- [ ] You can demo it to someone
- [ ] Database stores and retrieves data correctly
- [ ] Frontend and backend communicate

### Week 2 Success
- [ ] App deployed and accessible via URL
- [ ] Users can sign up and log in
- [ ] Core feature works for real users
- [ ] App doesn't crash under normal use
- [ ] You can fix bugs when they occur

### Overall Success
- [ ] Real users complete the core workflow
- [ ] App stays online without constant babysitting
- [ ] Users return and use it again
- [ ] You can build new features on this foundation

---

**Remember**: Perfect is the enemy of shipped. Build something people can use, then make it better based on real feedback.
