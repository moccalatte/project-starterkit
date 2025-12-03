# Hobby Project Templates

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

Lightweight starter templates for hobby and side projects. Everything you need, nothing you don't. Perfect for solo developers and small teams building MVPs and personal projects.

---

## When to Use Hobby vs SaaS

**Use Hobby when:**
- Building personal projects or MVPs
- Solo developer or small team (1-3 people)
- Budget-conscious (free/cheap hosting)
- Learning new technologies
- Rapid prototyping and experimentation

**Use SaaS when:**
- Building commercial products
- Multi-tenant requirements
- Team of 3+ developers
- Enterprise features needed
- Production-grade scalability required

---

## Available Templates

### 🌐 [Web Application](webapp/)
Simple full-stack web app template.

- **Stack:** React + Node.js/Python
- **Database:** SQLite/PostgreSQL (free tier)
- **Auth:** Basic JWT or OAuth
- **Hosting:** Vercel/Render (free tier)
- **Docs:** Context, dev setup, features

### 🤖 [Bot](bot/)
Quick messenger bot template.

- **Platform:** Telegram/Discord
- **Stack:** Node.js/Python
- **Database:** SQLite/Redis (optional)
- **Hosting:** Railway/Render (free tier)
- **Docs:** Bot concept, commands, deployment

### 📱 [Mobile App](mobile/)
Simple mobile app template.

- **Stack:** React Native/Flutter
- **Backend:** Firebase/Supabase (free tier)
- **Features:** Basic CRUD, offline support
- **Docs:** App idea, setup, release basics

### 🧠 [AI/ML](ai/)
Lightweight ML project template.

- **Stack:** Python + scikit-learn/PyTorch
- **Data:** CSV/JSON (small datasets)
- **Deployment:** Streamlit/Gradio
- **Hosting:** Hugging Face Spaces (free)
- **Docs:** Problem definition, simple pipeline, deployment

---

## Quick Start

```bash
# 1. Choose your project type
cd hobby/webapp  # or bot, mobile, ai

# 2. Read the docs
cat docs/01-context.md
cat docs/02-dev_protocol.md
cat docs/03-product_requirements.md

# 3. Start building!
```

---

## Documentation Structure

Each template includes minimal but complete documentation:

- **01-context.md** - What you're building and why
- **02-dev_protocol.md** - Setup and basic workflow
- **03-product_requirements.md** - Core features and acceptance criteria
- **AGENTS.md** - Quick AI collaboration guide
- **README.md** - Project-specific getting started

**That's it!** No bloat, just essentials.

---

## Philosophy

### Keep It Simple
- Start with SQLite, upgrade to PostgreSQL when needed
- Use free hosting tiers (Vercel, Render, Railway)
- Minimal dependencies
- Ship fast, iterate faster

### Free/Cheap Stack
- **Frontend:** Vercel/Netlify (free)
- **Backend:** Render/Railway (free tier)
- **Database:** Supabase/Neon/PlanetScale (free tier)
- **Storage:** Cloudflare R2 (free 10GB)
- **Auth:** Supabase Auth/Firebase Auth (free tier)
- **Monitoring:** Sentry (free tier)

### Essential Features Only
- Authentication (if needed)
- Basic CRUD operations
- Simple deployment
- Minimal testing (critical paths only)
- Basic error handling

---

## Project Structure

```
hobby/
├── webapp/          # Web application template
│   ├── docs/
│   │   ├── 01-context.md
│   │   ├── 02-dev_protocol.md
│   │   └── 03-product_requirements.md
│   ├── AGENTS.md
│   └── README.md
│
├── bot/             # Bot template
│   ├── docs/
│   ├── AGENTS.md
│   └── README.md
│
├── mobile/          # Mobile app template
│   ├── docs/
│   ├── AGENTS.md
│   └── README.md
│
├── ai/              # AI/ML template
│   ├── docs/
│   ├── AGENTS.md
│   └── README.md
│
└── README.md        # This file
```

---

## Common Patterns

### Rapid Development
1. Start with the simplest solution
2. Use managed services (Firebase, Supabase)
3. Leverage free tiers aggressively
4. Deploy early and often
5. Add complexity only when needed

### Cost Optimization
- Use serverless where possible
- Leverage free database tiers
- Static site generation (SSG) over SSR
- CDN for assets (Cloudflare)
- Monitor usage to stay in free tier

### Solo Developer Workflow
- Git for version control
- GitHub Issues for tasks
- Minimal documentation (these templates!)
- Focus on shipping features
- Iterate based on feedback

---

## Upgrading to SaaS

When your hobby project grows:

1. **Users grow (100+)** → Move to SaaS template
2. **Need multi-tenancy** → Use SaaS architecture
3. **Team expands** → Adopt SaaS dev protocols
4. **Revenue generated** → Invest in proper infrastructure

Migration path: Copy working code into SaaS template, add proper architecture incrementally.

---

## Tips for Success

### Start Small
- Build one feature at a time
- Ship MVP in 1-2 weeks
- Get feedback early
- Iterate quickly

### Use What You Know
- Stick to familiar technologies
- Don't learn 5 new things at once
- Copy-paste patterns that work
- Ask AI for help

### Stay Motivated
- Set achievable milestones
- Celebrate small wins
- Share progress publicly
- Join communities

---

## Free Resources

### Learning
- [The Odin Project](https://www.theodinproject.com/) - Free web dev curriculum
- [freeCodeCamp](https://www.freecodecamp.org/) - Free coding bootcamp
- [FastAPI Tutorial](https://fastapi.tiangolo.com/tutorial/) - Modern Python APIs
- [React Docs](https://react.dev/) - Official React guide

### Tools & Services
- [Supabase](https://supabase.com/) - Free PostgreSQL + Auth
- [Railway](https://railway.app/) - Free hosting
- [Render](https://render.com/) - Free web services
- [Vercel](https://vercel.com/) - Free frontend hosting
- [Cloudflare](https://www.cloudflare.com/) - Free CDN + R2 storage

### Communities
- [Indie Hackers](https://www.indiehackers.com/) - Solo founders
- [Dev.to](https://dev.to/) - Developer community
- [Reddit r/SideProject](https://www.reddit.com/r/SideProject/)
- [Product Hunt](https://www.producthunt.com/) - Launch platform

---

> **Remember:** Done is better than perfect. Ship it! 🚀
