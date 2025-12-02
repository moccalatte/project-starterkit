# 05. API & Integration

## 5.1 API Client
- **Base URL**: Configurable per environment (Dev/Staging/Prod).
- **Interceptors**:
  - Add `Authorization` header.
  - Handle 401 Unauthorized (Auto-refresh token or logout).

## 5.2 Synchronization Protocol
- **Pull**: Get latest data. (Client sends `last_sync_timestamp`).
- **Push**: Send local changes. (Queue of pending requests).
- **Conflict Resolution**: "Server Wins" or "Last Write Wins".

## 5.3 Push Notifications
- **Service**: Firebase Cloud Messaging (FCM).
- **Events**: "New Job Assigned", "Schedule Changed".
