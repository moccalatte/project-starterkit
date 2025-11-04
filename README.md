# 🧠 Project Starter Kit

Panduan & template universal untuk membangun proyek AI (bot, web, automation) dengan efisiensi token dan workflow stabil.

---


## 📚 Struktur & Dokumen Utama

- [docs/00_context.md](docs/00_context.md) — Deskripsi singkat proyek
- [docs/01_dev_protocol.md](docs/01_dev_protocol.md) — Aturan kolaborasi AI–manusia & best practice coding
- [docs/02_prd.md](docs/02_prd.md) — Product Requirement Document
- [docs/03_architecture_plan.md](docs/03_architecture_plan.md) — Desain arsitektur & struktur modular
- [docs/04_dev_tasks.md](docs/04_dev_tasks.md) — Daftar tugas development & milestone
- [docs/05_security_policy.md](docs/05_security_policy.md) — Kebijakan keamanan
- [docs/06_risk_audit.md](docs/06_risk_audit.md) — Audit risiko antifraud & mitigasi
- [docs/07_quality_review.md](docs/07_quality_review.md) — Evaluasi kualitas, testing, dan rekomendasi refactor
- [docs/08_release_notes.md](docs/08_release_notes.md) — Catatan rilis versi, perubahan, dan bugfix
- [docs/09_maintenance_plan.md](docs/09_maintenance_plan.md) — Panduan perawatan, backup, dan update
- [docs/agents.md](docs/agents.md) — Definisi peran AI agents

### 📦 Tabel Fungsi File

| File                       | Fungsi                                               |
|----------------------------|------------------------------------------------------|
| docs/00_context.md         | Deskripsi singkat proyek (overview, tujuan, platform)|
| docs/01_dev_protocol.md    | Aturan kolaborasi AI–manusia & best practice coding  |
| docs/02_prd.md             | Product Requirement Document – kebutuhan & user stories|
| docs/03_architecture_plan.md| Desain arsitektur & struktur modular                |
| docs/04_dev_tasks.md       | Daftar tugas development & milestone                 |
| docs/05_security_policy.md | Kebijakan keamanan (auth, validation, logging)       |
| docs/06_risk_audit.md      | Audit risiko antifraud & mitigasi                    |
| docs/07_quality_review.md  | Evaluasi kualitas, testing, dan rekomendasi refactor |
| docs/08_release_notes.md   | Catatan rilis versi, perubahan, dan bugfix           |
| docs/09_maintenance_plan.md| Panduan perawatan, backup, dan update                |
| docs/agents.md             | Definisi peran AI agents (Builder, Reviewer, dst)    |
| docs/core_summary.md       | Ringkasan inti proyek (opsional, untuk referensi cepat)|

---

## 🗺️ Visual Diagram

![Architecture Diagram](assets/architecture-diagram-placeholder.png)
*Gambar ini adalah placeholder. Tambahkan diagram arsitektur sistem di sini menggunakan tools seperti draw.io, Excalidraw, atau diagram markdown.*

---

## 🚀 Cara Pakai Starter Kit

**Langkah 1: Clone repo**
```bash
git clone https://github.com/moccalatte/project-starterkit
cd project-starterkit
```

**Langkah 2: Duplikat untuk proyek baru**
```bash
cp -r project-starterkit my_new_project
cd my_new_project
```

**Langkah 3: Isi deskripsi proyek**
Edit file:
- `docs/00_context.md` → isi ringkasan proyek
- `docs/02_prd.md` → tambahkan user stories & fitur utama

**Langkah 4: Panggil AI coder (Codex, Jules, Zed, dsb)**
Jalankan alur prompt di bawah untuk mulai build.

---

## 🔁 Alur Prompting Lengkap

Ikuti urutan berikut agar workflow efisien & hemat token.  
Cukup copy-paste prompt sesuai tahap ke AI coder-mu.

**Step 1 – Setup Context**
```
Generate `00_context.md` untuk proyek bernama <PROJECT_NAME>.
Tuliskan overview singkat, target user, platform, dan tujuan utama.
Gunakan bahasa ringkas agar hemat token.
```

**Step 2 – Requirements**
```
Refer to `01_dev_protocol.md` as guideline.
Create `02_prd.md` containing:
- User stories
- Core features
- Acceptance criteria
```

**Step 3 – Architecture & Tasks**
```
From `02_prd.md`, generate:
- `03_architecture_plan.md` → describe modules, data flow, and dependencies.
- `04_dev_tasks.md` → list technical milestones and to-do items.
```

**Step 4 – Security & Risk**
```
Audit the planned system and create:
- `05_security_policy.md` for authentication, input validation, and logging.
- `06_risk_audit.md` for antifraud and misuse scenarios with mitigation steps.
```

**Step 5 – Quality & Release**
```
After build is complete:
- Generate `07_quality_review.md` for QA and performance notes.
- Create `08_release_notes.md` summarizing version changes and known issues.
- Prepare `09_maintenance_plan.md` for long-term stability and monitoring.
```

**Step 6 – Agents Definition**
```
Write `agents.md` describing each AI agent role:
Builder, Reviewer, Security, Doc, and Integration.
```

---

## 💡 Tips Efisiensi

- Gunakan prompt singkat seperti:
  ```
  Refer to files 00–04. Build the codebase accordingly.
  ```
  untuk memanggil AI builder tanpa menempel ulang semua isi file.

- Pisahkan proyek besar menjadi modul (auth, core, integration) dengan sub-PRD kecil.

- Gunakan `docs/01_dev_protocol.md` sebagai aturan tetap di semua repositori.

- Setelah build stabil, buat ringkasan `docs/core_summary.md` (opsional, 1–2 k token) agar cepat direferensi ulang seluruh tim/AI.

---

## 🧠 Bonus Prompt – Universal Project Starterkit

Salin prompt ini sebagai *starter command* saat membuat proyek baru:

```
You are a senior AI developer and architect.
Create the base documentation set for a new project named <PROJECT_NAME>.

Follow the Project Starter Kit structure.
Use concise, professional Markdown output.

Generate:
- 00_context.md (overview, platform, target user)
- 02_prd.md (features, user stories, acceptance criteria)
- 03_architecture_plan.md (modules, data flow, dependencies)
- 04_dev_tasks.md (milestones)
- agents.md (AI roles)

Do not repeat or modify 01_dev_protocol.md.
End with:
✅ Done – base structure generated successfully.
```

---

## ❓ FAQ

**Q: Apakah starter kit ini cocok untuk developer non-coding/manual?**  
A: Sangat cocok! Semua protokol dan template dirancang agar AI bisa membangun codebase secara otomatis dan konsisten.

**Q: Bagaimana cara memastikan AI mengikuti aturan antifraud dan audit?**  
A: Pastikan AI selalu merujuk ke `docs/01_dev_protocol.md`, `docs/05_security_policy.md`, dan `docs/06_risk_audit.md` sebelum melakukan perubahan besar.

**Q: Apa yang harus dilakukan jika terjadi error atau konflik aturan?**  
A: Ikuti protokol debug di `docs/01_dev_protocol.md` dan dokumentasikan semua langkah di folder `/logs/`.

**Q: Apakah saya bisa menambah modul atau agent baru?**  
A: Bisa! Cukup tambahkan deskripsi dan aturan baru di file terkait (misal: docs/agents.md atau docs/architecture_plan.md).

**Q: Bagaimana cara rollback jika patch AI gagal?**  
A: Ikuti langkah rollback di `docs/04_dev_tasks.md` dan pastikan semua perubahan terdokumentasi di log.

---

## 📜 Lisensi

Starter kit ini menggunakan lisensi MIT.  
Silakan gunakan, modifikasi, dan distribusikan untuk kebutuhan pribadi atau tim.  
Untuk detail, lihat file LICENSE di root repo.

---

## 📝 Changelog

Perubahan besar pada struktur, protokol, atau template akan dicatat di [docs/08_release_notes.md](docs/08_release_notes.md).

---

## 🪶 Catatan Akhir

Toolkit ini cocok untuk:
- Developer solo yang mengandalkan AI penuh (Codex, Jules, Zed, Copilot)
- Tim kecil yang ingin menjaga konsistensi & efisiensi token
- Proyek internal yang butuh dokumentasi ringan namun terstruktur

---

✅ Ready to start your next AI-built project.
