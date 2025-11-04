# Product Requirements Document (PRD)

## Summary
Tujuan utama dan cakupan proyek.

## User Stories
1. Sebagai admin, saya ingin bisa login agar dapat mengelola data user.
2. Sebagai user, saya ingin mendaftar akun agar bisa mengakses fitur aplikasi.
3. Sebagai user, saya ingin melihat riwayat transaksi agar bisa memantau aktivitas saya.

### Contoh User Story Output (AI)
```json
{
  "role": "admin",
  "action": "login",
  "result": "akses dashboard admin"
}
```

## Functional Requirements
Daftar fitur utama dan behavior.

## Non-functional Requirements
Kinerja, keamanan, reliabilitas, dan batasan sistem.

## Acceptance Criteria
- Admin dapat login dengan username dan password valid.
- User dapat mendaftar akun baru dan menerima email konfirmasi.
- User dapat melihat daftar transaksi miliknya di halaman profil.

### Contoh Output Acceptance (AI)
```json
{
  "login_success": true,
  "register_success": true,
  "transactions": [
    {"id": 1, "amount": 10000, "date": "2025-11-01"},
    {"id": 2, "amount": 5000, "date": "2025-11-02"}
  ]
}
```

## Compliance
Semua fitur wajib mematuhi protokol anti-kecurangan dan keamanan sesuai dokumen risk & audit serta security policy.
