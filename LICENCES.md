# Licences and Attributions

All assets and data used by Zikra are recorded here. Cells marked **TO VERIFY** require legal confirmation before the app is published.

## Data Sources

| Asset | Source URL | Edition / Version | Licence | Redistribution allowed? | Notes |
|---|---|---|---|---|---|
| Quran Arabic text (Uthmani) | https://quran.com / https://tanzil.net | Currently from quran.com v4 API at runtime; target: Tanzil.net Uthmani v1.0.2 | TO VERIFY — Tanzil.net states "Free for non-commercial use with attribution" | TO VERIFY | Must not be user-editable. Sprint 1: bundle locally with SHA-256 check. |
| English translation (ID 131) | https://quran.com/translations/131 | Saheeh International | TO VERIFY — appears to be freely redistributable with attribution | TO VERIFY | Translator: Saheeh International. Not shown in UI yet — must add attribution in Sprint 1. |
| Tafsir (ID 169) | https://quran.com/tafsirs/169 | TO VERIFY (quran.com ID 169 — check author/book name via API /tafsirs endpoint) | TO VERIFY | TO VERIFY | Author and book title not yet displayed in UI. Sprint 1: display author/edition. |
| Hijri calendar calculations | https://pub.dev/packages/hijri | hijri ^3.0.0 (pub.dev) | BSD-2-Clause | Yes (with licence file) | See pub.dev page |
| OpenStreetMap tiles | https://tile.openstreetmap.org | OSM Standard layer | ODbL 1.0 (map data) + CC-BY-SA 2.0 (cartography) | Yes with attribution | Attribution "© OpenStreetMap contributors" must appear on any map view |
| Overpass API | https://overpass-api.de | Public instance | ODbL 1.0 | Yes (data under ODbL) | Do not hammer with high-frequency requests; cache results |

## Flutter / Dart Packages

All packages below are from pub.dev. Licences listed are as stated on pub.dev; verify via each package's LICENSE file before publishing.

| Package | Version | Licence (pub.dev stated) |
|---|---|---|
| flutter | SDK | BSD-3-Clause |
| cupertino_icons | ^1.0.8 | MIT |
| hijri | ^3.0.0 | BSD-2-Clause |
| geolocator | ^14.0.2 | MIT |
| geocoding | ^4.0.0 | MIT |
| shared_preferences | ^2.5.3 | BSD-3-Clause |
| flutter_map | ^7.0.2 | BSD-2-Clause |
| latlong2 | ^0.9.1 | Apache-2.0 |
| flutter_compass | ^0.8.1 | MIT |
| sensors_plus | ^6.1.1 | BSD-3-Clause |
| http | ^1.2.2 | BSD-3-Clause |
| flutter_riverpod | (added Sprint 0) | MIT |
| go_router | (added Sprint 0) | BSD-3-Clause |
| drift | (added Sprint 0) | MIT |
| drift_dev | (added Sprint 0 dev) | MIT |
| sqlite3_flutter_libs | (added Sprint 0) | MIT |
| build_runner | (added Sprint 0 dev) | MIT |
| path_provider | (added Sprint 0) | BSD-3-Clause |
| path | (added Sprint 0) | BSD-3-Clause |
| intl | (added Sprint 0) | BSD-3-Clause |
| flutter_lints | dev | BSD-3-Clause |
| flutter_test | SDK dev | BSD-3-Clause |

## Fonts

| Font | Source | Licence | Notes |
|---|---|---|---|
| Default Material font (Roboto) | Google Fonts via Material SDK | Apache-2.0 | Included automatically |
| Arabic Quranic font | TO VERIFY — not yet registered in pubspec | TO VERIFY | Must choose a certified Uthmani font (e.g. KFGQPC Uthmanic Script HAFS) in Sprint 1 |
| Sinhala font | TO VERIFY — not yet registered | TO VERIFY | Noto Sans Sinhala (Apache-2.0) is a good candidate |
| Tamil font | TO VERIFY — not yet registered | TO VERIFY | Noto Sans Tamil (Apache-2.0) is a good candidate |

## Action items before first public release

- [ ] Confirm Tanzil.net licence terms for bundled offline use
- [ ] Confirm Saheeh International (translation 131) redistribution terms
- [ ] Confirm tafsir ID 169 author, book, and licence
- [ ] Add OSM attribution overlay to every flutter_map instance
- [ ] Register and bundle Quranic, Sinhala, Tamil fonts with proper licence files
- [ ] Add in-app "Licences" page (Flutter's `LicensePage` widget)
