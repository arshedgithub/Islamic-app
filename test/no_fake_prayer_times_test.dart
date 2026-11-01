/// Ensures no hard-coded HH:MM prayer times appear in lib/ Dart source.
/// A hardcoded time next to a prayer name (e.g. "Fajr 05:01 AM") is a product
/// bug: it will show wrong times to every user in every timezone, every day.
library;

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

// Clock-time pattern: digits:digits followed by optional AM/PM
final _timePattern = RegExp(r'\b\d{1,2}:\d{2}(?:\s*[AaPp][Mm])?\b');

// Prayer names to look for alongside a time literal on the same line.
const _prayerNames = [
  'fajr',
  'dhuhr',
  'zuhr',
  'asr',
  'maghrib',
  'isha',
  'sunrise',
  'sunset',
];

void main() {
  test('no hard-coded prayer time literals (HH:MM) in lib/ Dart files', () {
    final dartFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));

    final violations = <String>[];

    for (final file in dartFiles) {
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (!_timePattern.hasMatch(line)) continue;

        final lower = line.toLowerCase();
        final nearPrayer = _prayerNames.any(lower.contains);
        if (nearPrayer) {
          violations.add(
            '${file.path}:${i + 1}\n  > ${line.trim()}',
          );
        }
      }
    }

    if (violations.isNotEmpty) {
      fail(
        'Found ${violations.length} hard-coded prayer-time literal(s):\n\n'
        '${violations.join('\n\n')}\n\n'
        'Replace with computed values from an adhan/prayer-times package.',
      );
    }
  });
}
