# SaaS Project Templates

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

This directory contains production-ready starter templates for different types of software projects. Each template includes complete documentation and AI-friendly workflows.

---

## Available Templates

### 🌐 [Web Application](webapp/)
Full-stack SaaS web application template.

- **Stack:** React/Next.js + Node/Python/Go backend
- **Features:** Multi-tenant architecture, API design, database schema
- **Key Docs:** Architecture, API contracts, security manifest

### 🤖 [Bot](bot/)
Conversational bot template for messaging platforms.

- **Platforms:** Telegram, Discord, Slack
- **Features:** Commands, NLP flows, state management
- **Key Docs:** Command registry, conversational flows, session handling

### 📱 [Mobile App](mobile/)
Native mobile application template.

- **Platforms:** iOS, Android (React Native/Flutter/Native)
- **Features:** Offline-first, sync, push notifications
- **Key Docs:** App architecture, store release, offline sync strategy

### 🧠 [AI/ML](ai/)
Machine learning and AI project template.

- **Focus:** Data pipelines, model training, deployment
- **Features:** Experiment tracking, model versioning, evaluation
- **Key Docs:** Data pipeline, model architecture, metrics & monitoring

---

## Getting Started

1. **Choose your project type** - Navigate to the appropriate folder
2. **Read the local README** - Each template has its own getting started guide
3. **Follow the docs in order** - Start with `01-context.md` and progress sequentially
4. **Leverage AI assistance** - Check `AGENTS.md` for AI collaboration guidelines

---

## Documentation Philosophy

Each template follows a standardized, AI-friendly documentation structure:

- **Concise & actionable** - No bloat, just what you need
- **Sequential workflow** - Build step-by-step with clear dependencies
- **Cross-referenced** - Easy navigation between related docs
- **Living documentation** - Update as the project evolves

---

## Structure

```
saas/
├── webapp/          # Web application template
│   ├── docs/        # Complete documentation set
│   ├── AGENTS.md    # AI collaboration guide
│   └── README.md    # Getting started
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

> **Pro tip:** Each template is standalone but follows the same documentation pattern. Start with the template that matches your project type, then customize as needed.
