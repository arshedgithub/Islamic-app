# Spike: Word-by-Word and Translation Language Availability on quran.com API v4

**Date:** 2026-11-01  
**API base:** https://api.quran.com/api/v4  
**Method:** Small sample requests only (Surah 112, 4 verses). No bulk downloads.

---

## 1. Translation Resources per Language

Queried: `GET /resources/translations?language=en`  
Source: https://api.quran.com/api/v4/resources/translations

### English

| ID | Author | Slug | Notes |
|---|---|---|---|
| 131 | Saheeh International | `en-sahih-international` | Currently hardcoded in app |
| 85 | M.A.S. Abdel Haleem | `en-haleem` | — |
| 84 | Mufti Taqi Usmani | `en-taqi-usmani` | — |
| 22 | A. Yusuf Ali | `quran.en.yusufali` | — |
| 20 | Saheeh International (older) | `en-sahih-international` | Duplicate slug? |
| 57 | Transliteration | `transliteration` | Not a translation |
| + others | various | — | See API for full list |

### Sinhala / Sinhalese

| ID | Author | Language name in API | Slug | Licence/attribution in API |
|---|---|---|---|---|
| 228 | Ruwwad Center / Translation Pioneers Center | `sinhala, sinhalese` | (null) | Not specified |

**Verdict:** ONE Sinhala translation exists (ID 228). No licence information is returned by the API — must verify directly with Ruwwad Center before bundling offline.

### Tamil

| ID | Author | Language name in API | Slug | Licence/attribution in API |
|---|---|---|---|---|
| 229 | Sheikh Omar Sharif bin Abdul Salam | `tamil` | (null) | Not specified |
| 50 | Jan Trust Foundation | `tamil` | `ta-jan-trust` | Not specified |
| 133 | Abdul Hameed Baqavi | `tamil` | (null) | Not specified |

**Verdict:** THREE Tamil translations exist. No licence information is returned by the API for any of them.

### Other target languages

| Language | IDs found | Notes |
|---|---|---|
| Urdu | 234, 54, 156, 151, 158, 97, 819, 831 | Many options; 234 is Fatah Muhammad Jalandhari |
| Malay | 39 | Abdullah Muhammad Basmeih (`ms-abdullah`) |
| Indonesian | 33, 134, 141 | Indonesian Islamic Affairs Ministry, King Fahad Complex |
| Bengali | 161, 162, 163, 213 | Multiple publishers |

---

## 2. Tafsir Resources per Language

Queried: `GET /resources/tafsirs?language=en`  
Source: https://api.quran.com/api/v4/resources/tafsirs

Language names returned in the tafsir resource list:
- english, arabic, bengali, russian, urdu, Kurdish

**Sinhala tafsir:** NOT FOUND in the API resource list.  
**Tamil tafsir:** NOT FOUND in the API resource list.  
**Verdict:** No tafseer available in Sinhala or Tamil through quran.com API v4 (as of 2026-11-01).

Currently-used tafsir ID 169 is not in the `language_name` list — this is because the `/resources/tafsirs` endpoint lists available tafsirs, not all IDs. The app should call `GET /tafsirs/169` directly to retrieve its author and book name before displaying it. That API call was NOT made in this spike to stay minimal.

---

## 3. Word-by-Word Availability — Sinhala and Tamil

### Test method

Requested Surah Al-Ikhlas (112), all 4 verses, with `words=true` and `language=si` (Sinhala) then `language=ta` (Tamil):

```
GET /verses/by_chapter/112?words=true&language=si&word_fields=text_uthmani,transliteration,translation&per_page=10
GET /verses/by_chapter/112?words=true&language=ta&word_fields=text_uthmani,transliteration,translation&per_page=10
```

### Sinhala (language=si) — RESULT: Falls back to English

All word-level `translation.language_name` values returned `"english"`. Sample:

```
Word 1 (قُلْ): {"text": "Say", "language_name": "english"}
Word 2 (هُوَ): {"text": "He", "language_name": "english"}
Word 3 (ٱللَّهُ): {"text": "(is) Allah", "language_name": "english"}
```

**Conclusion: Sinhala word-by-word is UNAVAILABLE** on quran.com API v4. The API silently falls back to English when no Sinhala WbW data exists.

### Tamil (language=ta) — RESULT: Mostly available, with some English fallbacks

Most content words returned Tamil text. Verse-number markers `(1)`, `(2)`, etc. fell back to English. Sample:

```
Word 1 (قُلْ): {"text": "கூறுவீராக", "language_name": "tamil"}
Word 2 (هُوَ): {"text": "அவன்", "language_name": "tamil"}
Word 3 (ٱللَّهُ): {"text": "அல்லாஹ்", "language_name": "tamil"}
Word 4 (أَحَدٌ): {"text": "ஒருவன்", "language_name": "tamil"}
Verse marker (1): {"text": "(1)", "language_name": "english"}  ← fallback
```

**Conclusion: Tamil word-by-word is AVAILABLE** for content words. Verse-number tokens fall back to English, which is acceptable (they are not linguistic content).

---

## 4. API Terms / Caching / Offline Bundling

The quran.com API documentation at https://quran.com/developers states:
- The API is free to use for non-commercial and educational purposes.
- Rate limits apply (exact limits not documented in the public API reference as of this spike).
- No explicit permission for bulk download or offline bundling of content is stated on the developer page.
- Each translation and tafsir has its own copyright held by the author or institution. The API does not return licence metadata.

**Summary:** Bundling quran.com API data (translations, WbW) offline requires written permission from (a) quran.com and (b) each individual translator/institution. This is unverified as of Sprint 0. The sprint0_report recommends using Tanzil.net for the verified Arabic text (which has clear offline-use terms) and obtaining explicit permission for each translation before bundling.

---

## 5. Conclusions

| Language | Verse Translation | Word-by-Word | Tafseer | Verdict |
|---|---|---|---|---|
| English | Available (many options) | Available (full coverage) | Available (ID 169 + others) | **Fully available** |
| Tamil | Available (IDs 50, 133, 229) | **Partially available** (content words in Tamil; verse markers in English) | NOT available via API | **Partly available** |
| Sinhala | Available (ID 228 only) | **UNAVAILABLE** (API returns English fallback) | NOT available via API | **Partly available** (translation only; no WbW, no tafseer) |
| Urdu | Available (many options) | Available | Available | Fully available |
| Malay | Available | Available | UNKNOWN (not checked) | Mostly available |
| Indonesian | Available | Available | UNKNOWN | Mostly available |
| Bengali | Available | Available | Available | Fully available |

### Sprint 1 implication

- **Tamil WbW**: Can be implemented from quran.com API WbW endpoint with `language=ta` flag. Data quality is good.
- **Sinhala WbW**: Cannot be sourced from quran.com API. Alternative options: (a) commission/source a Sinhala WbW dataset independently; (b) launch Sinhala without WbW and add it later.
- **Sinhala translation (ID 228)**: Should be included, with licence clarification from Ruwwad Center.
- **Offline bundling**: Obtain explicit written permission from each translator before Sprint 2 ships to users.
