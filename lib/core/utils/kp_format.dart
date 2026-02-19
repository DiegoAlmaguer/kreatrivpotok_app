import 'date_formatter.dart';

class KPFormat {

  static String date(dynamic value) {
    return DateFormatter.date(value);
  }

  static String dateTime(dynamic value) {
    return DateFormatter.dateTime(value);
  }

  static String relativeDate(dynamic value) {
    return DateFormatter.relative(value);
  }

  static String money(dynamic value, {String? currency}) {
    if (value == null) return '—';
    final n = _toNum(value);
    if (n == null) return '—';
    final cur = (currency ?? '').trim();
    final decimals = (n.roundToDouble() == n.toDouble()) ? 0 : 2;
    final s = n.toStringAsFixed(decimals);
    return cur.isEmpty ? s : '$s $cur';
  }


  static num? _toNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    return num.tryParse(value.toString().replaceAll(',', '.').trim());
  }
}
