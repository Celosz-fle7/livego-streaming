# LiveGO Premium UI Upgrade

Base ZIP ini sudah di-upgrade menjadi arah aplikasi premium cinematic:

## Mobile
- Bottom navbar premium: Home, Histori, Search, Favorit, Akun
- Home style CineFlow: pill header, hero banner, category chips, poster grid
- Fallback content supaya UI tetap hidup ketika API kosong/offline
- RefreshIndicator untuk reload content
- Route player tetap memakai `MobilePlayerScreen` lama yang sudah ada

## TV
- TV home cinematic baru
- Sidebar kiri auto-hide
- Sidebar muncul saat remote/focus menekan arah kiri
- Hero banner besar
- Category chips TV
- Poster rail horizontal
- Focus glow neon untuk Android TV

## Catatan push
Extract ZIP ini ke repo, lalu:

```bash
git add .
git commit -m "premium cinematic ui upgrade"
git push origin pro-v2
```

Setelah Actions hijau, test APK di mobile dan Android TV.
