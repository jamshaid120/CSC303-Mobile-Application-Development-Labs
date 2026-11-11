# CSC303 — Mobile Application Development Laboratory

**COMSATS University Islamabad, Sahiwal Campus · Department of Computer Science**  
Flutter & Dart lab material, revised November 2026.

This repository contains **15 teaching labs**, with source code and written instructions for each worked example. It also includes individually downloadable ZIP packages and the revised student lab manual.

> **Validation status:** The packages have been checked for archive integrity and shell syntax; the Flutter SDK and physical Android devices were not available in the packaging environment, so the examples have **not been fully compiled or device-tested**. Students and instructors should run `flutter analyze`, `flutter test` (where supplied) and `flutter run` in their actual Flutter/Android environments.

## Labs

| Lab | Topic | Source | Download ZIP |
|---|---|---|---|
| 01 | Professional setup, Git and GitHub | [View files](labs/CSC303_Lab_01/) | [ZIP](downloads/CSC303_Lab_01.zip) |
| 02 | Dart foundations and Flutter project anatomy | [View files](labs/CSC303_Lab_02/) | [ZIP](downloads/CSC303_Lab_02.zip) |
| 03 | Widgets, layouts and responsive UI | [View files](labs/CSC303_Lab_03/) | [ZIP](downloads/CSC303_Lab_03.zip) |
| 04 | Forms, validation and local state | [View files](labs/CSC303_Lab_04/) | [ZIP](downloads/CSC303_Lab_04.zip) |
| 05 | Navigation and passing data | [View files](labs/CSC303_Lab_05/) | [ZIP](downloads/CSC303_Lab_05.zip) |
| 06 | Lists, cards, search and feedback | [View files](labs/CSC303_Lab_06/) | [ZIP](downloads/CSC303_Lab_06.zip) |
| 07 | Drawer, bottom navigation, tabs and themes | [View files](labs/CSC303_Lab_07/) | [ZIP](downloads/CSC303_Lab_07.zip) |
| 08 | Provider and Cubit/BLoC | [View files](labs/CSC303_Lab_08/) | [ZIP](downloads/CSC303_Lab_08.zip) |
| 09 | Preferences and Drift/SQLite | [View files](labs/CSC303_Lab_09/) | [ZIP](downloads/CSC303_Lab_09.zip) |
| 10 | HTTP REST, JSON and offline fallback | [View files](labs/CSC303_Lab_10/) | [ZIP](downloads/CSC303_Lab_10.zip) |
| 11 | Firebase Authentication | [View files](labs/CSC303_Lab_11/) | [ZIP](downloads/CSC303_Lab_11.zip) |
| 12 | Cloud Firestore, Storage and messaging | [View files](labs/CSC303_Lab_12/) | [ZIP](downloads/CSC303_Lab_12.zip) |
| 13 | MVVM, repositories, dependency injection and tests | [View files](labs/CSC303_Lab_13/) | [ZIP](downloads/CSC303_Lab_13.zip) |
| 14 | Animations, rendering and native channels | [View files](labs/CSC303_Lab_14/) | [ZIP](downloads/CSC303_Lab_14.zip) |
| 15 | API, offline persistence and capstone guidance | [View files](labs/CSC303_Lab_15/) | [ZIP](downloads/CSC303_Lab_15.zip) |

## Start here

1. Read the [revised manual](docs/CSC303_Mobile_Application_Development_Lab_Manual_Revised_Nov2026.pdf) and the [deployment instructions](PUBLISH_TO_GITHUB.md) if you are a maintainer.
2. Open the required folder, for example `labs/CSC303_Lab_09/task_02`.
3. Read the lab's `README.md`. Each task is a **separate Flutter project**; do not merge `task_01` and `task_02` or their `lib/main.dart` files.
4. On a machine with Flutter SDK and Android SDK installed, run `bash setup.sh` from the task directory. Then run `flutter analyze` and `flutter run` (and `flutter test` where tests exist).
5. For Firebase labs, create your **own** Firebase project and generate `lib/firebase_options.dart` using `flutterfire configure`. Enable only the required services, and do not publish secrets, service-account JSON or signing keys.

Example:

```bash
cd labs/CSC303_Lab_09/task_02
bash setup.sh
flutter analyze
flutter run
```

## Repository layout

```text
labs/                       Browsable source and lab-specific PDF excerpts
  CSC303_Lab_01/ ... CSC303_Lab_15/
    task_01/                First worked example / setup
    task_02/                Second worked example
    README.md               Lab instructions
    ...Manual_Excerpt.pdf    Lab reading

downloads/                  15 individually shareable ZIP archives
docs/                       Revised, full 82-page lab manual
scripts/                    Optional publishing helper
PUBLISH_TO_GITHUB.md        How to upload/push to GitHub
```

## Classroom notes

- These are **reference worked examples**, not a submitted student portfolio or a finished capstone application. Lab 15 includes a semester-project brief.
- The `setup.sh` scripts create project scaffolding on the student machine. No prebuilt APKs or vendor credentials are included.
- Project and package versions may be resolved differently unless students use the same Flutter SDK and lockfiles.
- Firebase Storage may incur cloud charges. Only enable billing with instructor approval.
- **No open-source license has been selected** in this package. Do not infer permission to redistribute beyond the rights granted by the material owner; the repository owner should choose and add a LICENSE after confirming distribution rights.
