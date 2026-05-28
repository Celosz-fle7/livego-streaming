#!/usr/bin/env bash
set -e

OUT="release_notes.txt"

echo "LiveGO Low-End TV Release" > "$OUT"
echo "=========================" >> "$OUT"
echo "" >> "$OUT"

echo "Commit:" >> "$OUT"
git log --oneline -1 >> "$OUT"
echo "" >> "$OUT"

echo "Recent changes:" >> "$OUT"
git log --oneline -10 >> "$OUT"
echo "" >> "$OUT"

echo "Project stats:" >> "$OUT"
echo "Dart files: $(find lib -name "*.dart" | wc -l)" >> "$OUT"
echo "TV widgets: $(find lib/tv/widgets -name "*.dart" | wc -l)" >> "$OUT"
echo "TV core: $(find lib/tv/core -name "*.dart" | wc -l)" >> "$OUT"
echo "" >> "$OUT"

echo "APK files:" >> "$OUT"
ls -lh build/app/outputs/flutter-apk/*.apk >> "$OUT"

cat "$OUT"
