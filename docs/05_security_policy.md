# Security Policy

## Authentication & Authorization
Skema login/token, role, dan kontrol akses.

## Input Validation
Sanitasi dan pengecekan data masuk.

## Encryption & Secrets
Kunci rahasia, password, token.

## Rate Limiting
Batas request per user/session.

## Logging
Format log, lokasi penyimpanan, dan retensi.

## Anti-Fraud & Anti-Scam
- Dilarang melakukan manipulasi data, hasil, atau proses secara tidak sah.
- Jangan pernah commit credential, password, API key, atau data sensitif ke repo.
- Semua pelanggaran akan didokumentasikan dan ditindak sesuai protokol audit.

---

## 🔎 Sample Security Policy

```python
# Example: Input validation in Python
def sanitize_input(user_input: str) -> str:
    # Remove dangerous characters
    return user_input.replace(";", "").replace("--", "")

# Usage
username = sanitize_input(request.args.get("username"))
```

---

## 🛡️ Sample Threat Modeling

| Threat            | Mitigation                       |
|-------------------|----------------------------------|
| SQL Injection     | Input validation, ORM usage      |
| Data Leakage      | Encrypt sensitive fields         |
| Privilege Escal.  | Role-based access control        |

---

## 📋 Sample Audit Log

```
[timestamp] [SECURITY] User 'alice' failed login attempt from IP 192.168.1.10
[timestamp] [SECURITY] API key usage exceeded rate limit for user 'bob'
[timestamp] [SECURITY] Detected suspicious file upload: invoice.exe
```

---


## Threat Modeling
- Identifikasi potensi ancaman pada setiap modul (misal: data leakage, privilege escalation, injection).
- Dokumentasikan skenario serangan dan mitigasi di architecture_plan.md.
- Lakukan review threat model setiap kali ada perubahan besar pada arsitektur.

## Compliance Global
- Pastikan project mematuhi regulasi privasi dan keamanan data (misal: GDPR, HIPAA, atau aturan lokal).
- Jangan simpan data personal/sensitif tanpa persetujuan dan mekanisme proteksi.
- Sertakan link atau referensi ke dokumen compliance jika project berkembang ke enterprise.

## Audit Eksternal
- Rekomendasikan penggunaan tools audit eksternal seperti SAST (Static Application Security Testing), DAST (Dynamic Application Security Testing), dan dependency checker.
- Lakukan audit berkala dengan tools seperti Bandit (Python), npm audit (Node.js), atau layanan cloud security scanner.
- Dokumentasikan hasil audit eksternal di folder /logs/ dan release_notes.

