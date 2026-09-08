enum PlaceType { city, celestial }

/// A place the user can measure their distance to.
///
/// Cities carry [latitude]/[longitude] and the distance to them is
/// computed live from the user's current location (great-circle distance).
///
/// Celestial objects (planets, moons, stars, galaxies...) carry a
/// [fixedDistanceKm] instead, since it doesn't make sense to compute those
/// from lat/lon — we simply store a representative average distance.
class Place {
  final String name;
  final String? country; // null for celestial objects
  final PlaceType type;
  final double? latitude;
  final double? longitude;
  final double? fixedDistanceKm;

  const Place({
    required this.name,
    required this.type,
    this.country,
    this.latitude,
    this.longitude,
    this.fixedDistanceKm,
  });
}
