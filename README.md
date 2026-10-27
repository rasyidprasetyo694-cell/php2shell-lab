# PHP2Shell — Halim Local Lab

Laboratorium PHP2Shell lokal dengan portal simulasi bertema **Lanud Halim
Perdanakusuma**, tiga varian Docker, dan panduan penggunaan berbahasa Indonesia.

**Simulasi lokal · Bukan situs resmi · Konten dan ilustrasi contoh**

![Pratinjau portal simulasi Halim](PREVIEW.png)

## Mulai di sini

- [Panduan unggah ke GitHub](docs/UPLOAD-GITHUB.md) — browser dan Git.
- [Panduan menjalankan lab](docs/PANDUAN-LAB.md) — Windows dan Linux/WSL2.
- [Dokumentasi paket asal](README-UPSTREAM.md) — panduan serta atribusi sumber.
- [Catatan perubahan](CHANGELOG.md) dan [asal materi](NOTICE.md).

## Yang tersedia

- Portal responsif dengan navigasi seluler, filter kabar, pembaca artikel,
  galeri dan FAQ.
- Tiga ilustrasi SVG penerbangan yang disimpan lokal.
- Lab rentan serta kontrol perbaikan dan mitigasi.
- Launcher `lab.ps1` dan `lab.sh` dengan pilihan `start`, `status`, dan `stop`.
- Kode inti dan konfigurasi kerentanan dari arsip sumber dipertahankan.

| Varian | Runtime yang dideklarasikan | Alamat lokal |
|---|---|---|
| Rentan | PHP 8.4.26 + Apache | http://127.0.0.1:8088/ |
| Diperbaiki | PHP 8.4.27 + Apache | http://127.0.0.1:8089/ |
| Mitigasi konfigurasi | PHP 8.4.26 + Apache | http://127.0.0.1:8090/ |

Seluruh port publik Compose terikat ke `127.0.0.1`. Varian mitigasi tetap
menggunakan runtime lama dengan pengaturan berbeda; varian tersebut bukan
pengganti pembaruan PHP.

## Kebutuhan

- Docker Engine atau Docker Desktop dengan Linux containers dan Compose v2.
- Port 8088, 8089 dan 8090 tersedia.
- Linux/WSL2 amd64 serta Python 3.10+ untuk alur Python dari paket asal.
- Koneksi untuk pengunduhan image pertama.

## Jalankan lab

Ekstrak paket atau clone repositori, lalu buka terminal pada folder yang
langsung berisi `README.md` dan launcher. Hentikan lab lama terlebih dahulu
jika memakai nama container/port yang sama.

Windows / PowerShell:

```powershell
.\lab.ps1 start
```

Linux / WSL2:

```bash
bash ./lab.sh start
```

Padanan Docker langsung:

```text
docker compose -f lab/compose.yaml up -d --wait
```

Sesudah container siap, buka http://127.0.0.1:8088/.

Status dan penghentian:

```powershell
.\lab.ps1 status
.\lab.ps1 stop
```

```bash
bash ./lab.sh status
bash ./lab.sh stop
```

Launcher tidak menjalankan PoC secara otomatis. Selengkapnya, termasuk
penanganan kebijakan PowerShell dan pembaruan tampilan, tersedia dalam
[panduan lab](docs/PANDUAN-LAB.md).

## Struktur inti

```text
.
├── README.md
├── README-UPSTREAM.md
├── NOTICE.md
├── docs/
│   ├── UPLOAD-GITHUB.md
│   └── PANDUAN-LAB.md
├── lab.ps1
├── lab.sh
├── lab/
│   ├── compose.yaml
│   ├── config/
│   └── www/
├── docker/offsets.py
├── profiles/
├── how-to-patch/
├── out/.gitkeep
└── poc-cve-2026-109618.py
```

## Status pemeriksaan

- Sebelas berkas inti cocok dengan sumber berdasarkan SHA-256:
  [PRESERVASI-CORE.json](PRESERVASI-CORE.json).
- Antarmuka desktop dan ponsel, filter, dialog, galeri, serta menu telah
  diperiksa: [VERIFIKASI-UI.json](VERIFIKASI-UI.json).
- Docker CLI tidak tersedia saat paket disusun; runtime PHP dan keberhasilan
  eksploitasi belum diuji ulang.
- Pemeriksaan distribusi: [PACKAGING-CHECKS.json](PACKAGING-CHECKS.json).
- Hash isi paket: [MANIFEST.sha256](MANIFEST.sha256).

GitHub dipakai untuk menyimpan source. Lab PHP/Docker dijalankan lokal;
GitHub Pages tidak menjalankan runtime lab ini. Lihat penjelasan dan sumber
resminya dalam [panduan unggah](docs/UPLOAD-GITHUB.md).

## Lingkup dan atribusi

Konfigurasi rentan, endpoint shell, dan perilaku alat asal memang dipertahankan
untuk lingkungan uji lokal. Simpan hasil pengujian di `out`; aturan ignore
mengecualikan output, token, log dan konfigurasi pribadi dari penambahan Git.
Saat unggah melalui browser, aturan ignore tidak menyaring pilihan berkas.

Tema visual tidak mewakili situs atau layanan resmi Lanud Halim. Materi asli
dan atribusi kontributor tetap disertakan dalam [README-UPSTREAM.md](README-UPSTREAM.md).
Arsip sumber tidak memuat berkas LICENSE terpisah; paket ini tidak menetapkan
lisensi ulang untuk kode pihak ketiga. Rincian ada pada [NOTICE.md](NOTICE.md).
