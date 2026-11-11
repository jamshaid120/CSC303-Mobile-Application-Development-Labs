#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$HERE"
if ! command -v flutter >/dev/null 2>&1; then
  echo 'Flutter SDK is not on PATH. Install Flutter first (see README.md).' >&2
  exit 2
fi
PROJECT='mad_native_demo'
ORG='edu.cui.sahiwal'
if [ ! -d android ]; then
  echo 'Generating matching Android project scaffolding using installed Flutter SDK...'
  TEMP="$(mktemp -d)"
  trap 'rm -rf "$TEMP"' EXIT
  flutter create --platforms=android --org "$ORG" --project-name "$PROJECT" "$TEMP/scaffold"
  cp -R "$TEMP/scaffold/android" "$HERE/android"
  cp "$TEMP/scaffold/analysis_options.yaml" "$HERE/analysis_options.yaml"
  cp "$TEMP/scaffold/.metadata" "$HERE/.metadata"
  echo "Android project generated for ${ORG}.${PROJECT}"
fi

NATIVE="$HERE/platform_overrides/android/app/src/main/kotlin/edu/cui/sahiwal/mad_native_demo/MainActivity.kt"
if [ -f "$NATIVE" ]; then
  DEST="$HERE/android/app/src/main/kotlin/edu/cui/sahiwal/mad_native_demo/MainActivity.kt"
  mkdir -p "$(dirname "$DEST")"
  cp "$NATIVE" "$DEST"
fi

echo 'Resolving Flutter packages...'
flutter pub get

echo 'Next: flutter analyze && flutter run'
