enum UnitSystem { metric, imperial, nautical, astronomical }

/// A unit of distance. [metersPerUnit] is how many meters make up 1 unit,
/// so converting is always: valueInMeters / metersPerUnit.
class DistanceUnit {
  final String symbol;
  final String name;
  final double metersPerUnit;
  final UnitSystem system;

  const DistanceUnit({
    required this.symbol,
    required this.name,
    required this.metersPerUnit,
    required this.system,
  });
}
