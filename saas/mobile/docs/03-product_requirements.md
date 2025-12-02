# 03. Product Requirements (PRD)

## 3.1 Functional Requirements
- **FR-1**: Technician logs in with Employee ID.
- **FR-2**: Dashboard shows "Today's Jobs".
- **FR-3**: Job detail view shows address and instructions.
- **FR-4**: "Complete Job" form requires photo proof.

## 3.2 Offline Capabilities
- **Sync Logic**:
  - Download schedule at start of day (when online).
  - Save completed job forms locally.
  - Auto-sync when network returns.

## 3.3 UI/UX Requirements
- **Navigation**: Bottom Tab Bar (Home, Schedule, Profile).
- **Feedback**: Loading spinners during sync; Toast messages for success/error.
- **Dark Mode**: Support system theme.

## 3.4 Performance
- **Startup Time**: < 2s.
- **Frame Rate**: Consistent 60fps.
