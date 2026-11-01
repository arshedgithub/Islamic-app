import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/app_database.dart';
import 'services/location_cache_service.dart';
import '../features/quran/data/quran_bookmark_store.dart';
// Provides the single AppDatabase instance for the app lifetime.
final appDatabaseProvider = Provider<AppDatabase>(
  (ref) {
    final db = AppDatabase();
    ref.onDispose(db.close);
    return db;
  },
);

// Exposes LocationCacheService without rewriting its internals.
final locationCacheServiceProvider = Provider<LocationCacheService>(
  (_) => LocationCacheService.instance,
);

// Exposes QuranBookmarkStore singleton.
final quranBookmarkStoreProvider = Provider<QuranBookmarkStore>(
  (_) => QuranBookmarkStore.instance,
);

// Async provider that initialises SharedPreferences once.
final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (_) => SharedPreferences.getInstance(),
);
