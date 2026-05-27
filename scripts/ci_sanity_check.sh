#!/usr/bin/env bash
set -e

echo "CI SANITY CHECK"
echo "==============="

required_files=(
  "pubspec.yaml"
  "lib/main.dart"
  "lib/tv/system/tv_system_dashboard.dart"
  "lib/tv/system/tv_system_initializer.dart"
  "lib/tv/core/tv_low_memory_mode.dart"
  "lib/tv/performance/tv_release_config_summary.dart"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing required file: $file"
    exit 1
  fi
done

echo "Required files OK"

dart_files=$(find lib -name "*.dart" | wc -l)
if [ "$dart_files" -lt 100 ]; then
  echo "Dart file count too low: $dart_files"
  exit 1
fi

echo "Dart files: $dart_files"
echo "Sanity check passed"
