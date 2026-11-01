# Sprint 0 — Decisions Log

Decisions recorded here instead of stopping for confirmation, per working agreement.

---

## D1 — App Bundle ID: com.zikraapp.zikra

**Decision:** Use `com.zikraapp.zikra` as the Android applicationId and iOS bundle identifier.  
**Confirmed by:** User during Sprint 0 setup (2026-11-01).

---

## D2 — Sinhala and Tamil l10n keys: use English as placeholder

**Decision:** Where we are unsure of correct Sinhala (si) or Tamil (ta) translations for UI strings, the English text is copied into those ARB files. Each such entry is commented with `// NEEDS NATIVE REVIEW`.  
**Why:** Sprint 0 wires the localisation pipeline; accuracy of Sinhala/Tamil strings is verified by a native speaker before Sprint 2 ships to those users.

---

## D3 — Generated Drift files committed to version control

**Decision:** `lib/core/database/app_database.g.dart` is committed to the repo.  
**Why:** Avoids requiring every new developer and the CI runner to install the exact build_runner version before first build. The generated file is deterministic given the same schema, so drift is low.

---

## D4 — PrayerScreen stub (prayer_times.dart) deleted

**Decision:** `lib/features/prayer/prayer_times.dart` is deleted in T4.  
**Why:** It was a dead file — never imported, never reachable from the UI (confirmed by grep). Its only content was a scaffold placeholder with the text "Prayer Times will appear here". No useful layout ideas were present; the honest empty state wired in T4 is superior.

---

## D5 — Mosque search radius: use queried radius (12 km), not the original 40 km

**Decision (R9 fix):** The UI will state the actual queried radius (12 km) rather than a misleading 40 km claim.  
**Why:** The Overpass query is capped at 12 km for performance. Showing 40 km is dishonest. If a larger radius is needed in a future sprint, raise `_maxOverpassQueryKm` and re-evaluate Overpass load.

---

## D6 — Riverpod code-gen (@riverpod) used for new providers; legacy providers are hand-written

**Decision:** New providers use `@riverpod` annotation + build_runner. Existing singletons (LocationCacheService etc.) are wrapped in hand-written `Provider<T>` without touching their internals.  
**Why:** Minimises diff scope; avoids rewriting tested code during scaffolding.

---

## D7 — flutter_riverpod version pinned to 2.x range

**Decision:** Use `flutter_riverpod: ^2.6.1` (latest 2.x compatible with Dart 3.11).  
**Why:** Riverpod 3.x requires Dart 3.14+ which is beyond the current SDK constraint (`^3.11.0`).  
**Action:** Upgrade to Riverpod 3.x when upgrading Flutter/Dart in Sprint 2.

---

## D8 — go_router version selected from pub.dev

**Decision:** `go_router: ^14.6.1` — latest stable compatible with Flutter 3.41.1 / Dart 3.11.0.  
**Why:** go_router 15.x requires Dart 3.14+. Verified via `flutter pub add go_router`.

---

## D9 — Tafsir author/book (ID 169) not yet identified

**Decision:** Display tafsir text without an author label in Sprint 0. A "TO VERIFY" note is placed in LICENCES.md.  
**Why:** The quran.com API `/tafsirs/{id}` endpoint was not called in Sprint 0. Sprint 1 task is to query it and store the attribution.

---

## D10 — sqlite3_flutter_libs adds native .so; this is expected

**Decision:** `sqlite3_flutter_libs` adds native Android .so files, increasing APK size by ~2 MB. Accepted for Sprint 0.  
**Why:** The Drift DB requires a native SQLite library. On Android 9+ the OS provides SQLite 3.22+; this package ensures a modern version is always available.
