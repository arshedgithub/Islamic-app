/// Scans all Dart source files under lib/ and all ARB files under lib/l10n/
/// for user-visible strings that contain guilt, fear, streak-pressure, or
/// comparison language. Fails fast on any match outside the allowlist.
library;

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

// ─── Banned patterns (case-insensitive) ───────────────────────────────────────
const _bannedPatterns = [
  'streak',
  'leaderboard',
  'you missed',
  'broken',
  'falling behind',
];

// ─── Allowlist ────────────────────────────────────────────────────────────────
// Each entry is a substring that justifies a match.  Add entries only after
// team review; include a reason comment.
const _allowlist = <String>[
  // Example: 'broken' appears in a technical error message, not guilt language.
  // 'Unable to track location updates',
];

void main() {
  test('no guilt / streak / comparison language in lib/ Dart files', () {
    final dartFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));

    final violations = <String>[];

    for (final file in dartFiles) {
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i].toLowerCase();
        for (final pattern in _bannedPatterns) {
          if (line.contains(pattern)) {
            final fullLine = lines[i];
            final isAllowed = _allowlist.any(fullLine.contains);
            if (!isAllowed) {
              violations.add(
                '${file.path}:${i + 1} — matched "$pattern"\n'
                '  > ${lines[i].trim()}',
              );
            }
          }
        }
      }
    }

    if (violations.isNotEmpty) {
      fail(
        'Found ${violations.length} guilt/streak/comparison language '
        'violation(s):\n\n${violations.join('\n\n')}\n\n'
        'Fix the string, or add to _allowlist in ui_language_guard_test.dart '
        'with a justification comment.',
      );
    }
  });

  test('no guilt / streak / comparison language in lib/l10n/ ARB files', () {
    final arbFiles = Directory('lib/l10n')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.arb'));

    final violations = <String>[];

    for (final file in arbFiles) {
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i].toLowerCase();
        for (final pattern in _bannedPatterns) {
          if (line.contains(pattern)) {
            final fullLine = lines[i];
            final isAllowed = _allowlist.any(fullLine.contains);
            if (!isAllowed) {
              violations.add(
                '${file.path}:${i + 1} — matched "$pattern"\n'
                '  > ${lines[i].trim()}',
              );
            }
          }
        }
      }
    }

    if (violations.isNotEmpty) {
      fail(
        'Found ${violations.length} violation(s) in ARB files:\n\n'
        '${violations.join('\n\n')}',
      );
    }
  });
}
