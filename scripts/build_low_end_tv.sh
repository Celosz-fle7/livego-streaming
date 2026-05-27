#!/usr/bin/env bash
set -e

echo "Building LOW-END TV APK..."

flutter clean
flutter pub get

flutter build apk \
  --release \
  --split-per-abi

echo "Done. APK output:"
ls -lh build/app/outputs/flutter-apk/
