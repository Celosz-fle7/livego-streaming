#!/usr/bin/env bash
set -e

OUT="build_summary.txt"

echo "LIVEGO TV BUILD SUMMARY" > "$OUT"
echo "=======================" >> "$OUT"
echo "" >> "$OUT"

echo "Branch:" >> "$OUT"
git branch --show-current >> "$OUT"
echo "" >> "$OUT"

echo "Commit:" >> "$OUT"
git log --oneline -1 >> "$OUT"
echo "" >> "$OUT"

echo "Sanity:" >> "$OUT"
bash scripts/ci_sanity_check.sh >> "$OUT"
echo "" >> "$OUT"

echo "APK:" >> "$OUT"
ls -lh build/app/outputs/flutter-apk/*.apk >> "$OUT"

cat "$OUT"
