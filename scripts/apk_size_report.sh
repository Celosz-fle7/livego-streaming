#!/usr/bin/env bash
set -e

APK_DIR="build/app/outputs/flutter-apk"

echo "APK SIZE REPORT"
echo "==============="

if [ ! -d "$APK_DIR" ]; then
  echo "APK directory not found. Build first."
  exit 1
fi

ls -lh "$APK_DIR"/*.apk

echo ""
echo "Largest APK:"
du -h "$APK_DIR"/*.apk | sort -h | tail -n 1
