# 08. Testing & Quality Assurance

## 8.1 Testing Strategy
We follow the **Testing Pyramid**:
1.  **Unit Tests (70%)**: Test individual functions/components. (Jest/Vitest).
2.  **Integration Tests (20%)**: Test API endpoints with DB. (Supertest).
3.  **E2E Tests (10%)**: Test full user flows. (Playwright/Cypress).

## 8.2 Test Requirements
- All new features must have unit tests.
- Critical bug fixes must include a regression test.
- Coverage target: > 80% Statements.

## 8.3 QA Workflow
1.  **Local**: Dev runs `npm test` before commit.
2.  **CI**: GitHub Actions blocks merge if tests fail.
3.  **Staging**: Automated E2E tests run on deploy.
4.  **Manual**: QA team verifies UI/UX on Staging.

## 8.4 Bug Reporting
- **Title**: Clear summary.
- **Steps to Reproduce**: 1. Click X, 2. Type Y...
- **Expected vs Actual**: What happened vs what should happen.
- **Screenshot/Logs**: Attach evidence.
