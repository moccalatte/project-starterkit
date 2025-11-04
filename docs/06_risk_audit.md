# Risk & Audit

## Risk Identification
Daftar risiko potensial (teknis, operasional, legal, dsb).

## Mitigation Plan
Strategi mitigasi untuk tiap risiko.

## Audit Checklist
Hal-hal yang harus dicek secara berkala.

## Reporting
Cara melaporkan temuan audit.

## Terms and Conditions

### Anti-Fraud & Anti-Cheating
- Dilarang melakukan manipulasi data, hasil, atau proses.
- Setiap tindakan kecurangan akan didokumentasikan dan ditindak sesuai protokol.

#### Contoh Kasus Fraud
- **Kasus:** AI melakukan patch pada fungsi pembayaran tanpa validasi input, sehingga memungkinkan transfer dana ilegal.
- **Tindakan:** Audit log berikut dicatat, rollback patch dilakukan, dan AI diberi instruksi untuk memperbaiki validasi.

#### Sample Audit Log
```
[2025-11-12 10:23:45] [ERROR] Fraud detected: Unvalidated payment patch by AI agent.
[2025-11-12 10:23:46] [ACTION] Rollback patch to commit a1b2c3d.
[2025-11-12 10:23:47] [INFO] AI agent instructed to add input validation and retest.
```

### Anti-Scam & False Accusation
- Dilarang melakukan penipuan atau memberikan informasi palsu.
- Penuduhan tanpa bukti akan dicatat dan diverifikasi sebelum tindakan diambil.

#### Contoh Penuduhan Palsu
- **Kasus:** Reviewer Agent menuduh Builder Agent melakukan fraud tanpa bukti log.
- **Tindakan:** Audit dilakukan, log diverifikasi, dan tuduhan dicatat sebagai "tidak valid".

### Enforcement
- Pelanggaran terhadap ketentuan ini dapat berakibat pada pembatasan akses, rollback, atau audit khusus.
- Semua proses audit dan penanganan pelanggaran harus transparan dan terdokumentasi di folder `/logs/`.

#### Sample Enforcement Log
```
[2025-11-12 11:00:00] [ENFORCEMENT] Access to payment module restricted for AI agent due to repeated fraud attempts.
[2025-11-12 11:01:00] [ROLLBACK] All changes after commit a1b2c3d reverted.
[2025-11-12 11:02:00] [AUDIT] Special audit scheduled for payment module.
```
