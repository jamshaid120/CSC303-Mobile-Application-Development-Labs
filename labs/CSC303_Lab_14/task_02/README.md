# CSC303 / Lab 14 / Worked Task 2

**Kotlin MethodChannel battery level**

Source: revised *CSC303 Mobile Application Development Lab Manual* (November 2026), Lab 14.
This folder contains the hand-authored code from the manual. Flutter's generated `android/` files, generated Drift code and personal Firebase settings are not redistributed. Run the bootstrap script once to generate the Android scaffold for the locally installed SDK.

## Setup (Linux/macOS/Windows Git Bash)

```bash
cd task_02
bash setup.sh
flutter analyze
flutter run
```

If the Flutter SDK, Java/JDK, Android SDK or USB debugging is not installed, complete Lab 01 first. A working phone should be listed under `flutter devices`.

## Source files

- `lib/main.dart`
- `platform_overrides/android/app/src/main/kotlin/edu/cui/sahiwal/mad_native_demo/MainActivity.kt`

## Notes

- setup.sh copies the provided Kotlin MainActivity.kt to the matching generated Android directory.

## Validation disclaimer

Code was extracted from the revised manual and structurally checked, not compiled with Flutter in the packaging environment. External Firebase configuration and Android SDK/build toolchain are required for real execution.
