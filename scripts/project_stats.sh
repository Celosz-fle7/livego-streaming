#!/usr/bin/env bash
set -e

echo "Dart files:"
find lib -name "*.dart" | wc -l

echo "TV widgets:"
find lib/tv/widgets -name "*.dart" | wc -l

echo "TV core:"
find lib/tv/core -name "*.dart" | wc -l

echo "Project size:"
du -sh .
