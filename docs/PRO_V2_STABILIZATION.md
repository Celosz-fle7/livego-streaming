# Pro V2 Stabilization Plan

## Status saat ini
- CI hijau
- API/auth foundation sudah ada
- TV optimization sudah ada
- Masuk fase stabilization + integration

## Target utama
1. Test di TV RAM 2GB
2. Integrasi real Home -> Player
3. Cleanup & optimization
4. Jaga CI tetap hijau

## Checklist TV RAM 2GB
- App launch tanpa crash
- Home screen render stabil
- Player screen bisa dibuka
- Navigasi Home -> Player lancar
- Tidak ada loading infinite
- Tidak ada memory spike berat
- Back button TV remote bekerja
- Focus remote tidak macet
- Image/list tidak terlalu berat
- Player tetap responsif setelah beberapa menit

## Checklist Home / Player Integration
- Home memakai data real dari API/service layer
- Item channel/video bisa membuka player
- Player menerima URL/title/source secara jelas
- Error player tampil ramah, bukan blank screen
- Loading state ada
- Empty state ada
- Auth state tidak memblokir player tanpa alasan

## Cleanup Target
- Hapus debug print berlebihan
- Hindari widget rebuild berat
- Hindari list besar tanpa lazy rendering
- Rapikan file/service yang duplikat
- Pastikan asset tidak terlalu besar
- Pastikan dependency tidak mubazir

## Rule Stabilization
Jangan tambah fitur besar sebelum:
- analyze hijau
- test hijau
- build Android hijau
- flow Home -> Player lolos manual test
