# Web Application - Agent Instructions

The `docs/` folder is your knowledge base.

- **Missing info?** Search there first.
- **Found something useful?** Document it with a descriptive filename.

---

## Quick Navigation

### Start Here
1. **[01-context.md](docs/01-context.md)** - Business goals, stakeholders, and scope
2. **[02-dev_protocol.md](docs/02-dev_protocol.md)** - Coding standards and workflow

### Building
3. **[03-product_requirements.md](docs/03-product_requirements.md)** - Features and specifications
4. **[04-system_architecture.md](docs/04-system_architecture.md)** - System design and tech stack
5. **[05-backend_api.md](docs/05-backend_api.md)** - API endpoints and contracts
6. **[06-frontend_client.md](docs/06-frontend_client.md)** - UI architecture and components

### Operations
7. **[07-security_ops.md](docs/07-security_ops.md)** - Security controls and deployment
8. **[08-testing_qa.md](docs/08-testing_qa.md)** - Testing strategy and QA

---

## Key Concepts

- **Multi-Tenancy** - Tenant isolation, data segregation - see doc 04 & 05
- **Authentication** - JWT-based auth, role management - see doc 05 & 07
- **API Design** - RESTful conventions, versioning - see doc 05
- **Database Schema** - Prisma models, migrations - see doc 04 & 05
- **State Management** - React Query, Zustand - see doc 06
- **Security** - OWASP practices, input validation - see doc 07
- **Testing** - Unit, integration, E2E - see doc 08

---

## Tech Stack Overview

**Frontend:** React/Next.js + TypeScript + Tailwind CSS  
**Backend:** Node.js/Express + TypeScript + Prisma  
**Database:** PostgreSQL + Redis  
**Deployment:** Vercel/Railway + Docker

---

## When You're Stuck

1. Check the relevant doc first
2. Look at cross-references in each doc
3. Search the entire `/docs` folder
4. Ask specific questions with context

---

## Common Tasks

### Adding a new API endpoint
1. Define in `05-backend_api.md`
2. Implement in `backend/src/routes/`
3. Add tests in `backend/tests/`
4. Update API documentation

### Creating a new component
1. Design in `06-frontend_client.md`
2. Implement in `frontend/src/components/`
3. Add stories (Storybook)
4. Write tests

### Database changes
1. Document schema in `04-system_architecture.md`
2. Create Prisma migration
3. Update seed data
4. Test rollback procedure

---

> 𝚊_𝚟𝚎𝚛𝚢_𝚍𝚎𝚜𝚌𝚛𝚒𝚙𝚝𝚒𝚟𝚎_𝚏𝚒𝚕𝚎_𝚗𝚊𝚖𝚎.𝚖𝚍