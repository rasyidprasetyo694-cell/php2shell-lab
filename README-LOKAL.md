# Lab lokal PHP2Shell — tema Lanud Halim

Salinan lab PHP2Shell dengan halaman depan bertema Lanud Halim Perdanakusuma.
Halaman diberi label **simulasi lokal, bukan situs resmi**. Berita, ilustrasi,
dan interaksi yang ditampilkan merupakan materi demonstrasi.

Perubahan dilakukan pada halaman depan, gaya, JavaScript antarmuka dan aset
ilustrasi. Kode PoC, profil build, endpoint probe/shell/status, image Docker,
pengaturan PHP dan konfigurasi Apache dipertahankan dari arsip yang dianalisis.
Varian `vulnerable` tetap menggunakan konfigurasi rentan untuk pengujian lokal;
varian `patched` dan `mitigated` tetap tersedia sebagai pembanding.

## Kebutuhan

- Docker Engine atau Docker Desktop dengan **Linux containers** dan Compose v2.
- Linux/WSL2 amd64 untuk alur PoC asli; Python 3.10+ bila memakai alat Python.
- Port lokal 8088, 8089 dan 8090 tersedia.
- Unduhan image memerlukan koneksi internet pada pemakaian pertama.

Nama container dan port sengaja tetap sama agar cocok dengan alat lab asli.
Jika lab lama sedang ada, hentikan dari folder lab lama sebelum memulai salinan
ini. Dua salinan tidak dapat berjalan bersamaan dengan nama/port tersebut.

## Membuka lab pada Windows

Ekstrak ZIP, buka terminal pada folder hasil ekstraksi, lalu jalankan:

```powershell
.\lab.ps1 start
```

Jika kebijakan komputer tidak mengizinkan skrip PowerShell, gunakan perintah
Docker langsung pada bagian berikut; tidak perlu mengubah kebijakan sistem.

## Membuka lab pada Linux/WSL2

```bash
bash ./lab.sh start
```

Untuk menjalankan alur PoC asli, gunakan Python dan Compose dari folder paket
yang sama. Penyimpanan pada filesystem Linux WSL membantu konsistensi izin.

## Perintah Docker langsung

Jalankan dari akar folder hasil ekstraksi:

```text
docker compose -f lab/compose.yaml up -d --wait
docker compose -f lab/compose.yaml ps
```

Compose mengunduh image yang belum tersedia. Launcher juga menyiapkan direktori
hasil untuk kedua kontrol. Seluruh port publik Compose tetap terikat ke
`127.0.0.1`.

| Halaman lokal | Varian |
|---|---|
| http://127.0.0.1:8088/ | Rentan — PHP 8.4.26 |
| http://127.0.0.1:8089/ | Diperbaiki — PHP 8.4.27 |
| http://127.0.0.1:8090/ | Mitigasi konfigurasi — PHP 8.4.26 |

Menu, filter kabar, galeri dan pembaca artikel bekerja di browser. Tidak ada
login, formulir pengiriman data, aset eksternal, atau polling endpoint PHP.

## Status dan penghentian

```powershell
.\lab.ps1 status
.\lab.ps1 stop
```

```bash
bash ./lab.sh status
bash ./lab.sh stop
```

Padanan Docker langsung:

```text
docker compose -f lab/compose.yaml ps
docker compose -f lab/compose.yaml down
```

Penghentian tidak menghapus direktori hasil pada host. Jika antarmuka diubah
setelah container dibuat, hentikan lalu mulai ulang lab agar webroot mendapat
salinan halaman terbaru.

## Alur pengujian dan batas verifikasi

Panduan dan atribusi paket asal disimpan pada `README-UPSTREAM.md`. Endpoint
minimal `probe.php` tetap tersedia untuk jalur pengujian asli; perubahan desain
halaman depan tidak mengganti endpoint tersebut. Launcher hanya memulai,
memeriksa status, atau menghentikan container; launcher tidak menjalankan PoC.

Paket mewarisi perilaku dan keterbatasan kode asal. Pembatas target, probe
`dry-run`, dan penilaian proof tidak diubah melalui pekerjaan tampilan ini.
Gunakan lingkungan lokal tanpa data produksi. Web shell serta direktori hasil
yang writable memang bagian dari lab asal.

Saat paket ini dibuat, Docker CLI tidak ditemukan pada lingkungan penyusunan.
Preservasi berkas core diverifikasi dengan hash, sedangkan keberhasilan runtime
PHP dan eksploitasi belum diuji ulang. Pratinjau statis antarmuka terpisah dari
lab PHP dan tidak menunjukkan keberhasilan eksploitasi.

Antarmuka statis telah diperiksa pada desktop 1440 piksel dan ponsel 390 piksel:
menu, filter kabar, pembaca artikel, galeri dan FAQ lulus pemeriksaan. Tidak ada
error JavaScript atau permintaan aset eksternal pada pemeriksaan tersebut.
Hasilnya tersedia di `VERIFIKASI-UI.json`; pratinjau tampilan di `PREVIEW.png`.
Hash sebelas berkas inti yang dipertahankan tersedia di `PRESERVASI-CORE.json`.
