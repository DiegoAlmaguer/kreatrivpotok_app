import 'package:intl/intl.dart';

class KPFormat {
  static final DateFormat _date = DateFormat('dd.MM.yyyy');
  static final DateFormat _dateTime = DateFormat('dd.MM.yyyy  HH:mm');

  static String date(dynamic value) {
    final dt = _toDateTime(value);
    if (dt == null) return '—';
    return _date.format(dt.toLocal());
  }

  static String dateTime(dynamic value) {
    final dt = _toDateTime(value);
    if (dt == null) return '—';
    return _dateTime.format(dt.toLocal());
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

  static DateTime? _toDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;

    // на всякий случай, если прилетает timestamp
    if (value is int) {
      try {
        // ms timestamp
        return DateTime.fromMillisecondsSinceEpoch(value);
      } catch (_) {}
    }

    final s = value.toString().trim();
    if (s.isEmpty) return null;
    return DateTime.tryParse(s);
  }

  static num? _toNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    return num.tryParse(value.toString().replaceAll(',', '.').trim());
  }
}
