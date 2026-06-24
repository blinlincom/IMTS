#!/usr/bin/env sh
set -eu

flutter pub get
flutter analyze
flutter test
flutter build apk --release
flutter build web --release

printf '%s\n' 'Build outputs:'
printf '%s\n' '- Android APK: build/app/outputs/flutter-apk/app-release.apk'
printf '%s\n' '- Web: build/web'
