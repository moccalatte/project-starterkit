# 02. Development Protocol

## 2.1 Version Control
*   **System**: Git
*   **Branching Strategy**: GitFlow or Trunk-Based Development.
    - `main`: Production-ready code.
    - `develop`: Integration branch.
    - `feature/name`: New features.
    - `fix/name`: Bug fixes.

## 2.2 Commit Convention
Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat: add user login`
- `fix: resolve crash on dashboard`
- `docs: update API docs`
- `chore: update dependencies`

## 2.3 Code Standards
### Frontend (React/Next.js)
- **Linter**: ESLint with Airbnb config.
- **Formatter**: Prettier.
- **Naming**: PascalCase for components, camelCase for functions.
- **State**: Use Hooks/Context for local, [State Library] for global.

### Backend (Node/Python)
- **Linter**: [Pylint/ESLint].
- **Style**: [PEP8/StandardJS].
- **Error Handling**: Always use try/catch blocks or middleware for async errors.

## 2.4 CI/CD Workflow
1.  **Pull Request**: Opens PR to `develop`.
2.  **CI Checks**:
    - Linting check.
    - Unit tests pass.
    - Build verification.
3.  **Review**: Required approval from 1 reviewer.
4.  **Merge**: Squash and merge.

## 2.5 Definition of Done (DoD)
- [ ] Code compiles/runs without errors.
- [ ] Unit tests written and passing (>80% coverage).
- [ ] Feature works as per PRD.
- [ ] Documentation updated.
