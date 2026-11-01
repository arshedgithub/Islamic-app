# Sprint 0 Baseline

Captured on branch creation: `sprint-0/foundation`
Date: 2026-11-01

## flutter --version

```
Flutter 3.41.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 582a0e7c55 (9 months ago) • 2026-02-12 17:12:32 -0800
Engine • hash cc8e596aa65130a0678cc59613ed1c5125184db4
Tools • Dart 3.11.0 • DevTools 2.54.1
```

## flutter pub get

```
Got dependencies!
46 packages have newer versions incompatible with dependency constraints.
(non-blocking — no resolution errors)
```

## flutter analyze

```
7 issues found (all INFO — no errors or warnings):
- unnecessary_underscores ×2 (hijri_calendar_screen.dart:241, nearby_mosques_screen.dart:158)
- use_build_context_synchronously (hijri_calendar_screen.dart:478)
- deprecated_member_use ×3 DropdownButtonFormField.value (hijri_calendar_screen.dart:758,778,802)
- deprecated_member_use desiredAccuracy (nearby_mosques_screen.dart:48)
```

## flutter test

```
Test directory "test" does not appear to contain any test files.
```

## git log -5

```
edb637d adding quran screen
d253b49 adding bookmark to verses
7e54d26 adding Quran chapters to the quran tab
ca9cc5e add api calling from quran com
67daa49 make navbar distinct
```

## lib/ top-level folders

```
lib/
  core/
  features/
  shared/
  main.dart
```

### lib/core/

```
app.dart
main_shell.dart
theme.dart
```

### lib/features/

```
hijri/
mosques/
prayer/
qibla/
quran/
```

### lib/shared/

```
services/
widgets/
```
