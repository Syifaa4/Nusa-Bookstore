# 📚 NusaBookstore

**NusaBookstore** adalah aplikasi toko buku berbasis mobile yang dikembangkan menggunakan Flutter. Aplikasi ini menyediakan katalog buku, informasi dan sinopsis buku, serta fitur keranjang belanja dengan tampilan yang sederhana dan mudah digunakan.
Project ini dibuat untuk menerapkan pengembangan aplikasi Flutter dan pengelolaan state menggunakan Provider.

## Demo Video
https://youtu.be/WJ9i1ZQD1EI

## ✨ Fitur Utama
- **Katalog Buku** — Menampilkan koleksi buku beserta sampul, judul, penulis, dan harga.
- **Detail Buku** — Menampilkan informasi dan sinopsis buku.
- **Favorit Buku** — Menandai buku favorit.
- **Keranjang Belanja** — Menambahkan, mengurangi, dan menghapus buku dari keranjang.
- **Pengaturan Jumlah** — Mengatur kuantitas buku sebelum ditambahkan ke keranjang.
- **Perhitungan Total** — Menghitung total harga belanja secara otomatis dalam format Rupiah.
- **Badge Keranjang** — Menampilkan jumlah item pada ikon keranjang.
- **Light/Dark Mode** — Mengganti tema aplikasi sesuai preferensi pengguna.
- **Notifikasi SnackBar** — Memberikan informasi ketika buku berhasil ditambahkan ke keranjang.
- **Checkout** — Memberikan umpan balik melalui SnackBar ketika proses checkout dilakukan.

## 🛠️ Teknologi yang Digunakan
- **Flutter** — Framework pengembangan antarmuka aplikasi.
- **Dart** — Bahasa pemrograman.
- **Provider** — State management untuk mengelola data keranjang dan tema.
- **Material Design** — Komponen antarmuka aplikasi.
- **Assets** — Gambar sampul buku dan logo aplikasi.

## 📸 Screenshot Aplikasi

<img width="512" height="253" alt="image" src="https://github.com/user-attachments/assets/83c58169-53aa-47cb-aa10-0e53cd5892dd" />

### 1. Katalog Buku
Menampilkan daftar buku dalam bentuk grid, lengkap dengan sampul, judul, penulis, harga, dan tombol tambah ke keranjang.

<img width="471" height="348" alt="image" src="https://github.com/user-attachments/assets/1358bdd4-16a4-4814-bb8b-1a81abe6aa97" />

### 2. Badge Keranjang
Menampilkan jumlah item yang terdapat di keranjang belanja.

<img width="476" height="44" alt="image" src="https://github.com/user-attachments/assets/94dfa339-ce0c-4cab-b05a-95255db18f87" />

### 3. Keranjang Belanja
Menampilkan buku yang dipilih, jumlah item, harga, serta total belanja.

<img width="479" height="408" alt="image" src="https://github.com/user-attachments/assets/f611b18f-62db-410e-8add-82bf8e0e94a4" />

### 4. Light/Dark Mode
Menampilkan tampilan aplikasi dalam tema terang dan gelap.

Light Mode

<img width="479" height="311" alt="image" src="https://github.com/user-attachments/assets/e2bd85e9-7349-49f6-95ee-ec9f8975e1a8" />

Dark Mode 

<img width="477" height="300" alt="image" src="https://github.com/user-attachments/assets/8b3dcc48-a666-473c-ac88-0afdc14edc90" />

### 5. Notifikasi Checkout
Menampilkan SnackBar sebagai umpan balik setelah pengguna melakukan checkout.

<img width="477" height="413" alt="image" src="https://github.com/user-attachments/assets/ceb82dea-4b7d-4d7c-aad5-84c222f83725" />

## 📁 Struktur Project

```text
nusa_bookstore/
├── assets/
│   └── images/
│       ├── books/
│       ├── logo_light.png
│       └── logo_dark.png
├── lib/
│   ├── models/
│   │   └── book.dart
│   ├── providers/
│   │   ├── cart_provider.dart
│   │   └── theme_provider.dart
│   ├── screens/
│   │   ├── catalog_screen.dart
│   │   └── cart_screen.dart
│   └── main.dart
├── screenshots/
│   ├── katalog.png
│   ├── badge-keranjang.png
│   ├── keranjang.png
│   ├── light-mode.png
│   ├── dark-mode.png
│   └── checkout-snackbar.png
├── pubspec.yaml
└── README.md
```

## 🧩 State Management dengan Provider
NusaBookstore menggunakan Provider untuk memisahkan pengelolaan state dari tampilan aplikasi.
- **CartProvider** digunakan untuk mengelola item keranjang, kuantitas, dan perhitungan total belanja.
- **ThemeProvider** digunakan untuk mengelola perubahan tema Light Mode dan Dark Mode.
- **Consumer** dan **context.watch/read** digunakan untuk mengakses serta memperbarui state sesuai kebutuhan antarmuka.
