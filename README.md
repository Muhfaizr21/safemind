# SafeMind App 🧠🛡️

**SafeMind** adalah platform kesehatan mental yang dirancang untuk memberikan ruang aman bagi individu untuk melaporkan kasus kekerasan, perundungan (bullying), atau masalah kesehatan mental lainnya secara anonim maupun teridentifikasi. Aplikasi ini juga dilengkapi dengan chatbot cerdas berbasis AI untuk dukungan emosional awal.

## 🚀 Fitur Utama
- **Laporan Aman:** Laporkan insiden dengan detail lokasi, tanggal, dan bukti dokumen secara anonim.
- **Chatbot AI (Gemini):** Konsultasi awal dan dukungan emosional 24/7 menggunakan kecerdasan buatan.
- **Edukasi Kesehatan Mental:** Akses ke artikel dan tips psikologi yang divalidasi.
- **Pencarian Psikolog:** Temukan bantuan profesional terdekat.

---

## 🛠️ Panduan Instalasi & Integrasi

Jika Anda ingin menjalankan project ini di lokal, ikuti langkah-langkah berikut:

### 1. Prasyarat
Pastikan Anda sudah menginstal:
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Node.js](https://nodejs.org/) (untuk Backend)
- [MySQL](https://www.mysql.com/) (atau MAMP/XAMPP)

### 2. Setup Frontend (Flutter)
```bash
# Masuk ke direktori utama
cd safemind_app

# Ambil dependencies
flutter pub get

# Jalankan aplikasi
flutter run
```

### 3. Setup Backend (Node.js)
```bash
# Masuk ke folder backend
cd backend

# Instal library yang dibutuhkan
npm install

# Konfigurasi Environment
# Edit file .env dan sesuaikan dengan database Anda
```

### 4. Konfigurasi Database (MySQL)
1. Buat database baru bernama `safemind`.
2. Jika Anda menggunakan **MAMP**, pastikan port di `.env` adalah `8889`.
3. Gunakan kredensial berikut pada file `.env`:
   ```env
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=root
   DB_NAME=safemind
   DB_PORT=8889
   ```

---

## 🏗️ Struktur Project
- **`lib/`**: Folder utama kode Flutter (UI, Logika, Chatbot).
- **`backend/`**: Server Node.js (API & Koneksi Database).
- **`assets/`**: Gambar, ilustrasi, dan font yang digunakan aplikasi.

---

## 🤝 Kontribusi
Kontribusi selalu terbuka! Silakan lakukan *fork* repo ini dan buat *pull request* untuk fitur-fitur baru atau perbaikan bug.

**Assalamualaikum & Selamat Berkontribusi!** 😊
