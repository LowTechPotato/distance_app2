import 'dart:math';

/// Formats a distance value for display.
///
/// - Ordinary-sized numbers get thousands separators, e.g. "9 387".
/// - Very large or very small numbers switch to scientific notation with a
///   real superscript exponent, e.g. "1.23 × 10⁷".
class NumberFormatter {
  static const double _scientificUpperBound = 1e6;
  static const double _scientificLowerBound = 1e-3;

  static const Map<String, String> _superscriptDigits = {
    '0': '⁰',
    '1': '¹',
    '2': '²',
    '3': '³',
    '4': '⁴',
    '5': '⁵',
    '6': '⁶',
    '7': '⁷',
    '8': '⁸',
    '9': '⁹',
    '-': '⁻',
  };

  static String format(double value) {
    if (value == 0) return '0';
    final absValue = value.abs();

    if (absValue >= _scientificUpperBound || absValue < _scientificLowerBound) {
      final exponent = (log(absValue) / ln10).floor();
      final mantissa = value / pow(10, exponent);
      final mantissaStr = _trimTrailingZeros(mantissa.toStringAsFixed(2));
      return '$mantissaStr × 10${_toSuperscript(exponent)}';
    }

    final decimals = absValue >= 100
        ? 0
        : absValue >= 1
            ? 1
            : 3;
    return _addThousandsSeparator(value.toStringAsFixed(decimals));
  }

  static String _trimTrailingZeros(String s) {
    if (!s.contains('.')) return s;
    s = s.replaceFirst(RegExp(r'0+$'), '');
    s = s.replaceFirst(RegExp(r'\.$'), '');
    return s;
  }

  static String _toSuperscript(int n) {
    return n.toString().split('').map((c) => _superscriptDigits[c] ?? c).join();
  }

  static String _addThousandsSeparator(String number) {
    final parts = number.split('.');
    final intPart = parts[0];
    final isNegative = intPart.startsWith('-');
    final digits = isNegative ? intPart.substring(1) : intPart;

    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write('\u202F'); // narrow no-break space
      }
      buffer.write(digits[i]);
    }

    var result = buffer.toString();
    if (isNegative) result = '-$result';
    if (parts.length > 1 && parts[1].isNotEmpty) {
      result += ',${parts[1]}';
    }
    return result;
  }
}
