# Zikra — Architecture

## Layers

```
Presentation  →  Domain  →  Data  →  External (API / DB / Platform)
```

- **Presentation** (`features/<f>/presentation/`): Flutter widgets and screens. Reads from Riverpod providers. Never calls APIs directly.
- **Domain** (`features/<f>/domain/`): Pure Dart models and value objects. No Flutter imports. No `http` or `drift` imports.
- **Data** (`features/<f>/data/`): Repositories, API clients, local stores. Implements domain interfaces. Reads from Drift DB or http.

## State Management — flutter_riverpod

- Use `@riverpod` (code-gen) for new providers.
- Existing legacy services (`LocationCacheService`, `HijriNotesStore`, `QuranBookmarkStore`) are exposed via hand-written providers during migration.
- Providers live alongside their feature in `data/` (e.g. `quran/data/quran_providers.dart`).
- UI reads via `ref.watch`; mutations via `ref.read(…).method()`.

## Routing — go_router

- Configured in `lib/app/router.dart`.
- `StatefulShellRoute` wraps the five main tabs (Home, Prayers, Quran, Guidance, Tools).
- All `Navigator.push` calls are replaced by `context.go(RouteNames.xxx)` or `context.push(…)`.
- Named constants in `lib/app/routes.dart`.
- Deep links: not implemented in Sprint 0. Add in Sprint 2.

## Local Database — Drift (SQLite)

- `AppDatabase` in `lib/core/database/app_database.dart`.
- Bundled as a `FlutterQueryExecutor` (lazy open, creates file on first access).
- Schema migration via `MigrationStrategy` with `from` / `to` version handling.
- Generated file: `app_database.g.dart` — run `dart run build_runner build --delete-conflicting-outputs`.
- **Sprint 0 schema (v1)**: `app_meta(key TEXT PRIMARY KEY, value TEXT)` — key/value store for settings.
- **Sprint 1 target schema**: chapters, verses, words, translations, tafsir — see `docs/sprint0_report.md`.

## Small Persistence — shared_preferences

Used only for:
- Onboarding completion flag
- Last-read chapter/verse (until migrated to Drift)
- User settings (locale, font size, theme)
- Location cache

Not used for bulk data (Quran, dhikr) — use Drift.

## Localisation — flutter_localizations + intl

- ARB files: `lib/l10n/app_en.arb`, `app_si.arb`, `app_ta.arb`.
- Generated class: `AppLocalizations` (via `flutter gen-l10n`).
- Config: `l10n.yaml` at repo root.
- `localeProvider` (Riverpod): holds current locale, defaults to device locale with `en` fallback.
- Language-switcher UI: Sprint 1.

## Where Quran Data Will Live (Sprint 1)

```
assets/db/quran.db   ← bundled SQLite (Tanzil.net Uthmani text, SHA-256 verified)
lib/core/database/
  tables/
    quran_chapters.dart
    quran_verses.dart
    quran_words.dart
    quran_translations.dart
    quran_tafsirs.dart
```

- The DB file is checked against a committed SHA-256 on first launch.
- No Quran text is fetched from the network; the quran.com API is used only for metadata (translation/tafsir editions list) and word-by-word supplementary data.
- See `docs/spikes/wbw_and_translation_languages.md` for data availability findings.

## Platform Notes

- **Android**: `compileSdkVersion` 35, `minSdkVersion` 21. Exact-alarm permission added in Sprint 1 (F13).
- **iOS**: minimum deployment target 13.0 (Flutter default).
- **Web / Desktop**: exist in the repo skeleton but are not a target for Sprint 0–2.
