# Zikra

An offline-first Islamic companion app for Android and iOS.

**Bundle ID:** `com.zikraapp.zikra`  
**Flutter:** 3.41.1 · **Dart:** 3.11.0

---

## Features (Sprint 0 state)

| Feature | Status |
|---|---|
| Qibla compass with lock haptic | Working |
| Quran reader (online) with bookmarks | Working |
| Hijri calendar with notes | Working |
| Nearby mosques map | Working |
| Prayer times | Placeholder ("coming soon") |
| Zikr counter, dhikr library, wird, reminders | Not yet built |

---

## How to run

```sh
# Install dependencies
flutter pub get

# Generate Drift DB code and l10n classes
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# Run on connected device / emulator
flutter run
```

---

## How to run tests

```sh
flutter test
```

All tests must pass before committing. The test suite includes:

- **smoke_test.dart** — app builds with ProviderScope, all 5 tab labels visible
- **ui_language_guard_test.dart** — no streak/guilt/fear language in lib/ or l10n/
- **no_fake_prayer_times_test.dart** — no hardcoded HH:MM prayer times
- **qibla_math_test.dart** — Qibla bearing correctness (London, Jakarta, New York, Colombo)
- **app_database_test.dart** — Drift DB insert/read/upsert with in-memory executor

---

## How to regenerate code

Run after editing any `.drift` table file or ARB localisation file:

```sh
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

---

## Architecture

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the full architecture description.

**Quick summary:**
- State: `flutter_riverpod` 2.6.1
- Routing: `go_router` 17.5
- Local DB: `drift` 2.26 (SQLite) — schema v1 (`app_meta` key/value table)
- Persistence (small): `shared_preferences`
- Localisation: `flutter_localizations` + `intl`, ARBs in `lib/l10n/` (en, si, ta)
- Folder layout: `lib/app/`, `lib/core/`, `lib/features/<f>/{data,domain,presentation}/`, `lib/l10n/`

---

## Licences

See [LICENCES.md](LICENCES.md) for data sources, fonts, and package licences.

Several items are marked **TO VERIFY** — do not publish until those are resolved.

---

## Sprint 0 decisions

See [docs/sprint0_decisions.md](docs/sprint0_decisions.md) for all architectural and product decisions made during Sprint 0.
