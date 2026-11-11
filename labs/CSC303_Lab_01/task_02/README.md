# CSC303 / Lab 01 / Worked Task 2

**First-phone counter and widget test**

Source: revised *CSC303 Mobile Application Development Lab Manual* (November 2026), Lab 01.
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
- `test/widget_test.dart`

## Notes

- Works offline without external services unless specified in the source.

## Validation disclaimer

Code was extracted from the revised manual and structurally checked, not compiled with Flutter in the packaging environment. External Firebase configuration and Android SDK/build toolchain are required for real execution.
