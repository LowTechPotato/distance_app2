import '../models/place.dart';

/// Solar-system bodies and a couple of deep-space objects.
///
/// These use a single representative "average distance from Earth" in km,
/// not a live ephemeris — planetary distances actually change constantly
/// as bodies orbit the Sun. Good enough for a fun distance app; if you want
/// real-time accuracy later, swap [fixedDistanceKm] for a call to an
/// ephemeris API (e.g. NASA JPL Horizons).
class CelestialData {
  static const List<Place> all = [
    Place(name: 'Moon', type: PlaceType.celestial, fixedDistanceKm: 384400),
    Place(name: 'Sun', type: PlaceType.celestial, fixedDistanceKm: 149600000),
    Place(
        name: 'Mercury',
        type: PlaceType.celestial,
        fixedDistanceKm: 91700000),
    Place(
        name: 'Venus', type: PlaceType.celestial, fixedDistanceKm: 41400000),
    Place(name: 'Mars', type: PlaceType.celestial, fixedDistanceKm: 78300000),
    Place(
        name: 'Jupiter',
        type: PlaceType.celestial,
        fixedDistanceKm: 628900000),
    Place(
        name: 'Saturn',
        type: PlaceType.celestial,
        fixedDistanceKm: 1284400000),
    Place(
        name: 'Uranus',
        type: PlaceType.celestial,
        fixedDistanceKm: 2721400000),
    Place(
        name: 'Neptune',
        type: PlaceType.celestial,
        fixedDistanceKm: 4345400000),
    Place(
        name: 'Pluto',
        type: PlaceType.celestial,
        fixedDistanceKm: 5756400000),
    Place(
        name: 'Proxima Centauri',
        type: PlaceType.celestial,
        fixedDistanceKm: 40100000000000),
    Place(
        name: 'Andromeda Galaxy',
        type: PlaceType.celestial,
        fixedDistanceKm: 2.365e19),
  ];
}
