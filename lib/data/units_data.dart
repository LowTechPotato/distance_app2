import '../models/distance_unit.dart';

class UnitsData {
  static const List<DistanceUnit> all = [
    // Metric
    DistanceUnit(
        symbol: 'mm',
        name: 'Millimeters',
        metersPerUnit: 0.001,
        system: UnitSystem.metric),
    DistanceUnit(
        symbol: 'cm',
        name: 'Centimeters',
        metersPerUnit: 0.01,
        system: UnitSystem.metric),
    DistanceUnit(
        symbol: 'm',
        name: 'Meters',
        metersPerUnit: 1,
        system: UnitSystem.metric),
    DistanceUnit(
        symbol: 'km',
        name: 'Kilometers',
        metersPerUnit: 1000,
        system: UnitSystem.metric),

    // Imperial / US
    DistanceUnit(
        symbol: 'in',
        name: 'Inches',
        metersPerUnit: 0.0254,
        system: UnitSystem.imperial),
    DistanceUnit(
        symbol: 'ft',
        name: 'Feet',
        metersPerUnit: 0.3048,
        system: UnitSystem.imperial),
    DistanceUnit(
        symbol: 'yd',
        name: 'Yards',
        metersPerUnit: 0.9144,
        system: UnitSystem.imperial),
    DistanceUnit(
        symbol: 'mi',
        name: 'Miles',
        metersPerUnit: 1609.344,
        system: UnitSystem.imperial),

    // Nautical
    DistanceUnit(
        symbol: 'nmi',
        name: 'Nautical miles',
        metersPerUnit: 1852,
        system: UnitSystem.nautical),

    // Astronomical / engineering
    DistanceUnit(
        symbol: 'ls',
        name: 'Light seconds',
        metersPerUnit: 299792458,
        system: UnitSystem.astronomical),
    DistanceUnit(
        symbol: 'lm',
        name: 'Light minutes',
        metersPerUnit: 299792458 * 60,
        system: UnitSystem.astronomical),
    DistanceUnit(
        symbol: 'AU',
        name: 'Astronomical units',
        metersPerUnit: 149597870700,
        system: UnitSystem.astronomical),
    DistanceUnit(
        symbol: 'ly',
        name: 'Light years',
        metersPerUnit: 9460730472580800,
        system: UnitSystem.astronomical),
    DistanceUnit(
        symbol: 'pc',
        name: 'Parsecs',
        metersPerUnit: 3.0856775814913673e16,
        system: UnitSystem.astronomical),
  ];

  static DistanceUnit get defaultUnit => all[3]; // km
}
