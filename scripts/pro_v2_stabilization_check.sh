#!/usr/bin/env bash
set -e

echo "== Pro V2 Stabilization Check =="

echo ""
echo "1) Flutter version"
flutter --version

echo ""
echo "2) Pub get"
flutter pub get

echo ""
echo "3) Analyze"
flutter analyze

echo ""
echo "4) Test"
flutter test || echo "No tests or test failed - review needed"

echo ""
echo "5) Dependency check"
flutter pub outdated || true

echo ""
echo "6) Large files check"
find . -type f \
  -not -path "./.git/*" \
  -size +5M \
  -print

echo ""
echo "7) Debug print scan"
grep -R "print(" lib || true
grep -R "debugPrint(" lib || true

echo ""
echo "Done."
