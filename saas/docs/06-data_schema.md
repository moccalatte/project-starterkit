# 06. Data Schema
**Version:** 1.0  
**Author:** AI Agent  
**Last Updated:** 16 Nov 2025

## Purpose
Defines the structure of the application's data, including main and audit databases, to ensure consistency and compliance across all environments.

---

## Main Entities

| Entity        | Description           | Key Fields           |
|---------------|----------------------|----------------------|
| User          | End user of the system | id, email, password_hash, tenant_id, created_at, updated_at |
| Tenant        | Organization or customer account | id, name, plan, created_at, updated_at |
| Transaction   | Payment or action record | id, user_id, amount, status, created_at |
| AuditLog      | System event log      | id, entity_type, entity_id, action, actor_id, timestamp, details |
| ...           | ...                  | ...                  |

---

## Relationships

- **User ↔ Tenant:** Many users belong to one tenant.
- **Transaction ↔ User:** Each transaction is linked to a user.
- **AuditLog ↔ All Entities:** Audit logs reference any entity via `entity_type` and `entity_id`.

> Note for AI builders: Use this section to design database migrations, ORM models, and ensure referential integrity.

---

## Entity-Relationship Diagram

- [Placeholder for ER diagram image or link]

---

## Audit DB Schema

- **AuditLog Table:**  
  - Fields: id, entity_type, entity_id, action, actor_id, timestamp, details (JSON/text)
  - Indexed by timestamp and entity_id for efficient querying.
- **Retention Policy:**  
  - Audit logs retained for [X] months/years, then archived or deleted per compliance.

---

## Data Retention & Privacy

- **Personal Data:**  
  - Identify and flag PII fields (e.g., email, name).
  - Mask or encrypt sensitive data at rest.
- **Compliance:**  
  - GDPR/CCPA support: Right to erasure, data export.
  - Data minimization and access controls.

---

## Cross-References

- See [05-architecture.md](05-architecture.md) for system context.
- Reference [07-api_contracts.md](07-api_contracts.md) when designing API payloads.
- Use [10-audit_architecture.md](10-audit_architecture.md) for audit log implementation.

---

> Note for AI builders: Use this document as the single source of truth for all data modeling and schema-related tasks.