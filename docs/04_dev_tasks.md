# Development Tasks

## Milestone 1 – Setup
- [ ] Buat repo & inisialisasi struktur folder
- [ ] Setup environment (.env, venv, dsb)

## Milestone 2 – Core Features
- [ ] Bangun fitur utama (lihat PRD)
- [ ] Tambahkan logging dasar

## Milestone 3 – QA & Integration
- [ ] Uji semua endpoint / command
- [ ] Lakukan refactor ringan

## Milestone 4 – Deployment
- [ ] Deploy ke staging
- [ ] Siapkan dokumentasi dan changelog

---

## Contoh Nyata

### Sample Milestone
- [x] Setup environment dan berhasil menjalankan `python main.py` (log: `/logs/setup/2025-11-01.log`)
- [x] Fitur login sudah bisa menerima input dan menghasilkan output JSON (log: `/logs/core/2025-11-01.log`)

### Sample Log
```
[2025-11-01 10:00:00] [INFO] Environment setup complete.
[2025-11-01 10:01:00] [INFO] Login feature: input={"username":"user1"} output={"status":"success"}
[2025-11-01 10:02:00] [ERROR] Login feature: input={"username":""} error="Username required"
```

### Sample Rollback
Jika patch login gagal (misal, error validasi), rollback dilakukan dengan:
- Mengembalikan file `core/login.py` ke commit sebelumnya.
- Mendokumentasikan langkah rollback di `/logs/core/2025-11-01.log`:
```
[2025-11-01 10:05:00] [ROLLBACK] Revert login.py to commit abc123 due to validation error.
```

## Checklist Verifikasi & Log
- [ ] Setiap milestone sudah diverifikasi dengan contoh input/output
- [ ] Semua perubahan dan hasil milestone terdokumentasi di folder `/logs/`
- [ ] Jika ada rollback, catat langkah dan alasan di log
