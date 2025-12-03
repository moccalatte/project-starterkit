# Web Application Project Template

**Version:** v3  
**Last Updated:** 03 December 2025

---

## Purpose

A complete template for building production-ready, multi-tenant SaaS web applications with AI-friendly documentation and best practices.

---

## Quick Start

1. **Understand the context** → Read [01-context.md](docs/01-context.md)
2. **Set up development** → Follow [02-dev_protocol.md](docs/02-dev_protocol.md)
3. **Define requirements** → Review [03-product_requirements.md](docs/03-product_requirements.md)
4. **Build the system** → Implement using [04-system_architecture.md](docs/04-system_architecture.md)

---

## Features

- **Multi-tenant architecture** - Isolated data per organization
- **RESTful API** - Well-documented backend endpoints
- **Modern frontend** - React/Next.js with responsive design
- **Authentication & authorization** - JWT-based with role management
- **Database design** - Scalable PostgreSQL schema
- **API documentation** - OpenAPI/Swagger specs
- **Security hardening** - OWASP best practices
- **Testing strategy** - Unit, integration, and E2E tests

---

## Documentation Index

### Foundation
- **[01. Context](docs/01-context.md)** - Business goals, stakeholders, and scope
- **[02. Dev Protocol](docs/02-dev_protocol.md)** - Coding standards and workflow

### Product & Design
- **[03. Product Requirements](docs/03-product_requirements.md)** - Features and specifications
- **[04. System Architecture](docs/04-system_architecture.md)** - Technical design and stack
- **[05. Backend API](docs/05-backend_api.md)** - API contracts and endpoints
- **[06. Frontend Client](docs/06-frontend_client.md)** - UI architecture and components

### Operations & Quality
- **[07. Security & Ops](docs/07-security_ops.md)** - Security controls and deployment
- **[08. Testing & QA](docs/08-testing_qa.md)** - Testing strategy and coverage

---

## Tech Stack

### Frontend
- **Framework:** React 18+ / Next.js 14+
- **Language:** TypeScript
- **Styling:** Tailwind CSS / CSS Modules
- **State Management:** Zustand / Redux Toolkit
- **API Client:** React Query / SWR
- **Testing:** Vitest + React Testing Library

### Backend
- **Framework:** Node.js (Express/Fastify) / Python (FastAPI/Django) / Go (Fiber/Chi)
- **Language:** TypeScript / Python / Go
- **Database:** PostgreSQL 14+
- **ORM:** Prisma / TypeORM / SQLAlchemy
- **Cache:** Redis 7+
- **Queue:** Bull / Celery (optional)

### Infrastructure
- **Hosting:** Vercel / Railway / Render / Fly.io
- **Database:** Supabase / Neon / Railway
- **CDN:** Cloudflare / Vercel Edge
- **Monitoring:** Sentry / LogRocket
- **Analytics:** PostHog / Plausible

---

## Development Workflow

```bash
# 1. Install dependencies
npm install

# 2. Configure environment
cp .env.example .env
# Add your database URL and secrets

# 3. Run database migrations
npm run db:migrate

# 4. Start development server
npm run dev

# 5. Access application
# Frontend: http://localhost:3000
# Backend: http://localhost:8000
```

---

## Project Structure

```
webapp/
├── docs/                    # Complete documentation
├── frontend/
│   ├── src/
│   │   ├── components/     # Reusable UI components
│   │   ├── pages/          # Route components
│   │   ├── hooks/          # Custom React hooks
│   │   ├── services/       # API client services
│   │   ├── stores/         # State management
│   │   └── utils/          # Helper functions
│   ├── public/             # Static assets
│   └── package.json
│
├── backend/
│   ├── src/
│   │   ├── routes/         # API endpoints
│   │   ├── controllers/    # Request handlers
│   │   ├── services/       # Business logic
│   │   ├── models/         # Database models
│   │   ├── middleware/     # Auth, logging, etc.
│   │   └── utils/          # Helper functions
│   ├── prisma/             # Database schema
│   │   └── migrations/
│   └── package.json
│
├── tests/                  # E2E and integration tests
├── AGENTS.md              # AI collaboration guide
└── README.md              # This file
```

---

## Common Patterns

### API Request (Frontend)
```typescript
import { useMutation, useQuery } from '@tanstack/react-query';

// Fetch data
const { data, isLoading } = useQuery({
  queryKey: ['users'],
  queryFn: () => api.get('/users')
});

// Mutate data
const createUser = useMutation({
  mutationFn: (userData) => api.post('/users', userData),
  onSuccess: () => {
    queryClient.invalidateQueries(['users']);
  }
});
```

### API Endpoint (Backend)
```typescript
import { Router } from 'express';
import { authenticateUser } from '../middleware/auth';

const router = Router();

router.get('/users', authenticateUser, async (req, res) => {
  try {
    const users = await userService.findAll(req.user.tenantId);
    res.json({ data: users });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
```

### Database Query (Prisma)
```typescript
// Multi-tenant query
const users = await prisma.user.findMany({
  where: {
    tenantId: currentTenantId,
    isActive: true
  },
  include: {
    profile: true,
    roles: true
  }
});
```

---

## Key Features

### Multi-Tenancy
- Tenant isolation at database level
- Subdomain or path-based routing
- Tenant-specific configuration
- Data segregation and security

### Authentication
- JWT-based authentication
- Refresh token rotation
- Social login (Google, GitHub)
- Email verification
- Password reset flow

### Authorization
- Role-based access control (RBAC)
- Permission-based checks
- Tenant-level permissions
- Resource-level permissions

### API Design
- RESTful conventions
- Consistent error responses
- Pagination and filtering
- Rate limiting
- API versioning

---

## Deployment

### Environment Setup
```bash
# Production environment variables
NODE_ENV=production
DATABASE_URL=postgresql://...
REDIS_URL=redis://...
JWT_SECRET=your-secret-here
API_URL=https://api.yourdomain.com
FRONTEND_URL=https://yourdomain.com
```

### Build & Deploy
```bash
# Build frontend
cd frontend
npm run build

# Build backend
cd backend
npm run build

# Deploy (Railway/Render)
git push origin main
```

### Docker Deployment
```dockerfile
# Multi-stage build
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package*.json ./
RUN npm ci --only=production
EXPOSE 8000
CMD ["node", "dist/index.js"]
```

---

## Testing

### Unit Tests
```bash
npm test
```

### Integration Tests
```bash
npm run test:integration
```

### E2E Tests
```bash
npm run test:e2e
```

### Coverage Report
```bash
npm run test:coverage
```

---

## Performance Optimization

### Frontend
- Code splitting and lazy loading
- Image optimization
- CDN for static assets
- Service worker for offline support
- Memoization and virtualization

### Backend
- Database query optimization
- Redis caching
- Connection pooling
- Compression middleware
- CDN for API responses (optional)

---

## Security Checklist

- [ ] HTTPS enforced
- [ ] Environment variables secured
- [ ] SQL injection prevention
- [ ] XSS protection
- [ ] CSRF tokens
- [ ] Rate limiting enabled
- [ ] Input validation
- [ ] Error messages sanitized
- [ ] Dependencies updated
- [ ] Security headers configured

---

## Next Steps

1. Review all docs in the `/docs` folder sequentially
2. Customize the tech stack for your requirements
3. Set up authentication and multi-tenancy
4. Implement core features following the architecture
5. Write comprehensive tests
6. Deploy to staging environment
7. Monitor and iterate based on feedback

---

## Resources

### Learning
- [Next.js Documentation](https://nextjs.org/docs)
- [Prisma Documentation](https://www.prisma.io/docs)
- [TypeScript Handbook](https://www.typescriptlang.org/docs)
- [React Query Guide](https://tanstack.com/query/latest/docs)

### Tools
- [Excalidraw](https://excalidraw.com/) - Architecture diagrams
- [Postman](https://www.postman.com/) - API testing
- [Storybook](https://storybook.js.org/) - Component development

---

> **For AI builders:** Check [AGENTS.md](AGENTS.md) for collaboration guidelines and the `/docs` folder for complete technical documentation.
