# 19. Operations Checklist
**Version:** 1.0  
**Author:** AI Agent  
**Last Updated:** 16 Nov 2025

## Purpose
Provides a step-by-step checklist to ensure operational readiness before launch and for ongoing operations.

---

## Pre-Launch Checklist

- [ ] All features tested and signed off (see [15-testing_strategy.md](15-testing_strategy.md))
- [ ] Backups configured and tested (see [13-recovery_strategy.md](13-recovery_strategy.md))
- [ ] Monitoring and alerts enabled (see [17-observability.md](17-observability.md))
- [ ] Documentation up to date (see [20-docs_index.md](20-docs_index.md))
- [ ] Security controls verified (see [09-security_manifest.md](09-security_manifest.md))
- [ ] Audit logging enabled (see [10-audit_architecture.md](10-audit_architecture.md))
- [ ] Infrastructure provisioned and validated (see [18-infra_plan.md](18-infra_plan.md))

---

## Maintenance Checklist

See [12-maintenance_plan.md](12-maintenance_plan.md) for full details and explanations.

| Frequency | Task Category      | Description / Examples                                      | Reference Docs                |
|-----------|-------------------|-------------------------------------------------------------|-------------------------------|
| Daily     | Health Checks     | Service uptime, error logs, disk space, CPU/memory usage    | 17-observability.md           |
| Daily     | Cleaning          | Remove temp files, rotate logs, clear cache                 | 17-observability.md           |
| Daily     | Backups           | Incremental DB backup (if required by policy)               | 13-recovery_strategy.md       |
| Weekly    | Updates           | Review dependency updates, minor patching                   | 02-dev_protocol.md            |
| Weekly    | Database Review   | Check for orphaned records, run DB health scripts           | 06-data_schema.md, 13-recovery_strategy.md |
| Weekly    | Backup Verification | Test restore from backup (sample data)                    | 13-recovery_strategy.md       |
| Monthly   | Security Review   | Audit access logs, review user permissions                  | 09-security_manifest.md, 10-audit_architecture.md |
| Monthly   | System Updates    | Apply OS and major dependency updates                       | 02-dev_protocol.md            |
| Monthly   | Maintenance Review| Review recurring issues, update maintenance log             | 12-maintenance_plan.md        |
| Yearly    | Disaster Drill    | Full backup/restore and failover simulation                 | 13-recovery_strategy.md       |
| Yearly    | Compliance Audit  | Review for regulatory compliance (GDPR, etc.)               | 09-security_manifest.md       |
| Yearly    | Documentation     | Comprehensive review and update of all docs                 | 20-docs_index.md              |

---

## Post-Launch Checklist

- [ ] Incident response plan in place and team briefed (see [13-recovery_strategy.md](13-recovery_strategy.md))
- [ ] Support channels active and documented (see [12-maintenance_plan.md](12-maintenance_plan.md))
- [ ] Regular maintenance schedule established
- [ ] Access controls reviewed and enforced

---

## Ongoing Operations

- [ ] Logs and metrics reviewed regularly (see [17-observability.md](17-observability.md))
- [ ] Security patches applied promptly (see [12-maintenance_plan.md](12-maintenance_plan.md))
- [ ] Backups verified and tested periodically
- [ ] Risk register updated as needed (see [16-risk_register.md](16-risk_register.md))
- [ ] Documentation maintained and improved

---

> Note for AI builders: Use this checklist to verify operational readiness before launch and for continuous improvement after deployment. Cross-reference related docs for detailed procedures.