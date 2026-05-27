#!/usr/bin/env bash
set -e

OUT="release_manifest.json"
APK_DIR="build/app/outputs/flutter-apk"

cat > "$OUT" << JSON
{
  "project": "LiveGO TV",
  "branch": "$(git branch --show-current)",
  "commit": "$(git rev-parse --short HEAD)",
  "profile": "low-end-tv",
  "dart_files": $(find lib -name "*.dart" | wc -l),
  "tv_widgets": $(find lib/tv/widgets -name "*.dart" | wc -l),
  "tv_core": $(find lib/tv/core -name "*.dart" | wc -l),
  "apk_count": $(ls "$APK_DIR"/*.apk | wc -l)
}
JSON

cat "$OUT"
