/// Formats decimal-degree coordinates as e.g. "51.2194° N, 4.4025° E".
class CoordinateFormatter {
  static String format(double lat, double lon) {
    final latDir = lat >= 0 ? 'N' : 'S';
    final lonDir = lon >= 0 ? 'E' : 'W';
    return '${lat.abs().toStringAsFixed(4)}° $latDir, '
        '${lon.abs().toStringAsFixed(4)}° $lonDir';
  }
}
