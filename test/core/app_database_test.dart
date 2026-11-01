import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zikra/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  test('AppDatabase: insert and read an app_meta row', () async {
    await db.setMeta('theme', 'light');
    final value = await db.getMeta('theme');
    expect(value, 'light');
  });

  test('AppDatabase: getMeta returns null for a missing key', () async {
    final value = await db.getMeta('nonexistent');
    expect(value, isNull);
  });

  test('AppDatabase: setMeta upserts correctly', () async {
    await db.setMeta('locale', 'en');
    await db.setMeta('locale', 'si');
    final value = await db.getMeta('locale');
    expect(value, 'si');
  });
}
