#!/usr/bin/env bash
set -e

API_BASE_URL="${API_BASE_URL:-}"

flutter pub get

flutter build apk \
  --release \
  --dart-define=API_BASE_URL="$API_BASE_URL"

ls -lh build/app/outputs/flutter-apk/
