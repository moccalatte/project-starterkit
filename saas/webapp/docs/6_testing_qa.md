# 6. Testing & QA

## 6.1 Testing Pyramid
*   **Unit Tests**: Logic level (Jest/PyTest). Coverage goal: >80%.
*   **Integration Tests**: API/DB level.
*   **E2E Tests**: Critical flows (Playwright/Cypress).

## 6.2 QA Process
1.  Dev writes code + unit tests.
2.  PR opened -> CI runs tests.
3.  Deploy to Staging -> E2E smoke tests.
4.  Manual QA verification.

## 6.3 Local Testing
*Instructions on how to run tests locally.*
`npm test` or `pytest`
