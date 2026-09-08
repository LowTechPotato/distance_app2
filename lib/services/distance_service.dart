import 'dart:math';
import '../models/place.dart';

class DistanceService {
  static const double _earthRadiusKm = 6371.0088;

  /// Distance in meters between the user and [place].
  ///
  /// For cities this is the great-circle (haversine) distance from
  /// [userLat]/[userLon]. For celestial objects it's just the object's
  /// stored average distance.
  static double distanceInMeters({
    required Place place,
    double? userLat,
    double? userLon,
  }) {
    if (place.type == PlaceType.celestial) {
      return (place.fixedDistanceKm ?? 0) * 1000;
    }

    if (userLat == null || userLon == null) return 0;

    final km = _haversineKm(
      userLat,
      userLon,
      place.latitude!,
      place.longitude!,
    );
    return km * 1000;
  }

  static double _haversineKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) *
            cos(_deg2rad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return _earthRadiusKm * c;
  }

  static double _deg2rad(double deg) => deg * pi / 180;
}
