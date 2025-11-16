# Project Starterkit

**Version:** 1.0  
**Author:** AI Agent  
**Last Updated:** 16 Nov 2025

---

## Purpose

This repository provides a robust foundation for building and operating a multi-tenant SaaS or Telegram bot project, with clear, AI-friendly documentation and workflows.  
Follow this guide to leverage AI assistance for each phase of your software development lifecycle.

---

## How to Build This Project (AI-Assisted Step-by-Step)

### 1. Foundation

Start by establishing the business and technical context, and set up your development protocols.

- **[01-context.md](docs/01-context.md):** Define the business context, stakeholders, and project scope.
- **[02-dev_protocol.md](docs/02-dev_protocol.md):** Set coding standards, workflows, and tooling.

### 2. Product Design

Design the product requirements, user flows, architecture, and integration points.

- **[03-prd.md](docs/03-prd.md):** Capture all product requirements and goals.
- **[04-uiux_flow.md](docs/04-uiux_flow.md):** Map out user journeys and main flows.
- **[05-architecture.md](docs/05-architecture.md):** Document the high-level system architecture.
- **[06-data_schema.md](docs/06-data_schema.md):** Define the database and audit log schemas.
- **[07-api_contracts.md](docs/07-api_contracts.md):** Specify all API endpoints and contracts.
- **[08-integration_plan.md](docs/08-integration_plan.md):** Plan integrations with external/internal services.

### 3. Risk, Security, and Reliability

Identify risks, define security policies, and plan for maintenance and recovery.

- **[09-security_manifest.md](docs/09-security_manifest.md):** List security controls and practices.
- **[10-audit_architecture.md](docs/10-audit_architecture.md):** Describe audit logging and traceability.
- **[11-anti_fraud_policy.md](docs/11-anti_fraud_policy.md):** Outline anti-fraud measures.
- **[12-maintenance_plan.md](docs/12-maintenance_plan.md):** Plan for ongoing maintenance and support.
- **[13-recovery_strategy.md](docs/13-recovery_strategy.md):** Define backup and disaster recovery strategies.

### 4. Build & Testing

Plan the build, implement tests, and manage risks.

- **[14-build_plan.md](docs/14-build_plan.md):** Set milestones and build processes.
- **[15-testing_strategy.md](docs/15-testing_strategy.md):** Define testing approaches and coverage.
- **[16-risk_register.md](docs/16-risk_register.md):** Track and mitigate project risks.
- **[17-observability.md](docs/17-observability.md):** Plan for monitoring, logging, and alerting.

### 5. Deployment & Operations

Prepare infrastructure, operational checklists, and documentation index.

- **[18-infra_plan.md](docs/18-infra_plan.md):** Specify infrastructure and environments.
- **[19-ops_checklist.md](docs/19-ops_checklist.md):** Use this checklist for go-live and ongoing ops.
- **[20-docs_index.md](docs/20-docs_index.md):** Central index for all documentation.

---

## AI Builder Guidance

- **Always start with the lowest-numbered doc and proceed in order.**
- Each doc contains notes for AI builders on when and how to use it.
- Cross-reference docs as needed (e.g., use `data_schema.md` when designing APIs).
- Update documentation as the project evolves.
- For any new feature or change, ensure related docs are updated and referenced in `20-docs_index.md`.

---

## Directory Structure & File Descriptions

```
project-starterkit/
│
├── docs/                        # Main documentation knowledge base for the project
│   ├── 01-context.md            # Business and technical context, stakeholders, project scope
│   ├── 02-dev_protocol.md       # Coding standards, workflows, and tooling
│   ├── 03-prd.md                # Product Requirements Document (PRD)
│   ├── 04-uiux_flow.md          # User journeys, main flows, and UI/UX design
│   ├── 05-architecture.md       # High-level system architecture
│   ├── 06-data_schema.md        # Database and audit log schemas
│   ├── 07-api_contracts.md      # API endpoints and contracts
│   ├── 08-integration_plan.md   # Integration plans for external/internal services
│   ├── 09-security_manifest.md  # Security controls and practices
│   ├── 10-audit_architecture.md # Audit logging and traceability
│   ├── 11-anti_fraud_policy.md  # Anti-fraud measures and policies
│   ├── 12-maintenance_plan.md   # Ongoing maintenance and support plans
│   ├── 13-recovery_strategy.md  # Backup and disaster recovery strategies
│   ├── 14-build_plan.md         # Build milestones and processes
│   ├── 15-testing_strategy.md   # Testing approaches and coverage
│   ├── 16-risk_register.md      # Project risk tracking and mitigation
│   ├── 17-observability.md      # Monitoring, logging, and alerting plans
│   ├── 18-infra_plan.md         # Infrastructure and environment specifications
│   ├── 19-ops_checklist.md      # Go-live and operational checklists
│   ├── 20-docs_index.md         # Central index for all documentation
│   ├── ai_collaboration.md      # Guide for working productively with AI
│   ├── error_fix_guide.md       # Workflow for reporting and fixing errors
│   ├── free_alternatives.md     # Free/affordable services for hosting, DB, etc.
│   └── prompt.md                # Philosophy and best practices for AI prompt design
│
├── AGENTS.md                    # Guidance for using the docs folder as a knowledge base; instructions for agents on searching and updating documentation
├── LICENSE                      # Project license (MIT License)
└── README.md                    # This file
```

---

## Getting Started

1. Review and fill in each document in the `/docs` folder, starting from `01-context.md`.
2. Use the AI builder to generate, validate, and cross-link content as you progress.
3. Follow the step-by-step order for a smooth, reliable project build.
4. Keep all documentation up to date and reference the `20-docs_index.md` for navigation.

---

## Special Guides & Utilities

- **[ai_collaboration.md](docs/ai_collaboration.md):**  
  Practical guide for working with AI productively, including prompt engineering, context management, and avoiding common pitfalls.  
  *Use this to maximize the value and reliability of AI-assisted development.*

- **[error_fix_guide.md](docs/error_fix_guide.md):**  
  Step-by-step workflow for reporting, fixing, and documenting errors safely and efficiently.  
  *Reference this whenever you encounter bugs or production issues.*

- **[free_alternatives.md](docs/free_alternatives.md):**  
  Curated list of free and affordable services for hosting, databases, payments, monitoring, and more.  
  *Consult this to minimize costs and choose the right stack for solo or small-team projects.*

- **[prompt.md](docs/prompt.md):**  
  The philosophy and best practices for AI prompt design, including how to get the most thoughtful, high-quality solutions from AI collaborators.  
  *Read this to understand the mindset and approach expected when working with AI in this project.*

---

> For any questions or improvements, update the relevant doc and notify the team.