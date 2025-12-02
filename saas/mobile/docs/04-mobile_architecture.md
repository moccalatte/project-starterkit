# 04. Mobile Architecture

## 4.1 Tech Stack
- **Framework**: Flutter (Dart) or React Native (TS).
- **Local DB**: SQLite / Hive / Realm.
- **Networking**: Dio / Axios.

## 4.2 Layered Architecture
1.  **UI Layer**: Widgets/Components.
2.  **Logic Layer**: State Management (BLoC/Cubit).
3.  **Repository Layer**: Decides whether to fetch from API or Local DB.
4.  **Data Source**: API Client and Local Database definitions.

## 4.3 Directory Structure
```
/lib
  /core       # Constants, Theme
  /features   # Feature-based folder structure
    /auth
      /presentation
      /domain
      /data
```
