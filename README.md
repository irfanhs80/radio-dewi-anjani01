# RADIO DEWI ANJANI FM 104.6 MHz

Starter project Flutter untuk aplikasi Android Radio Dewi Anjani.

## Fitur
- Streaming live: https://i.klikhost.com/8140/1
- Jadwal siaran harian dan mingguan
- Profil radio
- Kontak WhatsApp, email, dan website

## Build APK tanpa laptop kuat (GitHub Actions)
1. Buat akun GitHub di https://github.com jika belum punya.
2. Buat repository baru, misalnya `radio-dewi-anjani`.
3. Upload seluruh isi folder proyek ini ke repository tersebut.
4. Buka tab **Actions** dan aktifkan workflow jika diminta.
5. Pilih **Build Android APK** lalu tekan **Run workflow**.
6. Setelah selesai, buka hasil workflow dan unduh artifact **radio-dewi-anjani-apk**.
7. Ekstrak file ZIP artifact; di dalamnya ada `app-release.apk`.

## Catatan penting
- Proyek ini adalah source awal yang disiapkan agar proses kompilasi dilakukan di cloud.
- APK belum dikompilasi dan belum diuji pada perangkat Android.
- Logo Radio Dewi Anjani dari pengguna disertakan sebagai `assets/logo_radio.jpg`, ditampilkan pada halaman utama, dan digunakan sebagai ikon aplikasi Android.
- Tombol pemutar tidak menunggu stream selesai sehingga indikator loading berhenti setelah perintah mulai pemutaran dijalankan. Pemutaran streaming pada versi awal ini aktif saat aplikasi terbuka; dukungan pemutaran di latar belakang perlu ditambahkan dan diuji pada tahap berikutnya.
- Pastikan hak penggunaan logo, nama, dan materi siaran telah dimiliki sebelum publikasi.


Catatan perbaikan build: widget Column pada halaman utama tidak lagi memakai const karena berisi Image.asset yang bukan const.
