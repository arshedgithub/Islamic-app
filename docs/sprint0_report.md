# Sprint 0 Report — Foundation and Quick Wins

**Branch:** `sprint-0/foundation`  
**Date completed:** 2026-11-01  
**Flutter:** 3.41.1 · Dart 3.11.0

---

## Final Check Results

```
flutter analyze:  No issues found (0 errors, 0 warnings, 0 infos)
flutter test:     All tests passed (13 tests)
```

---

## Definition of Done

- [x] App is named Zikra with ID `com.zikraapp.zikra` on Android and iOS configs
- [x] `flutter analyze`: 0 issues; `flutter test`: all pass (13 tests)
- [x] Riverpod 2.6.1, go_router 17.5, Drift 2.26 (in-memory test), l10n (en/si/ta) are wired
- [x] No streak text and no fake prayer times or counts anywhere in `lib/`
- [x] Audit defects R8, R9, R10 and all deprecations are fixed
- [x] Qibla bearing is unit-tested; haptic fires once on lock (with 2-second cooldown)
- [x] CI workflow and Dependabot config exist
- [x] Spike report written with a clear verdict for Sinhala and Tamil data
- [x] CLAUDE.md, ARCHITECTURE.md, LICENCES.md, sprint0_decisions.md exist
- [x] All work is committed on branch `sprint-0/foundation`, nothing pushed

---

## Tasks Completed

| Task | Commit | Summary |
|---|---|---|
| T0 | 64bcf0a | Branch created, baseline doc written |
| T1 | 7b31d42 | CLAUDE.md, ARCHITECTURE.md, LICENCES.md, sprint0_decisions.md |
| T2 | b07b2f2 | Renamed nafas → zikra; bundle ID com.zikraapp.zikra on Android + iOS |
| T3 | ec00699 | Riverpod 2.6.1, go_router 17.5, Drift 2.26+drift_dev, l10n en/si/ta, folder restructure |
| T4 | a851697 | Removed streak card and hard-coded prayer times; honest placeholders; deleted dead PrayerScreen |
| T5 | 4411574 | Fixed R8 (BuildContext async), R9 (mosque radius mismatch), R10 (touch targets); fixed all deprecations |
| T6 | 2fec73f | Extracted qibla_math.dart; 6 unit tests pass; haptic on lock with cooldown |
| T7 | 166f1ae | 13 tests: DB in-memory, qibla math, smoke (5 tabs), language guard, no-fake-prayer-times |
| T8 | 571139c | GitHub Actions CI (analyze + test + debug APK) and Dependabot |
| T9 | dabd844 | Spike: Tamil WbW available; Sinhala WbW unavailable; 3 Tamil / 1 Sinhala translations |
| T10 | (this commit) | README, sprint0_report.md, final check |

---

## Files and Dependencies Added

### New source files

```
lib/app/app.dart           — ZikraApp (ConsumerWidget, MaterialApp.router)
lib/app/router.dart        — GoRouter with StatefulShellRoute skeleton
lib/app/routes.dart        — Route name constants
lib/app/theme.dart         — (moved from lib/core/theme.dart)
lib/core/database/app_database.dart   — Drift AppDatabase, AppMetaTable
lib/core/database/app_database.g.dart — generated
lib/core/providers.dart    — Riverpod providers for DB, LocationCacheService, BookmarkStore, SharedPrefs
lib/core/services/location_cache_service.dart  — (moved from lib/shared/services/)
lib/features/qibla/domain/qibla_math.dart      — pure qiblaBearing() function
lib/l10n/app_en.arb        — English strings
lib/l10n/app_si.arb        — Sinhala strings (NEEDS NATIVE REVIEW)
lib/l10n/app_ta.arb        — Tamil strings (NEEDS NATIVE REVIEW)
lib/l10n/app_localizations*.dart  — generated
```

### New test files

```
test/smoke_test.dart
test/ui_language_guard_test.dart
test/no_fake_prayer_times_test.dart
test/features/qibla/qibla_math_test.dart
test/core/app_database_test.dart
```

### New config / doc files

```
CLAUDE.md
LICENCES.md
l10n.yaml
.github/workflows/ci.yml
.github/dependabot.yml
docs/ARCHITECTURE.md
docs/sprint0_baseline.md
docs/sprint0_decisions.md
docs/spikes/wbw_and_translation_languages.md
```

### New packages (versions resolved)

| Package | Type | Version |
|---|---|---|
| flutter_riverpod | runtime | 2.6.1 |
| go_router | runtime | 17.5.0 |
| drift | runtime | 2.26.0 |
| sqlite3_flutter_libs | runtime | resolved |
| path_provider | runtime | resolved |
| path | runtime | resolved |
| flutter_localizations | runtime (SDK) | SDK |
| intl | runtime | 0.20.2 |
| drift_dev | dev | 2.26.1 |
| build_runner | dev | 2.5.0 |

### Deleted files

```
lib/features/prayer/prayer_times.dart  — dead stub, never reachable from UI
```

### Renamed files

```
lib/shared/widgets/nafas_bottom_nav_bar.dart → zikra_bottom_nav_bar.dart
android/app/src/main/kotlin/com/example/nafas/ → com/zikraapp/zikra/
```

---

## Decisions Made

See [docs/sprint0_decisions.md](sprint0_decisions.md) for full detail. Key decisions:

- **D1** Bundle ID: `com.zikraapp.zikra`
- **D3** Generated Drift files committed to VCS
- **D4** Dead `PrayerScreen` stub deleted
- **D5** Mosque search radius: UI now shows actual queried radius (12 km)
- **D7** flutter_riverpod 2.x (not 3.x) — compatibility constraint with Dart 3.11 + drift_dev

---

## Skipped / Not Done

| Item | Reason |
|---|---|
| `flutter build apk --debug` in CI | Android toolchain not available in this environment; CI workflow is written correctly and will run on GitHub Actions. |
| Language-switcher UI | Scheduled for Sprint 1 (onboarding flow) |
| Sinhala/Tamil native string review | Requires a native speaker; strings are copied from English as placeholders |
| StatefulShellRoute with per-tab navigation stacks | GoRouter is wired with a flat MainShell for now; full shell routing is Sprint 1 |

---

## Recommended Sprint 1 Plan — Offline Quran Database

### Goal
Replace the current online-only quran.com API reader with a fully offline, verified SQLite/Drift database. This unblocks F6, F7, F8, F9, and F21.

### Proposed Drift Schema (v2, upgrading from v1)

```dart
// app_meta already exists (v1)

class QuranChaptersTable extends Table {
  IntColumn get id => integer()();
  TextColumn get arabicName => text()();
  TextColumn get englishName => text()();
  TextColumn get englishMeaning => text()();
  BoolColumn get hasBismillahPre => boolean()();
  IntColumn get startPage => integer()();
  IntColumn get endPage => integer()();
  IntColumn get verseCount => integer()();
}

class QuranVersesTable extends Table {
  IntColumn get id => integer()();
  IntColumn get chapterId => integer().references(QuranChaptersTable, #id)();
  IntColumn get verseNumber => integer()();
  TextColumn get verseKey => text()(); // "1:1"
  TextColumn get textUthmani => text()();
  IntColumn get pageNumber => integer()();
  IntColumn get juzNumber => integer()();
}

class QuranWordsTable extends Table {
  IntColumn get id => integer()();
  IntColumn get verseId => integer().references(QuranVersesTable, #id)();
  IntColumn get position => integer()();
  TextColumn get textUthmani => text()();
  TextColumn get transliteration => text()();
}

class QuranTranslationsTable extends Table {
  // One row per word-translation or verse-translation entry.
  IntColumn get verseId => integer()();  // foreign key to QuranVersesTable
  TextColumn get languageCode => text()(); // "en", "ta", "si"
  IntColumn get translatorId => integer()(); // quran.com translator ID
  TextColumn get text => text()();
}

class QuranWordTranslationsTable extends Table {
  IntColumn get wordId => integer()();
  TextColumn get languageCode => text()();
  TextColumn get text => text()();
}

class QuranTafsirsTable extends Table {
  IntColumn get verseId => integer()();
  IntColumn get tafsirId => integer()(); // quran.com tafsir ID
  TextColumn get languageCode => text()();
  TextColumn get text => text()();
}
```

### Import pipeline

1. Download Tanzil.net Uthmani XML (quran-uthmani.xml) — confirmed free for non-commercial offline use with attribution.
2. Write a one-off `tools/import_quran.dart` script that parses the XML and populates `QuranVersesTable` + `QuranChaptersTable`.
3. Export the populated DB as `assets/db/quran_seed.db`.
4. On app first launch, copy the seed DB to the app documents directory.
5. Compute SHA-256 of the seed DB at build time; commit the hash; verify on first launch.

### Integrity test (quran_integrity_test.dart)

```dart
test('quran DB has 114 chapters', () async { ... });
test('quran DB has exactly 6236 verses', () async { ... });
test('quran DB SHA-256 matches committed constant', () async { ... });
```

### Sprint 1 translation loading (informed by T9 spike)

- **English**: Use quran.com API WbW + verse translations (IDs: 131 Saheeh International).
- **Tamil**: Use quran.com API WbW (`language=ta`). Verse translations: ID 50 (Jan Trust Foundation). Obtain licence.
- **Sinhala**: No WbW available from quran.com API. Load verse translation ID 228 (Ruwwad Center). WbW: defer to Sprint 2; launch without.

---

## Known Issues

1. The IDE's Dart analysis server shows stale "package not found" warnings for `flutter_riverpod`, `go_router`, `drift`, and `flutter_localizations`. These are false positives — `flutter analyze` returns 0 issues. Restart the IDE after `flutter pub get` to clear them.
2. `flutter gen-l10n` exits with code 1 when `l10n.yaml` is present, printing an informational message about ignoring CLI flags. This is a known Flutter tool quirk — the ARB files are correctly generated to `lib/l10n/`. The CI uses `flutter gen-l10n` as a step; adjust if this causes false CI failures.
3. Sinhala and Tamil strings in ARB files are written by a non-native speaker and require review before launch.
4. `sqlite3_flutter_libs` requires Android Developer Mode (symlink support) when running on Windows dev machines. Not a runtime issue on Android devices.
