# 05. Backend & API Strategy

## 5.1 API Design Principles
- **RESTful**: Use standard HTTP verbs (GET, POST, PUT, DELETE).
- **Stateless**: No server-side session state; use Tokens (JWT).
- **Versioning**: `/api/v1/...`

## 5.2 Key API Endpoints
### Auth
- `POST /api/v1/auth/login`: Returns `{ accessToken, refreshToken }`.
- `POST /api/v1/auth/register`: Creates new user.

### Users
- `GET /api/v1/users/me`: Profile details.
- `PUT /api/v1/users/me`: Update profile.

### Resources
- `GET /api/v1/items`: List items (supports pagination `?page=1&limit=10`).
- `POST /api/v1/items`: Create item.

## 5.3 Database Schema (ERD)
*Describe key entities.*
- **Users**: `id`, `email`, `password_hash`, `role`, `created_at`.
- **Items**: `id`, `owner_id`, `name`, `status`.

## 5.4 Third-Party Integrations
- **Payment**: Stripe Webhooks handling at `/api/v1/webhooks/stripe`.
- **Email**: SendGrid API for transactional emails.
