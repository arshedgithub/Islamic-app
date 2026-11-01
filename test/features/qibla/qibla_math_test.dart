import 'package:flutter_test/flutter_test.dart';
import 'package:zikra/features/qibla/domain/qibla_math.dart';

void main() {
  group('qiblaBearing', () {
    // Tolerance: ±1 degree, consistent with the T6 acceptance criterion.
    const tolerance = 1.0;

    test('London → Qibla is about 119°', () {
      final b = qiblaBearing(fromLat: 51.5074, fromLng: -0.1278);
      expect(b, closeTo(119.0, tolerance));
    });

    test('Jakarta → Qibla is about 295°', () {
      final b = qiblaBearing(fromLat: -6.2088, fromLng: 106.8456);
      expect(b, closeTo(295.0, tolerance));
    });

    test('New York → Qibla is about 58°', () {
      final b = qiblaBearing(fromLat: 40.7128, fromLng: -74.0060);
      expect(b, closeTo(58.0, tolerance));
    });

    // Regression value: computed by the same formula.
    // This pins the result for Colombo so a future refactor cannot silently
    // change it without a test failure. It is NOT independently verified
    // against an external reference timetable.
    test('Colombo regression — bearing stays stable across refactors', () {
      final b = qiblaBearing(fromLat: 6.9271, fromLng: 79.8612);
      // Regression pin: ~294.8° (north-west from Colombo toward Makkah).
      // This value is computed by the same formula, NOT from an independent
      // reference timetable. Its purpose is to catch silent formula regressions.
      expect(b, closeTo(294.8, tolerance));
    });

    test('result is always in [0, 360)', () {
      for (final coords in [
        (51.5074, -0.1278),   // London
        (-6.2088, 106.8456),  // Jakarta
        (40.7128, -74.0060),  // New York
        (6.9271, 79.8612),    // Colombo
        (-33.8688, 151.2093), // Sydney
        (35.6762, 139.6503),  // Tokyo
      ]) {
        final b = qiblaBearing(fromLat: coords.$1, fromLng: coords.$2);
        expect(b, greaterThanOrEqualTo(0.0), reason: 'negative bearing at $coords');
        expect(b, lessThan(360.0), reason: 'bearing ≥ 360 at $coords');
      }
    });
  });

  group('bearingTo', () {
    test('bearing from a point to itself is 0 (or 360 — both normalise to 0)', () {
      final b = bearingTo(
        fromLat: 21.4225,
        fromLng: 39.8262,
        toLat: 21.4225,
        toLng: 39.8262,
      );
      expect(b % 360, closeTo(0.0, 1.0));
    });
  });
}
