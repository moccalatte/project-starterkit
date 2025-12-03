# Hobby Web App Template

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

A lightweight template for building simple web applications for hobby projects and MVPs. Perfect for solo developers who want to ship fast.

---

## Quick Start

```bash
# 1. Read the context
cat docs/01-context.md

# 2. Set up development
cat docs/02-dev_protocol.md

# 3. Understand features
cat docs/03-product_requirements.md

# 4. Start coding!
```

---

## Stack Recommendations

### Frontend
- **Framework:** React + Vite (or Next.js)
- **Styling:** Tailwind CSS
- **Hosting:** Vercel/Netlify (free tier)

### Backend
- **Node.js:** Express + TypeScript
- **Python:** FastAPI + uvicorn
- **Database:** SQLite → Supabase/Neon (free tier)

---

## What You Get

- **Minimal setup** - Start coding in minutes
- **Free hosting** - Vercel + Render free tiers
- **Simple auth** - Supabase Auth (free)
- **Quick deployment** - Git push to deploy

---

## Example: Task Manager App

### Features
1. Add/edit/delete tasks
2. Mark tasks complete
3. Filter by status
4. User authentication

### Setup (10 minutes)
```bash
# Frontend
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev

# Backend (optional - use Supabase instead!)
mkdir backend
cd backend
npm init -y
npm install express cors dotenv
```

---

## Project Structure

```
my-app/
├── docs/
│   ├── 01-context.md
│   ├── 02-dev_protocol.md
│   └── 03-product_requirements.md
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   └── App.jsx
│   └── package.json
├── backend/ (optional)
│   ├── index.js
│   └── package.json
└── README.md
```

---

## Free Stack

### Database & Auth
- **Supabase** - PostgreSQL + Auth + Storage (free 500MB)
- **Firebase** - NoSQL + Auth (free tier)
- **PlanetScale** - MySQL (free 5GB)

### Hosting
- **Frontend:** Vercel/Netlify (free)
- **Backend:** Render/Railway (free tier)
- **Database:** Supabase/Neon (free tier)

### Other Services
- **Storage:** Cloudflare R2 (free 10GB)
- **Email:** Resend (free 3k/month)
- **Analytics:** Plausible/Umami (self-hosted free)

---

## Deployment

### Frontend (Vercel)
```bash
# 1. Push to GitHub
git init
git add .
git commit -m "Initial commit"
git push

# 2. Import to Vercel
# - Go to vercel.com
# - Import repository
# - Deploy!
```

### Backend (Render)
```bash
# 1. Create render.yaml
# 2. Push to GitHub
# 3. Connect to Render
# 4. Deploy!
```

### Supabase Only (No Backend Needed!)
```bash
# Use Supabase for:
# - Database (PostgreSQL)
# - Auth (email, Google, GitHub)
# - Storage (files/images)
# - Real-time subscriptions
# - Edge Functions (serverless)
```

---

## Common Patterns

### API Call (React)
```jsx
import { useState, useEffect } from 'react';

function Tasks() {
  const [tasks, setTasks] = useState([]);
  
  useEffect(() => {
    fetch('/api/tasks')
      .then(res => res.json())
      .then(data => setTasks(data));
  }, []);
  
  return (
    <div>
      {tasks.map(task => (
        <div key={task.id}>{task.title}</div>
      ))}
    </div>
  );
}
```

### Supabase Integration
```jsx
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  'YOUR_SUPABASE_URL',
  'YOUR_SUPABASE_KEY'
);

// Fetch data
const { data, error } = await supabase
  .from('tasks')
  .select('*');

// Insert data
const { data, error } = await supabase
  .from('tasks')
  .insert({ title: 'New task' });
```

---

## Documentation

- **[01-context.md](docs/01-context.md)** - What and why
- **[02-dev_protocol.md](docs/02-dev_protocol.md)** - Setup and workflow
- **[03-product_requirements.md](docs/03-product_requirements.md)** - Features and flows
- **[AGENTS.md](AGENTS.md)** - AI collaboration guide

---

## Upgrade Path

1. **Start:** Static frontend + Supabase
2. **Add:** Backend API if needed
3. **Scale:** Move to dedicated database
4. **Grow:** Migrate to SaaS template

---

## Tips for Success

1. **Use Supabase** - Avoid building backend for v1
2. **Deploy early** - Use Vercel free tier
3. **Start simple** - One page, basic CRUD
4. **Add features slowly** - Based on real usage
5. **Get feedback** - Share early and often

---

## Next Steps

1. Read [01-context.md](docs/01-context.md) to define your app
2. Follow [02-dev_protocol.md](docs/02-dev_protocol.md) to set up
3. Build features from [03-product_requirements.md](docs/03-product_requirements.md)
4. Deploy to Vercel
5. Share and iterate!

---

> **Remember:** Use managed services (Supabase, Vercel) to avoid backend complexity. Ship fast! 🚀
