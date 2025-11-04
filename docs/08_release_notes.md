# Release Notes

## Version 0.1.0 – [YYYY-MM-DD]
### Added
- Fitur baru

### Fixed
- Bug yang diperbaiki

### Changed
- Perubahan struktur / dependensi

### Known Issues
- Masalah yang masih terbuka

---

## Contoh Nyata Release Note

### Version 0.2.0 – 2025-11-20
#### Added
- Modul `core/auth.py` untuk login user dengan JWT.
- Endpoint `/api/v1/ping` untuk health check.
- Logging otomatis ke `/logs/api/2025-11-20.log`.

#### Fixed
- Bug validasi email pada modul `core/user.py`.
- Error handling pada koneksi database (lihat log `/logs/db/2025-11-20.log`).

#### Changed
- Refactor struktur folder: `src/` → `src/core/`, `src/api/`, `src/utils/`.
- Update dependency: `fastapi==0.110.0`, `pytest==8.2.0`.

#### Known Issues
- Kadang terjadi timeout pada endpoint `/api/v1/ping` jika RAM < 512MB.
- Fitur reset password belum tersedia.

---

## Sample Changelog Format

```
## [0.2.0] - 2025-11-20
### Added
- JWT authentication
- Health check endpoint

### Fixed
- Email validation bug

### Changed
- Folder structure refactor

### Known Issues
- Timeout on low RAM
```

---

## Sample Bug Report

**Bug:** Validasi email gagal jika input mengandung spasi.
**Log:** `/logs/api/2025-11-20.log`
**Status:** Sudah diperbaiki di versi 0.2.0.
