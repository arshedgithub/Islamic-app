import 'dart:math' as math;

/// Kaaba coordinates (centre of the Masjid al-Haram).
const double kKaabaLatitude = 21.4225;
const double kKaabaLongitude = 39.8262;

/// Returns the initial bearing (forward azimuth) in degrees [0, 360) from the
/// point [fromLat]/[fromLng] to the Kaaba, using the spherical law of cosines.
///
/// This is the same formula used in QiblaScreen so that the UI and the tests
/// share a single implementation.
double qiblaBearing({
  required double fromLat,
  required double fromLng,
}) {
  return bearingTo(
    fromLat: fromLat,
    fromLng: fromLng,
    toLat: kKaabaLatitude,
    toLng: kKaabaLongitude,
  );
}

/// General-purpose forward bearing between two coordinates.
/// Returns a value in [0, 360).
double bearingTo({
  required double fromLat,
  required double fromLng,
  required double toLat,
  required double toLng,
}) {
  final phi1 = _toRad(fromLat);
  final phi2 = _toRad(toLat);
  final deltaLambda = _toRad(toLng - fromLng);

  final y = math.sin(deltaLambda);
  final x =
      math.cos(phi1) * math.tan(phi2) -
      math.sin(phi1) * math.cos(deltaLambda);
  final theta = math.atan2(y, x);
  return (_toDeg(theta) + 360) % 360;
}

double _toRad(double deg) => deg * math.pi / 180;
double _toDeg(double rad) => rad * 180 / math.pi;
