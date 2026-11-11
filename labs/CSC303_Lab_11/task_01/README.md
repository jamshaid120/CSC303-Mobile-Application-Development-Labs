# CSC303 / Lab 11 / Worked Task 1

**Firebase registration and auth gate**

Source: revised *CSC303 Mobile Application Development Lab Manual* (November 2026), Lab 11.
This folder contains the hand-authored code from the manual. Flutter's generated `android/` files, generated Drift code and personal Firebase settings are not redistributed. Run the bootstrap script once to generate the Android scaffold for the locally installed SDK.

## Setup (Linux/macOS/Windows Git Bash)

```bash
cd task_01
bash setup.sh
flutter analyze
flutter run
```

If the Flutter SDK, Java/JDK, Android SDK or USB debugging is not installed, complete Lab 01 first. A working phone should be listed under `flutter devices`.

## Source files

- `lib/main.dart`

## Notes

- Install the Firebase CLI (`npm install -g firebase-tools`), run `firebase login`, then `dart pub global activate flutterfire_cli` and `flutterfire configure` after setup; enable required providers in Firebase Console before launching. Ensure the Dart pub-cache bin directory is on PATH.
- setup.sh injects the INTERNET permission into android/app/src/main/AndroidManifest.xml. Verify with `grep INTERNET android/app/src/main/AndroidManifest.xml`.

## Validation disclaimer

Code was extracted from the revised manual and structurally checked, not compiled with Flutter in the packaging environment. External Firebase configuration and Android SDK/build toolchain are required for real execution.
