import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

// Sprint 0 schema — one key/value table for app settings.
// Sprint 1 will add chapters, verses, words, translations, tafsir.
class AppMetaTable extends Table {
  @override
  String get tableName => 'app_meta';

  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(tables: [AppMetaTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  // Upsert a meta key/value pair.
  Future<void> setMeta(String key, String value) =>
      into(appMetaTable).insertOnConflictUpdate(
        AppMetaTableCompanion.insert(key: key, value: value),
      );

  // Read a meta value; returns null if the key does not exist.
  Future<String?> getMeta(String key) async {
    final row = await (select(appMetaTable)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'zikra.db'));
    return NativeDatabase.createInBackground(file);
  });
}
