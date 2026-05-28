# Home / Player Integration Contract

## Tujuan
Menyambungkan Home screen ke Player screen memakai data real, bukan dummy flow.

## Data minimal dari Home ke Player
Player minimal menerima:

- title
- streamUrl / playbackUrl
- sourceId / channelId
- optional thumbnail
- optional headers/auth token jika diperlukan

## Expected Flow
1. User buka Home
2. Home load data dari service/API
3. User pilih item
4. App navigasi ke Player
5. Player validasi URL
6. Player mulai playback atau tampilkan error state

## Error State Wajib
- URL kosong
- URL invalid
- API gagal
- Auth expired
- Network timeout
- Player gagal load stream

## TV Remote Requirement
- Item Home bisa difokus remote
- Enter/OK membuka Player
- Back dari Player kembali ke Home
- Focus tidak hilang setelah kembali
