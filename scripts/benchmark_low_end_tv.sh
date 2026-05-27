#!/usr/bin/env bash
set -e

OUT="benchmark_report.txt"

echo "LOW-END TV BENCHMARK" > "$OUT"
echo "====================" >> "$OUT"
echo "" >> "$OUT"

echo "Timestamp:" >> "$OUT"
date >> "$OUT"
echo "" >> "$OUT"

echo "Project size:" >> "$OUT"
du -sh . >> "$OUT"
echo "" >> "$OUT"

echo "Dart files:" >> "$OUT"
find lib -name "*.dart" | wc -l >> "$OUT"
echo "" >> "$OUT"

echo "TV Widgets:" >> "$OUT"
find lib/tv/widgets -name "*.dart" | wc -l >> "$OUT"
echo "" >> "$OUT"

echo "TV Core:" >> "$OUT"
find lib/tv/core -name "*.dart" | wc -l >> "$OUT"
echo "" >> "$OUT"

echo "Performance policies:" >> "$OUT"
find lib/tv/performance -name "*.dart" | wc -l >> "$OUT"
echo "" >> "$OUT"

echo "APK outputs:" >> "$OUT"
ls -lh build/app/outputs/flutter-apk/*.apk >> "$OUT"

cat "$OUT"
