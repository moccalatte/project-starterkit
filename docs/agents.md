# Agents

## Overview
Dokumen ini menjelaskan peran dan fungsi agents dalam project, baik AI maupun manusia (jika ada).

## Types of Agents
- **Builder Agent:** Implementasi code sesuai PRD.
- **Reviewer Agent:** QA, analisis, dan refactor.
- **Security Agent:** Audit & mitigasi risiko.
- **Doc Agent:** Dokumentasi otomatis & README.
- **Integration Agent:** Webhook & API connection.
- **Human Agents (opsional):** Supervisi, validasi hasil, dan input strategis jika diperlukan.
- **Hybrid Agents:** Kolaborasi AI dan manusia untuk tugas kombinasi.

## Responsibilities
- Menjalankan tugas sesuai protokol dan peran masing-masing.
- Mendokumentasikan setiap keputusan penting dan perubahan pada project.
- Melaporkan status pekerjaan secara berkala melalui log atau sistem komunikasi yang disepakati.

## Communication
- Gunakan saluran komunikasi yang telah ditentukan (misal: log file, chat, email) untuk pelaporan status dan diskusi masalah.
- Semua komunikasi penting harus terdokumentasi dan dapat diakses untuk audit.

### Contoh Workflow Komunikasi
- Builder Agent mengirim log hasil build ke folder `/logs/` dan notifikasi ke Reviewer Agent.
- Reviewer Agent memberikan feedback atau hasil QA melalui komentar di log atau file review.
- Jika ditemukan bug, Reviewer Agent mengirimkan pesan ke Builder Agent untuk patch.
- Security Agent melakukan audit berkala dan mengirimkan laporan ke semua agent terkait.
- Semua komunikasi penting dicatat di log dan/atau file khusus (misal: `agents-comm.log`).

#### Sample Komunikasi (Log)
```
[2025-11-12 10:15:00] [builder] Build success: core module v1.0
[2025-11-12 10:15:01] [reviewer] QA feedback: core module, 1 minor bug found
[2025-11-12 10:15:05] [builder] Patch applied: bug #101
[2025-11-12 10:15:10] [security] Audit: no fraud detected, compliance OK
```


## Escalation
- Jika terjadi masalah yang tidak dapat diselesaikan oleh agent, lakukan eskalasi ke agent dengan otoritas lebih tinggi atau ke pemilik project.
- Proses eskalasi harus jelas dan terdokumentasi, termasuk alasan dan langkah yang diambil.

### Skenario Error & Recovery
- Jika Builder Agent gagal build (error fatal), log error dikirim ke Reviewer dan Security Agent.
- Reviewer Agent mencoba patch kecil, jika gagal, lakukan rollback dan dokumentasikan di log.
- Security Agent mendeteksi potensi fraud, segera eskalasi ke pemilik project dan lakukan audit khusus.
- Jika terjadi deadlock antar agent (misal: saling menunggu aksi), Human Agent (jika ada) atau pemilik project mengambil keputusan final.
- Recovery selalu didokumentasikan: langkah, hasil, dan status akhir.

#### Sample Error Recovery (Log)
```
[2025-11-12 10:20:00] [builder] Build failed: missing dependency 'requests'
[2025-11-12 10:20:01] [reviewer] Patch: add 'requests' to requirements.txt
[2025-11-12 10:20:05] [builder] Build success after patch
[2025-11-12 10:20:10] [security] Audit: dependency update verified, no risk found
```


## Ethics & Compliance
- Semua agent wajib mematuhi protokol anti-kecurangan, anti-penipuan, dan anti-penuduhan palsu.
- Dilarang melakukan manipulasi data, hasil, atau proses secara tidak sah.
- Setiap interaksi dan keputusan penting harus terdokumentasi dengan baik.
- Jika terjadi pelanggaran, lakukan audit dan tindak lanjut sesuai ketentuan di dokumen risk & audit.
- Transparansi dan integritas adalah prioritas utama dalam setiap aktivitas agent.

## Catatan
Template ini dapat disesuaikan sesuai kebutuhan project dan jumlah/jenis agent yang terlibat.
