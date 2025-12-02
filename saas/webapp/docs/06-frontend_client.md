# 06. Frontend & Client Strategy

## 6.1 Architecture
- **Component-Based**: Reusable UI components (Buttons, Inputs, Cards).
- **Layouts**: Master layout for Nav/Sidebar, Empty layout for Auth.

## 6.2 State Management
- **Local State**: `useState` for inputs.
- **Global State**: `Redux` or `Zustand` for User Profile, Theme, Notifications.
- **Server State**: `React Query` or `SWR` for caching API responses.

## 6.3 Routing & Navigation
- **Public Routes**: Login, Register, Landing.
- **Private Routes**: Dashboard, Settings (Requires `AuthGuard`).

## 6.4 Asset & Optimization
- **Images**: Use Next.js `<Image>` for optimization.
- **Bundling**: Code splitting by route.
- **SEO**: Dynamic metadata for public pages.
