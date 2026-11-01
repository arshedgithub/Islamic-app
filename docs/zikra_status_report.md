# Zikra App — Full Audit Status Report

**Audit date:** 2026-11-01  
**Auditor:** Senior Flutter Engineer / QA  
**Repo path:** `c:\Users\AETURNUM\Documents\codemyteLabs\nafas`  
**Branch:** `feature/quran-api-integration`

---

## 1. Project Snapshot

### Versions

| Item | Value |
|---|---|
| Flutter | 3.41.1 (channel stable, 2026-02-12) |
| Dart | 3.11.0 |
| DevTools | 2.54.1 |
| App version | 1.0.0+1 |
| App name | `nafas` (not yet renamed to Zikra) |

### Architecture

| Concern | Choice | Evidence |
|---|---|---|
| State management | **Plain setState / ChangeNotifier** | `LocationCacheService extends ChangeNotifier` — no Riverpod/Bloc/Provider import found anywhere |
| Routing | **Navigator.push (imperative)** | `main_shell.dart:63,138` — `MaterialPageRoute` pushes, no GoRouter or AutoRoute |
| Local DB / persistence | **shared_preferences only** | `quran_bookmark_store.dart:3`, `hijri_notes_store.dart:2`, `location_cache_service.dart:4` |
| Backend | **REST — quran.com v4 API + Overpass API** | `quran_api_client.dart:12-13`, `mosque_repository.dart:9` |
| Localisation | **None** | No `flutter_localizations`, no `easy_localization`, no ARB files found |
| Notifications | **None** | No notification package in `pubspec.yaml` |
| Prayer-time calculation | **None** | `prayer_times.dart` is a stub screen with placeholder text |
| Qibla | `flutter_compass ^0.8.1` + `sensors_plus ^6.1.1` + `geolocator ^14.0.2` | `pubspec.yaml:43-45` |
| Audio | **None** | No audio package (just_audio, audioplayers, etc.) in `pubspec.yaml` |
| Maps | `flutter_map ^7.0.2` + `latlong2 ^0.9.1` | `pubspec.yaml:41-42` — used only for mosque map |

### Key Dependencies (pubspec.yaml)

```
hijri: ^3.0.0
geolocator: ^14.0.2
geocoding: ^4.0.0
shared_preferences: ^2.5.3
flutter_map: ^7.0.2
latlong2: ^0.9.1
flutter_compass: ^0.8.1
sensors_plus: ^6.1.1
http: ^1.2.2
cupertino_icons: ^1.0.8
```

No: Riverpod, Bloc, GoRouter, Drift/Isar/Hive, Supabase, Firebase, flutter_local_notifications, just_audio, in_app_purchase, flutter_localizations.

### flutter analyze result

```
7 issues found (all INFO, no errors or warnings).
- unnecessary_underscores (×2): hijri_calendar_screen.dart:241, nearby_mosques_screen.dart:158
- use_build_context_synchronously: hijri_calendar_screen.dart:478
- deprecated_member_use (DropdownButtonFormField.value, ×3): hijri_calendar_screen.dart:758,778,802
- deprecated_member_use (desiredAccuracy): nearby_mosques_screen.dart:48
```

### flutter test result

```
Test directory "test" does not appear to contain any test files.
```

No tests exist.

### Git History (last 16 commits)

| Hash | Date | Message |
|---|---|---|
| edb637d | 2026-09-04 | adding quran screen |
| d253b49 | 2026-02-24 | adding bookmark to verses |
| 7e54d26 | 2026-02-24 | adding Quran chapters to the quran tab |
| ca9cc5e | 2026-02-24 | add api calling from quran com |
| 67daa49 | 2026-02-24 | make navbar distinct |
| 2d73eb2 | earlier | adding Qibla compass |
| c4d8a15 | earlier | edit delete monthly notes |
| b1f9df0 | earlier | hijri calendar note |
| 9fd5a33 | earlier | hijri calendar added |
| 0e80a42 | earlier | enhance the design |
| 4d40847 | earlier | side menu with widget enhancing |
| bd2e987 | earlier | fetch location in city, country format |
| 75dd835 | earlier | fetching location and hijri date |
| 709bda0 | earlier | adding quran section |
| 3f45284 | earlier | creating main shell with nav widgets |
| 0dd6a1f | earliest | initial app |

**Last commit date:** 2026-09-04 (edb637d)

### Overall Completion Estimate

**~9 %**

Calculation: 22 features scored 0 (NOT STARTED), 1 (STUB), 2 (UI ONLY), 3 (PARTIAL), or 4 (DONE). Weighted sum ÷ (22 × 4):

| Status | Count | Weight |
|---|---|---|
| DONE | 0 | 0 |
| PARTIAL | 3 (F6, F11, F15) | 3 × 2 = 6 |
| UI ONLY | 2 (F2, F14) | 2 × 1 = 2 |
| STUB | 4 (F3, F4, F9, F10) | 0 |
| NOT STARTED | 13 (F1,F5,F7,F8,F13,F16,F17,F18,F19,F20,F21,F22 + sub-parts) | 0 |

Total weighted: 8 / 88 = **9.1 %**

---

## 2. Feature Status Table

| ID | Feature | Status | Evidence (paths : lines) | What is missing | Effort |
|---|---|---|---|---|---|
| F1 | Onboarding | NOT STARTED | No onboarding screen anywhere in `lib/`. App launches directly into `MainShell` (`app.dart:10` → `main_shell.dart:13`). | Everything: language choice, niyyah, level, prayer-method, reminder permission, first-win, optional account. | L |
| F2 | Today screen | UI ONLY | Home tab (`main_shell.dart:38-58`) shows 3 hard-coded cards: "Next Prayer · Dhuhr in 01:42", "Streak · 7 days consistency", "Reminders · 2 active reminders". `HomeHijriLocationCard` (`home_hijri_location_card.dart`) shows real Hijri date and GPS location. | Live prayer countdown, wird card, ayah of day, quick zikr tap, evening reflection, time-of-day logic. All data is static. | L |
| F3 | Zikr counter | STUB | "Tasbih – Digital tasbih counter" entry in Guidance tab (`main_shell.dart:88-92`) shows a snackbar "Tasbih coming soon" when tapped (`main_shell.dart:158`). No counter screen exists. | Everything: tap area, progress ring, haptics, milestones, undo, hold-to-reset, wake-lock, home widget, persistence. | M |
| F4 | Zikr library and paths | NOT STARTED | "Adhkar – Morning and evening adhkar" and "Duas – Curated daily duas" entries exist in Guidance tab (`main_shell.dart:74-81`) as stubs that show "coming soon" snackbar. No dhikr model, data source, or screen. | Arabic text, transliteration, translation, source ref, custom dhikr, guided paths. | L |
| F5 | Wird and habits | NOT STARTED | No wird/habit screen, model, or data layer. | All tiers, adaptive suggestions, missed-day recovery, weekly reflection, weekly ayah journey. | L |
| F6 | Quran reader | PARTIAL | `quran_screen.dart` (692 lines) fetches chapters and verses from `api.quran.com/api/v4` via `QuranApiClient`. Chapters list, chapter drawer, verse-by-verse and page-by-page display views, inline translation and tafsir toggles all exist. Missing: offline-first (no local DB; fails with no internet), no "continue where left off", no font/size settings, no search, no Uthmani/IndoPak script switching (always requests `text_uthmani`), Juz tab is a placeholder (`quran_screen.dart:544`), Playlists tab is a placeholder (`quran_screen.dart:600`). | Offline cache, last-position persistence, font/theme settings, search, script switching, Juz view. | L |
| F7 | Word-by-word | NOT STARTED | `QuranVerse` model (`quran_verse.dart`) has no word-level data. API call (`quran_api_client.dart:36`) sets `words=false`. No WbW sheet or word model. | All: word tap, meaning sheet, per-language data, transliteration. | L |
| F8 | Translations and languages | NOT STARTED | No localisation package, no ARB/JSON locale files, no language switch. Translation in the Quran reader is hard-coded to English (translation ID 131 = Sahih International) via `quran_api_client.dart:36`. UI is English only. No Arabic, Sinhala, or Tamil fonts registered. | UI localisation, Sinhala/Tamil translations, RTL support, font registration, independent language settings. | L |
| F9 | Tafseer | STUB | Tafsir text is fetched from quran.com API (`quran_api_client.dart:36`: `tafsirs=169`) and displayed inline (`quran_screen.dart:526-533`). However: tafsir ID 169 corresponds to a single tafseer only, author/book label is not displayed, offline storage absent, no multi-source selection. | Author/book/language labels, multiple classical sources, offline availability. | M |
| F10 | Audio | NOT STARTED | No audio package in `pubspec.yaml`. "Playlists coming soon" placeholder (`quran_screen.dart:600-601`). | Recitation player, reciters, word highlighting, repeat, speed, offline download. | L |
| F11 | Personal tools | PARTIAL | Quran verse bookmarks exist end-to-end: `QuranBookmark` model (`quran_bookmark.dart`), `QuranBookmarkStore` (shared_preferences, `quran_bookmark_store.dart`), add/delete/note dialog and bookmarks tab (`quran_screen.dart:286-320, 548-597`). Missing: private notes (dialog accepts free text but stores it alongside Arabic text, not separately), no highlights, no collections, no reading plan / khatm tracker. | Notes as separate entity, highlights, collections, khatm planner. | M |
| F12 | Daily and weekly verse | NOT STARTED | No daily/weekly verse screen, service, or data source. The static home card is the only hint. | Curated source, context note, "read in context" link, theme preferences. | M |
| F13 | Reminders / notifications | NOT STARTED | No notification package (`flutter_local_notifications` etc.) in `pubspec.yaml`. Notification bell icon in AppBar (`main_shell.dart:169`) shows "Notifications coming soon" snackbar. Android manifest has no `SCHEDULE_EXACT_ALARM`, `USE_EXACT_ALARM`, or `RECEIVE_BOOT_COMPLETED` permissions. iOS `Info.plist` has no `NSUserNotificationUsageDescription` key. | Everything. | L |
| F14 | Prayer times | UI ONLY | `prayer_times.dart` is a standalone stub widget (`PrayerScreen`) that is never reachable from the UI (the main shell's Prayers tab is `_PrayersTabContent`, not `PrayerScreen`). Prayers tab (`main_shell.dart:222-231`) shows 6 hard-coded rows (Fajr 05:01 AM … Isha 07:31 PM) with no dynamic computation. | On-device calculation, methods, ACJU preset, Asr Hanafi/Standard, offsets, high-latitude, Ramadan, offsets, method display. | L |
| F15 | Qibla | PARTIAL | `QiblaScreen` (`qibla_screen.dart`, 462 lines) uses `flutter_compass`, `geolocator`, `sensors_plus`. Implements: GPS Kaaba bearing (lat 21.4225°N, lon 39.8262°E at lines 25-26), rotating compass ring with N/E/S/W labels, accelerometer flat-surface detection, compass reliability check, stable-sample locking (turns arrow green), calibration prompt (figure-8 instructions), retry-compass button, location permission handling, error states. Missing: alignment haptic on lock, map view, no offline fallback if location unavailable for first time (bearing requires GPS). | Alignment haptic, map view for orientation reference. | S |
| F16 | Multaqa Tadabbur community | NOT STARTED | No community screen, post model, or backend tables. | Everything: post composer, verse-anchored posts, reactions, replies, circles, feed, backend. | L |
| F17 | Moderation and safety | NOT STARTED | No report flow, admin tools, trust levels, or code-of-adab text. | Everything. | L |
| F18 | Accounts, sync and privacy | NOT STARTED | Account icon in AppBar (`main_shell.dart:179`) shows "Profile coming soon" snackbar. No auth package, no sync, no export. | Everything. | L |
| F19 | Design system and UX quality | PARTIAL | Single `AppTheme.lightTheme` defined (`theme.dart`). Uses Material 3 (`useMaterial3: true`), consistent color tokens (primary, secondary, tertiary, containers), rounded 14dp cards, `NavigationBar`. Missing: dark/sepia/OLED themes, Semantic labels on interactive widgets, reduced-motion support, custom typography per script, any registered custom fonts, empty-state illustrations, verified 48 dp touch targets (some icon buttons use `visualDensity: horizontal: -2, vertical: -2` shrinking them below 48 dp). | Dark/OLED/sepia themes, RTL layout directionality, custom fonts, Semantics wrappers, empty-state screens, touch-target audit. | M |
| F20 | Monetisation | NOT STARTED | No in_app_purchase package, no paywall screen, no Zikra Plus gating. No ads SDK. | Billing integration, restore purchases, feature gating. | L |
| F21 | Content integrity | NOT STARTED | Quran text sourced from `api.quran.com/api/v4` at runtime (`quran_api_client.dart:13`). No local verified database, no version/checksum, no licence file, translator edition not displayed to user, no "Report an error" action. Translation ID 131 (Sahih International) and tafsir ID 169 hardcoded, neither attributed in UI. | Local verified Quran DB, version/checksum, translator attribution in UI, error reporting, licence records. | L |
| F22 | Engineering quality | NOT STARTED | Zero test files. No CI config (no `.github/`, no `.gitlab-ci.yml`). No crash reporting package (Sentry, Firebase Crashlytics). No logging service. Secrets: no API keys committed (quran.com and Overpass are keyless public APIs). `shared_preferences` is used as the sole persistence layer — not suitable for large Quran data. No performance profiling. | Tests (unit/widget/integration), CI pipeline, error/crash reporting, logging, offline-first data layer. | L |

---

## 3. Top 10 Risks and Defects (by Severity)

### R1 — CRITICAL: Quran data is 100% online-only with no local DB

**Severity:** Critical  
**File:** `lib/features/quran/data/quran_api_client.dart:12-70`, `quran_repository.dart:12-14` (memory-only in-session cache)  
**Risk:** The app violates its own "offline-first" principle for its most important feature. With no internet, the entire Quran reader shows an error. There is no local SQLite/Drift database of Quran text. The repository has a memory cache (`_chaptersCache`, `_versesCache`) that survives a screen navigation within one session, but is lost on app restart.  
**Impact:** User cannot read Quran on a plane, in a rural area, or after data runs out. This is a non-negotiable MVP blocker.

---

### R2 — CRITICAL: No verified, locally-stored Quran text — source integrity not guaranteed

**Severity:** Critical  
**File:** `quran_api_client.dart:36` (API URL with no versioning or checksum), `quran_verse.dart:19-24` (arbitrary fallback to `text_imlaei`, `text_indopak`, `text_simple`)  
**Risk:** Quran Arabic text is fetched from a third-party API at runtime. There is no local verification, no SHA-256 or version check, no comparison against a certified mushaf. If the API returns incorrect, corrupted, or tampered text, it is displayed to the user with no warning. The `fromJson` fallback chain (line 20-25) can silently display a simplified (`text_simple`) rendering instead of the Uthmani script. No licence or edition metadata is stored.

---

### R3 — CRITICAL: No notifications/reminders infrastructure at all

**Severity:** Critical  
**File:** `pubspec.yaml` (no flutter_local_notifications), `android/app/src/main/AndroidManifest.xml` (no SCHEDULE_EXACT_ALARM or RECEIVE_BOOT_COMPLETED), `ios/Runner/Info.plist` (no notification usage description)  
**Risk:** Core loop of the app (wird reminders, prayer adhan) cannot function. On Android 12+ exact alarms require explicit permission declaration and user grant. On iOS, local notifications require `NSUserNotificationUsageDescription` and the permission request UI. Neither is set up.

---

### R4 — HIGH: Prayer times are hard-coded mock data

**Severity:** High  
**File:** `lib/core/main_shell.dart:222-231`  
**Risk:** The Prayers tab displays static times (Fajr 05:01 AM, Isha 07:31 PM, etc.) that are the same for every user in every location, every day. A user relying on this for prayer will pray at the wrong time. The `PrayerScreen` stub (`prayer_times.dart`) is never rendered — it is a dead file.

---

### R5 — HIGH: "Streak" language present in UI

**Severity:** High  
**File:** `lib/core/main_shell.dart:47-49`  
**Risk:** The Home tab contains a hard-coded card: "Streak — 7 days consistency" with a fire icon. This directly contradicts the app's stated principle of "no streak guilt". Although it is currently fake/static data, it sets a design precedent that conflicts with the Zikra mission.

---

### R6 — HIGH: Quran text stored in bookmarks with full arabicText copied into shared_preferences

**Severity:** High  
**File:** `lib/features/quran/domain/quran_bookmark.dart:7`, `quran_bookmark_store.dart:29`  
**Risk:** Every bookmark serialises the full `arabicText` string into SharedPreferences JSON. This means user-created notes exist alongside copied API data. While users cannot directly edit the Arabic (no TextField for it), the Quran text in a bookmark is snapshot data that could diverge from the authoritative source if the API changes. Per the app's principles, notes should store only a verse key (`surah:ayah`) and look up text from the verified DB at read time. Currently `verseKey` is stored alongside copied `arabicText`.

---

### R7 — HIGH: No offline fallback for mosque finder — uses OpenStreetMap tile layer requiring internet

**Severity:** High  
**File:** `lib/features/mosques/presentation/nearby_mosques_screen.dart:110-116`  
**Risk:** The mosque map uses `TileLayer` with `urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'`. No offline tile caching. Overpass API call also requires internet. If offline, the user sees a grey map and a timeout error.

---

### R8 — MEDIUM: use_build_context_synchronously violation

**Severity:** Medium  
**File:** `lib/features/hijri/presentation/hijri_calendar_screen.dart:478`  
**Risk:** BuildContext is used across an `await` gap after an `if (!mounted) return` guard that is not the immediate predecessor. `flutter analyze` flags this. On fast unmounts (e.g. navigating away during the save operation), this can throw a `FlutterError: setState() called after dispose()` or incorrectly mutate context.

---

### R9 — MEDIUM: Mosque Overpass query capped at 12 km despite UI claiming 40 km

**Severity:** Medium  
**File:** `lib/features/mosques/data/mosque_repository.dart:18-20`  
**Risk:** `_maxOverpassQueryKm = 12` but `NearbyMosquesScreen` passes `maxKm: 40`. The code silently caps the API query at 12 km (`queryKm = math.min(maxKm, _maxOverpassQueryKm)`), but the `_toSortedDistances` filter uses the original `maxKm` value (40 km). The status message will say "X mosques found nearby" but will never show mosques between 12–40 km that it told the user it was searching for. This is misleading.

---

### R10 — MEDIUM: Some icon buttons shrunk below 48 dp touch target

**Severity:** Medium  
**File:** `lib/features/quran/presentation/quran_screen.dart:368-380`  
**Risk:** IconButtons in the verse list toolbar use `visualDensity: VisualDensity(horizontal: -2, vertical: -2)`, which reduces hit area below the Material 3 / WCAG recommended 48 × 48 dp minimum. On small-screen or motor-impaired users this creates accessibility barriers.

---

## 4. Gap List vs. Plan

### MVP Blockers (F1–F15, F18, F19, F21)

These must exist for a trustworthy MVP:

| Feature | Current | Gap |
|---|---|---|
| F1 Onboarding | NOT STARTED | Full onboarding flow: language, niyyah, level, prayer method, reminder permissions, first win |
| F2 Today screen | UI ONLY | Real prayer countdown, wird card, ayah of day, time-of-day logic |
| F3 Zikr counter | STUB | Full counter with persistence, haptics, milestones |
| F4 Zikr library | NOT STARTED | Dhikr data source (local), all collections, Arabic+transliteration+translation |
| F5 Wird/habits | NOT STARTED | Habit tracking, tiers, recovery logic |
| F6 Quran reader | PARTIAL | Local offline DB (critical), search, continue reading, font settings, Juz view |
| F7 Word-by-word | NOT STARTED | WbW data, word-tap sheet, per-language support |
| F8 Translations/languages | NOT STARTED | flutter_localizations, Sinhala/Tamil translations and fonts, language settings |
| F9 Tafseer | STUB | Author/book labels, multiple sources, offline storage |
| F10 Audio | NOT STARTED | Audio package, recitation, reciters, offline download |
| F11 Personal tools | PARTIAL | Highlights, collections, khatm planner |
| F12 Daily/weekly verse | NOT STARTED | Curated verse source, context note, read-in-context |
| F13 Reminders | NOT STARTED | Notification package, platform permissions, quiet hours, exact alarm |
| F14 Prayer times | UI ONLY | On-device calculation (adhan/prayer-times package), methods, ACJU preset |
| F15 Qibla | PARTIAL | Alignment haptic, map view (functionally 85% done) |
| F18 Accounts/sync | NOT STARTED | Auth (optional), cloud sync, data export, account delete |
| F19 Design system | PARTIAL | Dark/OLED/sepia themes, fonts, accessibility (Semantics), empty states |
| F21 Content integrity | NOT STARTED | Local verified Quran DB, checksum, attribution displayed, licences recorded |

### Can Wait (F16, F17, F20)

| Feature | Rationale |
|---|---|
| F16 Multaqa Tadabbur | Requires backend, auth, and content moderation to all be stable first. Community without trust infra is risky. |
| F17 Moderation | Depends on F16. No community, no moderation needed yet. |
| F20 Monetisation | Core must be free and stable before introducing billing. |

---

## 5. Recommended Next 10 Tasks (Build Order)

### T1 — Bundle local Quran data (offline-first foundation)
Download verified Quran text (Uthmani script, `text_uthmani`) from quran.com or Tanzil.net, store as a SQLite/Drift database bundled as a Flutter asset. Write an integrity test: checksum the full database on first launch and compare against a committed SHA-256 hash.  
**Acceptance test:** App opens with airplane-mode on; Al-Fatiha reads correctly in Arabic with zero network requests.

### T2 — On-device prayer time calculation
Add `adhan` Dart package (or equivalent). Wire `PrayerTimes` to user coordinates, chosen method, and Asr convention. Replace the 6 hard-coded rows in `_PrayersTabContent`. Show next-prayer countdown on the Home tab.  
**Acceptance test:** For Colombo, Sri Lanka (6.9271°N, 79.8612°E) on any given date, the computed Fajr/Dhuhr/Asr/Maghrib/Isha times match the ACJU published timetable within ±1 minute.

### T3 — Complete Qibla + remove streak card
Add `HapticFeedback.lightImpact()` when `_isDirectionLocked` transitions to true. Replace the static "Streak – 7 days consistency" Home card with the real next-prayer countdown widget from T2. Optionally add a static map marker showing Kaaba direction.  
**Acceptance test:** In a screen recording, the arrow turns green and phone vibrates exactly once when the user holds the phone flat and steady; the Home tab shows no "Streak" text.

### T4 — Offline Quran reader: persist last position, search, font settings
Add `shared_preferences` key `quran_last_chapter_id`. On reader open, restore to last chapter. Add a search bar that filters verses diacritics-insensitively (strip tashkeel). Add a font-size slider stored in prefs.  
**Acceptance test:** User reads Al-Baqara verse 255, closes app, reopens — reader opens on Al-Baqara; searching "kursi" returns 2:255.

### T5 — Word-by-word data layer
Change `quran_api_client.dart` to set `words=true` and parse the word objects into a `QuranWord` model. Build a word-tap bottom sheet showing Arabic word, transliteration, and English gloss. Store WbW data in the local Drift DB from T1.  
**Acceptance test:** Tapping any word in Surah Al-Ikhlas shows a bottom sheet with correct Arabic, transliteration, and English meaning within 200 ms with no network call.

### T6 — Notifications and reminders infrastructure
Add `flutter_local_notifications`. Declare `SCHEDULE_EXACT_ALARM`, `RECEIVE_BOOT_COMPLETED` in AndroidManifest.xml. Add `NSUserNotificationUsageDescription` to Info.plist. Build `NotificationService` with: schedule-for-prayer, quiet-hours check, daily-cap enforcement. Show the permission value screen before requesting.  
**Acceptance test:** User enables Fajr reminder; background process fires a notification at the calculated Fajr time (within ±1 min) even after device restart.

### T7 — Local dhikr library (F4)
Create a JSON/Dart data file with at minimum: morning/evening adhkar, after-prayer, istighfar, salawat — each with Arabic, transliteration, English translation, count, and source reference (book + hadith). Build `DhikrLibraryScreen` and a `DhikrCounterScreen` that replaces the stub. Persist session counts in shared_preferences.  
**Acceptance test:** "Morning adhkar" collection shows all canonical morning adhkar in Arabic with transliteration; completing a dhikr persists its count through app restart.

### T8 — Wird/habits framework (F5)
Design `WirdEntry` model with `tier` (Tiny/Steady/Deep), `completedDays` list. Build `WirdScreen` showing today's wird items with checkboxes. Persist to local DB. Show "missed-day recovery" UI that uses neutral language (e.g. "Pick up where you left off") — never "missed" or "broken".  
**Acceptance test:** User completes two wird items; closes app; reopens — items still marked complete; UI contains no string matching "streak", "missed", or "broken".

### T9 — Onboarding flow (F1)
Build a multi-step `OnboardingScreen`: (1) welcome + language choice, (2) niyyah intention, (3) starting level, (4) location + prayer method, (5) reminder permission with context shown first, (6) first-win micro-action (one dhikr tap). Skip on subsequent launches using a prefs flag. Optional account screen after first win.  
**Acceptance test:** Fresh install shows onboarding; after completion, `prefs.getBool('onboarding_complete')` is `true`; reinstall shows onboarding again.

### T10 — Content attribution and integrity tests (F21)
Add a `LICENCES.md` recording source URL, edition, version, and licence for: Quran text, each translation, each tafseer, Hijri library, and all fonts. Display translator name and edition on the Quran reader info sheet. Add a unit test that loads the bundled Quran DB and verifies: 114 chapters, total verses = 6236, SHA-256 of the DB file matches committed constant.  
**Acceptance test:** `flutter test` passes with a test named `quran_integrity_test` that verifies chapter count (114), verse count (6236), and DB checksum.

---

## 6. Manual Test Checklist (Real Device)

Features marked PARTIAL or UNVERIFIED require device testing. All features require a test since `flutter test` returns zero tests.

### Android Device Tests

**Setup:** Pixel 6 or equivalent, Android 13+; test once with full internet, once in airplane mode.

| # | Test | Expected | Feature |
|---|---|---|---|
| A1 | Open app in airplane mode | Home tab loads; Hijri date and cached location shown; no crash | F2, F19 |
| A2 | Tap Prayers tab | 6 hard-coded prayer times displayed (document exact times) | F14 (documents current broken state) |
| A3 | Tap "Find Qibla" | QiblaScreen opens; after location permission, bearing displayed; place phone flat and steady for 10 s — arrow should turn green | F15 |
| A4 | Tap "Retry compass" after forcing unreliable state | Status message updates; arrow resumes tracking | F15 |
| A5 | Open Quran tab → select Al-Fatiha | 7 verses in Arabic render correctly; no extra spaces or garbling | F6 |
| A6 | Open Quran tab in airplane mode | Error message shown; no crash | F6 |
| A7 | Toggle translation on a verse | English translation (Sahih International) appears below Arabic text | F6, F9 |
| A8 | Toggle tafsir on a verse | Tafsir text appears; check for HTML artefacts (`<sup>`, `<br>` etc.) | F9 |
| A9 | Bookmark a verse, add a note, restart app | Bookmark persists; note text preserved | F11 |
| A10 | Delete a bookmark | Bookmark removed; list updates immediately | F11 |
| A11 | Open Hijri Calendar | Current Hijri month grid shown; today highlighted | — |
| A12 | Add a note on a future Hijri date | Note saved; appears in month notes list as "Upcoming" | — |
| A13 | Edit and delete a Hijri note | CRUD operations persist through restart | — |
| A14 | Open "Mosques near me" | Map loads with current location blue dot; mosque pins visible | — |
| A15 | Open "Mosques near me" in airplane mode | Error state shown; no crash; no indefinite spinner | — |
| A16 | Tap any Guidance or Tools stub entry | Snackbar "coming soon" appears; no crash | — |
| A17 | Rotate device to landscape | Layout adapts without overflow errors | F19 |
| A18 | Enable large text in Android accessibility → open app | Text does not overflow cards; layout readable | F19 |
| A19 | Tap Location chip in HomeHijriLocationCard → deny permission | Snackbar with Settings link appears | — |

### iOS Device Tests

| # | Test | Expected | Feature |
|---|---|---|---|
| I1 | Open app fresh (no location permission) | "Locating…" shown; no crash on permission request | — |
| I2 | Grant location → Qibla screen | Compass ring shown; bearing calculated | F15 |
| I3 | Deny location → Qibla screen | "Location permission required for Qibla" message; no crash | F15 |
| I4 | Quran reader: load Al-Baqara (286 verses) | All verses load; no UI jank on scroll | F6 |
| I5 | Switch to page-by-page mode | Pages render; verses filtered to correct chapter | F6 |
| I6 | Bookmark, restart, check bookmarks tab | Bookmark persists (SharedPreferences works on iOS) | F11 |
| I7 | Mosques near me — map tiles load | OSM tiles render; no crash from flutter_map on iOS | — |
| I8 | Switch between all 5 nav tabs rapidly | No memory spike; no blank screens | F19 |
| I9 | Use VoiceOver on Quran verse list | Each verse row is announced meaningfully (currently likely announces just "button") | F19 |

---

## 7. Items That Could Not Be Inspected

| Item | Reason |
|---|---|
| Actual prayer time accuracy | `flutter test` has no tests; no adhan package is present; prayer time computation does not exist yet. Cannot verify against a reference timetable. |
| Quran text correctness | Text is fetched from quran.com API at runtime. No local copy exists to verify against a certified mushaf. |
| App size / performance on low-end Android | Cannot run on a real device in this audit. |
| Offline compass sensor behaviour | Compass requires physical gyroscope/magnetometer. Cannot test heading values or lock behaviour without a device. |
| OpenStreetMap tile caching on device | Tile caching behaviour of `flutter_map` depends on runtime cache configuration; no cache config was found in the code. |
| Push/background notifications | No notification package exists; cannot test exact-alarm behaviour or background scheduling. |
| `DropdownButtonFormField` deprecation fix effect | `flutter analyze` reports `deprecated_member_use` for `value` parameter; changing to `initialValue` should be tested for visual regression. |
| `pubspec.lock` dependency resolution on a clean machine | `pubspec.lock` (20002 bytes) lists resolved transitive deps; not read line by line; no known conflict spotted but full resolution untested. |
