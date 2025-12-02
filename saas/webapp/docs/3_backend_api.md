# 3. Backend & API

## 3.1 API Protocol
*   **Style**: REST / GraphQL / gRPC
*   **Auth**: JWT / OAuth2 / API Key

## 3.2 API Endpoints (Contracts)
| Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- |
| POST | `/api/v1/auth/login` | User login | No |
| GET | `/api/v1/users/me` | Get current user | Yes |

## 3.3 Integrations
*   **Payment Gateway**: [e.g., Stripe] - *details*
*   **Email Service**: [e.g., SendGrid] - *details*

## 3.4 Error Handling
*Standard error response format.*
```json
{
  "error": "code",
  "message": "Human readable message"
}
```
